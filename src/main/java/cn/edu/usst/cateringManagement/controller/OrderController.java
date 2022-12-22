package cn.edu.usst.cateringManagement.controller;

import cn.edu.usst.cateringManagement.bean.po.CustomerPO;
import cn.edu.usst.cateringManagement.bean.po.DishPO;
import cn.edu.usst.cateringManagement.bean.po.PurchaseDishPO;
import cn.edu.usst.cateringManagement.bean.po.PurchasePO;
import cn.edu.usst.cateringManagement.mapper.DishMapper;
import cn.edu.usst.cateringManagement.mapper.PurchaseDishMapper;
import cn.edu.usst.cateringManagement.mapper.PurchaseMapper;
import cn.edu.usst.cateringManagement.utils.Constant;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@RestController
@Slf4j
@RequestMapping("/order")
public class OrderController {
    @Autowired
    PurchaseMapper purchaseMapper;

    @Autowired
    DishMapper dishMapper;
    @Autowired
    PurchaseDishMapper purchaseDishMapper;

    /**
     * 向purchaseDish表中插入信息
     * @param dish_id 菜品ID
     * @param number 菜品数量
     * @param purchase_id 订单ID
     */
    private void addDish(Integer dish_id,Integer number,Integer purchase_id){
        if(purchaseDishMapper.exists(Wrappers.lambdaQuery(PurchaseDishPO.class)
                .eq(PurchaseDishPO::getPurchaseId,purchase_id)
                .eq(PurchaseDishPO::getDishId,dish_id))){
            PurchaseDishPO po = purchaseDishMapper.selectOne(Wrappers.lambdaQuery(PurchaseDishPO.class)
                    .eq(PurchaseDishPO::getPurchaseId,purchase_id)
                    .eq(PurchaseDishPO::getDishId,dish_id));
            po.setDishNum(number+ po.getDishNum());
            purchaseDishMapper.updateById(po);
        }
        else{
            purchaseDishMapper.insert(new PurchaseDishPO(purchase_id,dish_id,number));
        }
    }
    @PostMapping()
    public String post(@RequestBody List<Map> list,
                       HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");
        System.out.println(list);
        try {
            BigDecimal totalPrice = new BigDecimal("0");
            LambdaQueryWrapper<DishPO> dishQueryWrapper;
            for (Map map : list) {
                int id = Integer.parseInt((String) map.get("index")); //每道菜的id
                String number = (String) map.get("number"); //每道菜的已点数量
                //查找该菜的价格
                dishQueryWrapper = new LambdaQueryWrapper<>();
                dishQueryWrapper.eq(DishPO::getId, id);
                DishPO dish = dishMapper.selectOne(dishQueryWrapper);
                totalPrice = totalPrice.add(dish.getPrice().multiply(new BigDecimal(number)));
                System.out.println("id:" + id + ",number:" + number + ",price:" + dish.getPrice() + ",totalPrice:" + totalPrice);
            }

            //从session中读用户信息
            HttpSession session = request.getSession(true);
            CustomerPO customer = (CustomerPO) session.getAttribute(Constant.USER);

            //从数据库读出该用户的订单信息
            LambdaQueryWrapper<PurchasePO> purchaseQueryWrapper = new LambdaQueryWrapper<>();
            purchaseQueryWrapper.eq(PurchasePO::getCustomerId, customer.getId());
            PurchasePO purchase = purchaseMapper.selectOne(purchaseQueryWrapper);

            //修改该订单信息
            LambdaUpdateWrapper<PurchasePO> purchaseUpdateWrapper = new LambdaUpdateWrapper<>();
            purchaseUpdateWrapper.set(PurchasePO::getAmount, purchase.getAmount().add(totalPrice))
                    .eq(PurchasePO::getId, purchase.getId());
            purchaseMapper.update(purchase, purchaseUpdateWrapper);
        } catch (Exception e) {
            return e.getMessage(); //下单失败，返回失败信息
        }
        return "ok"; //下单成功，返回"ok"
    }
}