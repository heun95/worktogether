package kr.or.workTogether.memo.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.workTogether.common.vo.MemoVO;
import kr.or.workTogether.memo.mapper.MemoMapper;
import kr.or.workTogether.memo.service.MemoService;


@Service
public class MemoServiceImpl implements MemoService {

	@Autowired
	MemoMapper memoMapper;
	
	//메모 작성하기
	public int writeMemo (MemoVO memoVO) {
		return this.memoMapper.writeMemo(memoVO);
	}
	//메모 조회하기
	public List<MemoVO> selectMemo(Map<String , Object>map){
		return this.memoMapper.selectMemo(map);
	}
	
	//메모 수정하기
	public int updateMemo(Map<String,Object>map) {
		return this.memoMapper.updateMemo(map);
	}
	
	//메모 삭제하기
	public int deleteMemo(Map<String,Object>map ) {
		return this.memoMapper.deleteMemo(map);
	}
}
