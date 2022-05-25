package kr.or.workTogether.common.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

//증명서신청(CRTFC_APLCT)
public class CrtfcAplictVO {
	private String crtfcAplctId;            //증명서신청코드
	private String crtfcAplctEmpId;         //증명서신청자아이디
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date crtfcAplctDt;              //증명서신청일자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date crtfcIssueDt;              //증명서발행일자
	private String crtfcSign;               //증명서성명
	private String crtfcUse;                //증명서용도
	private String crtfcAplctState;         //증명서신청상태
	private String crtfcTypeId;             //증명서유형코드
	
	public CrtfcAplictVO() {}
	
	public String getCrtfcAplctId() {
		return crtfcAplctId;
	}
	public void setCrtfcAplctId(String crtfcAplctId) {
		this.crtfcAplctId = crtfcAplctId;
	}
	public String getCrtfcAplctEmpId() {
		return crtfcAplctEmpId;
	}
	public void setCrtfcAplctEmpId(String crtfcAplctEmpId) {
		this.crtfcAplctEmpId = crtfcAplctEmpId;
	}
	public Date getCrtfcAplctDt() {
		return crtfcAplctDt;
	}
	public void setCrtfcAplctDt(Date crtfcAplctDt) {
		this.crtfcAplctDt = crtfcAplctDt;
	}
	public Date getCrtfcIssueDt() {
		return crtfcIssueDt;
	}
	public void setCrtfcIssueDt(Date crtfcIssueDt) {
		this.crtfcIssueDt = crtfcIssueDt;
	}
	public String getCrtfcSign() {
		return crtfcSign;
	}
	public void setCrtfcSign(String crtfcSign) {
		this.crtfcSign = crtfcSign;
	}
	public String getCrtfcUse() {
		return crtfcUse;
	}
	public void setCrtfcUse(String crtfcUse) {
		this.crtfcUse = crtfcUse;
	}
	public String getCrtfcAplctState() {
		return crtfcAplctState;
	}
	public void setCrtfcAplctState(String crtfcAplctState) {
		this.crtfcAplctState = crtfcAplctState;
	}
	public String getCrtfcTypeId() {
		return crtfcTypeId;
	}
	public void setCrtfcTypeId(String crtfcTypeId) {
		this.crtfcTypeId = crtfcTypeId;
	}
	
	@Override
	public String toString() {
		return "certificateApplicationVO [crtfcAplctId=" + crtfcAplctId + ", crtfcAplctEmpId=" + crtfcAplctEmpId
				+ ", crtfcSign=" + crtfcSign + ", crtfcUse=" + crtfcUse + ", crtfcAplctState=" + crtfcAplctState
				+ ", crtfcTypeId=" + crtfcTypeId + "]";
	}
	
}
