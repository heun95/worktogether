package kr.or.workTogether.common.vo;

//VW_USER_AUTH
public class EmployeeAuthVO {
	private String username;
	private String auth;
	
	public EmployeeAuthVO() {}
	
	public String getUsername() {
		return username;
	}
	public String getAuth() {
		return auth;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}

	@Override
	public String toString() {
		return "EmployeeAuthVO [username=" + username + ", auth=" + auth + "]";
	}
	
}
