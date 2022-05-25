package kr.or.workTogether.common.vo;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

//게시판(BOARD)
public class BoardVO {
	private String brdId; // 게시글번호
	private String brdTitle; // 게시글제목
	private String brdCntnt; // 게시글내용
	private int brdHit; // 게시글조회수
	private String brdWrtr; // 게시판작성자
	@DateTimeFormat(pattern = "yyyy/MM/dd")
	private Date brdWrtDt; // 게시글작성일자
	@DateTimeFormat(pattern = "yyyy/MM/dd")
	private Date brdMdfyDt; // 게시글수정일자
	@DateTimeFormat(pattern = "yyyy/MM/dd")
	private Date brdDelDt; // 게시글삭제일자
	private String atchId; // 첨부파일코드
	private String brdTypeId; // 게시판그룹코드
	private String brdSendId; //게시글보낸직원
	private String brdRcvId; //게시글받는직원

	private String rnum; // 순번

	// 다중 파일 객체
	private MultipartFile[] uploadFile;
	// 다중 파일 업로드 객체
	private List<AttachVO> attachVO;
	// 다중 파일 객체의 파일명
	private String uploadFileName;
	// 파일
	private String noticeFile;

	public BoardVO() {
	}

	
	
	public String getBrdSendId() {
		return brdSendId;
	}



	public void setBrdSendId(String brdSendId) {
		this.brdSendId = brdSendId;
	}



	public String getBrdRcvId() {
		return brdRcvId;
	}



	public void setBrdRcvId(String brdRcvId) {
		this.brdRcvId = brdRcvId;
	}



	public String getBrdTypeId() {
		return brdTypeId;
	}

	public void setBrdTypeId(String brdTypeId) {
		this.brdTypeId = brdTypeId;
	}

	public String getAtchId() {
		return atchId;
	}

	public void setAtchId(String atchId) {
		this.atchId = atchId;
	}

	public Date getBrdDelDt() {
		return brdDelDt;
	}

	public void setBrdDelDt(Date brdDelDt) {
		this.brdDelDt = brdDelDt;
	}

	public Date getBrdMdfyDt() {
		return brdMdfyDt;
	}

	public void setBrdMdfyDt(Date brdMdfyDt) {
		this.brdMdfyDt = brdMdfyDt;
	}

	public Date getBrdWrtDt() {
		return brdWrtDt;
	}

	public void setBrdWrtDt(Date brdWrtDt) {
		this.brdWrtDt = brdWrtDt;
	}

	public String getBrdWrtr() {
		return brdWrtr;
	}

	public void setBrdWrtr(String brdWrtr) {
		this.brdWrtr = brdWrtr;
	}

	public int getBrdHit() {
		return brdHit;
	}

	public void setBrdHit(int brdHit) {
		this.brdHit = brdHit;
	}

	public String getBrdCntnt() {
		return brdCntnt;
	}

	public void setBrdCntnt(String brdCntnt) {
		this.brdCntnt = brdCntnt;
	}

	public String getBrdTitle() {
		return brdTitle;
	}

	public void setBrdTitle(String brdTitle) {
		this.brdTitle = brdTitle;
	}

	public String getBrdId() {
		return brdId;
	}

	public void setBrdId(String brdId) {
		this.brdId = brdId;
	}

	public String getRnum() {
		return rnum;
	}

	public void setRnum(String rnum) {
		this.rnum = rnum;
	}

	public MultipartFile[] getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(MultipartFile[] uploadFile) {
		this.uploadFile = uploadFile;
	}

	public List<AttachVO> getAttachVO() {
		return attachVO;
	}

	public void setAttachVO(List<AttachVO> attachVO) {
		this.attachVO = attachVO;
	}

	public String getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	public String getNoticeFile() {
		return noticeFile;
	}

	public void setNoticeFile(String noticeFile) {
		this.noticeFile = noticeFile;
	}

	@Override
	public String toString() {
		return "BoardVO [brdId=" + brdId + ", brdTitle=" + brdTitle + ", brdCntnt=" + brdCntnt + ", brdHit=" + brdHit
				+ ", brdWrtr=" + brdWrtr + ", brdWrtDt=" + brdWrtDt + ", brdMdfyDt=" + brdMdfyDt + ", brdDelDt="
				+ brdDelDt + ", atchId=" + atchId + ", brdTypeId=" + brdTypeId + ", brdSendId=" + brdSendId
				+ ", brdRcvId=" + brdRcvId + ", rnum=" + rnum + ", uploadFile=" + Arrays.toString(uploadFile)
				+ ", attachVO=" + attachVO + ", uploadFileName=" + uploadFileName + ", noticeFile=" + noticeFile + "]";
	}

}
