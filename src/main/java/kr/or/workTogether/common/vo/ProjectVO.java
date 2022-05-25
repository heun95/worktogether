package kr.or.workTogether.common.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

//프로젝트(PROJECT)
public class ProjectVO {
	private String projId;                  //프로젝트코드
	private String projName;                //프로젝트이름
	private String projCntnt;               //프로젝트설명
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date projWrtDt;                 //프로젝트작성일자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date projStrtDt;                //프로젝트시작일자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date projEndDt;                 //프로젝트예상만기일자
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date projRendDt;                //프로젝트실제만기일자
	private int projProgress;               //프로젝트진행도
	private String projState;               //프로젝트상태
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date projMdfyDt;                //프로젝트수정일자
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date projDelDt;                 //프로젝트삭제일자
	
	private List<String> projMemList; //
	
	public ProjectVO() {}
	
	public String getProjId() {
		return projId;
	}
	public String getProjName() {
		return projName;
	}
	public String getProjCntnt() {
		return projCntnt;
	}
	public Date getProjWrtDt() {
		return projWrtDt;
	}
	public Date getProjStrtDt() {
		return projStrtDt;
	}
	public Date getProjEndDt() {
		return projEndDt;
	}
	public Date getProjRendDt() {
		return projRendDt;
	}
	public int getProjProgress() {
		return projProgress;
	}
	public String getProjState() {
		return projState;
	}
	public Date getProjMdfyDt() {
		return projMdfyDt;
	}
	public Date getProjDelDt() {
		return projDelDt;
	}
	public void setProjId(String projId) {
		this.projId = projId;
	}
	public void setProjName(String projName) {
		this.projName = projName;
	}
	public void setProjCntnt(String projCntnt) {
		this.projCntnt = projCntnt;
	}
	public void setProjWrtDt(Date projWrtDt) {
		this.projWrtDt = projWrtDt;
	}
	public void setProjStrtDt(Date projStrtDt) {
		this.projStrtDt = projStrtDt;
	}
	public void setProjEndDt(Date projEndDt) {
		this.projEndDt = projEndDt;
	}
	public void setProjRendDt(Date projRendDt) {
		this.projRendDt = projRendDt;
	}
	public void setProjProgress(int projProgress) {
		this.projProgress = projProgress;
	}
	public void setProjState(String projState) {
		this.projState = projState;
	}
	public void setProjMdfyDt(Date projMdfyDt) {
		this.projMdfyDt = projMdfyDt;
	}
	public void setProjDelDt(Date projDelDt) {
		this.projDelDt = projDelDt;
	}
	
	public List<String> getProjMemList() {
		return projMemList;
	}

	public void setProjMemList(List<String> projMemList) {
		this.projMemList = projMemList;
	}

	@Override
	public String toString() {
		return "ProjectVO [projId=" + projId + ", projName=" + projName + ", projCntnt=" + projCntnt + ", projWrtDt="
				+ projWrtDt + ", projStrtDt=" + projStrtDt + ", projEndDt=" + projEndDt + ", projRendDt=" + projRendDt
				+ ", projProgress=" + projProgress + ", projState=" + projState + ", projMdfyDt=" + projMdfyDt
				+ ", projDelDt=" + projDelDt + ", projMemList=" + projMemList + "]";
	}
	
	
	
}
