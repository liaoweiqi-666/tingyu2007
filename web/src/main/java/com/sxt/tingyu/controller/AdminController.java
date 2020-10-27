package com.sxt.tingyu.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.sxt.tingyu.pojo.Admin;
import com.sxt.tingyu.service.IAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpSession;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private IAdminService adminService;

    @RequestMapping("/login")
    public String login(String aname, String apwd, Model model, HttpSession session){

        QueryWrapper<Admin> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("aname",aname);
        queryWrapper.eq("apwd",apwd);

        Admin admin = adminService.getOne(queryWrapper);
        System.out.println("admin :"+admin);
        if(admin == null){
            model.addAttribute("errorMsg","账号密码错误！请重新登录");
            return "forward:/login.jsp";
        }
        //共享登录用户对象
        session.setAttribute("admin",admin);

        return "redirect:/index.do";
    }

}

