package cn.edu.usst.cateringManagement.service;

import cn.edu.usst.cateringManagement.bean.po.DishPO;
import cn.edu.usst.cateringManagement.bean.po.DishTypePO;
import cn.edu.usst.cateringManagement.bean.po.PurchaseDishPO;
import cn.edu.usst.cateringManagement.bean.po.PurchasePO;
import cn.edu.usst.cateringManagement.bean.vo.ReportVO;
import cn.edu.usst.cateringManagement.mapper.DishMapper;
import cn.edu.usst.cateringManagement.mapper.DishTypeMapper;
import cn.edu.usst.cateringManagement.mapper.PurchaseDishMapper;
import cn.edu.usst.cateringManagement.mapper.PurchaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;


@Service
public class ReportService {
    @Autowired
    PurchaseMapper purchaseMapper;
    @Autowired
    PurchaseDishMapper purchaseDishMapper;
    @Autowired
    DishMapper dishMapper;
    @Autowired
    DishTypeMapper dishTypeMapper;
    private String getLastDayOfMonth(String yearMonth) {
        String[] temp = yearMonth.split("-");
        int year = Integer.parseInt(yearMonth.split("-")[0]);  //年
        int month = Integer.parseInt(yearMonth.split("-")[1]); //月
        Calendar cal = Calendar.getInstance();
        // 设置年份
        cal.set(Calendar.YEAR, year);
        // 设置月份
        // cal.set(Calendar.MONTH, month - 1);
        cal.set(Calendar.MONTH, month); //设置当前月的上一个月
        // 获取某月最大天数
        //int lastDay = cal.getActualMaximum(Calendar.DATE);
        int lastDay = cal.getMinimum(Calendar.DATE); //获取月份中的最小值，即第一天
        // 设置日历中月份的最大天数
        //cal.set(Calendar.DAY_OF_MONTH, lastDay);
        cal.set(Calendar.DAY_OF_MONTH, lastDay - 1); //上月的第一天减去1就是当月的最后一天
        // 格式化日期
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(cal.getTime());
    }
    public ReportVO getDayReport(String day){
        BigDecimal totalMoney = new BigDecimal(0);		    //总交易额
        Integer totalDesk = 0;			//总开台数
        HashMap<String,BigDecimal> money = new HashMap<>();
        BigDecimal[] income = {new BigDecimal(0),new BigDecimal(0)};            //固定第一个是微信交易额,第二个是支付宝交易额度
        String start = day+" 00:00:00";
        String end = day+ " 23:59:59";
        DateTimeFormatter ftf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime parse_start = LocalDateTime.parse(start, ftf);
        LocalDateTime parse_end = LocalDateTime.parse(end, ftf);
        Long startTime = LocalDateTime.from(parse_start).atZone(ZoneId.systemDefault()).toInstant().toEpochMilli();
        Long endTime = LocalDateTime.from(parse_end).atZone(ZoneId.systemDefault()).toInstant().toEpochMilli();
        List<PurchasePO> purchasePOList = purchaseMapper.selectList(Wrappers.lambdaQuery(PurchasePO.class)
                .ge(PurchasePO::getCreateTime,new Date(startTime))
                .le(PurchasePO::getCreateTime,new Date(endTime))
                .eq(PurchasePO::getPayStatus,1));
        if(purchasePOList == null){
            return null;
        }
        for(PurchasePO po:purchasePOList){
            totalMoney = totalMoney.add(po.getAmount());
            totalDesk++;
            if(po.getPayMethod().equals("Wechat")){
                income[0] = income[0].add(po.getAmount());
            }
            else if(po.getPayMethod().equals("Alipay")){
                income[1] = income[1].add(po.getAmount());
            }
            List<PurchaseDishPO> purchaseDishPOS = purchaseDishMapper
                    .selectList(Wrappers.lambdaQuery(PurchaseDishPO.class).eq(PurchaseDishPO::getPurchaseId,po.getId()));
            for(PurchaseDishPO purchaseDishPO:purchaseDishPOS){
                Integer dish_id = purchaseDishPO.getDishId();
                BigDecimal dish_num = new BigDecimal(purchaseDishPO.getDishNum());
                BigDecimal dish_price = dishMapper.selectOne(Wrappers.lambdaQuery(DishPO.class)
                        .eq(DishPO::getId,dish_id)).getPrice();
                Integer dish_type_id =dishMapper.selectOne(Wrappers.lambdaQuery(DishPO.class)
                        .eq(DishPO::getId,dish_id)).getDishTypeId();
                String type_name = dishTypeMapper.selectOne(Wrappers
                        .lambdaQuery(DishTypePO.class).eq(DishTypePO::getId,dish_type_id)).getName();
                if(money.containsKey(type_name)){
                    BigDecimal temp1 = dish_price.multiply(dish_num);
                    BigDecimal temp2 = money.get(type_name).add(temp1);
                    money.remove(type_name);
                    money.put(type_name,temp2);
                }
                else if(money.containsKey(type_name) != true){
                    BigDecimal temp = dish_price.multiply(dish_num);
                    money.put(type_name,temp);
                }
            }
        }
        String[] names = new String[money.size()];
        Double[] doubles = new Double[money.size()];
        Double[] incomes = new Double[income.length];
        for(int i = 0;i< income.length;i++){
            incomes[i] = income[i].doubleValue();
        }
        money.keySet().toArray(names);
        for(int i = 0;i< names.length;i++){
            doubles[i] = money.get(names[i]).doubleValue();
        }
        return new ReportVO(day,totalMoney.doubleValue(),totalDesk.intValue(),names,doubles,incomes);
    }
    public ReportVO getMonthReport(String month){
        BigDecimal totalMoney = new BigDecimal(0);		    //总交易额
        Integer totalDesk = 0;			//总开台数
        HashMap<String,BigDecimal> money = new HashMap<>();
        BigDecimal[] income = {new BigDecimal(0),new BigDecimal(0)};            //固定第一个是微信交易额,第二个是支付宝交易额度
        String start = month+"-01 00:00:00";
        String end = getLastDayOfMonth(month)+" 23:59:59";
        DateTimeFormatter ftf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime parse_start = LocalDateTime.parse(start, ftf);
        LocalDateTime parse_end = LocalDateTime.parse(end, ftf);
        Long startTime = LocalDateTime.from(parse_start).atZone(ZoneId.systemDefault()).toInstant().toEpochMilli();
        Long endTime = LocalDateTime.from(parse_end).atZone(ZoneId.systemDefault()).toInstant().toEpochMilli();
        List<PurchasePO> purchasePOList = purchaseMapper.selectList(Wrappers.lambdaQuery(PurchasePO.class)
                .ge(PurchasePO::getCreateTime,new Date(startTime))
                .le(PurchasePO::getCreateTime,new Date(endTime))
                .eq(PurchasePO::getPayStatus,1));
        for(PurchasePO po:purchasePOList){
            totalMoney = totalMoney.add(po.getAmount());
            totalDesk++;
            if(po.getPayMethod().equals("Wechat")){
                income[0] = income[0].add(po.getAmount());
            }
            else if(po.getPayMethod().equals("Alipay")){
                income[1] = income[1].add(po.getAmount());
            }
            List<PurchaseDishPO> purchaseDishPOS = purchaseDishMapper
                    .selectList(Wrappers.lambdaQuery(PurchaseDishPO.class).eq(PurchaseDishPO::getPurchaseId,po.getId()));
            for(PurchaseDishPO purchaseDishPO:purchaseDishPOS){
                Integer dish_id = purchaseDishPO.getDishId();
                BigDecimal dish_num = new BigDecimal(purchaseDishPO.getDishNum());
                BigDecimal dish_price = dishMapper.selectOne(Wrappers.lambdaQuery(DishPO.class)
                        .eq(DishPO::getId,dish_id)).getPrice();
                Integer dish_type_id =dishMapper.selectOne(Wrappers.lambdaQuery(DishPO.class)
                        .eq(DishPO::getId,dish_id)).getDishTypeId();
                String type_name = dishTypeMapper.selectOne(Wrappers
                        .lambdaQuery(DishTypePO.class).eq(DishTypePO::getId,dish_type_id)).getName();
                if(money.containsKey(type_name)){
                    BigDecimal temp1 = dish_price.multiply(dish_num);
                    BigDecimal temp2 = money.get(type_name).add(temp1);
                    money.remove(type_name);
                    money.put(type_name,temp2);
                }
                else if(money.containsKey(type_name) != true){
                    BigDecimal temp = dish_price.multiply(dish_num);
                    money.put(type_name,temp);
                }
            }
        }
        String[] names = new String[money.size()];
        Double[] doubles = new Double[money.size()];
        Double[] incomes = new Double[income.length];
        for(int i = 0;i< income.length;i++){
            incomes[i] = income[i].doubleValue();
        }
        money.keySet().toArray(names);
        for(int i = 0;i< names.length;i++){
            doubles[i] = money.get(names[i]).doubleValue();
        }
        return new ReportVO(month,totalMoney.doubleValue(),totalDesk.intValue(),names,doubles,incomes);
    }
    public ReportVO getYearReport(String year){
        BigDecimal totalMoney = new BigDecimal(0);		    //总交易额
        Integer totalDesk = 0;			//总开台数
        HashMap<String,BigDecimal> money = new HashMap<>();
        BigDecimal[] income = {new BigDecimal(0),new BigDecimal(0)};            //固定第一个是微信交易额,第二个是支付宝交易额度
        String start = year+"-01-01 00:00:00";
        String end = year+"-12-31 23:59:59";
        DateTimeFormatter ftf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime parse_start = LocalDateTime.parse(start, ftf);
        LocalDateTime parse_end = LocalDateTime.parse(end, ftf);
        Long startTime = LocalDateTime.from(parse_start).atZone(ZoneId.systemDefault()).toInstant().toEpochMilli();
        Long endTime = LocalDateTime.from(parse_end).atZone(ZoneId.systemDefault()).toInstant().toEpochMilli();
        List<PurchasePO> purchasePOList = purchaseMapper.selectList(Wrappers.lambdaQuery(PurchasePO.class)
                .ge(PurchasePO::getCreateTime,new Date(startTime))
                .le(PurchasePO::getCreateTime,new Date(endTime))
                .eq(PurchasePO::getPayStatus,1));
        for(PurchasePO po:purchasePOList){
            totalMoney = totalMoney.add(po.getAmount());
            totalDesk++;
        }

        return new ReportVO(year,totalMoney.doubleValue(),totalDesk.intValue(),null,null,null);
    }
}
