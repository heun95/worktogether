package kr.or.workTogether.common.vo;

public class WorkMngrVO {
	
	private String workId;
	private String workMngrId;
	private String workMngrNm;
	
	public String getWorkId() {
		return workId;
	}
	public void setWorkId(String workId) {
		this.workId = workId;
	}
	public String getWorkMngrId() {
		return workMngrId;
	}
	public void setWorkMngrId(String workMngrId) {
		this.workMngrId = workMngrId;
	}
	public String getWorkMngrNm() {
		return workMngrNm;
	}
	public void setWorkMngrNm(String workMngrNm) {
		this.workMngrNm = workMngrNm;
	}
	
	@Override
	public String toString() {
		return "WorkMngrVO [workId=" + workId + ", workMngrId=" + workMngrId + ", workMngrNm=" + workMngrNm + "]";
	}
	
}
