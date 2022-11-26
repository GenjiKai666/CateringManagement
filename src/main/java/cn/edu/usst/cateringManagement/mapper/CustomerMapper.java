package cn.edu.usst.cateringManagement.mapper;

import cn.edu.usst.cateringManagement.bean.po.CustomerPO;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CustomerMapper extends BaseMapper<CustomerPO> {
}
