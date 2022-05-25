package kr.or.workTogether.notice.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.workTogether.common.vo.BoardVO;

@Mapper /* 자동으로 되는데 명시적 표현 */
public interface NoticeMapper {

	// 공지사항 리스트 및 페이징
	public List<BoardVO> list(Map<String, Object> map);

	// 공지사항 리스트 전체 갯수
	public int listCount(Map<String, Object> map);

	// 공지사항 상세내용
	public BoardVO detail(String brdId);

	// 공지사항 등록
	public int insert(BoardVO boardVO);

	// 공지사항 수정
	public int update(BoardVO boardVO);

	// 조회수 올리기
	public int updateViewCnt(String brdId);

	// 공지사항 삭제(숨기기)
	public int delete(String brdId);
	
}
