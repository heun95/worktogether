package kr.or.workTogether.mypage.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.workTogether.common.vo.EmployeeVO;
import kr.or.workTogether.mypage.mapper.MypageMapper;
import kr.or.workTogether.mypage.service.MypageService;

@Service
public class MypageServiceImpl implements MypageService {

	@Autowired
	MypageMapper mypageMapper;
	
	//개인정보 조회하기
	public EmployeeVO selectEmpl(HashMap<String , Object> map) {
		return this.mypageMapper.selectEmpl(map);
	}
	
	//개인정보 수정하기
	public int updateEmpl(Map<String , Object> map) {
		return this.mypageMapper.updateEmpl(map);
	}
	
}
