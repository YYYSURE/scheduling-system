package org.example.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EmployeeLoginVO implements Serializable {
    private Long id;
    private String userName;
//    private String name;
    private String token;
}
