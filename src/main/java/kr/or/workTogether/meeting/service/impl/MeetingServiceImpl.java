package kr.or.workTogether.meeting.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.workTogether.common.vo.MeetingVO;
import kr.or.workTogether.meeting.mapper.MeetingMapper;
import kr.or.workTogether.meeting.service.MeetingService;

@Service
public class MeetingServiceImpl implements MeetingService{

	@Autowired
	private MeetingMapper meetingMapper;
	
	@Override
	public List<MeetingVO> getConferenceList() {
		return meetingMapper.getConferenceList();
	}

}
