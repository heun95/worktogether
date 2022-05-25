package kr.or.workTogether.common.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

//메신저(CHAT)
public class ChatVO {
	private String chatId;                     //메신저방번호
	private String chatCntnt;               //메신저내용
	private String chatWrtr;                //메신저작성자
	private String wrtrName;                 //메신저작성일자
	private String wrtrPhoto;                 //메신저작성일자
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date chatWrtDt;                 //메신저작성일자
	private String chatbangId;                 //메신저작성일자
	
	public ChatVO() {}
	
	public String getChatId() {
		return chatId;
	}
	public void setChatId(String chatId) {
		this.chatId = chatId;
	}
	public String getChatCntnt() {
		return chatCntnt;
	}
	public void setChatCntnt(String chatCntnt) {
		this.chatCntnt = chatCntnt;
	}
	public String getChatWrtr() {
		return chatWrtr;
	}
	public void setChatWrtr(String chatWrtr) {
		this.chatWrtr = chatWrtr;
	}
	public Date getChatWrtDt() {
		return chatWrtDt;
	}
	public void setChatWrtDt(Date chatWrtDt) {
		this.chatWrtDt = chatWrtDt;
	}
	
	public String getChatbangId() {
		return chatbangId;
	}

	public void setChatbangId(String chatbangId) {
		this.chatbangId = chatbangId;
	}
	
	public String getWrtrName() {
		return wrtrName;
	}

	public void setWrtrName(String wrtrName) {
		this.wrtrName = wrtrName;
	}

	public String getWrtrPhoto() {
		return wrtrPhoto;
	}

	public void setWrtrPhoto(String wrtrPhoto) {
		this.wrtrPhoto = wrtrPhoto;
	}

	@Override
	public String toString() {
		return "ChatVO [chatId=" + chatId + ", chatCntnt=" + chatCntnt + ", chatWrtr=" + chatWrtr + ", wrtrName="
				+ wrtrName + ", wrtrPhoto=" + wrtrPhoto + ", chatWrtDt=" + chatWrtDt + ", chatbangId=" + chatbangId
				+ "]";
	}
	
}
