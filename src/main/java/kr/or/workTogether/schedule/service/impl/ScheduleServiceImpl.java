package kr.or.workTogether.schedule.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.workTogether.common.vo.CalendarVO;
import kr.or.workTogether.common.vo.ScheduleVO;
import kr.or.workTogether.schedule.mapper.ScheduleMapper;
import kr.or.workTogether.schedule.service.ScheduleService;

@Service
public class ScheduleServiceImpl implements ScheduleService{

	@Autowired
	ScheduleMapper scheduleMapper;

	@Override
	public List<ScheduleVO> getScheduleList(Map<String, Object> map) {
		return scheduleMapper.getScheduleList(map);
	}

	@Override
	public ScheduleVO getSchedule(String schdlId) {
		return scheduleMapper.getSchedule(schdlId);
	}

	@Override
	public int insertSchedule(ScheduleVO scheduleVO) {
		return scheduleMapper.insertSchedule(scheduleVO);
	}

	@Override
	public int updateSchedule(ScheduleVO scheduleVO) {
		return scheduleMapper.updateSchedule(scheduleVO);
	}

	@Override
	public int deleteSchedule(String schdlId) {
		return scheduleMapper.deleteSchedule(schdlId);
	}

	
	
	
	
	
	
	
	
	/*
		//민정
		@Override
		public List<CalendarVO> calendar(String schdlId) {
			return scheduleMapper.calendar(schdlId);
		}
	*/
}
