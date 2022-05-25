package kr.or.workTogether.common.vo;

import java.util.List;

//메신저그룹(CHAT_MEMBER)
public class ChatBangVO {
	private String chatbangId;                     //메신저방번호
	private List<EmployeeVO> employeeVO;
	
	public ChatBangVO() {}

	public String getChatbangId() {
		return chatbangId;
	}

	public void setChatbangId(String chatbangId) {
		this.chatbangId = chatbangId;
	}

	public List<EmployeeVO> getEmployeeVO() {
		return employeeVO;
	}

	public void setEmployeeVO(List<EmployeeVO> employeeVO) {
		this.employeeVO = employeeVO;
	}

	@Override
	public String toString() {
		return "ChatBangVO [chatbangId=" + chatbangId + ", employeeVO=" + employeeVO + "]";
	}
	
	

	
}
