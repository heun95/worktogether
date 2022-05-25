package kr.or.workTogether.project.service;

import java.util.List;
import java.util.Map;

import kr.or.workTogether.common.vo.AttachVO;
import kr.or.workTogether.common.vo.CalendarVO;
import kr.or.workTogether.common.vo.EmployeeVO;
import kr.or.workTogether.common.vo.GanttChartVO;
import kr.or.workTogether.common.vo.ProjMemVO;
import kr.or.workTogether.common.vo.ProjWorkReplyVO;
import kr.or.workTogether.common.vo.ProjWorkVO;
import kr.or.workTogether.common.vo.ProjectVO;

public interface ProjectService {
	
	// 프로젝트 리스트 가져오기
	public List<ProjectVO> projList(String empId);
	
	// 새프로젝트 추가하기 
	public int projInsert(ProjectVO projectVO);
	
	// 프로젝트 멤버 추가하기
	public int projMemInsert(Map<String, Object> map);
	
	// 프로젝트 이름 가져오기
	public String projName(String projId);
	
	// 프로젝트 디테일
	public ProjectVO projDetail(String projId);
	
	// 프로젝트 멤버 리스트
	public List<EmployeeVO> memberList(String string);
	
	// 업무 추가
	public int insertWork(ProjWorkVO projWorkVO) throws Exception;
	
	// 업무 카운트
	public int listCount(Map<String, Object> map);
	
	// 업무 리스트 가져오기
	public List<ProjWorkVO> workList(Map<String, Object> map);
	
	// 업무 디테일 가져오기
	public ProjWorkVO worktDetail(String workId);
	
	// 홈에 사용할 업무리스트 가져오기
	public List<ProjWorkVO> workHomeList(Map<String, Object> map);
	
	// 업무 수정
	public int updateWork(ProjWorkVO projWorkVO) throws Exception;
	
	// 업무 삭제
	public int deleteWork(String workId);
	
	// 업무 댓글 등록
	public int insertRpl(ProjWorkReplyVO projWorkReplyVO);
	
	// 업무 댓글 리스트
	public List<ProjWorkReplyVO> rplList(String workId);
	
	// 업무 댓글 삭제
	public int deleteRpl(int workReplyId);
	
	// 캘린더 데이터 가져오기
	public List<CalendarVO> calendarList(String projId);
	
	// 간트차트 데이터 가져오기
	public List<GanttChartVO> gantList(String projId);
	
	// 파일 리스트 가져오기
	public List<AttachVO> fileList(String projId);

	// 프로젝트 차트데이터 가져오기
	public Map<String, Object> projChart(String projId);

	// 프로젝트 일일 업무량 가져오기
	public List<Map<String, String>> workCountDate(Map<String, Object> map);
}
