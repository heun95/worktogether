package kr.or.workTogether.common.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

//실시간알림(NOTIFICATION)
public class NotificationVO {
	private String notId;                   //알림코드
	private String notReceiver;             //수진받는 직원
	private String notSender;          	    //발신하는 직원
	private String notTypeId;               //알림종류
	private String notCntntId;              //알림해당글PK
	private String notMsg;                  //알림내용
	private String notUrl;                  //알림글URL
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date notDt;                     //알림발생일자
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date notReadDt;                 //알림확인일자
	private String isread;					//확인여부
	
	private int cnt;						//읽지않은 총 개수
	
	//private String notCntnt;				//알림해당글
	//private String notCntntName;			//알림해당글명
	
	private String notSenderName;			//발신하는 직원명
	
	public NotificationVO() {}
	
	public String getNotId() {
		return notId;
	}
	public String getNotTypeId() {
		return notTypeId;
	}
	public String getNotCntntId() {
		return notCntntId;
	}
	public String getNotMsg() {
		return notMsg;
	}
	public String getNotUrl() {
		return notUrl;
	}
	public Date getNotDt() {
		return notDt;
	}
	public Date getNotReadDt() {
		return notReadDt;
	}
	public void setNotId(String notId) {
		this.notId = notId;
	}
	public void setNotTypeId(String notTypeId) {
		this.notTypeId = notTypeId;
	}
	public void setNotCntntId(String notCntntId) {
		this.notCntntId = notCntntId;
	}
	public void setNotMsg(String notMsg) {
		this.notMsg = notMsg;
	}
	public void setNotUrl(String notUrl) {
		this.notUrl = notUrl;
	}
	public void setNotDt(Date notDt) {
		this.notDt = notDt;
	}
	public void setNotReadDt(Date notReadDt) {
		this.notReadDt = notReadDt;
	}
	public String getNotReceiver() {
		return notReceiver;
	}
	public void setNotReceiver(String notReceiver) {
		this.notReceiver = notReceiver;
	}
	public String getNotSender() {
		return notSender;
	}
	public void setNotSender(String notSender) {
		this.notSender = notSender;
	}
	public String getIsread() {
		return isread;
	}
	public void setIsread(String isread) {
		this.isread = isread;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getNotSenderName() {
		return notSenderName;
	}
	public void setNotSenderName(String notSenderName) {
		this.notSenderName = notSenderName;
	}

	@Override
	public String toString() {
		return "NotificationVO [notId=" + notId + ", notReceiver=" + notReceiver + ", notSender=" + notSender
				+ ", notTypeId=" + notTypeId + ", notCntntId=" + notCntntId + ", notMsg=" + notMsg + ", notUrl="
				+ notUrl + ", notDt=" + notDt + ", notReadDt=" + notReadDt + ", isread=" + isread + ", cnt=" + cnt
				+ ", notSenderName=" + notSenderName + "]";
	}
	
}
