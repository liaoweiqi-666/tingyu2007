package com.sxt.tingyu.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.sxt.tingyu.pojo.Host;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
public interface HostMapper extends BaseMapper<Host> {

    @Select("select h.*,hp.hpdiscount,hp.hpstar from t_host h left join t_host_power hp ON h.hid = hp.hostid ${ew.customSqlSegment}")
    IPage<Host> selectHostPageData(@Param(Constants.WRAPPER) Wrapper wrapper,IPage<Host> page);

}
