package com.sxt.tingyu.service;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.sxt.tingyu.pojo.DataGridResult;
import com.sxt.tingyu.pojo.Host;
import com.baomidou.mybatisplus.extension.service.IService;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
public interface IHostService extends IService<Host> {
    DataGridResult selectHostPageData(Host host, int page, int size);
}
