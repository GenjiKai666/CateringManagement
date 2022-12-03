package cn.edu.usst.cateringManagement.controller;

import cn.edu.usst.cateringManagement.bean.dto.UserDTO;
import cn.edu.usst.cateringManagement.bean.po.CustomerPO;
import cn.edu.usst.cateringManagement.service.CustomerService;
import cn.edu.usst.cateringManagement.utils.Constant;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.constraints.NotNull;
import java.io.IOException;
import java.util.Objects;

@RestController
@Slf4j
public class UserController {

    CustomerService userService;

    @Autowired
    public UserController(CustomerService customerService) {
        this.userService = customerService;
    }


    @GetMapping("/user")
    public void user(HttpServletResponse response) throws IOException {
        response.sendRedirect("/user/info.html");
    }

    @PostMapping("/user/login")
    public ResponseEntity<String> login(@RequestBody @NotNull UserDTO userDTO, HttpSession session) {
        CustomerPO customerPO = userService.loginCustomer(userDTO);
        if (Objects.isNull(customerPO)) {
            // 登陆失败
            return new ResponseEntity<>(HttpStatus.FORBIDDEN);
        } else {
            // 登陆成功，session记录
            session.setAttribute(Constant.USER, customerPO);
            session.setAttribute(Constant.ROLE, Constant.NORMAL);
            return new ResponseEntity<>(HttpStatus.OK);
        }
    }

    @PostMapping("/user/register")
    public ResponseEntity<String> register(@RequestBody @Validated UserDTO userDTO) {
        if (userDTO.getName() == null || userDTO.getPassword() == null || userDTO.getPhone() == null) {
            log.warn("{}注册失败", userDTO);
            return new ResponseEntity<>("不能为null", HttpStatus.CONFLICT);
        }
        try {
            userService.registerCustomer(userDTO);
        } catch (Exception e) {
            log.warn(e.getMessage());
            log.warn("{}注册失败", userDTO);
            return new ResponseEntity<>("用户名或手机号重复", HttpStatus.CONFLICT);
        }
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @GetMapping("/user/info")
    public ResponseEntity<UserDTO> info(HttpSession session) {
        // 能够访问到该地址的用户，一定在session中保存有数据
        CustomerPO customerPO = (CustomerPO) session.getAttribute(Constant.USER);
        UserDTO userDTO = new UserDTO(null,
                customerPO.getName(),
                "******",   // 密码显示统一返回六个 *
                customerPO.getPhone());
        return new ResponseEntity<>(userDTO, HttpStatus.OK);
    }

    @PostMapping("/user/update")
    public ResponseEntity<String> update(@RequestBody @Validated UserDTO userDTO, HttpSession session) {
        CustomerPO customerPO = (CustomerPO) session.getAttribute(Constant.USER);
        userDTO.setId(customerPO.getId());
        customerPO = userService.updateCustomer(userDTO);
        if (customerPO == null) {
            // 更新失败
            return new ResponseEntity<>("更新失败", HttpStatus.UNAUTHORIZED);
        } else {
            session.setAttribute(Constant.USER, customerPO);
            return new ResponseEntity<>(HttpStatus.OK);
        }
    }
}
