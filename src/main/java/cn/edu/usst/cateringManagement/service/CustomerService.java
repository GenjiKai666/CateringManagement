package cn.edu.usst.cateringManagement.service;

import cn.edu.usst.cateringManagement.bean.dto.UserDTO;
import cn.edu.usst.cateringManagement.bean.po.CustomerPO;

public interface CustomerService {
    /**
     * 顾客的登陆操作，如果登陆成功返回顾客的PO对象，失败返回{@code null}
     *
     * @param userDTO 接受顾客数据
     * @return 顾客的PO对象
     */
    CustomerPO loginCustomer(UserDTO userDTO);

    /**
     * 顾客的注册操作，如果注册成功返回顾客的PO对象，失败则返回{@code null}
     *
     * @param userDTO 接受顾客数据
     * @return 顾客PO类
     */
    CustomerPO registerCustomer(UserDTO userDTO);

    /**
     * 更新用户数据，包括密码，手机号码等
     * 用户id用于定位，不能更改。
     *
     * <p>
     * userDTO 中对于存在的属性则更新入数据库，不存在就不做更改
     * </p>
     *
     * @param userDTO 要更新为的数据
     * @return 更新后的顾客数据
     */
    CustomerPO updateCustomer(UserDTO userDTO);
}
