package kr.or.workTogether.qna.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.workTogether.common.vo.BoardReplyVO;
import kr.or.workTogether.common.vo.BoardVO;

@Mapper /* 자동으로 되는데 명시적 표현 */
public interface QnaMapper {

	// QnA 리스트 및 페이징
	public List<BoardVO> list(Map<String, Object> map);

	// QnA 리스트 전체 갯수
	public int listCount(Map<String, Object> map);

	// QnA 상세내용
	public BoardVO detail(String brdId);

	// QnA 등록
	public int insert(BoardVO boardVO);

	// QnA 수정
	public int update(BoardVO boardVO);

	// 조회수 올리기
	public int updateViewCnt(String brdId);

	// 공지사항 삭제(숨기기)
	public int delete(String brdId);

	// 댓글 리스트
	public List<BoardReplyVO> rlist(BoardReplyVO boardReplyVO);

	// 댓글 등록
	public int rinsert(BoardReplyVO boardReplyVO);

	// 댓글 수정
	public BoardReplyVO rdetail(String brdRplyId);

	public int rupdate(BoardReplyVO boardReplyVO);

	// 댓글 삭제(숨기기)
	public int rdelete(String brdRplyId);

}
