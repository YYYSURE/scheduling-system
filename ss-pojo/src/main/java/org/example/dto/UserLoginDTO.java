package org.example.dto;


import lombok.Data;
import java.io.Serializable;

@Data
public class UserLoginDTO implements Serializable {
    // 用户名
    private Account account;
}
