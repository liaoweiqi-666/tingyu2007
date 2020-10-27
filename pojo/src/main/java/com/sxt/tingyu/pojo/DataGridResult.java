package com.sxt.tingyu.pojo;

import java.util.List;

/**
 * EasyUI DataGrid 显示数据对象
 */
public class DataGridResult {

    private List<?> rows;

    private Long total;

    public List<?> getRows() {
        return rows;
    }

    public void setRows(List<?> rows) {
        this.rows = rows;
    }

    public Long getTotal() {
        return total;
    }

    public void setTotal(Long total) {
        this.total = total;
    }
}
