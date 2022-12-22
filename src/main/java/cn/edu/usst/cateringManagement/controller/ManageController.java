package cn.edu.usst.cateringManagement.controller;

import cn.edu.usst.cateringManagement.bean.po.CustomerPO;
import cn.edu.usst.cateringManagement.bean.po.DeskPO;
import cn.edu.usst.cateringManagement.bean.po.DishPO;
import cn.edu.usst.cateringManagement.bean.po.DishTypePO;
import cn.edu.usst.cateringManagement.mapper.CustomerMapper;
import cn.edu.usst.cateringManagement.mapper.DeskMapper;
import cn.edu.usst.cateringManagement.mapper.DishMapper;
import cn.edu.usst.cateringManagement.mapper.DishTypeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;

@Controller
@SpringBootApplication(scanBasePackages="cn.edu.usst.cateringManagement")
@MultipartConfig
public class ManageController {

    @Autowired
    DeskMapper deskMapper;
    @Autowired
    CustomerMapper customerMapper;
    @Autowired
    DishMapper dishMapper;
    @Autowired
    DishTypeMapper dishTypeMapper;

    @RequestMapping(value = "/management",method = RequestMethod.GET)
    public void showManagePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        String name = request.getParameter("name");
        String buttonName = request.getParameter("buttonName");

        if (buttonName != null && buttonName.equals("insert")) {
            request.setAttribute("action","insert");
        }
        if (buttonName != null && buttonName.equals("delete")) {
            request.setAttribute("action", "delete");
        }
        if (buttonName == null) {
            request.setAttribute("action", "update");
        }

