package com.sxt.tingyu.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sxt.tingyu.pojo.Admin;
import com.sxt.tingyu.pojo.Company;
import com.sxt.tingyu.pojo.Menu;
import com.sxt.tingyu.pojo.ResultData;
import com.sxt.tingyu.service.IMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
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
@RequestMapping("/menu")
public class MenuController {


    @Autowired
    private IMenuService iMenuService;

    /**
     * 通过当前登录用户查询对对应的菜单
     * @param session
     * @return
     */
    @RequestMapping("/selectMenuByLoginAdmin")
    @ResponseBody
    public List<Menu> list(HttpSession session){

        //从Session获取登录用户信息
       Admin admin =  (Admin) session.getAttribute("admin");
        System.out.println(iMenuService);
        List<Menu> menus = iMenuService.selectMenuByAdminId(admin.getAid());

        return  menus;
    }



    @RequestMapping("/list")
    @ResponseBody
    public List<Menu> list(){
        return iMenuService.list();
    }

    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public ResultData saveOrUpdate(Menu menu){

        menu.setIsparent("1");
        menu.setStatus("0");
        boolean flag = iMenuService.saveOrUpdate(menu);

        return flag ? ResultData.ok("操作成功"):ResultData.error("操作数据失败，请联系管理员");

    }


    /**
     * 删除菜单
     * 删除思路
     * 1，先根据当前id去数据库查询是否还有子菜单
     *   1.1 有 提示用户不能删除
     *   1.2 没有： 可以删除
     * @param mid 菜单id
     * @return
     */
    @RequestMapping("/delete")
    @ResponseBody
    public ResultData delete(Integer mid){

        //1，先根据当前id去数据库查询是否还有子菜单数据
        QueryWrapper<Menu> menuQueryWrapper = new QueryWrapper<>();
        menuQueryWrapper.eq("pid",mid);

        List<Menu> children = iMenuService.list(menuQueryWrapper);

        if(children.size() > 0){
            return ResultData.error("此菜单还有子菜单，请先删除子菜单");
        }

        boolean flag = iMenuService.removeById(mid);

        return flag ? ResultData.ok("删除菜单成功"):ResultData.error("删除菜单失败，请联系管理员");
    }





    @RequestMapping("/menuManager")
    public String menuManager(){
        return "menuManager";
    }


}

