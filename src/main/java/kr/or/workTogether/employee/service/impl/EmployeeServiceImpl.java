package kr.or.workTogether.employee.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.workTogether.common.vo.EmployeeVO;
import kr.or.workTogether.employee.mapper.EmployeeMapper;
import kr.or.workTogether.employee.service.EmployeeService;

@Service
public class EmployeeServiceImpl implements EmployeeService {
	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	//직원목록(LIST)
	@Override
	public List<EmployeeVO> list() {
		return employeeMapper.list();
	}

	//스프링 시큐리티 로그인(SELECT)
	@Override
	public EmployeeVO read(String empName) {
		return employeeMapper.read(empName);
	}
	
	//스프링 시큐리티  USER 뷰 생성 및 재정의
	@Override
	public int replaceUserView() {
		return employeeMapper.replaceUserView();
	}
	
	
}





