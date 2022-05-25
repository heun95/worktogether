package kr.or.workTogether.common.vo;

//알림설정(PUSH_OPTION)
public class PushOptionVO {
	private String empId;                   //직원아이디
	private String pushMenu;                //알림메뉴
	private String pushYn;                  //알림여부(Y/N)
	
	public PushOptionVO() {}
	
	public String getEmpId() {
		return empId;
	}
	public String getPushMenu() {
		return pushMenu;
	}
	public String getPushYn() {
		return pushYn;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public void setPushMenu(String pushMenu) {
		this.pushMenu = pushMenu;
	}
	public void setPushYn(String pushYn) {
		this.pushYn = pushYn;
	}
	
	@Override
	public String toString() {
		return "PushOptionVO [empId=" + empId + ", pushMenu=" + pushMenu + ", pushYn=" + pushYn + "]";
	}
	
}
