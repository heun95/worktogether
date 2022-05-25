package kr.or.workTogether.common.vo;

//메신저즐겨찾기(CHAT_BOOKMARK)
public class ChatBookmarkVO {
	private String empId;                   //직원아이디
	private String bkmrkEmpId;              //즐겨찾기대상직원
	
	public ChatBookmarkVO() {}

	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getBkmrkEmpId() {
		return bkmrkEmpId;
	}
	public void setBkmrkEmpId(String bkmrkEmpId) {
		this.bkmrkEmpId = bkmrkEmpId;
	}

	@Override
	public String toString() {
		return "chatBookmarkVO [empId=" + empId + ", bkmrkEmpId=" + bkmrkEmpId + "]";
	}
	
}
