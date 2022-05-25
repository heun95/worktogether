package kr.or.workTogether.common.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

//프로젝트업무댓글(PROJ_WORK_REPLY)
public class ProjWorkReplyVO {
	private int workReplyId;                //업무댓글번호
	private int topWorkRplyId;              //업무댓글상위번호
	private int workRplyLevel;              //업무댓글레벨
	private String workId;                  //업무코드
	private String workRplyCntnt;           //업무댓글내용
	private String workRplyWrtr;            //업무댓글작성자
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date workRplyWrtDt;             //업무댓글작성일자
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date workRplyMdfyDt;            //업무댓글수정일자
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date workRplyDelDt;             //업무댓글삭제일자
	private String projId;                  //프로젝트코드
	private String empName;                
	private String wrtrPhoto;                 
	
	
	public ProjWorkReplyVO() {}
	
	public int getWorkReplyId() {
		return workReplyId;
	}
	public int getTopWorkRplyId() {
		return topWorkRplyId;
	}
	public int getWorkRplyLevel() {
		return workRplyLevel;
	}
	public String getWorkId() {
		return workId;
	}
	public String getWorkRplyCntnt() {
		return workRplyCntnt;
	}
	public String getWorkRplyWrtr() {
		return workRplyWrtr;
	}
	public Date getWorkRplyWrtDt() {
		return workRplyWrtDt;
	}
	public Date getWorkRplyMdfyDt() {
		return workRplyMdfyDt;
	}
	public Date getWorkRplyDelDt() {
		return workRplyDelDt;
	}
	public String getProjId() {
		return projId;
	}
	public void setWorkReplyId(int workReplyId) {
		this.workReplyId = workReplyId;
	}
	public void setTopWorkRplyId(int topWorkRplyId) {
		this.topWorkRplyId = topWorkRplyId;
	}
	public void setWorkRplyLevel(int workRplyLevel) {
		this.workRplyLevel = workRplyLevel;
	}
	public void setWorkId(String workId) {
		this.workId = workId;
	}
	public void setWorkRplyCntnt(String workRplyCntnt) {
		this.workRplyCntnt = workRplyCntnt;
	}
	public void setWorkRplyWrtr(String workRplyWrtr) {
		this.workRplyWrtr = workRplyWrtr;
	}
	public void setWorkRplyWrtDt(Date workRplyWrtDt) {
		this.workRplyWrtDt = workRplyWrtDt;
	}
	public void setWorkRplyMdfyDt(Date workRplyMdfyDt) {
		this.workRplyMdfyDt = workRplyMdfyDt;
	}
	public void setWorkRplyDelDt(Date workRplyDelDt) {
		this.workRplyDelDt = workRplyDelDt;
	}
	public void setProjId(String projId) {
		this.projId = projId;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	
	public String getWrtrPhoto() {
		return wrtrPhoto;
	}

	public void setWrtrPhoto(String wrtrPhoto) {
		this.wrtrPhoto = wrtrPhoto;
	}

	@Override
	public String toString() {
		return "ProjWorkReplyVO [workReplyId=" + workReplyId + ", topWorkRplyId=" + topWorkRplyId + ", workRplyLevel="
				+ workRplyLevel + ", workId=" + workId + ", workRplyCntnt=" + workRplyCntnt + ", workRplyWrtr="
				+ workRplyWrtr + ", workRplyWrtDt=" + workRplyWrtDt + ", workRplyMdfyDt=" + workRplyMdfyDt
				+ ", workRplyDelDt=" + workRplyDelDt + ", projId=" + projId + ", empName=" + empName + ", wrtrPhoto="
				+ wrtrPhoto + "]";
	}
	
}
