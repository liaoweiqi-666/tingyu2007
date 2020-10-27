package com.sxt.tingyu.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sxt.tingyu.pojo.DataGridResult;
import com.sxt.tingyu.pojo.Planner;
import com.sxt.tingyu.service.IPlannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

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
@RequestMapping("/planner")
public class PlannerController {

    @Autowired
    private IPlannerService plannerService;

    /**
     * 根据婚庆公司的id查询出对应的 策划师
     * @param cid
     * @return
     */
    @RequestMapping("/list")
    @ResponseBody
    public DataGridResult list(Integer cid, Integer rows, Integer page){

        //创建分页对象
        Page<Planner> plannerPage = new Page<>(page, rows);


        //创建条件对象
        QueryWrapper<Planner> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("cid",cid);


        //执行分页查询
        Page<Planner> result = plannerService.page(plannerPage, queryWrapper);

        DataGridResult dataGridResult = new DataGridResult();
        dataGridResult.setRows(result.getRecords());
        dataGridResult.setTotal(result.getTotal());
        return  dataGridResult;
    }
}

