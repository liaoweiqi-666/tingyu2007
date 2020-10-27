package com.sxt.tingyu.mapper;

import com.sxt.tingyu.pojo.Menu;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
public interface MenuMapper extends BaseMapper<Menu> {

    /**
     * 根据管理员的id查询出菜单信息
     * @param aid 管理员id
     * @return
     */
    List<Menu> selectMenuByAdminId(Integer aid);


}
