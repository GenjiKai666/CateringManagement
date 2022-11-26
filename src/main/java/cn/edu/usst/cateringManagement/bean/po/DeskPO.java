package cn.edu.usst.cateringManagement.bean.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
@TableName("DESK")
public class DeskPO {
    @TableId(type = IdType.AUTO)
    private Integer id;
    @TableField
    private Integer seatNum;
    @TableField
    private Integer status;
}
