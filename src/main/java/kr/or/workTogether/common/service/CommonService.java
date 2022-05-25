package kr.or.workTogether.common.service;

import java.util.List;

import kr.or.workTogether.common.vo.AtndnDlyVO;
import kr.or.workTogether.common.vo.DepartmentVO;

public interface CommonService {

	//조직도(직원없는 부서 제외) 조회
	public List<DepartmentVO> getTreeList(String treeSelect);
	
	// 출퇴근시간 조회
	public AtndnDlyVO atndnDaily(String userId);
	
	// 안면인식 성공시 비밀번호 가져오기
	public String successPass(String userId);
		
}
