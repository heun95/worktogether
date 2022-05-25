package kr.or.workTogether.common.vo;

import java.io.Serializable;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

//직원(EMPLOYEE)
public class EmployeeVO implements Serializable{
	@NotBlank
	private String empId;                   //직원아이디(사원 번호)
	@NotBlank
	private String empPassword;             //비밀번호
	@NotBlank
	private String empName;                 //직원이름
	@NotBlank
	@Pattern(regexp = "^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$", message = "핸드폰번호 양식 01x-xxxx-xxxx")
	private String empTel;                  //전화번호
	private String empPosition;             //직원직급
	private String deptId;                  //부서코드
	private String empPhoto;                //증명사진
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date empBirth;                  //생년월일
	private String empReg;                  //주민번호
	private String empEmail;                //직원이메일
	private String empResume;               //이력서
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date empEcnyYmd;                //입사일자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date empRetireYmd;              //퇴사일자
	private String empState;                //재직상태
	private String empQrcode;               //큐알코드
	private String empSign;                 //전자서명
	private String deptName;                //부서이름
	private int rnum;                       //페이징 숫자
	private String empPostno; //우편번호
	private String empAddr1; //주소
	private String empAddr2; //상세주소
	
	//로그인 - VW_USER 뷰테이블
	private String username;
	private String password;
	private String enabled;
	private String atchId;
	private String atchPath;
	private String atchName;
	private String atchOldName;
	private String atchExtns;
	
	//로그인 - EmployeeAuthList
	List<EmployeeAuthVO> employeeAuthList;
	
	//다중 파일 객체
	private MultipartFile[] uploadFile;
	//다중 파일 업로드 객체
	private List<AttachVO> attachVO;
	
	//다중 파일 객체의 파일명
	private String uploadFileName;

	private String cmmnGroupName;
	
	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getEmpPassword() {
		return empPassword;
	}

	public void setEmpPassword(String empPassword) {
		this.empPassword = empPassword;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getEmpTel() {
		return empTel;
	}

	public void setEmpTel(String empTel) {
		this.empTel = empTel;
	}

	public String getEmpPosition() {
		return empPosition;
	}

	public void setEmpPosition(String empPosition) {
		this.empPosition = empPosition;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public String getEmpPhoto() {
		return empPhoto;
	}

	public void setEmpPhoto(String empPhoto) {
		this.empPhoto = empPhoto;
	}

	public Date getEmpBirth() {
		return empBirth;
	}

	public void setEmpBirth(Date empBirth) {
		this.empBirth = empBirth;
	}

	public String getEmpReg() {
		return empReg;
	}

	public void setEmpReg(String empReg) {
		this.empReg = empReg;
	}

	public String getEmpEmail() {
		return empEmail;
	}

	public void setEmpEmail(String empEmail) {
		this.empEmail = empEmail;
	}

	public String getEmpResume() {
		return empResume;
	}

	public void setEmpResume(String empResume) {
		this.empResume = empResume;
	}

	public Date getEmpEcnyYmd() {
		return empEcnyYmd;
	}

	public void setEmpEcnyYmd(Date empEcnyYmd) {
		this.empEcnyYmd = empEcnyYmd;
	}

	public Date getEmpRetireYmd() {
		return empRetireYmd;
	}

	public void setEmpRetireYmd(Date empRetireYmd) {
		this.empRetireYmd = empRetireYmd;
	}

	public String getEmpState() {
		return empState;
	}

	public void setEmpState(String empState) {
		this.empState = empState;
	}

	public String getEmpQrcode() {
		return empQrcode;
	}

	public void setEmpQrcode(String empQrcode) {
		this.empQrcode = empQrcode;
	}

	public String getEmpSign() {
		return empSign;
	}

	public void setEmpSign(String empSign) {
		this.empSign = empSign;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public int getRnum() {
		return rnum;
	}

	public void setRnum(int rnum) {
		this.rnum = rnum;
	}

	public String getEmpPostno() {
		return empPostno;
	}

	public void setEmpPostno(String empPostno) {
		this.empPostno = empPostno;
	}

	public String getEmpAddr1() {
		return empAddr1;
	}

	public void setEmpAddr1(String empAddr1) {
		this.empAddr1 = empAddr1;
	}

	public String getEmpAddr2() {
		return empAddr2;
	}

	public void setEmpAddr2(String empAddr2) {
		this.empAddr2 = empAddr2;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEnabled() {
		return enabled;
	}

	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}

	public List<EmployeeAuthVO> getEmployeeAuthList() {
		return employeeAuthList;
	}

	public void setEmployeeAuthList(List<EmployeeAuthVO> employeeAuthList) {
		this.employeeAuthList = employeeAuthList;
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

	public String getCmmnGroupName() {
		return cmmnGroupName;
	}

	public void setCmmnGroupName(String cmmnGroupName) {
		this.cmmnGroupName = cmmnGroupName;
	}

	public String getAtchId() {
		return atchId;
	}

	public void setAtchId(String atchId) {
		this.atchId = atchId;
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

	public String getAtchOldName() {
		return atchOldName;
	}

	public void setAtchOldName(String atchOldName) {
		this.atchOldName = atchOldName;
	}

	public String getAtchExtns() {
		return atchExtns;
	}

	public void setAtchExtns(String atchExtns) {
		this.atchExtns = atchExtns;
	}

	@Override
	public String toString() {
		return "EmployeeVO [empId=" + empId + ", empPassword=" + empPassword + ", empName=" + empName + ", empTel="
				+ empTel + ", empPosition=" + empPosition + ", deptId=" + deptId + ", empPhoto=" + empPhoto
				+ ", empBirth=" + empBirth + ", empReg=" + empReg + ", empEmail=" + empEmail + ", empResume="
				+ empResume + ", empEcnyYmd=" + empEcnyYmd + ", empRetireYmd=" + empRetireYmd + ", empState=" + empState
				+ ", empQrcode=" + empQrcode + ", empSign=" + empSign + ", deptName=" + deptName + ", rnum=" + rnum
				+ ", empPostno=" + empPostno + ", empAddr1=" + empAddr1 + ", empAddr2=" + empAddr2 + ", username="
				+ username + ", password=" + password + ", enabled=" + enabled + ", atchId=" + atchId + ", atchPath="
				+ atchPath + ", atchName=" + atchName + ", atchOldName=" + atchOldName + ", atchExtns=" + atchExtns
				+ ", employeeAuthList=" + employeeAuthList + ", uploadFile=" + Arrays.toString(uploadFile)
				+ ", attachVO=" + attachVO + ", uploadFileName=" + uploadFileName + ", cmmnGroupName=" + cmmnGroupName
				+ "]";
	}

}
	