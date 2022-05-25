package kr.or.workTogether.qna.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.workTogether.common.vo.BoardReplyVO;
import kr.or.workTogether.common.vo.BoardVO;
import kr.or.workTogether.qna.mapper.QnaMapper;
import kr.or.workTogether.qna.service.QnaService;

@Service
public class QnaServiceImpl implements QnaService{

	@Autowired
	QnaMapper qnaMapper;
	
	/*QnA 목록 및 페이징*/
	@Override
	public List<BoardVO> list(Map<String, Object> map) {
		return qnaMapper.list(map);
	}

	/*QnA 페이징 처리를 위한 목록갯수*/
	@Override
	public int listCount(Map<String, Object> map) {
		return this.qnaMapper.listCount(map);
	}

	@Override
	public BoardVO detail(String brdId) {
		return this.qnaMapper.detail(brdId);
	}

	@Override
	public int insert(BoardVO boardVO) {
		return this.qnaMapper.insert(boardVO);
	}

	@Override
	public int update(BoardVO boardVO) {
		return this.qnaMapper.update(boardVO);
	}

	@Override
	public int updateViewCnt(String brdId) {
		return this.qnaMapper.updateViewCnt(brdId);
	}

	@Override
	public int delete(String brdId) {
		return this.qnaMapper.delete(brdId);
	}

	@Override
	public List<BoardReplyVO> rlist(BoardReplyVO boardReplyVO) {
		return qnaMapper.rlist(boardReplyVO);
	}

	@Override
	public int rinsert(BoardReplyVO boardReplyVO) {
		return this.qnaMapper.rinsert(boardReplyVO);
	}

	@Override
	public int rupdate(BoardReplyVO boardReplyVO) {
		return this.qnaMapper.rupdate(boardReplyVO);
	}

	@Override
	public BoardReplyVO rdetail(String brdRplyId) {
		return this.qnaMapper.rdetail(brdRplyId);
	}

	@Override
	public int rdelete(String brdRplyId) {
		return this.qnaMapper.rdelete(brdRplyId);
	}

}
