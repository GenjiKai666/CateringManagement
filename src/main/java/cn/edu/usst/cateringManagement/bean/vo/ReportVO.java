package cn.edu.usst.cateringManagement.bean.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
public class ReportVO {
    String date;				//格式同上
    Double totalMoney;		    //总交易额
    Integer totalDesk;			//总开台数
    String[] typeName;		    //类别名称,与各类别营业额相对应
    Double[] money;			    //各类别的营业额
    Double[] income;			//固定第一个是微信交易额,第二个是支付宝交易额度
}
