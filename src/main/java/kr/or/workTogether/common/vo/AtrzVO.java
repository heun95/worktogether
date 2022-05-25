package kr.or.workTogether.common.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

//결재(ATRZ)
public class AtrzVO {
	private String atrzId;                  //결재코드
	private String docId;                   //문서코드
	private int atrzLevel;                  //결재단계
	private String atrzTypeId;              //결재결과코드
	private String atrzCmt;                 //코멘트
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date atrzWrtDt;                 //받은일자
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date atrzAprvDt;                //결재일자
	private String atrzAprvId;              //결재자아이디
	private String atrzSign; 				//전자서명
	
	private int atrzCount; 					//결재자 수
	
	public AtrzVO() {}
	
	public String getAtrzId() {
		return atrzId;
	}
	public void setAtrzId(String atrzId) {
		this.atrzId = atrzId;
	}
	public String getDocId() {
		return docId;
	}
	public void setDocId(String docId) {
		this.docId = docId;
	}
	public int getAtrzLevel() {
		return atrzLevel;
	}
	public void setAtrzLevel(int atrzLevel) {
		this.atrzLevel = atrzLevel;
	}
	public String getAtrzTypeId() {
		return atrzTypeId;
	}
	public void setAtrzTypeId(String atrzTypeId) {
		this.atrzTypeId = atrzTypeId;
	}
	public String getAtrzCmt() {
		return atrzCmt;
	}
	public void setAtrzCmt(String atrzCmt) {
		this.atrzCmt = atrzCmt;
	}
	public Date getAtrzWrtDt() {
		return atrzWrtDt;
	}
	public void setAtrzWrtDt(Date atrzWrtDt) {
		this.atrzWrtDt = atrzWrtDt;
	}
	public Date getAtrzAprvDt() {
		return atrzAprvDt;
	}
	public void setAtrzAprvDt(Date atrzAprvDt) {
		this.atrzAprvDt = atrzAprvDt;
	}
	public String getAtrzAprvId() {
		return atrzAprvId;
	}
	public void setAtrzAprvId(String atrzAprvId) {
		this.atrzAprvId = atrzAprvId;
	}
	public String getAtrzSign() {
		return atrzSign;
	}
	public void setAtrzSign(String atrzSign) {
		this.atrzSign = atrzSign;
	}
	public int getAtrzCount() {
		return atrzCount;
	}
	public void setAtrzCount(int atrzCount) {
		this.atrzCount = atrzCount;
	}

	@Override
	public String toString() {
		return "AtrzVO [atrzId=" + atrzId + ", docId=" + docId + ", atrzLevel=" + atrzLevel + ", atrzTypeId="
				+ atrzTypeId + ", atrzCmt=" + atrzCmt + ", atrzWrtDt=" + atrzWrtDt + ", atrzAprvDt=" + atrzAprvDt
				+ ", atrzAprvId=" + atrzAprvId + ", atrzSign=" + atrzSign + ", atrzCount=" + atrzCount + "]";
	}
	
}
