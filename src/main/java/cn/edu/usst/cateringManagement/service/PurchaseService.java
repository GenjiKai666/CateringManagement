package cn.edu.usst.cateringManagement.service;

import cn.edu.usst.cateringManagement.bean.po.PurchaseDishPO;
import cn.edu.usst.cateringManagement.bean.po.PurchasePO;
import cn.edu.usst.cateringManagement.mapper.PurchaseDishMapper;
import cn.edu.usst.cateringManagement.mapper.PurchaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PurchaseService {
    @Autowired
    PurchaseMapper purchaseMapper;
    @Autowired
    PurchaseDishMapper purchaseDishMapper;

    /**
     * 创建订单
     *
     * @param purchasePO 订单类
     * @return 成功返回1
     */
    public int createPurchase(PurchasePO purchasePO) {
        return purchaseMapper.insert(purchasePO);
    }

    /**
     * 通过订单ID查询订单
     *
     * @param id 订单ID
     * @return 返回类
     */
    public PurchasePO getPurchaseById(int id) {
        return purchaseMapper.selectById(id);
    }

    /**
     * 通过用户ID查询其所有订单
     *
     * @param userId 用户ID
     * @return 返回类的集合,按照订单ID排序
     */
    public List<PurchasePO> getPurchaseByUser(int userId) {
        return purchaseMapper
                .selectList(Wrappers.lambdaQuery(PurchasePO.class)
                        .eq(PurchasePO::getCustomerId, userId)
                        .last("order by ID"));
    }

    /**
     * 通过订单ID返回订单所点菜品
     * @param purchaseId 订单ID
     * @return 返回类的集合,按照菜品ID排序
     */
    public List<PurchaseDishPO> getPurchaseDishById(int purchaseId){
        return purchaseDishMapper
                .selectList(Wrappers.lambdaQuery(PurchaseDishPO.class)
                        .eq(PurchaseDishPO::getDishId, purchaseId)
                        .last("order by DISH_ID"));
    }

    /**
     * 对某个订单进行支付
     *
     * @param purchaseId 订单ID
     * @param payMethod 支付方式
     * @return 支付成功返回1，失败返回0
     */
    public int pay(int purchaseId, String payMethod) {
        PurchasePO target = purchaseMapper.selectById(purchaseId);
        if (target != null) {
            if (target.getPayStatus() == 0) {
                target.setPayMethod(payMethod);
                target.setPayStatus(1);
                purchaseMapper.updateById(target);
                return 1;
            }
        }
        return 0;
    }
}