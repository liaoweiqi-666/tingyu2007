package com.sxt.tingyu.test;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sxt.tingyu.mapper.HostMapper;
import com.sxt.tingyu.pojo.Host;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:springdao.xml")
public class HostTest {


    @Autowired
    private HostMapper hostMapper;


    @Test
    public void selectPageDataTest(){

        QueryWrapper<Host> queryWrapper = new QueryWrapper<>();
        queryWrapper.like("hname","刘");


        Page<Host> hostPage = new Page<>();
        hostPage.setCurrent(1);
        hostPage.setSize(5);

        IPage<Host> result = hostMapper.selectHostPageData(queryWrapper, hostPage);

        System.out.println(result.getRecords());
        System.out.println(result.getTotal());

    }

}
