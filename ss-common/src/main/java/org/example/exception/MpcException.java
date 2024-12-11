package org.example.exception;

import lombok.Data;
import org.example.enums.ResultCodeEnum;

/**
 * 自定义异常
 *
 * @author Mark sunlightcs@gmail.com
 */
@Data
public class MpcException extends RuntimeException {
	private static final long serialVersionUID = 1L;
	
    private String msg;
    private int code = 500;
    
    public MpcException(String msg) {
		super(msg);
		this.msg = msg;
	}

	/**
	 * 接收枚举类型对象
	 * @param resultCodeEnum
	 */
	public MpcException(ResultCodeEnum resultCodeEnum) {
		super(resultCodeEnum.getMessage());
		this.code = resultCodeEnum.getCode();
		this.msg = resultCodeEnum.getMessage();
	}
	
	public MpcException(String msg, Throwable e) {
		super(msg, e);
		this.msg = msg;
	}
	
	public MpcException(String msg, int code) {
		super(msg);
		this.msg = msg;
		this.code = code;
	}
	
	public MpcException(String msg, int code, Throwable e) {
		super(msg, e);
		this.msg = msg;
		this.code = code;
	}

}
