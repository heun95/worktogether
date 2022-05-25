package kr.or.workTogether.common.vo;

//결재선상세(ATRZ_LINE_DETAIL)
public class AtrzLineDetailVO {
	private String atrzLineId;              //결재선코드
	private int atrzLineLevel;              //순위
	private String atrzAprvId;              //결재자아이디
	private String atrzName;				//결재자이름
	private String positionName;			//직급명
	private String deptName;				//부서명
	private String positionId;				//직급아이디
	
	public AtrzLineDetailVO() {}
	
	public String getAtrzLineId() {
		return atrzLineId;
	}
	public void setAtrzLineId(String atrzLineId) {
		this.atrzLineId = atrzLineId;
	}
	public int getAtrzLineLevel() {
		return atrzLineLevel;
	}
	public void setAtrzLineLevel(int atrzLineLevel) {
		this.atrzLineLevel = atrzLineLevel;
	}
	public String getAtrzAprvId() {
		return atrzAprvId;
	}
	public void setAtrzAprvId(String atrzAprvId) {
		this.atrzAprvId = atrzAprvId;
	}
	public String getAtrzName() {
		return atrzName;
	}
	public void setAtrzName(String atrzName) {
		this.atrzName = atrzName;
	}
	public String getPositionName() {
		return positionName;
	}
	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getPositionId() {
		return positionId;
	}
	public void setPositionId(String positionId) {
		this.positionId = positionId;
	}

	@Override
	public String toString() {
		return "AtrzLineDetailVO [atrzLineId=" + atrzLineId + ", atrzLineLevel=" + atrzLineLevel + ", atrzAprvId="
				+ atrzAprvId + ", atrzName=" + atrzName + ", positionName=" + positionName + ", deptName=" + deptName
				+ ", positionId=" + positionId + "]";
	}
}
