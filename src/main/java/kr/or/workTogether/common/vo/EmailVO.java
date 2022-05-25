package kr.or.workTogether.common.vo;

import java.util.Arrays;
import java.util.Date;
import java.util.List;


import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

//메일(EMAIL)
public class EmailVO {
	private String emailId;                 //메일코드
	private String emailCntnt;              //메일내용
	private String emailTitle;              //메일제목
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date emailWrtDt;                //메일작성일자
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date emailDelDt;                //메일삭제일자
	private String emailSendId;             //메일보낸직원
	private String emailRcvId;              //메일받은직원
	private String emailTypeId;             //메일유형코드
	private String atchId;                  //첨부파일코드
	private String emailSee;                //메일 열람 여부
	private String emailDelId;				//메일 삭제한사람
	private String emailCheck;              //메일 확인 여부
	private String emailSenddel;            //발신자 삭제여부
	private String emailRedel;              //수신자 삭제여부
	
	private String empName;                 //직원이름
	private int rnum;                 //직원이름
	
	//다중 파일 객체
	private MultipartFile[] uploadFile;
	//다중 파일 업로드 객체
	private List<AttachVO> attachVO;
	//다중 파일 객체의 파일명
	private String uploadFileName;
	
	
	public EmailVO() {}

	public String getEmailId() {
		return emailId;
	}

	public void setEmailId(String emailId) {
		this.emailId = emailId;
	}

	public String getEmailCntnt() {
		return emailCntnt;
	}

	public void setEmailCntnt(String emailCntnt) {
		this.emailCntnt = emailCntnt;
	}

	public String getEmailTitle() {
		return emailTitle;
	}

	public void setEmailTitle(String emailTitle) {
		this.emailTitle = emailTitle;
	}

	public Date getEmailWrtDt() {
		return emailWrtDt;
	}

	public void setEmailWrtDt(Date emailWrtDt) {
		this.emailWrtDt = emailWrtDt;
	}

	public Date getEmailDelDt() {
		return emailDelDt;
	}

	public void setEmailDelDt(Date emailDelDt) {
		this.emailDelDt = emailDelDt;
	}

	public String getEmailSendId() {
		return emailSendId;
	}

	public void setEmailSendId(String emailSendId) {
		this.emailSendId = emailSendId;
	}

	public String getEmailRcvId() {
		return emailRcvId;
	}

	public void setEmailRcvId(String emailRcvId) {
		this.emailRcvId = emailRcvId;
	}

	public String getEmailTypeId() {
		return emailTypeId;
	}

	public void setEmailTypeId(String emailTypeId) {
		this.emailTypeId = emailTypeId;
	}

	public String getAtchId() {
		return atchId;
	}

	public void setAtchId(String atchId) {
		this.atchId = atchId;
	}

	public String getEmailSee() {
		return emailSee;
	}

	public void setEmailSee(String emailSee) {
		this.emailSee = emailSee;
	}

	
	public String getEmailDelId() {
		return emailDelId;
	}

	public void setEmailDelId(String emailDelId) {
		this.emailDelId = emailDelId;
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
	
	

	public String getEmailCheck() {
		return emailCheck;
	}

	public void setEmailCheck(String emailCheck) {
		this.emailCheck = emailCheck;
	}

	
	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	
	public String getEmailSenddel() {
		return emailSenddel;
	}

	public void setEmailSenddel(String emailSenddel) {
		this.emailSenddel = emailSenddel;
	}

	public String getEmailRedel() {
		return emailRedel;
	}

	public void setEmailRedel(String emailRedel) {
		this.emailRedel = emailRedel;
	}
	

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	@Override
	public String toString() {
		return "EmailVO [emailId=" + emailId + ", emailCntnt=" + emailCntnt + ", emailTitle=" + emailTitle
				+ ", emailWrtDt=" + emailWrtDt + ", emailDelDt=" + emailDelDt + ", emailSendId=" + emailSendId
				+ ", emailRcvId=" + emailRcvId + ", emailTypeId=" + emailTypeId + ", atchId=" + atchId + ", emailSee="
				+ emailSee + ", emailDelId=" + emailDelId + ", emailCheck=" + emailCheck + ", emailSenddel="
				+ emailSenddel + ", emailRedel=" + emailRedel + ", empName=" + empName + ", rnum=" + rnum
				+ ", uploadFile=" + Arrays.toString(uploadFile) + ", attachVO=" + attachVO + ", uploadFileName="
				+ uploadFileName + "]";
	}

}
