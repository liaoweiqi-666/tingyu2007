package com.sxt.tingyu.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sxt.tingyu.pojo.Company;
import com.sxt.tingyu.pojo.DataGridResult;
import com.sxt.tingyu.pojo.ResultData;
import com.sxt.tingyu.service.ICompanyService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.xml.crypto.Data;
import java.time.LocalDateTime;
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
@RequestMapping("/company")
public class CompanyController {


    @Autowired
    private ICompanyService companyService;

    @RequestMapping("/companyManager")
    public String companyManager(){
        return "companyManager";
    }

    @RequestMapping("/list")
    @ResponseBody
    public DataGridResult list(Company company, @RequestParam(defaultValue = "10") Integer rows,@RequestParam(defaultValue = "1") Integer page){

        //创建条件对象
        QueryWrapper<Company> companyQueryWrapper = new QueryWrapper<>();

        if(StringUtils.isNotBlank(company.getCname())){
            companyQueryWrapper.like("cname",company.getCname());
        }

        if(StringUtils.isNotBlank(company.getStatus())){
            companyQueryWrapper.eq("status",company.getStatus());
        }

        if(Objects.nonNull(company.getOrdernumber())){
            if(company.getOrdernumber() == 0){
                companyQueryWrapper.orderByDesc("ordernumber");
            }else if(company.getOrdernumber() == 1) {
                companyQueryWrapper.orderByAsc("ordernumber");
            }
        }
        //创建分页条件对象
        Page<Company> companyPage = new Page<>(page, rows);
        //执行查询返回结果
        Page<Company> result = companyService.page(companyPage, companyQueryWrapper);

        //创建DataGrid对象
        DataGridResult dataGridResult = new DataGridResult();
        dataGridResult.setRows(result.getRecords());
        dataGridResult.setTotal(result.getTotal());
        return dataGridResult;

    }


    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public ResultData saveOrUpdate(Company company){


        //设置starttime, 新增才设置时间
        if(Objects.isNull(company.getCid())){
            company.setStarttime(LocalDateTime.now());
            //设置状态，后台管理员录入的公司信息默认已通过正常
            company.setStatus("1");
        }




        boolean flag = companyService.saveOrUpdate(company);

        return flag ? ResultData.ok("操作成功"):ResultData.error("操作数据失败，请联系管理员");

    }


    /**
     * 修改公司状态
     * @param cid 公司id
     * @param status 状态  0 未审核 1 正常 2 禁用
     * @return
     */
    @RequestMapping("/changeStatus")
    @ResponseBody
    public ResultData disable(Integer cid,String status){


        UpdateWrapper<Company> companyUpdateWrapper = new UpdateWrapper<>();
        companyUpdateWrapper.eq("cid",cid);
        if("0".equals(status)){
            companyUpdateWrapper.set("status","1");
        }else if("1".equals(status)){
            companyUpdateWrapper.set("status","2");
        }else if("2".equals(status)){
            companyUpdateWrapper.set("status","1");
        }

        boolean flag = companyService.update(companyUpdateWrapper);

        return flag ? ResultData.ok("操作成功"):ResultData.error("操作失败，请联系管理员");
    }


}

