package cn.edu.usst.cateringManagement.controller;

import cn.edu.usst.cateringManagement.bean.po.DishPO;
import cn.edu.usst.cateringManagement.bean.po.DishTypePO;
import cn.edu.usst.cateringManagement.mapper.DishMapper;
import cn.edu.usst.cateringManagement.mapper.DishTypeMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@Slf4j
@RequestMapping("/dish")
public class ReadDishController {
    @Autowired
    DishMapper dishMapper;

    @Autowired
    DishTypeMapper dishTypeMapper;

    @GetMapping
    public void get(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");
        //从数据库获取菜品类型信息
        LambdaQueryWrapper<DishTypePO> dishTypeQueryWrapper = new LambdaQueryWrapper<>();//新建LambdaQueryWrapper对象
        List<DishTypePO> typeList = new ArrayList<>();
        try {
            typeList = dishTypeMapper.selectList(dishTypeQueryWrapper);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        //从数据库获取菜品信息
        Map<Integer, List<DishPO>> dishMap = new HashMap<>(); //所有菜品信息
        //Map<Integer, String> pictureMap= new HashMap<>();
        for (DishTypePO type : typeList) {
            LambdaQueryWrapper<DishPO> dishQueryWrapper = new LambdaQueryWrapper<>();
            dishQueryWrapper.eq(DishPO::getDishTypeId, type.getId());
            List<DishPO> dishList = new ArrayList<>(); //商品类型为type.getId()的菜品信息
            try {
                dishList = dishMapper.selectList(dishQueryWrapper);
                for (DishPO dish : dishList) {
                    //将数据库图片转成本地图片
                    saveImage(dish.getPicture(), dish.getId());
                }
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
            dishMap.put(type.getId(), dishList);
        }
        //将菜品信息输出到页面上
        request.setAttribute("typeList", typeList);
        request.setAttribute("dishMap", dishMap);
        RequestDispatcher rd = request.getRequestDispatcher("/menu.jsp");
        rd.forward(request, response);
    }

    public static void saveImage(byte[] bytes1, int id) {
        try {
//            byte[] bytes1 = Base64.decodeBase64(base64String);
            ByteArrayInputStream bais = new ByteArrayInputStream(bytes1);
            BufferedImage bi1 = ImageIO.read(bais);
            File w2 = new File("./src/main/webapp/static/picture/" + id + "picture.jpg"); //图片命名：编号+picture.jpg
            ImageIO.write(bi1, "jpg", w2);// 不管输出什么格式图片，此处不需改动
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}