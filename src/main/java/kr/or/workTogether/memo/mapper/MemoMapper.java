package kr.or.workTogether.memo.mapper;

import java.util.List;
import java.util.Map;

import kr.or.workTogether.common.vo.MemoVO;

public interface MemoMapper {

	//메모 작성하기
	public int writeMemo (MemoVO memoVO);

	//메모 조회하기
	public List<MemoVO> selectMemo(Map<String , Object>map);
	
	//메모 수정하기
	public int updateMemo(Map<String,Object>map);
	
	//메모 삭제하기
	public int deleteMemo(Map<String,Object>map);
}
