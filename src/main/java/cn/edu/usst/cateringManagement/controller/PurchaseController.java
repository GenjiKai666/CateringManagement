package cn.edu.usst.cateringManagement.controller;

import cn.edu.usst.cateringManagement.bean.dto.PurchaseDTO;
import cn.edu.usst.cateringManagement.bean.po.CustomerPO;
import cn.edu.usst.cateringManagement.bean.po.PurchaseDishPO;
import cn.edu.usst.cateringManagement.bean.po.PurchasePO;
import cn.edu.usst.cateringManagement.bean.vo.PurchaseDishVO;
import cn.edu.usst.cateringManagement.bean.vo.PurchaseVO;
import cn.edu.usst.cateringManagement.mapper.PurchaseDishMapper;
import cn.edu.usst.cateringManagement.mapper.PurchaseMapper;
import cn.edu.usst.cateringManagement.service.PurchaseService;
import cn.edu.usst.cateringManagement.utils.Constant;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@RestController
@Transactional
public class PurchaseController {
    @Autowired
    PurchaseService purchaseService;
    @Autowired
    PurchaseMapper purchaseMapper;
    @Autowired
    PurchaseDishMapper purchaseDishMapper;

    /**
     * 创建订单,仅做测试用,不定时删除,请不要使用
     *
     * @param purchaseDTO 用户传入数据类
     * @return 成功返回1
     */
    @RequestMapping(value = "/bill/create", method = RequestMethod.POST)
    public int createBill(@RequestBody PurchaseDTO purchaseDTO) {
        //向数据库中插入订单数据，不包括菜品数据
        PurchasePO purchasePO = new PurchasePO(null,
                new Date(purchaseDTO.getCreateTime()),
                new BigDecimal(purchaseDTO.getAmount()),
                null,
                0,
                purchaseDTO.getCustomerId(),
                purchaseDTO.getDeskId());
        purchaseService.createPurchase(purchasePO);
        Integer purchaseId = purchasePO.getId();
        //插入订单内菜品的数据
        for (int i = 0; i < purchaseDTO.getDishId().length; i++) {
            purchaseDishMapper.insert(new PurchaseDishPO(purchaseId,
                    purchaseDTO.getDishId()[i],
                    purchaseDTO.getDishNum()[i]));
        }
        return 1;
    }

    /**
     * 获取订单所有信息,包括菜品信息
     *
     * @param id 订单ID
     * @return PurchaseVO类
     */
    @RequestMapping(value = "/bill/selectbyid", method = RequestMethod.GET)
    public PurchaseVO selectById(@RequestParam("id") @NotNull Integer id) {
        PurchasePO purchasePO = purchaseService.getPurchaseById(id);
        if (purchasePO != null) {
            List<PurchaseDishPO> purchaseDishPO = purchaseService.getPurchaseDishById(id);
            List<PurchaseDishVO> purchaseDishVO = new ArrayList<>(purchaseDishPO.size());
            for (PurchaseDishPO dishPO : purchaseDishPO) {
                purchaseDishVO.add(new PurchaseDishVO(dishPO.getDishId(), dishPO.getDishNum()));
            }
            if (purchaseDishPO != null) {
                return new PurchaseVO(purchasePO.getId(),
                        purchasePO.getCreateTime(),
                        purchasePO.getAmount(),
                        purchasePO.getPayMethod(),
                        purchasePO.getPayStatus(),
                        purchasePO.getCustomerId(),
                        purchasePO.getDeskId(),
                        purchaseDishVO);
            }
        }
        return null;
    }
    @RequestMapping(value = "/bill/getpayurl",method = RequestMethod.GET)
    public String[] getPayURL(@RequestParam("id") @NotNull Integer id){
        String[] payurl = new String[2];
        payurl[0] = "localhost:8080/bill/pay?id="+id+"&&payMethod=Alipay";
        payurl[1] = "localhost:8080/bill/pay?id="+id+"&&payMethod=Wechat";
        return payurl;
    }

    /**
     * 支付订单
     * @param id 订单ID
     * @param payMethod 支付方法
     * @return 成功返回1 失败返回0
     */
    @RequestMapping(value = "/bill/pay",method = RequestMethod.GET)
    public int payById(@RequestParam("id") @NotNull Integer id,
                       @RequestParam("payMethod") @NotNull String payMethod){
        if(purchaseService.pay(id,payMethod) == 1){
            return 1;
        }
        return 0;
    }
    @RequestMapping(value = "/purchase/getpurchasesbyuserid",method = RequestMethod.GET)
    public List<PurchaseVO> getPurchasesByUserId(HttpSession session){
        CustomerPO customerPO = (CustomerPO)session.getAttribute(Constant.USER);
        Integer userid = customerPO.getId();
        List<PurchasePO> purchasePOList = purchaseMapper.selectList(Wrappers
                .lambdaQuery(PurchasePO.class).eq(PurchasePO::getCustomerId,userid));
        List<PurchaseVO> purchaseVOS = new ArrayList<>();
        for(PurchasePO po:purchasePOList){
            purchaseVOS.add(selectById(po.getId()));
        }
        return purchaseVOS;
    }
}