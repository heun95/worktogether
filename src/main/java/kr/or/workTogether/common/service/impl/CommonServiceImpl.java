package kr.or.workTogether.common.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.workTogether.common.mapper.CommonMapper;
import kr.or.workTogether.common.service.CommonService;
import kr.or.workTogether.common.vo.AtndnDlyVO;
import kr.or.workTogether.common.vo.DepartmentVO;

@Service
public class CommonServiceImpl implements CommonService{

	@Autowired
	private CommonMapper commonMapper;

	//조직도(직원없는 부서 제외) 조회
	@Override
	public List<DepartmentVO> getTreeList(String treeSelect) {
		return commonMapper.getTreeList(treeSelect);
	}

	@Override
	public AtndnDlyVO atndnDaily(String userId) {
		return commonMapper.atndnDaily(userId);
	}

	@Override
	public String successPass(String userId) {
		return commonMapper.successPass(userId);
	}
	
	
	
}
