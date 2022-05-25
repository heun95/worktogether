package kr.or.workTogether.common.vo;

//프로젝트그룹(PROJ_MEM)
public class ProjMemVO {
	private String projId;                  //프로젝트코드
	private String empId;                   //직원아이디
	private String prjLdrYn;                //Y/N
	
	public ProjMemVO() {}
	
	public String getProjId() {
		return projId;
	}
	public String getEmpId() {
		return empId;
	}
	public String getPrjLdrYn() {
		return prjLdrYn;
	}
	public void setProjId(String projId) {
		this.projId = projId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public void setPrjLdrYn(String prjLdrYn) {
		this.prjLdrYn = prjLdrYn;
	}
	
	@Override
	public String toString() {
		return "ProjectMemberVO [projId=" + projId + ", empId=" + empId + ", prjLdrYn=" + prjLdrYn + "]";
	}
	
}
