package kr.or.workTogether.common.vo;

//회의참여그룹(MTNG_MEM)
public class MtngMemVO {
	private String empId;                   //직원아이디
	private String mtngId;                  //회의코드
	
	public MtngMemVO() {}
	
	public String getEmpId() {
		return empId;
	}
	public String getMtngId() {
		return mtngId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public void setMtngId(String mtngId) {
		this.mtngId = mtngId;
	}
	
	@Override
	public String toString() {
		return "MeetingMemberVO [empId=" + empId + ", mtngId=" + mtngId + "]";
	}
	
}
