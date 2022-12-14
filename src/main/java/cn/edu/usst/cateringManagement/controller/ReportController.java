package cn.edu.usst.cateringManagement.controller;

import cn.edu.usst.cateringManagement.bean.vo.ReportVO;
import cn.edu.usst.cateringManagement.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Transactional
public class ReportController {
    @Autowired
    ReportService reportService;
    @RequestMapping(value = "/report/day",method = RequestMethod.GET)
    public ReportVO getDay(String day){
        return reportService.getDayReport(day);
    }
    @RequestMapping(value = "/report/month",method = RequestMethod.GET)
    public ReportVO getMonth(String month){
        return reportService.getMonthReport(month);
    }
    @RequestMapping(value = "/report/year",method = RequestMethod.GET)
    public ReportVO getYear(String year){
        return reportService.getYearReport(year);
    }
}
