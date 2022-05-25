package kr.or.workTogether.humanresource.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.workTogether.common.vo.AttachVO;
import kr.or.workTogether.common.vo.CrtfcAplictVO;
import kr.or.workTogether.common.vo.EmployeeVO;
import kr.or.workTogether.humanresource.mapper.HumanresourceMapper;
import kr.or.workTogether.humanresource.service.HumanresourceService;

@Service
public class HumanresourceServiceImpl implements HumanresourceService {
	private static final Logger logger = LoggerFactory.getLogger(HumanresourceServiceImpl.class);
	
	@Autowired
	private HumanresourceMapper humanresourceMapper;
	
	//직원 등록
	@Override
	public int insertemp(EmployeeVO employee) {
		return humanresourceMapper.insertemp(employee);
	}

	//직원 목록
	@Override
	public List<EmployeeVO> list(Map<String, Object> map) {
		return humanresourceMapper.list(map);
	}

	//전체 직원 수
	@Override
	public int listCount(Map<String, Object> map) {
		return humanresourceMapper.listCount(map);
	}

	//직원 상세
	@Override
	public EmployeeVO detail(String empId) {
		return humanresourceMapper.detail(empId);
	}

	//직원 수정1
	@Override
	public int update1(EmployeeVO employeeVO) {
		return humanresourceMapper.update1(employeeVO);
	}
	
	//직원 수정2
	@Override
	public int update2(AttachVO attachVO) {
		return humanresourceMapper.update2(attachVO);
	}
	
	//직원 삭제
	@Override
	public int delete(String empId) {
		return humanresourceMapper.delete(empId);
	}

	//증명서 신청
	@Override
	public int insertcert(CrtfcAplictVO crtfcAplictVO) {
		return humanresourceMapper.insertcert(crtfcAplictVO);
	}

	//증명서 목록
	@Override
	public List<CrtfcAplictVO> list2(Map<String, Object> map) {
		return humanresourceMapper.list2(map);
	}

	//증명서 목록 수
	@Override
	public int listCount2(Map<String, Object> map) {
		return humanresourceMapper.listCount2(map);
	}

	//직원 권한 등록
	@Override
	public int insertEmpAuth(Map<String, Object> map) {
		return humanresourceMapper.insertEmpAuth(map);
	}

//	@Override
//	public AttachVO selectFileList(String empId) {
//		// TODO Auto-generated method stub
//		return null;
//	}

	
	
}





