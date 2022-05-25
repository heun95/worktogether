package kr.or.workTogether.common.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

//결재문서(ATRZ_DOC)
public class AtrzDocVO {
	private String docId;                   //문서코드
	private String docTitle;                //문서제목

	private String docState;                //문서상태코드
	private int atrzLevel;                  //결재단계
	private String docTypeId;               //문서유형코드
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date docMdfyDt;                 //문서수정일자
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date docWrtDt;                  //문서기안일자
	private String docWrtr;                 //기안자아이디
	private String atrzLineStr;             //결재선문자열
	private String atchId;                  //첨부파일코드
	private String docWrtrName; 			//기안자이름
	private String docRetention;			//보존연한
	private String docDeptName;				//부서명
	private String docTypeName;				//문서양식이름
	private String atrzLineId;  			//결재선
	
	private String atrzState; 				//결재상태
	
	private List<AtrzLineDetailVO> atrzLineDetailList; //결재선상세 리스트
	
	private String docContentPath;			//문서내용경로
	
	private String docCntnt;                //문서내용
	
	public AtrzDocVO() {}
	
	public String getDocId() {
		return docId;
	}
	public void setDocId(String docId) {
		this.docId = docId;
	}
	public String getDocTitle() {
		return docTitle;
	}
	public void setDocTitle(String docTitle) {
		this.docTitle = docTitle;
	}
	public String getDocCntnt() {
		return docCntnt;
	}
	public void setDocCntnt(String docCntnt) {
		this.docCntnt = docCntnt;
	}
	public String getDocState() {
		return docState;
	}
	public void setDocState(String docState) {
		this.docState = docState;
	}
	public int getAtrzLevel() {
		return atrzLevel;
	}
	public void setAtrzLevel(int atrzLevel) {
		this.atrzLevel = atrzLevel;
	}
	public String getDocTypeId() {
		return docTypeId;
	}
	public void setDocTypeId(String docTypeId) {
		this.docTypeId = docTypeId;
	}
	public Date getDocMdfyDt() {
		return docMdfyDt;
	}
	public void setDocMdfyDt(Date docMdfyDt) {
		this.docMdfyDt = docMdfyDt;
	}
	public Date getDocWrtDt() {
		return docWrtDt;
	}
	public void setDocWrtDt(Date docWrtDt) {
		this.docWrtDt = docWrtDt;
	}
	public String getDocWrtr() {
		return docWrtr;
	}
	public void setDocWrtr(String docWrtr) {
		this.docWrtr = docWrtr;
	}
	public String getAtrzLineStr() {
		return atrzLineStr;
	}
	public void setAtrzLineStr(String atrzLineStr) {
		this.atrzLineStr = atrzLineStr;
	}
	public String getAtchId() {
		return atchId;
	}
	public void setAtchId(String atchId) {
		this.atchId = atchId;
	}
	public String getDocWrtrName() {
		return docWrtrName;
	}
	public void setDocWrtrName(String docWrtrName) {
		this.docWrtrName = docWrtrName;
	}
	public String getDocRetention() {
		return docRetention;
	}
	public void setDocRetention(String docRetention) {
		this.docRetention = docRetention;
	}
	public String getDocDeptName() {
		return docDeptName;
	}
	public void setDocDeptName(String docDeptName) {
		this.docDeptName = docDeptName;
	}
	public String getDocTypeName() {
		return docTypeName;
	}
	public void setDocTypeName(String docTypeName) {
		this.docTypeName = docTypeName;
	}
	public String getAtrzLineId() {
		return atrzLineId;
	}
	public void setAtrzLineId(String atrzLineId) {
		this.atrzLineId = atrzLineId;
	}
	public List<AtrzLineDetailVO> getAtrzLineDetailList() {
		return atrzLineDetailList;
	}
	public void setAtrzLineDetailList(List<AtrzLineDetailVO> atrzLineDetailList) {
		this.atrzLineDetailList = atrzLineDetailList;
	}
	public String getAtrzState() {
		return atrzState;
	}
	public void setAtrzState(String atrzState) {
		this.atrzState = atrzState;
	}
	public String getDocContentPath() {
		return docContentPath;
	}
	public void setDocContentPath(String docContentPath) {
		this.docContentPath = docContentPath;
	}

	@Override
	public String toString() {
		return "AtrzDocVO [docId=" + docId + ", docTitle=" + docTitle + ", docState=" + docState + ", atrzLevel="
				+ atrzLevel + ", docTypeId=" + docTypeId + ", docMdfyDt=" + docMdfyDt + ", docWrtDt=" + docWrtDt
				+ ", docWrtr=" + docWrtr + ", atrzLineStr=" + atrzLineStr + ", atchId=" + atchId + ", docWrtrName="
				+ docWrtrName + ", docRetention=" + docRetention + ", docDeptName=" + docDeptName + ", docTypeName="
				+ docTypeName + ", atrzLineId=" + atrzLineId + ", atrzState=" + atrzState + ", atrzLineDetailList="
				+ atrzLineDetailList + ", docContentPath=" + docContentPath + ", docCntnt=" + docCntnt + "]";
	}
	
}
