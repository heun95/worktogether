package kr.or.workTogether.common.vo;

import java.util.List;

//부서(DEPARTMENT)
public class DepartmentVO {
	private String deptId;                  //부서코드
	private String topDeptId;               //상위부서코드
	private int deptLevel;                  //부서레벨
	private String deptName;                //부서이름
	private String empId;                   //부서장
	
	//조직도 - employeeList
	private List<EmployeeVO> employeeList;
	private String topDeptName; //상위부서이름
	
	private List<DepartmentVO> deptList;
	
	public DepartmentVO() {}
	
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getTopDeptId() {
		return topDeptId;
	}
	public void setTopDeptId(String topDeptId) {
		this.topDeptId = topDeptId;
	}
	public int getDeptLevel() {
		return deptLevel;
	}
	public void setDeptLevel(int deptLevel) {
		this.deptLevel = deptLevel;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public List<EmployeeVO> getEmployeeList() {
		return employeeList;
	}
	public void setEmployeeList(List<EmployeeVO> employeeList) {
		this.employeeList = employeeList;
	}
	public String getTopDeptName() {
		return topDeptName;
	}
	public void setTopDeptName(String topDeptName) {
		this.topDeptName = topDeptName;
	}
	public List<DepartmentVO> getDeptList() {
		return deptList;
	}
	public void setDeptList(List<DepartmentVO> deptList) {
		this.deptList = deptList;
	}

	@Override
	public String toString() {
		return "DepartmentVO [deptId=" + deptId + ", topDeptId=" + topDeptId + ", deptLevel=" + deptLevel
				+ ", deptName=" + deptName + ", empId=" + empId + ", employeeList=" + employeeList + ", topDeptName="
				+ topDeptName + ", deptList=" + deptList + "]";
	}
	
}
