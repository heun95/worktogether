package kr.or.workTogether.attendance.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.workTogether.attendance.mapper.AttendanceMapper;
import kr.or.workTogether.attendance.service.AttendanceService;
import kr.or.workTogether.common.vo.AtndnAplictVO;
import kr.or.workTogether.common.vo.AtndnDlyVO;

@Service
public class AttendanceServiceImpl implements AttendanceService {

	@Autowired
	AttendanceMapper attendanceMapper;
	
	@Override
	public List<AtndnDlyVO> state(HashMap<String, String> map) {
		return attendanceMapper.state(map);
	}

	@Override
	public int recordStart(AtndnDlyVO atndnDlyVO) {
		return attendanceMapper.recordStart(atndnDlyVO);
	}

	@Override
	public int getCountAtndnDly(String empId) {
		return attendanceMapper.getCountAtndnDly(empId);
	}

	@Override
	public int recordEnd(AtndnDlyVO atndnDlyVO) {
		return attendanceMapper.recordEnd(atndnDlyVO);
	}

	@Override
	public int getCountAtndnEndDt(String empId) {
		return attendanceMapper.getCountAtndnEndDt(empId);
	}

	@Override
	public AtndnDlyVO getAtndnDlyVO(AtndnDlyVO atndnDlyVO) {
		return attendanceMapper.getAtndnDlyVO(atndnDlyVO);
	}

	@Override
	public AtndnDlyVO dateSelectType(AtndnDlyVO atndnDlyVO) {
		return attendanceMapper.dateSelectType(atndnDlyVO);
	}

	@Override
	public int reasonUpdate(AtndnDlyVO atndnDlyVO) {
		return attendanceMapper.reasonUpdate(atndnDlyVO);
	}
	
	/**********************************************************/

	@Override
	public int apply(AtndnAplictVO atndnAplictVO) {
		return attendanceMapper.apply(atndnAplictVO);
	}
	
	@Override
	public List<AtndnAplictVO> applyList(HashMap<String, String> map) {
		return attendanceMapper.applyList(map);
	}
	
	@Override
	public int applyAccept(AtndnAplictVO atndnAplictVO) {
		return attendanceMapper.applyAccept(atndnAplictVO);
	}

	@Override
	public int applyDelete(AtndnAplictVO atndnAplictVO) {
		return attendanceMapper.applyDelete(atndnAplictVO);
	}
	
	@Override
	public List<AtndnAplictVO> getApplyList(AtndnAplictVO atndnAplictVO) {
		return attendanceMapper.getApplyList(atndnAplictVO);
	}
	
	@Override
	public String bringDeptName(String empId) {
		return attendanceMapper.bringDeptName(empId);
	}
	
	/**********************************************************/

	@Override
	public int useAnnual(AtndnAplictVO atndnAplictVO) {
		return attendanceMapper.useAnnual(atndnAplictVO);
	}

	
	
}
