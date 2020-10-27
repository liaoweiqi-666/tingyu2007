package com.sxt.tingyu.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sxt.tingyu.pojo.*;
import com.sxt.tingyu.service.IAdminRoleService;
import com.sxt.tingyu.service.IMenuService;
import com.sxt.tingyu.service.IRoleService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Objects;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private IRoleService roleService;


    @Autowired
    private IAdminRoleService adminRoleService;


    @RequestMapping("/roleManager")
    public String roleManager(){
        return "roleManager";
    }


    @RequestMapping("/list")
    @ResponseBody
    public DataGridResult list( @RequestParam(defaultValue = "10") Integer rows, @RequestParam(defaultValue = "1") Integer page){


        //创建分页条件对象
        Page<Role> rolePage = new Page<>(page, rows);
        //执行查询返回结果
        Page<Role> result = roleService.page(rolePage);

        //创建DataGrid对象
        DataGridResult dataGridResult = new DataGridResult();
        dataGridResult.setRows(result.getRecords());
        dataGridResult.setTotal(result.getTotal());
        return dataGridResult;

    }


    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public ResultData saveOrUpdate(Role role,Integer[] mids){
       boolean flag =  roleService.saveOrUpdateRoleAndRoleMenu(role,mids);

        return flag ? ResultData.ok("操作成功"):ResultData.error("操作数据失败，请联系管理员");
    }

    /**
     * 删除指定角色id对应的数据（包括角色菜单数据）
     * @param rid
     * @return
     */
    @RequestMapping("/deleteByIdRid")
    @ResponseBody
    public ResultData deleteByIdRid(Integer rid){
        //删除之前先判断当前角色是否还有管理员，如果有不能删除
        QueryWrapper<AdminRole> adminRoleQueryWrapper = new QueryWrapper<>();
        adminRoleQueryWrapper.eq("rid",rid);

        List<AdminRole> adminRoles = adminRoleService.list(adminRoleQueryWrapper);

        if(adminRoles.size()>0){
            return ResultData.error("此角色下面还有管理员，不能删除");
        }

        boolean flag = roleService.deleteByIdRid(rid);

        return  flag ? ResultData.ok("删除数据成功"):ResultData.error("删除数据失败，请联系管理员");
    }

}

