package cn.edu.usst.cateringManagement.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@RestController
@RequestMapping("/openTable")
public class OpenTableController {

//   @Resource
//   private DishService dishService;


   @GetMapping
   public int doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      //获取前端传来的人数
      request.setCharacterEncoding("utf-8");
      response.setContentType("text/html;charset=UTF-8");
      int number = Integer.parseInt(request.getParameter("number"));
      String phoneNumber = request.getParameter("phoneNumber");
      String fullName = request.getParameter("fullName");
      //将用户信息放入session
      HttpSession session = request.getSession(true);
      session.setAttribute("phoneNumber", phoneNumber);
      session.setAttribute("fullName", fullName);
      //访问数据库，找到一个合适的座位
      int seat = 12;
      //将这个座位号返回给前端
      return seat;
   }
}