        RequestDispatcher requestDispatcher;
        if ( name == null) {
            request.setAttribute("tableName", "desk");
            List<DeskPO> deskPOList = deskMapper.selectList(null);
            request.setAttribute("tableData", deskPOList);
        }
        if ( name != null && name.equalsIgnoreCase("desk")) {
            request.setAttribute("tableName", "desk");
            List<DeskPO> deskPOList = deskMapper.selectList(null);
            request.setAttribute("tableData", deskPOList);
        }
        if ( name != null && name.equalsIgnoreCase("dish")) {
            List<DishTypePO> dishTypePOList = dishTypeMapper.selectList(null);
            request.setAttribute("dishTypes",dishTypePOList);
            request.setAttribute("tableName","dish");
            List<DishPO> dishPOList = dishMapper.selectList(null);
            request.setAttribute("tableData",dishPOList);
        }
        if ( name != null && name.equalsIgnoreCase("dishType")) {
            List<DishTypePO> dishTypePOList = dishTypeMapper.selectList(null);
            request.setAttribute("tableData",dishTypePOList);
            request.setAttribute("tableName", "dishType");
        }
        if ( name != null && name.equalsIgnoreCase("customer")) {
            request.setAttribute("tableName", "customer");
            List<CustomerPO> customerPOList = customerMapper.selectList(null);
            request.setAttribute("tableData", customerPOList);
        }
        requestDispatcher = request.getRequestDispatcher("manage.jsp");
        requestDispatcher.forward(request, response);
    }





    @RequestMapping(value = "/handle", method = RequestMethod.POST)
    public void handleTable(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html");
        response.setCharacterEncoding("utf-8");

        String name = request.getParameter("name");
        String buttonName = request.getParameter("buttonName");

        RequestDispatcher requestDispatcher;

        if(name.equals("desk")){
            if (buttonName != null && buttonName.equals("insert")){
                String seatNum = request.getParameter("desk-insert-seatNum");
                String status = request.getParameter("desk-insert-status");
                System.out.println(status);
                DeskPO deskPO = new DeskPO(null, Integer.parseInt(seatNum), Integer.parseInt(status));
                deskMapper.insert(deskPO);
            }
            if (buttonName != null && buttonName.equals("delete")){
                String[] deleteId = request.getParameterValues("deleteBox");
                for(String id : deleteId){
                    deskMapper.deleteById(Integer.parseInt(id));
                }
            }
            if (buttonName != null && buttonName.equals("update")){
                List<DeskPO> updateList = deskMapper.selectList(null);
                for(int i = 0 ; i < updateList.size(); i++){
                    int id = updateList.get(i).getId();
                    int updateSeatNum = Integer.parseInt(request.getParameter("desk-"+id+"-seatNum"));
                    int updateStatus = Integer.parseInt(request.getParameter("desk-"+id+"-status"));
                    updateList.get(i).setSeatNum(updateSeatNum);
                    updateList.get(i).setStatus(updateStatus);
                    deskMapper.updateById(updateList.get(i));
                }
            }
            List<DeskPO> deskPOList = deskMapper.selectList(null);
            request.setAttribute("tableName", "desk");
            request.setAttribute("tableData", deskPOList);
        }
        if(name.equals("customer")){
            if (buttonName != null && buttonName.equals("insert")){
                String insertName = request.getParameter("customer-insert-name");
                String insertPassword = request.getParameter("customer-insert-password");
                String insertPhone = request.getParameter("customer-insert-phone");
                CustomerPO customerPO = new CustomerPO(null,insertName,insertPassword,insertPhone);
                customerMapper.insert(customerPO);
            }
            if (buttonName != null && buttonName.equals("delete")){
                String[] deleteId = request.getParameterValues("deleteBox");
                for(String id : deleteId){
                    customerMapper.deleteById(Integer.parseInt(id));
                }
            }
            if (buttonName != null && buttonName.equals("update")){
                List<CustomerPO> updateList = customerMapper.selectList(null);
                for(int i = 0 ; i < updateList.size(); i++){
                    CustomerPO customerPO = updateList.get(i);
                    int id = customerPO.getId();
                    String updateName = request.getParameter("customer-"+id+"-name");
                    String updatePassword = request.getParameter("customer-"+id+"-password");
                    String updatePhone = request.getParameter("customer-"+id+"-phone");
                    customerPO.setName(updateName);
                    customerPO.setPassword(updatePassword);
                    customerPO.setPhone(updatePhone);
                    customerMapper.updateById(customerPO);
                }
            }
            List<CustomerPO> customerPOList = customerMapper.selectList(null);
            request.setAttribute("tableName", "customer");
            request.setAttribute("tableData", customerPOList);
        }
        if(name.equals("dish")){
            if (buttonName != null && buttonName.equals("insert")){
                String insertName = request.getParameter("dish-insert-dishName");
                String insertPrice = request.getParameter("dish-insert-price");
                String insertDishTypeId = request.getParameter("dish-insert-dishTypeId");
                String insertPicture = request.getParameter("dish-insert-picture");
                DishPO dishPO = new DishPO(null,insertName,null,new BigDecimal(insertPrice),Integer.parseInt(insertDishTypeId));
                dishMapper.insert(dishPO);
            }
            if (buttonName != null && buttonName.equals("delete")){
                String[] deleteId = request.getParameterValues("deleteBox");
                for(String id : deleteId){
                    dishMapper.deleteById(Integer.parseInt(id));
                }
            }
            if (buttonName != null && buttonName.equals("update")){
                List<DishPO> updateList = dishMapper.selectList(null);
                for(int i = 0 ; i < updateList.size(); i++){
                    DishPO dishPO = updateList.get(i);
                    int id = dishPO.getId();
                    String updateDishName = request.getParameter("dish-"+id+"-dishName");
                    BigDecimal updatePrice = new BigDecimal(request.getParameter("dish-"+id+"-price"));
                    int updateDishTypeId = Integer.parseInt(request.getParameter("dish-"+id+"-dishTypeId"));
                    dishPO.setDishName(updateDishName);
                    dishPO.setPrice(updatePrice);
                    dishPO.setDishTypeId(updateDishTypeId);
                    dishMapper.updateById(dishPO);
                }
            }
            List<DishTypePO> dishTypePOList = dishTypeMapper.selectList(null);
            request.setAttribute("dishTypes",dishTypePOList);
            List<DishPO> dishPOList = dishMapper.selectList(null);
            request.setAttribute("tableName", "dish");
            request.setAttribute("tableData", dishPOList);
        }
        if(name.equals("dishType")){
            if (buttonName != null && buttonName.equals("insert")){
                String insertName = request.getParameter("dishType-insert-name");
                DishTypePO dishTypePO = new DishTypePO(null,insertName);
                dishTypeMapper.insert(dishTypePO);
            }
            if (buttonName != null && buttonName.equals("delete")){
                String[] deleteId = request.getParameterValues("deleteBox");
                for(String id : deleteId){
                    dishTypeMapper.deleteById(Integer.parseInt(id));
                }
            }
            if (buttonName != null && buttonName.equals("update")){
                List<DishTypePO> updateList = dishTypeMapper.selectList(null);
                for(int i = 0 ; i < updateList.size(); i++){
                    DishTypePO dishTypePO = updateList.get(i);
                    int id = dishTypePO.getId();
                    String updateName = request.getParameter("dishType-"+id+"-name");
                    dishTypePO.setName(updateName);
                    dishTypeMapper.updateById(dishTypePO);
                }
            }
            List<DishTypePO> dishTypePOList = dishTypeMapper.selectList(null);
            request.setAttribute("tableName", "dishType");
            request.setAttribute("tableData", dishTypePOList);
        }
        request.setAttribute("action","update");
        requestDispatcher = request.getRequestDispatcher("manage.jsp");
        requestDispatcher.forward(request, response);
    }


}

