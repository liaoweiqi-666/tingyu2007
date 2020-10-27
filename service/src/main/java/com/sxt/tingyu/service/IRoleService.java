package com.sxt.tingyu.service;

import com.sxt.tingyu.pojo.Role;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2020-10-10
 */
public interface IRoleService extends IService<Role> {
    /**
     * 新增或者修改角色和角色菜单表数据
     * @param role 角色信息
     * @param mids 菜单id
     * @return
     */
    boolean saveOrUpdateRoleAndRoleMenu(Role role, Integer[] mids);

    /**
     * 删除指定id的角色信息
     * @param rid 角色id
     * @return
     */
    boolean deleteByIdRid(Integer rid);
}
