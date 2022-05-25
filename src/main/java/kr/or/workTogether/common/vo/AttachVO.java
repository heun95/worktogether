package kr.or.workTogether.common.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

//첨부파일(ATTACH)
public class AttachVO {
	private String atchId; // 첨부파일코드
	private String atchRelId; // 첨부파일코드
	private String atchPath; // 첨부파일경로
	private String atchName; // 첨부파일이름
	private String atchOldname; // 첨부파일원래이름
	private String atchExtns; // 첨부파일확장자
	@DateTimeFormat(pattern = "yyyy/MM/dd")
	private Date atchWrtDate; // 첨부파일등록일자
	@DateTimeFormat(pattern = "yyyy/MM/dd")
	private Date atchDelDate; // 첨부파일삭제일자
	private long atchSize; // 첨부파일크기
	private String atchWrtr; // 첨부파일확장자

	public AttachVO() {
	}

	public String getAtchId() {
		return atchId;
	}

	public void setAtchId(String atchId) {
		this.atchId = atchId;
	}

	public String getAtchRelId() {
		return atchRelId;
	}

	public void setAtchRelId(String atchRelId) {
		this.atchRelId = atchRelId;
	}

	public String getAtchPath() {
		return atchPath;
	}

	public void setAtchPath(String atchPath) {
		this.atchPath = atchPath;
	}

	public String getAtchName() {
		return atchName;
	}

	public void setAtchName(String atchName) {
		this.atchName = atchName;
	}

	public String getAtchOldname() {
		return atchOldname;
	}

	public void setAtchOldname(String atchOldname) {
		this.atchOldname = atchOldname;
	}

	public String getAtchExtns() {
		return atchExtns;
	}

	public void setAtchExtns(String atchExtns) {
		this.atchExtns = atchExtns;
	}

	public Date getAtchWrtDate() {
		return atchWrtDate;
	}

	public void setAtchWrtDate(Date atchWrtDate) {
		this.atchWrtDate = atchWrtDate;
	}

	public Date getAtchDelDate() {
		return atchDelDate;
	}

	public void setAtchDelDate(Date atchDelDate) {
		this.atchDelDate = atchDelDate;
	}
	
	
	public long getAtchSize() {
		return atchSize;
	}

	public void setAtchSize(long l) {
		this.atchSize = l;
	}
	
	public String getAtchWrtr() {
		return atchWrtr;
	}

	public void setAtchWrtr(String atchWrtr) {
		this.atchWrtr = atchWrtr;
	}

	@Override
	public String toString() {
		return "AttachVO [atchId=" + atchId + ", atchRelId=" + atchRelId + ", atchPath=" + atchPath + ", atchName="
				+ atchName + ", atchOldname=" + atchOldname + ", atchExtns=" + atchExtns + ", atchWrtDate="
				+ atchWrtDate + ", atchDelDate=" + atchDelDate + ", atchSize=" + atchSize + ", atchWrtr=" + atchWrtr
				+ "]";
	}

}
