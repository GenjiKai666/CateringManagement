package cn.edu.usst.cateringManagement.bean.dto;

import lombok.*;
import org.springframework.validation.annotation.Validated;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
@ToString
@Validated
/*
  仅用于测试,请勿使用
 */
public class PurchaseDTO {
    @NotNull
    private long createTime;
    @Min(0)
    private double amount;
    @NotNull
    private Integer customerId;
    @Min(0)
    private Integer deskId;
    @NotBlank
    private Integer[] dishId;
    @NotBlank
    private Integer[] dishNum;
}
