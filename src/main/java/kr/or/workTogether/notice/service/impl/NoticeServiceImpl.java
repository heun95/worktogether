package kr.or.workTogether.notice.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.workTogether.common.vo.BoardVO;
import kr.or.workTogether.notice.mapper.NoticeMapper;
import kr.or.workTogether.notice.service.NoticeService;

@Service
public class NoticeServiceImpl implements NoticeService{

	@Autowired
	NoticeMapper noticeMapper;
	
	/*공지사항 목록 및 페이징*/
	@Override
	public List<BoardVO> list(Map<String, Object> map) {
		return noticeMapper.list(map);
	}

	/*공지사항 페이징 처리를 위한 목록갯수*/
	@Override
	public int listCount(Map<String, Object> map) {
		return this.noticeMapper.listCount(map);
	}

	@Override
	public BoardVO detail(String brdId) {
		return this.noticeMapper.detail(brdId);
	}

	@Override
	public int insert(BoardVO boardVO) {
		return this.noticeMapper.insert(boardVO);
	}

	@Override
	public int update(BoardVO boardVO) {
		return this.noticeMapper.update(boardVO);
	}

	@Override
	public int updateViewCnt(String brdId) {
		return this.noticeMapper.updateViewCnt(brdId);
	}

	@Override
	public int delete(String brdId) {
		return this.noticeMapper.delete(brdId);
	}

}
