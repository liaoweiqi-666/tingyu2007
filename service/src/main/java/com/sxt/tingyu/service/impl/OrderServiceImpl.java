package com.sxt.tingyu.service.impl;

import com.sxt.tingyu.pojo.Order;
import com.sxt.tingyu.mapper.OrderMapper;
import com.sxt.tingyu.service.IOrderService;
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
public class OrderServiceImpl extends ServiceImpl<OrderMapper, Order> implements IOrderService {

}
