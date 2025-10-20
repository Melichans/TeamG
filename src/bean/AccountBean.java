package bean;
 
import java.sql.Timestamp;
 
public class AccountBean {
    private int accountId;
    private String username;
    private String password; // Mật khẩu mã hóa
    private int roleId; // Liên kết với role_id
    private Timestamp createdAt;
 
    public int getAccountId() { return accountId; }
    public void setAccountId(int accountId) { this.accountId = accountId; }
 
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
 
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
 
    public int getRoleId() { return roleId; }
    public void setRoleId(int roleId) { this.roleId = roleId; }
 
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}