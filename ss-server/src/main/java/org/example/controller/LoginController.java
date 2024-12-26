package org.example.controller;

import org.example.dto.Account;
import org.example.dto.ResetDTO;
import org.example.entity.Employee;
import org.example.result.Result;
import org.example.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

import static org.example.enums.ResultCodeEnum.ACCOUNT_ERROR;

@RestController
@RequestMapping("/accounts")
public class LoginController {
    @Autowired
    private EmployeeService employeeService;
//    @Autowired
//    private EnterpriseAdminService enterpriseAdminService;
//    @Autowired
//    private StoreAdminService storeAdminService;

    // 用户登录
    @PostMapping("/login")
    public Result login(@RequestBody Account account) {

        System.out.println(account);

        int type = account.getType();
        System.out.println("type:" + type);

        Map<String, Object> map = new HashMap<>();

        // TODO:
        if (type == 1) {
            // 员工
            Employee employee = employeeService.login(account);

            System.out.println("login: " + employee);

            map.put("name", employee.getUsername());
            map.put("id", employee.getId());
            map.put("store", employee.getStoreId());

        } else if (type == 2) {
            // 企业管理员
//            EnterpriseAdmin enterpriseAdmin = enterpriseService.login(account);
//
//            map.put("name", enterpriseAdmin.getUsername());
//            map.put("id", enterpriseAdmin.getId());
//            map.put("store", enterpriseAdmin.getStoreId());

        } else if (type == 3) {
            // 门店管理员
//            StoreAdmin storeAdmin  = StoreAdminService.login(account);
//
//            map.put("name", storeAdmin.getUsername());
//            map.put("id", storeAdmin.getId());
//            map.put("store", storeAdmin.getStoreId());
        }


        return Result.ok().addData("data", map);
    }

    @PostMapping("/reset")
    public Result reset(@RequestBody ResetDTO resetDTO) {

        System.out.println(resetDTO);

        String idCard = resetDTO.getIdCard();
        String phone = resetDTO.getAccount().getEmail();
        String password = resetDTO.getAccount().getPassword();


        Employee employee = employeeService.getByPhone(phone);
        System.out.println("reset: " + employee);
        if (employee != null) {
            if (!employee.getIdCard().equals(idCard)) {
                return Result.error(ACCOUNT_ERROR);
            }
            // update password
            employeeService.updatePassword(idCard, password);
            System.out.println("update password succeed");

            return Result.ok();
        }

        // TODO:
//        EnterpriseAdmin enterpriseAdmin = enterpriseAdminService.getByIdCard();
//        if (enterpriseAdmin != null) {
//            if (enterpriseAdmin.getIdCard() != idCard) {
//                return Result.error(ACCOUNT_ERROR);
//            }
//            // update password
//            enterpriseAdminService.updatePassword(idCard, password);
//            return Result.ok();
//        }
//        StoreAdmin storeAdmin = storeService.getByIdCard();
//        if (storeAdmin != null) {
//            if (storeAdmin.getIdCard() != idCard) {
//                return Result.error(ACCOUNT_ERROR);
//            }
//            // update password
//            storeAdminService.updatePassword(idCard, password);
//            return Result.ok();
//        }

        return Result.error(ACCOUNT_ERROR);




    }

}
