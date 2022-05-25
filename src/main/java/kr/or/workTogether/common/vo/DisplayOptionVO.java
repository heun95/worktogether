package kr.or.workTogether.common.vo;

//화면설정(DISPLAY_OPTION)
public class DisplayOptionVO {
	private String empId;                   //직원아이디
	private String darkYn;                  //Y/N
	
	public DisplayOptionVO() {}
	
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getDarkYn() {
		return darkYn;
	}
	public void setDarkYn(String darkYn) {
		this.darkYn = darkYn;
	}
	
	@Override
	public String toString() {
		return "DisplayOptionVO [empId=" + empId + ", darkYn=" + darkYn + "]";
	}
	
}
