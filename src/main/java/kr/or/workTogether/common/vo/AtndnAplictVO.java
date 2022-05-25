package kr.or.workTogether.common.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

//근태신청(ATNDN_APLCT)
public class AtndnAplictVO {
	private String atndnAplctId;            //근태신청코드
	private String atndnAplctRqstr;         //근태작성자
	private String atndnAplctAprvl;         //근태결재자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date atndnStrtDt;               //근태시작일자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date atndnEndDt;                //근태종료일자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date atndnWrtDt;                //근태작성일자
	private String atndnAplctState;         //근태신청상태
	private String atndnTypeId;             //근태유형코드
	private String atndnAplctRsn;           //근태신청내용
	
	

	public AtndnAplictVO() {}
	
	public String getAtndnAplctRsn() {
		return atndnAplctRsn;
	}
	
	public void setAtndnAplctRsn(String atndnAplctRsn) {
		this.atndnAplctRsn = atndnAplctRsn;
	}
	
	public String getAtndnAplctId() {
		return atndnAplctId;
	}
	public String getAtndnAplctRqstr() {
		return atndnAplctRqstr;
	}
	public String getAtndnAplctAprvl() {
		return atndnAplctAprvl;
	}
	public Date getAtndnStrtDt() {
		return atndnStrtDt;
	}
	public Date getAtndnEndDt() {
		return atndnEndDt;
	}
	public Date getAtndnWrtDt() {
		return atndnWrtDt;
	}
	public String getAtndnAplctState() {
		return atndnAplctState;
	}
	public String getAtndnTypeId() {
		return atndnTypeId;
	}
	public void setAtndnAplctId(String atndnAplctId) {
		this.atndnAplctId = atndnAplctId;
	}
	public void setAtndnAplctRqstr(String atndnAplctRqstr) {
		this.atndnAplctRqstr = atndnAplctRqstr;
	}
	public void setAtndnAplctAprvl(String atndnAplctAprvl) {
		this.atndnAplctAprvl = atndnAplctAprvl;
	}
	public void setAtndnStrtDt(Date atndnStrtDt) {
		this.atndnStrtDt = atndnStrtDt;
	}
	public void setAtndnEndDt(Date atndnEndDt) {
		this.atndnEndDt = atndnEndDt;
	}
	public void setAtndnWrtDt(Date atndnWrtDt) {
		this.atndnWrtDt = atndnWrtDt;
	}
	public void setAtndnAplctState(String atndnAplctState) {
		this.atndnAplctState = atndnAplctState;
	}
	public void setAtndnTypeId(String atndnTypeId) {
		this.atndnTypeId = atndnTypeId;
	}

	@Override
	public String toString() {
		return "AtndnAplictVO [atndnAplctId=" + atndnAplctId + ", atndnAplctRqstr=" + atndnAplctRqstr
				+ ", atndnAplctAprvl=" + atndnAplctAprvl + ", atndnStrtDt=" + atndnStrtDt + ", atndnEndDt=" + atndnEndDt
				+ ", atndnWrtDt=" + atndnWrtDt + ", atndnAplctState=" + atndnAplctState + ", atndnTypeId=" + atndnTypeId
				+ ", atndnAplctRsn=" + atndnAplctRsn + "]";
	}
	
}
