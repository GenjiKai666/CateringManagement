package cn.edu.usst.cateringManagement.utils;

public class Constant {
    public static final String USER = "USER";       // session 中对对应用户的key,可以获得CustomerPO对象
    public static final String ROLE = "ROLE";       // session中对应用户身份的key,可以获得代表用户权限的常量：NORMAL,ADMIN
    public static final String NORMAL = "NORMAL";   //role获得的普通用户身份
    public static final String ADMIN = "ADMIN";     // role 获得的管理员身份
}
