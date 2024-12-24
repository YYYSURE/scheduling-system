package org.example.result;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.enums.ResultCodeEnum;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;

/**
 * 返回数据
 *
 * @author Mark sunlightcs@gmail.com
 */
@Data
@NoArgsConstructor
public class Result extends HashMap<String, Object> {
    private static final long serialVersionUID = 1L;

    public Integer getCode() {
        return (int) (this.get("code"));
    }

    public static Result ok() {
        Result r = new Result();
        r.put("code", ResultCodeEnum.SUCCESS.getCode());
        r.put("message", "success");
        return r;
    }

    public Result addData(String key, Object value) {
        this.put(key, value);
        return this;
    }

    @Override
    public String toString() {
        return JSON.toJSONString(this);
    }

    public static Result error(int code, String msg) {
        Result r = new Result();
        r.put("code", code);
        r.put("message", msg);
        return r;
    }

    public static Result error(ResultCodeEnum resultCodeEnum) {
        Result r = new Result();
        r.put("code", resultCodeEnum.getCode());
        r.put("message", resultCodeEnum.getMessage());
        return r;
    }
    // 新增的 error 方法
    public static Result error(String message) {
        Result r = new Result();
        r.put("code", ResultCodeEnum.FAIL.getCode()); // 假设失败的代码为 ResultCodeEnum.FAIL.getCode()
        r.put("message", message);
        return r;
    }


    /**
     * 使用fastjson工具来转化数据类型
     *
     * @param typeReference
     * @param <T>
     * @return
     */
    public <T> T getData(String key, TypeReference<T> typeReference) {
        Object data = this.get(key);
        String s = JSON.toJSONString(data);
        T t = JSON.parseObject(s, typeReference);
        return t;
    }

}
