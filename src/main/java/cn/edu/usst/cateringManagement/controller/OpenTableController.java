package cn.edu.usst.cateringManagement.controller;

import cn.edu.usst.cateringManagement.bean.po.CustomerPO;
import cn.edu.usst.cateringManagement.bean.po.DeskPO;
import cn.edu.usst.cateringManagement.bean.po.PurchasePO;
import cn.edu.usst.cateringManagement.mapper.CustomerMapper;
import cn.edu.usst.cateringManagement.mapper.DeskMapper;
import cn.edu.usst.cateringManagement.mapper.PurchaseMapper;
import cn.edu.usst.cateringManagement.utils.Constant;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;

@RestController
@RequestMapping("/openTable")
public class OpenTableController {
   @Autowired
   PurchaseMapper purchaseMapper;

   @Autowired
   DeskMapper deskMapper;

   @Autowired
   CustomerMapper customerMapper;

   @GetMapping
   public int get(HttpServletRequest request, HttpServletResponse response) throws IOException {
      request.setCharacterEncoding("utf-8");
      response.setContentType("text/html;charset=UTF-8");
      //获取前端传来的人数
      int number = Integer.parseInt(request.getParameter("number"));

      //从session中读用户信息
      HttpSession session = request.getSession(true);
      CustomerPO customer = (CustomerPO) session.getAttribute(Constant.USER);
      System.out.println(customer.getName());

      //访问数据库，找到一个合适的座位（Desk.seat_num>=number && Desk.status=0）（找到一个合适的返回即可）
      LambdaQueryWrapper<DeskPO> deskQueryWrapper = new LambdaQueryWrapper<>();
      deskQueryWrapper.eq(DeskPO::getStatus, 0)
              .ge(DeskPO::getSeatNum, number)
              .last("LIMIT 1");
      DeskPO desk = deskMapper.selectOne(deskQueryWrapper);
      if (ObjectUtils.isNull(desk)) {
         return 0; //如果没有找到合适的座位，返回0
      }

      //将查询到的这个餐桌的status设置为1
      LambdaUpdateWrapper<DeskPO> deskUpdateWrapper = new LambdaUpdateWrapper<>();
      deskUpdateWrapper.set(DeskPO::getStatus, 1)
              .eq(DeskPO::getId, desk.getId());
      deskMapper.update(desk, deskUpdateWrapper);

      //创建新的订单信息
      PurchasePO purchase = new PurchasePO();
      purchase.setCreateTime(new Date()); //获取当前时间
      purchase.setCustomerId(customer.getId()); //用户id
      purchase.setDeskId(desk.getId()); //座位号
      purchase.setPayStatus(0);
      purchase.setAmount(new BigDecimal("0"));
      purchase.setPayMethod(null);
      //purchase.setId(1); //订单id自增
      try {
         purchaseMapper.insert(purchase);
      } catch (Exception e) {
         System.out.println(e.getMessage());
      }

      //将这个座位号返回给前端
      System.out.println("开台成功，座位号为" + desk.getId());
      return desk.getId();
   }
}
