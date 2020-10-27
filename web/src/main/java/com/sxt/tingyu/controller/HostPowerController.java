package com.sxt.tingyu.controller;


import com.sxt.tingyu.pojo.HostPower;
import com.sxt.tingyu.pojo.ResultData;
import com.sxt.tingyu.service.IHostPowerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Arrays;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
@Controller
@RequestMapping("/hostPower")
public class HostPowerController {

    @Autowired
    private IHostPowerService hostPowerService;


    /**
     * 设置主持人权限
     * @param hostids 主持人id，可能有多个主持人设置，所以必须使用数组接受主持人id数据
     * @param hostPower  主持人权限数据
     * @return
     */
    @RequestMapping("/hostPowerSet")
    @ResponseBody
    public ResultData hostPowerSet(Integer[] hostids, HostPower hostPower){
        System.out.println(Arrays.toString(hostids));
        System.out.println(hostPower);

        boolean flag = hostPowerService.hostPowerSet(hostids, hostPower);
        if (flag){
            return ResultData.ok("设置权限成功");
        }
        return  ResultData.error("设置主持人权限失败，请联系管理员");
    }

}

