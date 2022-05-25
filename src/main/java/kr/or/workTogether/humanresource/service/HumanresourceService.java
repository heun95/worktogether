package kr.or.workTogether.humanresource.service;

import java.util.List;
import java.util.Map;

import kr.or.workTogether.common.vo.AttachVO;
import kr.or.workTogether.common.vo.CrtfcAplictVO;
import kr.or.workTogether.common.vo.EmployeeVO;

public interface HumanresourceService {
	//직원 목록
	public List<EmployeeVO> list(Map<String, Object> map);

	//전체 직원 수
	public int listCount(Map<String, Object> map);
	
	//직원 등록
	public int insertemp(EmployeeVO employee);
	
	//상세 보기
	public EmployeeVO detail(String empId);

	//수정하기1
	public int update1(EmployeeVO employeeVO);

	//수정하기2
	public int update2(AttachVO attachVO);
	
	//삭제하기
	public int delete(String empId);

	//증명서 신청
	public int insertcert(CrtfcAplictVO crtfcAplictVO);
	
	//증명서 목록
	public List<CrtfcAplictVO> list2(Map<String, Object> map);
	
	//증명서 목록 수 
	public int listCount2(Map<String, Object> map);

	//
	//public AttachVO selectFileList(String empId);
	
	//직원 권한 등록
	public int insertEmpAuth(Map<String, Object> map);

}





