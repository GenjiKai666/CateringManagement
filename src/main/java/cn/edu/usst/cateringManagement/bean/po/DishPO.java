package cn.edu.usst.cateringManagement.bean.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
@TableName("DISH")
public class DishPO {
    @TableId(type = IdType.AUTO)
    private Integer id;
    @TableField
    private String dishName;
    @TableField
    private byte[] picture;
    @TableField
    private BigDecimal price;
    @TableField
    private Integer dishTypeId;
}
