package kr.or.workTogether.mypage.service;

import java.util.HashMap;
import java.util.Map;

import kr.or.workTogether.common.vo.EmployeeVO;

public interface MypageService {
	//개인정보 조회하기
	public EmployeeVO selectEmpl(HashMap<String , Object> map);
	
	//개인정보 수정하기
	public int updateEmpl(Map<String , Object> map);
	
}
