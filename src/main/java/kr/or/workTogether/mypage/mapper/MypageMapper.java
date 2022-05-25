package kr.or.workTogether.mypage.mapper;

import java.util.Map;

import kr.or.workTogether.common.vo.EmployeeVO;

public interface MypageMapper {

	//개인정보 조회하기
	public EmployeeVO selectEmpl(Map<String, Object> map);
	
	//개인정보 수정하기
	public int updateEmpl(Map<String , Object> map);
	
}



