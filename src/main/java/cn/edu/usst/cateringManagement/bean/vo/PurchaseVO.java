package cn.edu.usst.cateringManagement.bean.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
public class PurchaseVO {
    private Integer id;
    private Date createTime;
    private BigDecimal amount;
    private String payMethod;
    private Integer payStatus;
    private Integer customerId;
    private Integer deskId;
    private List<PurchaseDishVO> dishList;
}
