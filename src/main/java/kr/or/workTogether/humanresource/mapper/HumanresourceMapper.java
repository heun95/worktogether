package kr.or.workTogether.humanresource.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.workTogether.common.vo.AttachVO;
import kr.or.workTogether.common.vo.CrtfcAplictVO;
import kr.or.workTogether.common.vo.EmployeeVO;

@Mapper /* 자동으로 되는데 명시적 표현 */
public interface HumanresourceMapper {
	//직원 목록
	public List<EmployeeVO> list(Map<String, Object> map);

	//전체 직원 수
	public int listCount(Map<String, Object> map);

	//직원 등록
	public int insertemp(EmployeeVO employee);
	
	//상세보기
	public EmployeeVO detail(String empId);

	//수정하기1
	public int update1(EmployeeVO employeeVO);
	
	//수정하기2
	public int update2(AttachVO attachVO);
	
	//삭제하기
	public int delete(String employeeID);
	
	//증명서 신청
	public int insertcert(CrtfcAplictVO crtfcAplictVO);
	
	//증명서 목록(자신만)
	public List<CrtfcAplictVO> list2(Map<String, Object> map);
	
	//증명서 목록 수
	public int listCount2(Map<String, Object> map);

	//직원 권한 등록
	public int insertEmpAuth(Map<String, Object> map);

}
