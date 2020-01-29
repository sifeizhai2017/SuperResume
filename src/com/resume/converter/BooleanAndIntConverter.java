package com.resume.converter;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * @author danny
 * @date 2020/1/21
 */
public class BooleanAndIntConverter extends BaseTypeHandler<Boolean> {
    /**
     * java(boolean) --> db(int)
     *
     * @param ps        PreparedStatement
     * @param i         PreparedStatment对象操作的参数的位置
     * @param parameter java值
     * @param jdbcType  jdbc操作的数据库类型
     * @throws SQLException SQLException
     */
    @Override
    public void setNonNullParameter(PreparedStatement ps, int i, Boolean parameter, JdbcType jdbcType) throws SQLException {
        if (parameter) {
            ps.setInt(i, 1);
        } else {
            ps.setInt(i, 0);
        }
    }

    @Override
    public Boolean getNullableResult(ResultSet rs, String columnName) throws SQLException {
        int read = rs.getInt(columnName);
        return read == 1;
    }

    @Override
    public Boolean getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        int read = rs.getInt(columnIndex);
        return read == 1;
    }

    @Override
    public Boolean getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        int read = cs.getInt(columnIndex);
        return read == 1;
    }
}
