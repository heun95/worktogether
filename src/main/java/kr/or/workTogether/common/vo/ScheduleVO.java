package kr.or.workTogether.common.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

//일정(SCHEDULE)
public class ScheduleVO {
	private String schdlId;                 //일정코드
	private String schdlTitle;              //일정제목
	private String schdlCntnt;              //일정내용
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date schdlStrtDt;               //일정시작일자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date schdlEndDt;                //일장종료일자
	private String schdlWrtr;               //일정작성자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date schdlWrtDt;                //일정작성일자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date schdlMdfyDt;               //일정수정일자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date schdlDelDt;                //일정삭제일자
	private String schdlTypeId;             //일정유형코드
	private String schdlImport;				//일정중요여부
	
	public ScheduleVO() {}
	
	public String getSchdlId() {
		return schdlId;
	}
	public String getSchdlTitle() {
		return schdlTitle;
	}
	public String getSchdlCntnt() {
		return schdlCntnt;
	}
	public Date getSchdlStrtDt() {
		return schdlStrtDt;
	}
	public Date getSchdlEndDt() {
		return schdlEndDt;
	}
	public String getSchdlWrtr() {
		return schdlWrtr;
	}
	public Date getSchdlWrtDt() {
		return schdlWrtDt;
	}
	public Date getSchdlMdfyDt() {
		return schdlMdfyDt;
	}
	public Date getSchdlDelDt() {
		return schdlDelDt;
	}
	public String getSchdlTypeId() {
		return schdlTypeId;
	}
	public void setSchdlId(String schdlId) {
		this.schdlId = schdlId;
	}
	public void setSchdlTitle(String schdlTitle) {
		this.schdlTitle = schdlTitle;
	}
	public void setSchdlCntnt(String schdlCntnt) {
		this.schdlCntnt = schdlCntnt;
	}
	public void setSchdlStrtDt(Date schdlStrtDt) {
		this.schdlStrtDt = schdlStrtDt;
	}
	public void setSchdlEndDt(Date schdlEndDt) {
		this.schdlEndDt = schdlEndDt;
	}
	public void setSchdlWrtr(String schdlWrtr) {
		this.schdlWrtr = schdlWrtr;
	}
	public void setSchdlWrtDt(Date schdlWrtDt) {
		this.schdlWrtDt = schdlWrtDt;
	}
	public void setSchdlMdfyDt(Date schdlMdfyDt) {
		this.schdlMdfyDt = schdlMdfyDt;
	}
	public void setSchdlDelDt(Date schdlDelDt) {
		this.schdlDelDt = schdlDelDt;
	}
	public void setSchdlTypeId(String schdlTypeId) {
		this.schdlTypeId = schdlTypeId;
	}
	public String getSchdlImport() {
		return schdlImport;
	}
	public void setSchdlImport(String schdlImport) {
		this.schdlImport = schdlImport;
	}

	@Override
	public String toString() {
		return "ScheduleVO [schdlId=" + schdlId + ", schdlTitle=" + schdlTitle + ", schdlCntnt=" + schdlCntnt
				+ ", schdlStrtDt=" + schdlStrtDt + ", schdlEndDt=" + schdlEndDt + ", schdlWrtr=" + schdlWrtr
				+ ", schdlWrtDt=" + schdlWrtDt + ", schdlMdfyDt=" + schdlMdfyDt + ", schdlDelDt=" + schdlDelDt
				+ ", schdlTypeId=" + schdlTypeId + ", schdlImport=" + schdlImport + "]";
	}
	
}
