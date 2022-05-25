package kr.or.workTogether.common.vo;


import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

//결재선(ATRZ_LINE)
public class AtrzLineVO {
	private String atrzLineId;              //결재선코드
	private String atrzLineName;            //결재선명
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date atrzLineDt;                //생성일자
	private String atrzAprvId;              //결재자아이디
	private String atrzLineStr;             //결재선문자열
	
	public AtrzLineVO() {}
	
	public String getAtrzLineId() {
		return atrzLineId;
	}
	public void setAtrzLineId(String atrzLineId) {
		this.atrzLineId = atrzLineId;
	}
	public String getAtrzLineName() {
		return atrzLineName;
	}
	public void setAtrzLineName(String atrzLineName) {
		this.atrzLineName = atrzLineName;
	}
	public Date getAtrzLineDt() {
		return atrzLineDt;
	}
	public void setAtrzLineDt(Date atrzLineDt) {
		this.atrzLineDt = atrzLineDt;
	}
	public String getAtrzAprvId() {
		return atrzAprvId;
	}
	public void setAtrzAprvId(String atrzAprvId) {
		this.atrzAprvId = atrzAprvId;
	}
	public String getAtrzLineStr() {
		return atrzLineStr;
	}
	public void setAtrzLineStr(String atrzLineStr) {
		this.atrzLineStr = atrzLineStr;
	}
	
	@Override
	public String toString() {
		return "authorizationLineVO [atrzLineId=" + atrzLineId + ", atrzLineName=" + atrzLineName + ", atrzAprvId="
				+ atrzAprvId + ", atrzLineStr=" + atrzLineStr + "]";
	}
	
}
