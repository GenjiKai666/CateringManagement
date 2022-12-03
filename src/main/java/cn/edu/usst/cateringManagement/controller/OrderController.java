package cn.edu.usst.cateringManagement.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@RestController
@Slf4j
@RequestMapping("/order")
public class OrderController extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取前端传来的点餐数据（每道菜的id，已点数量）
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");
        Map<String, String[]> map = request.getParameterMap();
        System.out.println("map:" + map.toString());
        //将点餐数据更新至数据库

        //返回前端点菜完成页面（或者跳转到失败页面）
        return;

    }

}