package com.sxt.tingyu.service.impl;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.sxt.tingyu.mapper.RoleMenuMapper;
import com.sxt.tingyu.pojo.Role;
import com.sxt.tingyu.mapper.RoleMapper;
import com.sxt.tingyu.pojo.RoleMenu;
import com.sxt.tingyu.service.IRoleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
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
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements IRoleService {

    @Autowired
    private RoleMenuMapper roleMenuMapper;



    @Override
    public boolean saveOrUpdateRoleAndRoleMenu(Role role, Integer[] mids) {

        //1.新增修改角色
        boolean flag = this.saveOrUpdate(role);

        if(flag){

            //通过rid删除中间中标中的所有当前角色id对应的数据
            UpdateWrapper<RoleMenu> roleMenuUpdateWrapper = new UpdateWrapper<>();
            roleMenuUpdateWrapper.eq("rid",role.getRid());
            roleMenuMapper.delete(roleMenuUpdateWrapper);

            System.out.println("role :"+role);
            //2.循环菜单id数组，分别向角色菜单表中插入数据 t_role_menu
            for (Integer mid : mids) {
                //创建角色菜单对象
                RoleMenu roleMenu = new RoleMenu();
                roleMenu.setRid(role.getRid());
                roleMenu.setMid(mid);

                //循环插入数据
                int insert = roleMenuMapper.insert(roleMenu);
                if(insert == 0){
                    return  false;
                }
            }
        }else{
            return  false;
        }

        return true;
    }

    @Override
    public boolean deleteByIdRid(Integer rid) {

        //删除角色表中的数据
        int row = baseMapper.deleteById(rid);
        //删除角色菜单中间表中对应的角色信息
        if(row == 1){

            UpdateWrapper<RoleMenu> menuUpdateWrapper = new UpdateWrapper<>();
            menuUpdateWrapper.eq("rid",rid);

            row = roleMenuMapper.delete(menuUpdateWrapper);

            return row >= 1 ? true : false;
        }else{
            return false;
        }

    }
}
