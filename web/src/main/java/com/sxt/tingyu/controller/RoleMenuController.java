package com.sxt.tingyu.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sxt.tingyu.mapper.RoleMenuMapper;
import com.sxt.tingyu.pojo.RoleMenu;
import com.sxt.tingyu.service.IRoleMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
@Controller
@RequestMapping("/roleMenu")
public class RoleMenuController {

    @Autowired
    private IRoleMenuService roleMenuService;

    /**
     * 根据角色的id 查询出对应的菜单id
     * @param rid 角色id
     * @return 角色拥有的菜单的id的集合
     */
    @RequestMapping("/selectRoleMenuByRid")
    @ResponseBody
    public List<Integer> selectRoleMenuByRid(Integer rid){

        //创建条件对象
        QueryWrapper<RoleMenu> queryWrapper = new QueryWrapper<>();
        //设置角色id条件
        queryWrapper.eq("rid",rid);
        //查询所有的角色菜单信息
        List<RoleMenu> roleMenus = roleMenuService.list(queryWrapper);

        List<Integer> mids = new ArrayList<>();
        for (RoleMenu roleMenu : roleMenus) {
            mids.add(roleMenu.getMid());
        }

        return mids;

    }

}

