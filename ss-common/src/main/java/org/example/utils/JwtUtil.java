package org.example.utils;

import io.jsonwebtoken.*;
import org.springframework.util.StringUtils;

import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.Map;

public class JwtUtil {
    /**
     * 生成jwt
     * 使用Hs256算法, 私匙使用固定秘钥
     *
     * @param secretKey jwt秘钥
     * @param ttlMillis jwt过期时间(毫秒)
     * @param claims    设置的信息
     * @return
     */
    public static String createJWT(String secretKey, long ttlMillis, Map<String, Object> claims) {
        // 指定签名的时候使用的签名算法，也就是header那部分
        SignatureAlgorithm signatureAlgorithm = SignatureAlgorithm.HS256;

        // 生成JWT的时间
        long expMillis = System.currentTimeMillis() + ttlMillis;
        Date exp = new Date(expMillis);

        // 设置jwt的body
        JwtBuilder builder = Jwts.builder()
                // 如果有私有声明，一定要先设置这个自己创建的私有的声明，这个是给builder的claim赋值，一旦写在标准的声明赋值之后，就是覆盖了那些标准的声明的
                .setClaims(claims)
                // 设置签名使用的签名算法和签名使用的秘钥
                .signWith(signatureAlgorithm, secretKey.getBytes(StandardCharsets.UTF_8))
                // 设置过期时间
                .setExpiration(exp);

        return builder.compact();
    }










    //下面为增加部分





    /**
     * JWT的默认过期时间，单位为毫秒。这里设定为一年（365天）
     */
    private static long tokenExpiration = 365 * 24 * 60 * 60 * 1000;
    /**
     * 在实际应用中，应使用随机生成的字符串
     */
    private static String tokenSignKey = "dsahdashoiduasguiewu23114";


    /**
     * Token解密
     *
     * @param secretKey jwt秘钥 此秘钥一定要保留好在服务端, 不能暴露出去, 否则sign就可以被伪造, 如果对接多个客户端建议改造成多个
     * @param token     加密后的token
     * @return
     */
    public static Claims parseJWT(String secretKey, String token) {
        // 得到DefaultJwtParser
        Claims claims = Jwts.parser()
                // 设置签名的秘钥
                .setSigningKey(secretKey.getBytes(StandardCharsets.UTF_8))
                // 设置需要解析的jwt
                .parseClaimsJws(token).getBody();
        return claims;
    }
    /**
     * 从给定的JWT令牌中提取指定参数名对应的值。
     *
     * @param token     需要解析的JWT令牌字符串
     * @param paramName 要提取的参数名
     * @return 参数值（字符串形式），如果令牌为空、解析失败或参数不存在，则返回null
     */
    public static String getParam(String token, String paramName) {
        try {
            if (StringUtils.isEmpty(token)) {
                return null;
            }
            // 使用提供的密钥解析并验证JWT
            Jws<Claims> claimsJws = Jwts.parser().setSigningKey(tokenSignKey).parseClaimsJws(token);
            // 获取JWT的有效载荷（claims），其中包含了所有声明（参数）
            Claims claims = claimsJws.getBody();
            // 提取指定参数名对应的值
            Object param = claims.get(paramName);
            // 如果参数值为空，则返回null；否则将其转换为字符串并返回
            return param == null ? null : param.toString();
        } catch (Exception e) {
            // 记录解析过程中的任何异常，并返回null
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 根据用户信息生成一个新的JWT令牌。
     *
     * @param userId
     * @param username
     * @return
     */
    public static String createToken(Long userId, String username, Long enterpriseId, Long storeId, int userType) {
//        System.out.println("createToken userType:" + userType);
        // 使用Jwts.builder()构建JWT
        String token = Jwts.builder()
                // 设置JWT的主题（subject），此处为常量"AUTH-USER"
                .setSubject("AUTH-USER")
                // 设置过期时间，当前时间加上预设的过期时间（tokenExpiration）
                .setExpiration(new Date(System.currentTimeMillis() + tokenExpiration))
                // 有效载荷
                .claim("userId", userId)
                .claim("username", username)
                .claim("enterpriseId", enterpriseId)
                .claim("storeId", storeId)
                .claim("userType", userType)
                // 使用HS512算法和指定密钥对JWT进行加密
                .signWith(SignatureAlgorithm.HS512, tokenSignKey)
                // 使用GZIP压缩算法压缩JWT字符串，将字符串变成一行来显示
                .compressWith(CompressionCodecs.GZIP)
                // 完成构建并生成紧凑格式的JWT字符串
                .compact();
        return token;
    }


    public static String getUserId(String token) {
        return getParam(token, "userId");
    }

    public static String getUsername(String token) {
        return getParam(token, "username");
    }

    public static String getEnterpriseId(String token) {
        return getParam(token, "enterpriseId");
    }

    public static String getStoreId(String token) {
        return getParam(token, "storeId");
    }

    public static String getUserType(String token) {
        return getParam(token, "userType");
    }


}
