package kr.or.workTogether.common.vo;

//공통코드(COMMON_CODE)
public class CommonCodeVO {
	private String cmmnId;                  //공통코드
	private String cmmnGroupId;             //공통그룹코드
	private String cmmnGroupName;           //공통코드그룹명
	private String cmmnNm1;                 //코드명1
	private String cmmnNm2;                 //코드명2
	private String cmmnNm3;                 //코드명3
	private String cmmnOpt1;                //옵션1
	private String cmmnOpt2;                //옵션2
	private String cmmnOpt3;                //옵션3
	private String cmmnYn;                  //사용여부(Y/N)
	private String cmmnClob; 				//대용량
	
	public CommonCodeVO() {}
	
	public String getCmmnId() {
		return cmmnId;
	}
	public void setCmmnId(String cmmnId) {
		this.cmmnId = cmmnId;
	}
	public String getCmmnGroupId() {
		return cmmnGroupId;
	}
	public void setCmmnGroupId(String cmmnGroupId) {
		this.cmmnGroupId = cmmnGroupId;
	}
	public String getCmmnGroupName() {
		return cmmnGroupName;
	}
	public void setCmmnGroupName(String cmmnGroupName) {
		this.cmmnGroupName = cmmnGroupName;
	}
	public String getCmmnNm1() {
		return cmmnNm1;
	}
	public void setCmmnNm1(String cmmnNm1) {
		this.cmmnNm1 = cmmnNm1;
	}
	public String getCmmnNm2() {
		return cmmnNm2;
	}
	public void setCmmnNm2(String cmmnNm2) {
		this.cmmnNm2 = cmmnNm2;
	}
	public String getCmmnNm3() {
		return cmmnNm3;
	}
	public void setCmmnNm3(String cmmnNm3) {
		this.cmmnNm3 = cmmnNm3;
	}
	public String getCmmnOpt1() {
		return cmmnOpt1;
	}
	public void setCmmnOpt1(String cmmnOpt1) {
		this.cmmnOpt1 = cmmnOpt1;
	}
	public String getCmmnOpt2() {
		return cmmnOpt2;
	}
	public void setCmmnOpt2(String cmmnOpt2) {
		this.cmmnOpt2 = cmmnOpt2;
	}
	public String getCmmnOpt3() {
		return cmmnOpt3;
	}
	public void setCmmnOpt3(String cmmnOpt3) {
		this.cmmnOpt3 = cmmnOpt3;
	}
	public String getCmmnYn() {
		return cmmnYn;
	}
	public void setCmmnYn(String cmmnYn) {
		this.cmmnYn = cmmnYn;
	}
	public String getCmmnClob() {
		return cmmnClob;
	}
	public void setCmmnClob(String cmmnClob) {
		this.cmmnClob = cmmnClob;
	}

	@Override
	public String toString() {
		return "CommonCodeVO [cmmnId=" + cmmnId + ", cmmnGroupId=" + cmmnGroupId + ", cmmnGroupName=" + cmmnGroupName
				+ ", cmmnNm1=" + cmmnNm1 + ", cmmnNm2=" + cmmnNm2 + ", cmmnNm3=" + cmmnNm3 + ", cmmnOpt1=" + cmmnOpt1
				+ ", cmmnOpt2=" + cmmnOpt2 + ", cmmnOpt3=" + cmmnOpt3 + ", cmmnYn=" + cmmnYn + ", cmmnClob=" + cmmnClob
				+ "]";
	}
	
}
