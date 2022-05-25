package kr.or.workTogether.common.vo;

//회의실예약(MTNG_RSRVT)
public class MtngRsrvtVO {
	private String mtngRsrvtId;             //회의실예약코드
	private String mtngRsrvtEmpId;          //회의실예약자
	private String mtngRsrvtState;          //회의실예약상태
	private String mtngRoomTypeId;          //회의실분류코드
	
	public MtngRsrvtVO() {}
	
	public String getMtngRsrvtId() {
		return mtngRsrvtId;
	}
	public String getMtngRsrvtEmpId() {
		return mtngRsrvtEmpId;
	}
	public String getMtngRsrvtState() {
		return mtngRsrvtState;
	}
	public String getMtngRoomTypeId() {
		return mtngRoomTypeId;
	}
	public void setMtngRsrvtId(String mtngRsrvtId) {
		this.mtngRsrvtId = mtngRsrvtId;
	}
	public void setMtngRsrvtEmpId(String mtngRsrvtEmpId) {
		this.mtngRsrvtEmpId = mtngRsrvtEmpId;
	}
	public void setMtngRsrvtState(String mtngRsrvtState) {
		this.mtngRsrvtState = mtngRsrvtState;
	}
	public void setMtngRoomTypeId(String mtngRoomTypeId) {
		this.mtngRoomTypeId = mtngRoomTypeId;
	}
	
	@Override
	public String toString() {
		return "MeetingReserveVO [mtngRsrvtId=" + mtngRsrvtId + ", mtngRsrvtEmpId=" + mtngRsrvtEmpId
				+ ", mtngRsrvtState=" + mtngRsrvtState + ", mtngRoomTypeId=" + mtngRoomTypeId + "]";
	}
	
}
