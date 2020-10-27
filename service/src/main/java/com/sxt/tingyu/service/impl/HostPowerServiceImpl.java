package com.sxt.tingyu.service.impl;

import com.sxt.tingyu.pojo.HostPower;
import com.sxt.tingyu.mapper.HostPowerMapper;
import com.sxt.tingyu.service.IHostPowerService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
@Service
public class HostPowerServiceImpl extends ServiceImpl<HostPowerMapper, HostPower> implements IHostPowerService {

    @Override
    public boolean hostPowerSet(Integer[] hostids, HostPower hostPower) {



        //1.循环主持人id，将主持id设置到主持人权限表HostPower对象中
        for (Integer hostid : hostids) {
            hostPower.setHostid(hostid);
            //将主持人权限保存到数据库
            int row = this.baseMapper.insert(hostPower);
            if(row != 1){
                return false;
            }
        }
        return true;
    }
}
