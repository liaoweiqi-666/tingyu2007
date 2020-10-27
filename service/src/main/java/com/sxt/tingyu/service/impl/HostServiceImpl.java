package com.sxt.tingyu.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sxt.tingyu.pojo.DataGridResult;
import com.sxt.tingyu.pojo.Host;
import com.sxt.tingyu.mapper.HostMapper;
import com.sxt.tingyu.service.IHostService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Objects;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
@Service
public class HostServiceImpl extends ServiceImpl<HostMapper, Host> implements IHostService {

    @Autowired
    private HostMapper hostMapper;


    @Override
    public DataGridResult selectHostPageData(Host host, int page, int size) {

        //创建分页对象
        Page<Host> hostPage = new Page<>(page,size);

        //创建条件对象
        QueryWrapper<Host> queryWrapper = new QueryWrapper<>();

        //hname条件
        if(StringUtils.isNotBlank(host.getHname())){
            queryWrapper.like("hname",host.getHname());
        }
        //status条件
        if(StringUtils.isNotBlank(host.getStatus())){
            queryWrapper.eq("status",host.getStatus());
        }
        //hpstart 条件

        if(!Objects.isNull(host.getHpstar())){
            queryWrapper.eq("hpstar",host.getHpstar());
        }
        //hpdiscount 条件
        if(!Objects.isNull(host.getHpdiscount())){
            queryWrapper.eq("hpdiscount",host.getHpdiscount());
        }

        //strong排序
        if(StringUtils.isNotBlank(host.getStrong())){
            if("0".equals(host.getStrong())){
                queryWrapper.orderByDesc("strong");
            }else if("1".equals(host.getStrong())){
                queryWrapper.orderByAsc("strong");
            }
        }
        //ordernumber排序
        if(!Objects.isNull(host.getOrdernumber())){
            if(host.getOrdernumber() == 0){
                queryWrapper.orderByDesc("ordernumber");
            }else if(host.getOrdernumber() == 1){
                queryWrapper.orderByAsc("ordernumber");
            }
        }


        //执行查询方法
        IPage<Host> hostIPage = hostMapper.selectHostPageData(queryWrapper, hostPage);

        //封装DataGrid数据
        DataGridResult dataGridResult = new DataGridResult();
        dataGridResult.setRows(hostIPage.getRecords());
        dataGridResult.setTotal(hostIPage.getTotal());

        return dataGridResult;
    }


    public static void main(String[] args) {
        /**
         *  commons-lang3-3.0.jar 是Apache为java语言编写的一个增强包
         *
         *  里面对各种常见的数据类型进行各种增强编写各种工具类型
         *  Xxx(任意)Utils，提供各种静态方法
         *
         *  如： StringUtils
         *  里面有判断字符串是否为空的方法
         *  如 ：ArrayUtils 提供类似于集合的 add，get 相关方法
         *
         *
         */

        //判断字符串是否为空

        System.out.println(StringUtils.isNotBlank(null));//false
        System.out.println(StringUtils.isNotBlank(""));//false
        System.out.println(StringUtils.isNotBlank("  "));//false


    }
}
