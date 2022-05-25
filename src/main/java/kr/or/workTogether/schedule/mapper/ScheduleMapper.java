package kr.or.workTogether.schedule.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.workTogether.common.vo.ScheduleVO;

@Mapper
public interface ScheduleMapper {

	//일정 리스트(전체,일반,중요)
	public List<ScheduleVO> getScheduleList(Map<String,Object> map);
	
	//일정 상세 
	public ScheduleVO getSchedule(String schdlId);
	
	//일정 등록 
	public int insertSchedule(ScheduleVO scheduleVO);
	
	//일정 수정
	public int updateSchedule(ScheduleVO scheduleVO);
	
	//일정 삭제 
	public int deleteSchedule(String schdlId);
	
	
	
	
	
	
	
	
	
	/*
		//민정
		//일정보이기
		public List<CalendarVO> calendar(String schdlId);
	*/
}
