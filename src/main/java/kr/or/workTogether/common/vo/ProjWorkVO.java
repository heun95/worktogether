package kr.or.workTogether.common.vo;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

//프로젝트업무(PROJ_WORK)
public class ProjWorkVO {
	private String workId;                  //업무코드
	private String projId;                  //프로젝트코드
	private String workRqstr;               //업무작성자아이디
	private String workRqstrNm;               //업무작성자이름
	private String workRqstrPhoto;               //업무작성자이름
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date workStrtDt;                //업무시작일자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date workEndDt;                 //업무예상만기일자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date workRendDt;                //업무실제만기일자
	private int workProgress;               //업무진행도
	private String workState;               //업무상태
	private String workPriority;            //업무우선도
	private String topWorkId;               //상위업무코드
	private int workLevel;                  //업무레벨
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date workWrtDt;                 //업무작성일자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date workMdfyDt;                //업무수정일자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date workDelDt;                 //업무삭제일자
	private String workTitle;               //업무제목
	private String workCntnt;               //업무내용
	
	private List<WorkMngrVO> workMngr;                  //업무담당자
	private List<String> workMngrId;                  //업무담당자
	
	private MultipartFile[] uploadFile;     //다중 파일 객체
	
	private List<AttachVO> attachVO;        //다중 파일 업로드 객체
	
	public ProjWorkVO() {}


	public String getWorkId() {
		return workId;
	}



	public void setWorkId(String workId) {
		this.workId = workId;
	}



	public String getProjId() {
		return projId;
	}



	public void setProjId(String projId) {
		this.projId = projId;
	}



	public String getWorkRqstr() {
		return workRqstr;
	}



	public void setWorkRqstr(String workRqstr) {
		this.workRqstr = workRqstr;
	}



	public String getWorkRqstrNm() {
		return workRqstrNm;
	}



	public void setWorkRqstrNm(String workRqstrNm) {
		this.workRqstrNm = workRqstrNm;
	}



	public String getWorkRqstrPhoto() {
		return workRqstrPhoto;
	}



	public void setWorkRqstrPhoto(String workRqstrPhoto) {
		this.workRqstrPhoto = workRqstrPhoto;
	}



	public Date getWorkStrtDt() {
		return workStrtDt;
	}



	public void setWorkStrtDt(Date workStrtDt) {
		this.workStrtDt = workStrtDt;
	}



	public Date getWorkEndDt() {
		return workEndDt;
	}



	public void setWorkEndDt(Date workEndDt) {
		this.workEndDt = workEndDt;
	}



	public Date getWorkRendDt() {
		return workRendDt;
	}



	public void setWorkRendDt(Date workRendDt) {
		this.workRendDt = workRendDt;
	}



	public int getWorkProgress() {
		return workProgress;
	}



	public void setWorkProgress(int workProgress) {
		this.workProgress = workProgress;
	}



	public String getWorkState() {
		return workState;
	}



	public void setWorkState(String workState) {
		this.workState = workState;
	}



	public String getWorkPriority() {
		return workPriority;
	}



	public void setWorkPriority(String workPriority) {
		this.workPriority = workPriority;
	}



	public String getTopWorkId() {
		return topWorkId;
	}



	public void setTopWorkId(String topWorkId) {
		this.topWorkId = topWorkId;
	}



	public int getWorkLevel() {
		return workLevel;
	}



	public void setWorkLevel(int workLevel) {
		this.workLevel = workLevel;
	}



	public Date getWorkWrtDt() {
		return workWrtDt;
	}



	public void setWorkWrtDt(Date workWrtDt) {
		this.workWrtDt = workWrtDt;
	}



	public Date getWorkMdfyDt() {
		return workMdfyDt;
	}



	public void setWorkMdfyDt(Date workMdfyDt) {
		this.workMdfyDt = workMdfyDt;
	}



	public Date getWorkDelDt() {
		return workDelDt;
	}



	public void setWorkDelDt(Date workDelDt) {
		this.workDelDt = workDelDt;
	}



	public String getWorkTitle() {
		return workTitle;
	}



	public void setWorkTitle(String workTitle) {
		this.workTitle = workTitle;
	}



	public String getWorkCntnt() {
		return workCntnt;
	}



	public void setWorkCntnt(String workCntnt) {
		this.workCntnt = workCntnt;
	}



	public List<WorkMngrVO> getWorkMngr() {
		return workMngr;
	}



	public void setWorkMngr(List<WorkMngrVO> workMngr) {
		this.workMngr = workMngr;
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

	

	public List<String> getWorkMngrId() {
		return workMngrId;
	}


	public void setWorkMngrId(List<String> workMngrId) {
		this.workMngrId = workMngrId;
	}


	@Override
	public String toString() {
		return "ProjWorkVO [workId=" + workId + ", projId=" + projId + ", workRqstr=" + workRqstr + ", workRqstrNm="
				+ workRqstrNm + ", workRqstrPhoto=" + workRqstrPhoto + ", workStrtDt=" + workStrtDt + ", workEndDt="
				+ workEndDt + ", workRendDt=" + workRendDt + ", workProgress=" + workProgress + ", workState="
				+ workState + ", workPriority=" + workPriority + ", topWorkId=" + topWorkId + ", workLevel=" + workLevel
				+ ", workWrtDt=" + workWrtDt + ", workMdfyDt=" + workMdfyDt + ", workDelDt=" + workDelDt
				+ ", workTitle=" + workTitle + ", workCntnt=" + workCntnt + ", workMngr=" + workMngr + ", workMngrId="
				+ workMngrId + ", uploadFile=" + Arrays.toString(uploadFile) + ", attachVO=" + attachVO + "]";
	}



	
}
