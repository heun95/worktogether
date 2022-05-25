package kr.or.workTogether.common.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

//회의일정(MEETING)
public class MeetingVO {
	private String mtngId;                  //회의코드
	private String mtngTitle;               //회의제목
	private String mtngCntnt;               //회의내용
	private String mtngRsrvtId;             //회의실예약코드
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date mtngStrtDt;                //회의시작일자
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date mtngWrtDt;                 //회의작성일자
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date mtngMdfyDt;                //회의수정일자
	@DateTimeFormat(pattern="yyyy/MM/dd")
	private Date mtngDelDt;                 //회의삭제일자
	private String mtngTypeId;              //회의분류코드
	private String mtngStrtTime;			//회의시작시간
	private String mtngEndTime;				//회의종료시간
	
	private String mtngState;				//회의상태
	
	private String mtngRsrvtEmpId;			//회의실예악자코드
	private String mtngRsrvtState;			//회실예약상태
	private String mtngRoomTypeId;			//회의실분류코드
	
	private String roomName;				//회의실명
	
	private String empName;					//회의실예약자이름
	
	private String mtngTypeName;			//회의분류명
	
	private String mtngAttendCnt;			//회의참석자수
	
	public MeetingVO() {}
	
	public String getMtngId() {
		return mtngId;
	}
	public String getMtngTitle() {
		return mtngTitle;
	}
	public String getMtngCntnt() {
		return mtngCntnt;
	}
	public String getMtngRsrvtId() {
		return mtngRsrvtId;
	}
	public Date getMtngStrtDt() {
		return mtngStrtDt;
	}
	public Date getMtngWrtDt() {
		return mtngWrtDt;
	}
	public Date getMtngMdfyDt() {
		return mtngMdfyDt;
	}
	public Date getMtngDelDt() {
		return mtngDelDt;
	}
	public String getMtngTypeId() {
		return mtngTypeId;
	}
	public void setMtngId(String mtngId) {
		this.mtngId = mtngId;
	}
	public void setMtngTitle(String mtngTitle) {
		this.mtngTitle = mtngTitle;
	}
	public void setMtngCntnt(String mtngCntnt) {
		this.mtngCntnt = mtngCntnt;
	}
	public void setMtngRsrvtId(String mtngRsrvtId) {
		this.mtngRsrvtId = mtngRsrvtId;
	}
	public void setMtngStrtDt(Date mtngStrtDt) {
		this.mtngStrtDt = mtngStrtDt;
	}
	public void setMtngWrtDt(Date mtngWrtDt) {
		this.mtngWrtDt = mtngWrtDt;
	}
	public void setMtngMdfyDt(Date mtngMdfyDt) {
		this.mtngMdfyDt = mtngMdfyDt;
	}
	public void setMtngDelDt(Date mtngDelDt) {
		this.mtngDelDt = mtngDelDt;
	}
	public void setMtngTypeId(String mtngTypeId) {
		this.mtngTypeId = mtngTypeId;
	}
	public String getMtngStrtTime() {
		return mtngStrtTime;
	}
	public void setMtngStrtTime(String mtngStrtTime) {
		this.mtngStrtTime = mtngStrtTime;
	}
	public String getMtngEndTime() {
		return mtngEndTime;
	}
	public void setMtngEndTime(String mtngEndTime) {
		this.mtngEndTime = mtngEndTime;
	}
	public String getMtngState() {
		return mtngState;
	}
	public void setMtngState(String mtngState) {
		this.mtngState = mtngState;
	}
	public String getMtngRsrvtEmpId() {
		return mtngRsrvtEmpId;
	}
	public void setMtngRsrvtEmpId(String mtngRsrvtEmpId) {
		this.mtngRsrvtEmpId = mtngRsrvtEmpId;
	}
	public String getMtngRsrvtState() {
		return mtngRsrvtState;
	}
	public void setMtngRsrvtState(String mtngRsrvtState) {
		this.mtngRsrvtState = mtngRsrvtState;
	}
	public String getMtngRoomTypeId() {
		return mtngRoomTypeId;
	}
	public void setMtngRoomTypeId(String mtngRoomTypeId) {
		this.mtngRoomTypeId = mtngRoomTypeId;
	}
	public String getRoomName() {
		return roomName;
	}
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getMtngTypeName() {
		return mtngTypeName;
	}
	public void setMtngTypeName(String mtngTypeName) {
		this.mtngTypeName = mtngTypeName;
	}
	public String getMtngAttendCnt() {
		return mtngAttendCnt;
	}
	public void setMtngAttendCnt(String mtngAttendCnt) {
		this.mtngAttendCnt = mtngAttendCnt;
	}

	@Override
	public String toString() {
		return "MeetingVO [mtngId=" + mtngId + ", mtngTitle=" + mtngTitle + ", mtngCntnt=" + mtngCntnt
				+ ", mtngRsrvtId=" + mtngRsrvtId + ", mtngStrtDt=" + mtngStrtDt + ", mtngWrtDt=" + mtngWrtDt
				+ ", mtngMdfyDt=" + mtngMdfyDt + ", mtngDelDt=" + mtngDelDt + ", mtngTypeId=" + mtngTypeId
				+ ", mtngStrtTime=" + mtngStrtTime + ", mtngEndTime=" + mtngEndTime + ", mtngState=" + mtngState
				+ ", mtngRsrvtEmpId=" + mtngRsrvtEmpId + ", mtngRsrvtState=" + mtngRsrvtState + ", mtngRoomTypeId="
				+ mtngRoomTypeId + ", roomName=" + roomName + ", empName=" + empName + ", mtngTypeName=" + mtngTypeName
				+ ", mtngAttendCnt=" + mtngAttendCnt + "]";
	}
	
}
