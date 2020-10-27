package com.sxt.tingyu.service;

import com.sxt.tingyu.pojo.HostPower;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
public interface IHostPowerService extends IService<HostPower> {

    /**
     * 设置主持人权限
     * @param hostids 主持人id
     * @param hostPower 权限数据
     * @return
     */
    boolean hostPowerSet(Integer[] hostids, HostPower hostPower);

}
