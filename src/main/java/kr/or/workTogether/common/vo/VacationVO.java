package kr.or.workTogether.common.vo;

//잔여휴가(VACATION)
public class VacationVO {
	private String empId;                   //직원아이디
	private String atndnTypeId;             //근태유형코드
	private int vacationRmn;                //잔여휴가수
	
	public VacationVO() {}
	
	public String getEmpId() {
		return empId;
	}
	public String getAtndnTypeId() {
		return atndnTypeId;
	}
	public int getVacationRmn() {
		return vacationRmn;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public void setAtndnTypeId(String atndnTypeId) {
		this.atndnTypeId = atndnTypeId;
	}
	public void setVacationRmn(int vacationRmn) {
		this.vacationRmn = vacationRmn;
	}
	
	@Override
	public String toString() {
		return "VacationVO [empId=" + empId + ", atndnTypeId=" + atndnTypeId + ", vacationRmn=" + vacationRmn + "]";
	}
	
}
