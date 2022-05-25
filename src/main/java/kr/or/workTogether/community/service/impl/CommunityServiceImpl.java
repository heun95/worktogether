package kr.or.workTogether.community.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.workTogether.common.vo.BoardReplyVO;
import kr.or.workTogether.common.vo.BoardVO;
import kr.or.workTogether.community.mapper.CommunityMapper;
import kr.or.workTogether.community.service.CommunityService;

@Service
public class CommunityServiceImpl implements CommunityService {

	@Autowired 
	CommunityMapper communityMapper;

	/*커뮤니티 목록 및 페이징*/
	@Override
	public List<BoardVO> list(Map<String, Object> map) {
		return communityMapper.list(map);
	}
	
	/*커뮤니티 목록 및 페이징2*/
	@Override
	public List<BoardVO> list2(Map<String, Object> map) {
		return communityMapper.list2(map);
	}

	/*커뮤니티 페이징 처리를 위한 목록갯수*/
	@Override
	public int listCount(Map<String, Object> map) {
		return communityMapper.listCount(map);
	}

	/*커뮤니티 페이징 처리를 위한 목록갯수2*/
	@Override
	public int listCount2(Map<String, Object> map) {
		return communityMapper.listCount2(map);
	}
	
	/*커뮤니티 등록1*/
	@Override
	public int insert(BoardVO boardVO) {
		return communityMapper.insert(boardVO);
	}

	/*커뮤니티 등록2*/
	@Override
	public int insert2(BoardVO boardVO) {
		return communityMapper.insert2(boardVO);
	}

	/*조회수 올리기1*/
	@Override
	public int updateViewCnt(String brdId) {
		return communityMapper.updateViewCnt(brdId);
	}

	/*조회수 올리기2*/
	@Override
	public int updateViewCnt2(String brdId) {
		return communityMapper.updateViewCnt2(brdId);
	}
	
	/*커뮤니티 디테일1*/
	@Override
	public BoardVO detail(String brdId) {
		return communityMapper.detail(brdId);
	}

	/*커뮤니티 디테일2*/
	@Override
	public BoardVO detail2(String brdId) {
		return communityMapper.detail2(brdId);
	}

	/*커뮤니티 수정*/
	@Override
	public int update(BoardVO boardVO) {
		return communityMapper.update(boardVO);
	}

	/*커뮤니티 수정2*/
	@Override
	public int update2(BoardVO boardVO) {
		return communityMapper.update2(boardVO);
	}
	
	/*커뮤니티 삭제*/
	@Override
	public int delete(String brdId) {
		return communityMapper.delete(brdId);	
	}
	
	/*커뮤니티 삭제2*/
	@Override
	public int delete2(String brdId) {
		return communityMapper.delete2(brdId);
	}
	
	/* 댓글 리스트 */
	@Override
	public List<BoardReplyVO> rlist(BoardReplyVO boardReplyVO) {
		return communityMapper.rlist(boardReplyVO);
	}
	
	/* 댓글 리스트 */
	@Override
	public List<BoardReplyVO> rlist2(BoardReplyVO boardReplyVO) {
		return communityMapper.rlist2(boardReplyVO);
	}

	/* 댓글 등록1 */
	public int rinsert(BoardReplyVO boardReplyVO) {
		return communityMapper.rinsert(boardReplyVO);
	}

	/* 댓글 등록2 */
	@Override
	public int rinsert2(BoardReplyVO boardReplyVO) {
		return communityMapper.rinsert2(boardReplyVO);
	}
	
	/* 댓글 수정1 */
	@Override
	public int rupdate(BoardReplyVO boardReplyVO) {
		return communityMapper.rupdate(boardReplyVO);
	}
	
	/* 댓글 수정2 */
	@Override
	public int rupdate2(BoardReplyVO boardReplyVO) {
		return communityMapper.rupdate2(boardReplyVO);
	}
	
	@Override
	public BoardReplyVO rdetail(String brdRplyId) {
		return communityMapper.rdetail(brdRplyId);
	}
	
	@Override
	public BoardReplyVO rdetail2(String brdRplyId) {
		return communityMapper.rdetail2(brdRplyId);
	}
	
	/* 댓글 삭제 */
	@Override
	public int rdelete(String brdRplyId) {
		return communityMapper.rdelete(brdRplyId);
	}

	/* 댓글 삭제 */
	@Override
	public int rdelete2(String brdRplyId) {
		return communityMapper.rdelete2(brdRplyId);
	}

	

}
