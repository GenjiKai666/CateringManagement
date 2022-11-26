package cn.edu.usst.cateringManagement.bean.po;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.github.jeffreyning.mybatisplus.anno.MppMultiId;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
@TableName("PURCHASE_DISH")
public class PurchaseDishPO {
    @MppMultiId
    @TableField("PURCHASE_ID")
    private Integer purchaseId;
    @MppMultiId
    @TableField("DISH_ID")
    private Integer dishId;
    @TableField("DISH_NUM")
    private Integer dishNum;
}
