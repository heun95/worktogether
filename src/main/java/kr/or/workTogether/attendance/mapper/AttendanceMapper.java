package kr.or.workTogether.attendance.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.workTogether.common.vo.AtndnAplictVO;
import kr.or.workTogether.common.vo.AtndnDlyVO;

@Mapper
public interface AttendanceMapper {

	// 근태현황
	public List<AtndnDlyVO> state(HashMap<String, String> map);

	// 출근기록
	public int recordStart(AtndnDlyVO atndnDlyVO);

	// 출근중복방지
	public int getCountAtndnDly(String empId);

	// 퇴근 기록
	public int recordEnd(AtndnDlyVO atndnDlyVO);

	// 퇴근 처리 알림
	public int getCountAtndnEndDt(String empId);

	// 오늘 출근정보
	public AtndnDlyVO getAtndnDlyVO(AtndnDlyVO atndnDlyVO);

	// 해당 날짜에 대한 DB정보 가져오기
	public AtndnDlyVO dateSelectType(AtndnDlyVO atndnDlyVO);

	// 사유 입력 업데이트
	public int reasonUpdate(AtndnDlyVO atndnDlyVO);

	/**********************************************************/
	
	// 근태신청
	public int apply(AtndnAplictVO atndnAplictVO);

	// 근태신청리스트 - ajax
	public List<AtndnAplictVO> applyList(HashMap<String, String> map);

	// 근태신청 승인
	public int applyAccept(AtndnAplictVO atndnAplictVO);
	
	// 근태신청 삭제
	public int applyDelete(AtndnAplictVO atndnAplictVO);
	
	// 근태신청 목록
	public List<AtndnAplictVO> getApplyList(AtndnAplictVO atndnAplictVO);
	
	// 사원 부서명 가져오기
	public String bringDeptName(String empId);
	
	/**********************************************************/
	
	//연차 사용내역
	public int useAnnual(AtndnAplictVO atndnAplictVO);
}
