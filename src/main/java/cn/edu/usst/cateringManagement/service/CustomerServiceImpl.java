package cn.edu.usst.cateringManagement.service;

import cn.edu.usst.cateringManagement.bean.dto.UserDTO;
import cn.edu.usst.cateringManagement.bean.po.CustomerPO;
import cn.edu.usst.cateringManagement.mapper.CustomerMapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@Slf4j
public class CustomerServiceImpl implements CustomerService {

    CustomerMapper customerMapper;
    private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Autowired
    public CustomerServiceImpl(CustomerMapper customerMapper) {
        this.customerMapper = customerMapper;
    }

    @Override
    public CustomerPO loginCustomer(UserDTO userDTO) {
        CustomerPO customerPO = customerMapper.selectOne(Wrappers
                .lambdaQuery(CustomerPO.class)
                .eq(CustomerPO::getName, userDTO.getName()));
        if (customerPO != null
                && userDTO.getPassword().equals(customerPO.getPassword())) {
            return customerPO;
        } else {
            return null;
        }
    }

    @Override
    public CustomerPO registerCustomer(UserDTO userDTO) {
        CustomerPO customerPO = new CustomerPO(null,
                userDTO.getName(),
                userDTO.getPassword(),
                userDTO.getPhone());
        // 插入失败之后，会触发回滚，并抛出异常，由controller捕获，并处理
        customerMapper.insert(customerPO);
        return customerPO;
    }

    @Override
    public CustomerPO updateCustomer(UserDTO userDTO) {
        CustomerPO customerPO = new CustomerPO(userDTO.getId(),
                userDTO.getName(),
                userDTO.getPassword(),
                userDTO.getPhone());
        if (userDTO.getId() != null) {
            customerMapper.updateById(customerPO);
            log.info("更新id为{}，的用户数据：{}", userDTO.getId(), userDTO);
            return customerMapper.selectById(userDTO.getId());
        } else {
            log.warn("无法定位用户的修改：{}", userDTO);
            return null;
        }
    }

}
