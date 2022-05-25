package kr.or.workTogether.common.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

//게시판댓글(BOARD_REPLY)
public class BoardReplyVO {
	private int brdRplyId;                  //게시판댓글번호
	private String brdId;                      //게시글번호
	private String brdRplyCntnt;            //게시판댓글내용
	private int topBrdRplyId;               //게시판상위댓글번호
	private int brdRplyLevel;               //게시판댓글레벨
	private String brdRplyWrtr;             //게시판댓글작성자
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date brdRplyWrtDt;              //게시판댓글작성일자
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date brdRplyMdfyDt;             //게시판댓글수정일자
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date brdRplyDelDt;              //게시판댓글삭제일자
	
	public BoardReplyVO() {}
	
	public int getBrdRplyId() {
		return brdRplyId;
	}
	public void setBrdRplyId(int brdRplyId) {
		this.brdRplyId = brdRplyId;
	}
	public String getBrdId() {
		return brdId;
	}
	public void setBrdId(String brdId) {
		this.brdId = brdId;
	}
	public String getBrdRplyCntnt() {
		return brdRplyCntnt;
	}
	public void setBrdRplyCntnt(String brdRplyCntnt) {
		this.brdRplyCntnt = brdRplyCntnt;
	}
	public int getTopBrdRplyId() {
		return topBrdRplyId;
	}
	public void setTopBrdRplyId(int topBrdRplyId) {
		this.topBrdRplyId = topBrdRplyId;
	}
	public int getBrdRplyLevel() {
		return brdRplyLevel;
	}
	public void setBrdRplyLevel(int brdRplyLevel) {
		this.brdRplyLevel = brdRplyLevel;
	}
	public String getBrdRplyWrtr() {
		return brdRplyWrtr;
	}
	public void setBrdRplyWrtr(String brdRplyWrtr) {
		this.brdRplyWrtr = brdRplyWrtr;
	}
	public Date getBrdRplyWrtDt() {
		return brdRplyWrtDt;
	}
	public void setBrdRplyWrtDt(Date brdRplyWrtDt) {
		this.brdRplyWrtDt = brdRplyWrtDt;
	}
	public Date getBrdRplyMdfyDt() {
		return brdRplyMdfyDt;
	}
	public void setBrdRplyMdfyDt(Date brdRplyMdfyDt) {
		this.brdRplyMdfyDt = brdRplyMdfyDt;
	}
	public Date getBrdRplyDelDt() {
		return brdRplyDelDt;
	}
	public void setBrdRplyDelDt(Date brdRplyDelDt) {
		this.brdRplyDelDt = brdRplyDelDt;
	}
	
	@Override
	public String toString() {
		return "boardReplyVO [brdRplyId=" + brdRplyId + ", brdId=" + brdId + ", brdRplyCntnt=" + brdRplyCntnt
				+ ", topBrdRplyId=" + topBrdRplyId + ", brdRplyLevel=" + brdRplyLevel + ", brdRplyWrtr=" + brdRplyWrtr
				+ "]";
	}
	
}
