package kr.or.workTogether.meeting.service;

import java.util.List;

import kr.or.workTogether.common.vo.MeetingVO;

public interface MeetingService {

	//회의일정(진행중,예정,종료) 조회 : SELECT - LIST
	public List<MeetingVO> getConferenceList();
	
}
