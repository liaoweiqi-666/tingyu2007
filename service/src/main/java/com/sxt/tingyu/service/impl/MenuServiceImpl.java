package com.sxt.tingyu.service.impl;

import com.sxt.tingyu.pojo.Menu;
import com.sxt.tingyu.mapper.MenuMapper;
import com.sxt.tingyu.service.IMenuService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
@Service
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements IMenuService {


    @Autowired
    private MenuMapper menuMapper;

    @Override
    public List<Menu> selectMenuByAdminId(Integer aid) {



        return menuMapper.selectMenuByAdminId(aid);
    }
}
