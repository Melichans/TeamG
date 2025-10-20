package bean;
 
public class UserBean {
    private int userId;
    private String name;
    private String gender; // 男 or 女
    private String position; // アルバイト、社員、店長、リーダー
    private String workplace; // 厨房、ホールなど
 
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
 
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
 
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
 
    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }
 
    public String getWorkplace() { return workplace; }
    public void setWorkplace(String workplace) { this.workplace = workplace; }
}