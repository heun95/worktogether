package kr.or.workTogether.meeting.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.workTogether.common.vo.MeetingVO;

@Mapper
public interface MeetingMapper {

	//회의일정(진행중,예정,종료) 조회 : SELECT - LIST
	public List<MeetingVO> getConferenceList();

}
