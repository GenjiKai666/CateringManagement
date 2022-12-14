use cateringmanagement;

-- 餐桌表的模式
create table DESK
(
    ID       int auto_increment primary key,
    SEAT_NUM int not null check ( SEAT_NUM > 0),
    STATUS   int not null default 0 comment '0表示没有使用，1表示被使用',
    constraint DESK_CHECK
        check ( STATUS = 0 or STATUS = 1 )
) charset = utf8mb4;

-- 顾客表
create table CUSTOMER
(
    ID       int auto_increment primary key,
    NAME     varchar(20) not null comment '用户名也不能重复' unique,
    PASSWORD varchar(32) not null,
    PHONE    varchar(14) default null comment '手机号不能重复注册' unique
) charset = utf8mb4;

-- 订单表
create table PURCHASE
(
    ID          int auto_increment primary key,
    CREATE_TIME timestamp          not null,
    AMOUNT      decimal(9, 2) not null,
    PAY_METHOD  varchar(10)            default null,
    PAY_STATUS  int           not null default 0 comment '0表示没有支付，1表示已经支付',
    CUSTOMER_ID int           not null,
    DESK_ID     int           not null,
    constraint PURCHASE_CHECK1
        check ( PAY_STATUS = 0 or PAY_STATUS = 1 ),
    constraint PURCHASE_CHECK2
        check ( (PAY_STATUS = 0 and PAY_METHOD is null) or (PAY_STATUS = 1 and PAY_METHOD is not null)),
    constraint PURCHASE_CUSTOMER_FK
        foreign key (CUSTOMER_ID) references CUSTOMER (ID),
    constraint PURCHASE_DESK_FK
        foreign key (DESK_ID) references DESK (ID)
) charset = utf8mb4;

-- 菜品表
create table DISH
(
    ID        int auto_increment primary key,
    DISH_NAME varchar(30)   not null,
    DISH_TYPE_ID varchar(20)   not null,
    PRICE     decimal(9, 2) not null,
    PICTURE   longblob      not null
) charset = utf8mb4;

-- 菜品和订单的关系
create table PURCHASE_DISH
(
    PURCHASE_ID int references PURCHASE (ID),
    DISH_ID     int references DISH (ID),
    DISH_NUM    int not null check ( DISH_NUM > 0 ),
    constraint PURCHASE_DISH_PK
        primary key (PURCHASE_ID, DISH_ID)
) charset = utf8mb4;

create table DISH_TYPE
(
    ID   int auto_increment primary key,
    NAME varchar(40) not null
)charset = utf8mb4;