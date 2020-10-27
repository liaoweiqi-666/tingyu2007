package com.sxt.tingyu.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sxt.tingyu.pojo.DataGridResult;
import com.sxt.tingyu.pojo.MarriedPerson;
import com.sxt.tingyu.pojo.ResultData;
import com.sxt.tingyu.service.IMarriedPersonService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDateTime;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
@Controller
@RequestMapping("/married")
public class MarriedPersonController {



    @Autowired
    private IMarriedPersonService marriedPersonService;


    @RequestMapping("/marriedManager")
    public String marriedManager(){
        return "marriedManager";
    }


    @RequestMapping("/list")
    @ResponseBody
    public DataGridResult list(MarriedPerson marriedPerson, @RequestParam(defaultValue = "1") Integer page,@RequestParam(defaultValue = "10") Integer rows){


        //创建分页对象
        Page<MarriedPerson> marriedPersonPage = new Page<>(page, rows);


        //创建条件对象

        QueryWrapper<MarriedPerson> queryWrapper = new QueryWrapper<>();
        if(StringUtils.isNotBlank(marriedPerson.getPname())){
            queryWrapper.like("pname",marriedPerson.getPname());
        }
        if(StringUtils.isNotBlank(marriedPerson.getPhone())){
            queryWrapper.like("phone",marriedPerson.getPhone());
        }


        //执行分页查询
        Page<MarriedPerson> result = marriedPersonService.page(marriedPersonPage, queryWrapper);

        //封装DataGrid对象
        DataGridResult dataGridResult = new DataGridResult();
        dataGridResult.setRows(result.getRecords());
        dataGridResult.setTotal(result.getTotal());

        return  dataGridResult;

    }


    @RequestMapping("/insert")
    @ResponseBody
    public ResultData insert(MarriedPerson marriedPerson){

        //设置默认为启用状态
        marriedPerson.setStatus("1");
        //设置当前时间为注册时间
        marriedPerson.setRegdate(LocalDateTime.now());

        boolean flag = marriedPersonService.save(marriedPerson);

        return flag ? ResultData.ok("注册成功"):ResultData.error("注册失败！");
    }

}

