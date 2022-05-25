package kr.or.workTogether.common.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

//일바별근태(ATNDN_DLY)
public class AtndnDlyVO {
	private String atndnDlyId; // 출퇴근코드
	private String empId; // 직원아이디
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date atndnDlyDt; // 출퇴근날짜
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date atndnStrtDt; // 출근시간
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date atndnEndDt; // 퇴근시간
	private String atndnDlyRsn; // 근태사유
	private String atndnTypeId; // 근태유형코드

	private String date;
	private String start;
	private String end;

	private String tempAtndnDlyDt; //임시출퇴근날짜
	
	
	public AtndnDlyVO() {
	}

//	public static void main(String[] args) {
//		SimpleDateFormat simpleFormat = new SimpleDateFormat("HH:mm");
//		System.out.println(simpleFormat.format(new Date()));
//	}

	public String getDate() {
		SimpleDateFormat simpleFormat = new SimpleDateFormat("dd");
		date = simpleFormat.format(atndnDlyDt);
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getStart() {
		SimpleDateFormat simpleFormat = new SimpleDateFormat("HH:mm");
		start = simpleFormat.format(atndnStrtDt);
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}

	public String getEnd() {
		SimpleDateFormat simpleFormat = new SimpleDateFormat("HH:mm");
		if(atndnEndDt == null) {
			end = "";
		}else {
			end = simpleFormat.format(atndnEndDt);
		}
		return end;
	}

	public void setEnd(String end) {
		this.end = end;
	}

	public String getAtndnDlyId() {
		return atndnDlyId;
	}

	public void setAtndnDlyId(String atndnDlyId) {
		this.atndnDlyId = atndnDlyId;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public Date getAtndnDlyDt() {
		return atndnDlyDt;
	}

	public void setAtndnDlyDt(Date atndnDlyDt) {
		this.atndnDlyDt = atndnDlyDt;
	}

	public Date getAtndnStrtDt() {
		return atndnStrtDt;
	}

	public void setAtndnStrtDt(Date atndnStrtDt) {
		this.atndnStrtDt = atndnStrtDt;
	}

	public Date getAtndnEndDt() {
		return atndnEndDt;
	}

	public void setAtndnEndDt(Date atndnEndDt) {
		this.atndnEndDt = atndnEndDt;
	}

	public String getAtndnDlyRsn() {
		return atndnDlyRsn;
	}

	public void setAtndnDlyRsn(String atndnDlyRsn) {
		this.atndnDlyRsn = atndnDlyRsn;
	}

	public String getAtndnTypeId() {
		return atndnTypeId;
	}

	public void setAtndnTypeId(String atndnTypeId) {
		this.atndnTypeId = atndnTypeId;
	}

	public String getTempAtndnDlyDt() {
		return tempAtndnDlyDt;
	}

	public void setTempAtndnDlyDt(String tempAtndnDlyDt) {
		this.tempAtndnDlyDt = tempAtndnDlyDt;
	}

	@Override
	public String toString() {
		return "AtndnDlyVO [atndnDlyId=" + atndnDlyId + ", empId=" + empId + ", atndnDlyDt=" + atndnDlyDt
				+ ", atndnStrtDt=" + atndnStrtDt + ", atndnEndDt=" + atndnEndDt + ", atndnDlyRsn=" + atndnDlyRsn
				+ ", atndnTypeId=" + atndnTypeId + ", date=" + date + ", start=" + start + ", end=" + end
				+ ", tempAtndnDlyDt=" + tempAtndnDlyDt + "]";
	}

}
