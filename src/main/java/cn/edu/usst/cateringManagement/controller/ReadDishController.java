package cn.edu.usst.cateringManagement.controller;

import cn.edu.usst.cateringManagement.bean.po.DishPO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@RestController
@Slf4j
@RequestMapping("/readDish")
public class ReadDishController extends HttpServlet {
    @GetMapping
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //从数据库获取菜品信息
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");
        List dishList = new ArrayList();
        DishPO dish = new DishPO();
        dish.setId(1);
        dish.setDishName("beef");
        dish.setDishTypeId(1);
        dish.setPicture(new byte[10]);
        dish.setPrice(new BigDecimal("3.14"));
        DishPO dish2 = new DishPO();
        dish2.setId(2);
        dish2.setDishName("beef2");
        dish2.setDishTypeId(2);
        dish2.setPicture(new byte[10]);
        dish2.setPrice(new BigDecimal("10.14"));
        dishList.add(dish);
        dishList.add(dish2);
        //将菜品信息输出到页面上
//        return dishList;
        request.setAttribute("dishList", dishList);
        RequestDispatcher rd = request.getRequestDispatcher("/menu.jsp");
        rd.forward(request, response);
    }

}