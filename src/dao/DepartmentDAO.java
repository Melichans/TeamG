package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.DepartmentBean;

public class DepartmentDAO {
    private Connection conn;

    public DepartmentDAO(Connection conn) {
        this.conn = conn;
    }

    public List<DepartmentBean> getAllDepartments() throws SQLException {
        List<DepartmentBean> departments = new ArrayList<>();
        String sql = "SELECT dept_id, dept_name, description FROM department ORDER BY dept_name";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    DepartmentBean dept = new DepartmentBean();
                    dept.setDeptId(rs.getInt("dept_id"));
                    dept.setDeptName(rs.getString("dept_name"));
                    dept.setDescription(rs.getString("description"));
                    departments.add(dept);
                }
            }
        }
        return departments;
    }
}
