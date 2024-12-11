package org.example.utils;


/**
 * 检查密码
 */
public class CheckPasswordUtil {
    /**
     * 密码正则表达式
     * 可以使用数字、字母、特殊字符，长度在6-30之间
     */
    public static final String PASSWORD_PATTERN = ".{6,30}$";

    /**
     * 密码校验
     *
     * @param password
     * @return
     */
    public static boolean passwordCheck(String password) {
        return password.matches(PASSWORD_PATTERN);
    }

}
