package cn.edu.usst.cateringManagement.bean.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

import java.math.BigDecimal;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
@TableName("PURCHASE")
public class PurchasePO {
    @TableId(type = IdType.AUTO)
    private Integer id;
    @TableField
    private Date createTime;
    @TableField
    private BigDecimal amount;
    @TableField
    private String payMethod;
    @TableField
    private Integer patStatus;
    @TableField
    private Integer customerId;
    @TableField
    private Integer deskId;
}
