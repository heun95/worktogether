package kr.or.workTogether.community.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.workTogether.common.vo.BoardReplyVO;
import kr.or.workTogether.common.vo.BoardVO;

@Mapper
public interface CommunityMapper {

		// 커뮤니티 리스트 및 페이징
		public List<BoardVO> list(Map<String, Object> map);
		
		// 커뮤니티 리스트 및 페이징 2
		public List<BoardVO> list2(Map<String, Object> map);

		// 커뮤니티 페이징, 커뮤니티 전체 글 갯수
		public int listCount(Map<String, Object> map);
		
		// 커뮤니티 페이징, 커뮤니티 전체 글 갯수 2
		public int listCount2(Map<String, Object> map);

		// 커뮤니티 등록1
		public int insert(BoardVO boardVO);
		
		// 커뮤니티 등록2
		public int insert2(BoardVO boardVO);

		//조회수 올리기1
		public int updateViewCnt(String brdId);
		
		//조회수 올리기2
		public int updateViewCnt2(String brdId);
		
		//커뮤니티 상세내용1
		public BoardVO detail(String brdId);
		
		//커뮤니티 상세내용2
		public BoardVO detail2(String brdId);
		
		//커뮤니티 수정1
		public int update(BoardVO boardVO);
		
		//커뮤니티 수정2
		public int update2(BoardVO boardVO);

		//커뮤니티 삭제1
		public int delete(String brdId);
		
		//커뮤니티 삭제2
		public int delete2(String brdId);
		
		// 댓글 리스트
		public List<BoardReplyVO> rlist(BoardReplyVO boardReplyVO);
		
		// 댓글 리스트2
		public List<BoardReplyVO> rlist2(BoardReplyVO boardReplyVO);

		//댓글 등록
		public int rinsert(BoardReplyVO boardReplyVO);
		
		//댓글 등록2
		public int rinsert2(BoardReplyVO boardReplyVO);
		
		//댓글 수정1
		public BoardReplyVO rdetail(String brdRplyId);
		
		//댓글 수정2
		public BoardReplyVO rdetail2(String brdRplyId);
		
		public int rupdate(BoardReplyVO boardReplyVO);
		
		public int rupdate2(BoardReplyVO boardReplyVO);

		//댓글 삭제1
		public int rdelete(String brdRplyId);

		//댓글 삭제2
		public int rdelete2(String brdRplyId);

		
		
		
		
		
}
