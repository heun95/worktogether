package kr.or.workTogether.common.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

//메모(MEMO)
public class MemoVO {
	private String memoId;                  //메모번호
	private String memoWrtr;                //메모작성자
	private String memoTitle;               //메모제목
	private String memoCntnt;               //메모내용
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date memoWrtDt;                 //메모작성일자
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date memoMdfyDt;                //메모수정일자
	
	public MemoVO() {}

	public String getMemoId() {
		return memoId;
	}

	public void setMemoId(String memoId) {
		this.memoId = memoId;
	}

	public String getMemoWrtr() {
		return memoWrtr;
	}

	public void setMemoWrtr(String memoWrtr) {
		this.memoWrtr = memoWrtr;
	}

	public String getMemoTitle() {
		return memoTitle;
	}

	public void setMemoTitle(String memoTitle) {
		this.memoTitle = memoTitle;
	}

	public String getMemoCntnt() {
		return memoCntnt;
	}

	public void setMemoCntnt(String memoCntnt) {
		this.memoCntnt = memoCntnt;
	}

	public Date getMemoWrtDt() {
		return memoWrtDt;
	}

	public void setMemoWrtDt(Date memoWrtDt) {
		this.memoWrtDt = memoWrtDt;
	}

	public Date getMemoMdfyDt() {
		return memoMdfyDt;
	}

	public void setMemoMdfyDt(Date memoMdfyDt) {
		this.memoMdfyDt = memoMdfyDt;
	}

	@Override
	public String toString() {
		return "MemoVO [memoId=" + memoId + ", memoWrtr=" + memoWrtr + ", memoTitle=" + memoTitle + ", memoCntnt="
				+ memoCntnt + ", memoWrtDt=" + memoWrtDt + ", memoMdfyDt=" + memoMdfyDt + "]";
	}
	
	

}
