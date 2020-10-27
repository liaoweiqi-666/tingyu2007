package com.sxt.tingyu.controller;


import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.sxt.tingyu.pojo.DataGridResult;
import com.sxt.tingyu.pojo.Host;
import com.sxt.tingyu.pojo.ResultData;
import com.sxt.tingyu.service.IHostService;
import org.apache.ibatis.annotations.Param;
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
@RequestMapping("/host")
public class HostController {


    @Autowired
    private IHostService iHostService;

    /**
     * 跳转到主持人管理界面
     * @return
     */
    @RequestMapping("/hostManager")
    public String hostManager(){

        return "hostManager";
    }


    @RequestMapping("/list")
    @ResponseBody
    public DataGridResult list(Host host, @RequestParam(defaultValue = "1") Integer page,@RequestParam(defaultValue = "10") Integer rows){
        System.out.println("host :"+host);
        return iHostService.selectHostPageData(host,page,rows);
    }

    /**
     * 新增主持人
     */
    @RequestMapping("/insert")
    @ResponseBody
    public ResultData insert(Host host){

        //把当前时间作为注册时间
        host.setStarttime(LocalDateTime.now());
        //设置状态
        host.setStatus("1");
        //设置权重
        host.setStrong("0");

        //新增功能
        boolean flag = iHostService.save(host);

        if (flag){
            return ResultData.ok("新增主持人成功！！");
        }else{
            return ResultData.error("新增数据失败，请联系管理员");
        }

    }

    /**
     * 修改主持人状态
     * @param hid 主持人id
     * @param status 主持人现有状态
     */
    @RequestMapping("/changeStatus")
    @ResponseBody
    public ResultData changeStatus(Integer hid,Integer status){

        UpdateWrapper<Host> hostUpdateWrapper = new UpdateWrapper<>();
        hostUpdateWrapper.eq("hid",hid);
        if(status == 0){
            hostUpdateWrapper.set("status",1);
        }else if(status == 1){
            hostUpdateWrapper.set("status",0);
        }


        boolean flag = iHostService.update(hostUpdateWrapper);

        if(flag){
            return ResultData.ok("修改成功");
        }else {
            return ResultData.error("修改数据失败,请联系管理员");
        }

    }
    /**
     * 修改主持人状态
     * @param hid 主持人id
     * @param strong 主持人权重
     */
    @RequestMapping("/changeStrong")
    @ResponseBody
    public ResultData changeStrong(Integer hid,Integer strong){

        UpdateWrapper<Host> hostUpdateWrapper = new UpdateWrapper<>();
        hostUpdateWrapper.eq("hid",hid);

        hostUpdateWrapper.set("strong",strong);

        boolean flag = iHostService.update(hostUpdateWrapper);
        if(flag){
            return ResultData.ok("修改权重成功");
        }else {
            return ResultData.error("修改数据失败,请联系管理员");
        }

    }

}

