package kr.or.workTogether.employee.service;

import java.util.List;

import kr.or.workTogether.common.vo.EmployeeVO;

public interface EmployeeService {
	//직원 목록(LIST)
	public List<EmployeeVO> list();
	
	//스프링 시큐리티 로그인(SELECT)
	public EmployeeVO read(String empName);
	
	//스프링 시큐리티  USER 뷰 생성 및 재정의
	public int replaceUserView();
	
}





