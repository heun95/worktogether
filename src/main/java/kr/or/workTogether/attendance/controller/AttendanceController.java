package kr.or.workTogether.attendance.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.workTogether.attendance.service.AttendanceService;
import kr.or.workTogether.common.vo.AtndnAplictVO;
import kr.or.workTogether.common.vo.AtndnDlyVO;
import kr.or.workTogether.common.vo.BoardReplyVO;
import kr.or.workTogether.common.vo.DepartmentVO;
import kr.or.workTogether.common.vo.EmployeeVO;
import kr.or.workTogether.common.vo.NotificationVO;
import kr.or.workTogether.notification.service.NotificationService;
import kr.or.workTogether.security.CustomUser;

@RequestMapping("/attendance")
@Controller
public class AttendanceController {

	@Autowired
	AttendanceService attendanceService;
	@Autowired
	private NotificationService notiService;

	public static final Logger logger = LoggerFactory.getLogger(AttendanceController.class);

	@RequestMapping(value = "/recordMain")
	public String recordMain() {
		return "attendance/recordMain";
	}

	@ResponseBody
	// @GetMapping("/start")
	@RequestMapping(value = "/recordStart", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
//	public String start(@RequestParam("sdate") String sdate, @RequestParam("stime") String stime) {
	// 이름을 변경하거나 데이터 타입을 변경할 때 @RequestParam 을 사용하면 된다.
	public Map<String, String> start(@RequestParam String sdate, AtndnDlyVO atndnDlyVO, Authentication auth,
			Model model, HttpServletResponse response) throws ParseException {

		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();

		// 포맷터
		SimpleDateFormat simpleFormat = new SimpleDateFormat("yyyy-MM-dd-hh:mm:ss");
		Date date = simpleFormat.parse(sdate);
//		Date time = formatter.parse(stime);

		LocalTime now = LocalTime.now();

		if (now.getHour() >= 9 && now.getMinute() >= 0 && now.getSecond() > 0) {
			atndnDlyVO.setAtndnTypeId("late");
		} else {
			atndnDlyVO.setAtndnTypeId("attendance");
		}

		String noticeMsg = null;

		atndnDlyVO.setEmpId(userInfo.getUsername());
		atndnDlyVO.setAtndnDlyDt(date);
		atndnDlyVO.setAtndnStrtDt(date);

		int result = attendanceService.getCountAtndnDly(userInfo.getUsername());
		Map<String, String> retInfo = new HashMap<String, String>();

		if (result > 0) {
			retInfo.put("noticeMsg", "이미출근처리 되었습니다.");
		} else {
			attendanceService.recordStart(atndnDlyVO);
			retInfo.put("noticeMsg", "출근 처리 되었습니다.");
		}
		retInfo.put("atndCode", atndnDlyVO.getAtndnDlyId());
		return retInfo;
	}

	@ResponseBody
	@RequestMapping(value = "/recordEnd", method = RequestMethod.GET, produces = "application/text; charset=UTF-8")
	public String end(Authentication auth, @RequestParam String sdate, AtndnDlyVO atndnDlyVO, Model model,
			HttpServletResponse response, String atndnDlyId) throws ParseException {
		// System.err.println("!! : "+atndnDlyVO);
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		atndnDlyVO.setEmpId(userInfo.getUsername());

		SimpleDateFormat simpleFormat = new SimpleDateFormat("yyyy-MM-dd-hh:mm:ss");
		Date date = simpleFormat.parse(sdate);
		LocalTime now = LocalTime.now();

		AtndnDlyVO list = attendanceService.getAtndnDlyVO(atndnDlyVO);
		list.setAtndnEndDt(date);

		System.out.println("!@!@확인전:" + list);
		if (now.getHour() < 18 && now.getMinute() <= 59 && now.getSecond() <= 59) {
			list.setAtndnTypeId("earlyLeave");
		} else if (!list.getAtndnTypeId().equals("late")) {
			list.setAtndnTypeId("leave");
		}

		String noticeMsg = null;
		int result = attendanceService.getCountAtndnEndDt(userInfo.getUsername());

		if (result == 0) {
			attendanceService.recordEnd(list);
			noticeMsg = "퇴근 처리 되었습니다.";
		}
		return noticeMsg;
	}

	@RequestMapping(value = "/state", method = RequestMethod.GET)
	public String state(Model model, AtndnDlyVO atndnDlyVO, EmployeeVO employeeVO, Authentication auth,
			HashMap<String, String> map, Date atndnDlyDt, String atndnDlyId, Date atndnStrtDt, Date atndnEndDt,
			String atndnTypeId, String atndnDlyRsn, String empName) {

		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		String empId = userInfo.getUsername();

		atndnDlyVO.setEmpId(empId);
		AtndnDlyVO list = attendanceService.getAtndnDlyVO(atndnDlyVO);

		String empName1 = userInfo.getEmpName();
		employeeVO.setEmpName(empName1);

		model.addAttribute("atndnDlyVO", list);

		return "attendance/state";
	}

	@PostMapping("/state")
	public String statePost(Model model, @ModelAttribute AtndnDlyVO atndnDlyVO, Authentication auth)
			throws ParseException {

		attendanceService.reasonUpdate(atndnDlyVO);
		return "attendance/state";
	}

	@ResponseBody
	@PostMapping("/state_modal_ajax")
	public AtndnDlyVO stateModalPost(@RequestParam(required = false) String atndnDlyDt, Model model, // AtndnDlyVO
																										// atndnDlyVO,
			Authentication auth, String atndnTypeId) throws ParseException {
		AtndnDlyVO atndnDlyVO = new AtndnDlyVO();

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		// 문자열 -> Date
		Date date = formatter.parse(atndnDlyDt + " 00:00:00");

		atndnDlyVO.setAtndnDlyDt(date);

		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		String empId = userInfo.getUsername();

		atndnDlyVO.setEmpId(empId);

		AtndnDlyVO returnAtndnDlyVO = attendanceService.dateSelectType(atndnDlyVO);

		return returnAtndnDlyVO;
	}

	@ResponseBody
	@PostMapping("/state_ajax")
	public List<AtndnDlyVO> statePost(

			Model model, Authentication auth, @RequestParam(required = false) String year,
			@RequestParam(required = false) String month, AtndnDlyVO atndnDlyVO, String atndnTypeId

	) {
		HashMap<String, String> map = new HashMap<>();
		month = (Integer.parseInt(month) + 1) + "";

		if (Integer.parseInt(month) < 10) {
			month = "0" + (Integer.parseInt(month));
		}

		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		String empId = userInfo.getUsername();

		map.put("empId", userInfo.getUsername());
		map.put("startDate", year + "-" + month + "-01 00:00:00");

		if (Integer.parseInt(month) == 12) {
			year = (Integer.parseInt(year) + 1) + "";
			month = "01";
		} else {
			if (Integer.parseInt(month) < 10) {
				month = "0" + (Integer.parseInt(month) + 1);
			} else {
				month = (Integer.parseInt(month) + 1) + "";
			}
		}

		map.put("endDate", year + "-" + month + "-01 00:00:00");

		atndnDlyVO.setEmpId(empId);

		List<AtndnDlyVO> list = attendanceService.state(map);
		return list;
	}

	@RequestMapping(value = "/stateMem", method = RequestMethod.GET)
	public String stateMem(Model model, AtndnDlyVO atndnDlyVO, EmployeeVO employeeVO, Authentication auth,
			HashMap<String, String> map, Date atndnDlyDt, String atndnDlyId, Date atndnStrtDt, Date atndnEndDt,
			String atndnTypeId, String atndnDlyRsn, String empName, @RequestParam(required = false) String selectEmpId,
			@RequestParam(required = false) String selectEmpName) {

		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		String empId = userInfo.getUsername();

		System.err.println("1 : " + atndnDlyVO);
		// 조직도 접근
		if (selectEmpId == null) {
			atndnDlyVO.setEmpId(empId);
		} else {
			atndnDlyVO.setEmpId(selectEmpId);
		}

		System.err.println("2 : " + atndnDlyVO);

		AtndnDlyVO list = attendanceService.getAtndnDlyVO(atndnDlyVO);
		model.addAttribute("atndnDlyVO", list);
		System.err.println("3 : " + list);

		String empName1 = userInfo.getEmpName();
		employeeVO.setEmpName(empName1);
		System.err.println("4 : " + employeeVO);

		model.addAttribute("selectEmpName", selectEmpName);
		model.addAttribute("selectEmpId", selectEmpId);
		System.err.println("5 : " + model);

		return "attendance/stateMem";
	}

	@ResponseBody
	@PostMapping("/stateMem_ajax")
	public List<AtndnDlyVO> stateMemPost(@RequestParam(required = false) String year, Model model,
			AtndnDlyVO atndnDlyVO, @RequestParam(required = false) String month, Authentication auth,
			String atndnTypeId, @RequestParam(required = false) String selectEmpId) {
		HashMap<String, String> map = new HashMap<>();
		month = (Integer.parseInt(month) + 1) + "";

		if (Integer.parseInt(month) < 10) {
			month = "0" + (Integer.parseInt(month));
		}

		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		String empId = userInfo.getUsername();

		// 조직도 접근
		if (selectEmpId == "") {
			map.put("empId", userInfo.getUsername());
		} else {
			map.put("empId", selectEmpId);
		}

		map.put("startDate", year + "-" + month + "-01 00:00:00");

		if (Integer.parseInt(month) == 12) {
			year = (Integer.parseInt(year) + 1) + "";
			month = "01";
		} else {
			if (Integer.parseInt(month) < 10) {
				month = "0" + (Integer.parseInt(month) + 1);
			} else {
				month = (Integer.parseInt(month) + 1) + "";
			}
		}

		map.put("endDate", year + "-" + month + "-01 00:00:00");

		atndnDlyVO.setEmpId(empId);
		List<AtndnDlyVO> list = attendanceService.state(map);
		return list;
	}

	@RequestMapping(value = "/apply", method = RequestMethod.GET)
	public String apply(Model model, AtndnAplictVO atndnAplictVO, EmployeeVO employeeVO, Authentication auth,
			Date atndnDlyDt, String atndnDlyId, Date atndnStrtDt, Date atndnEndDt, String atndnTypeId,
			String atndnAplctRsn, String empName, @RequestParam(required = false) String deleteId) {

		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		logger.info("사용자정보 : " + userInfo);

		String empId = userInfo.getUsername();
		String deptName = userInfo.getDeptName();

		model.addAttribute("deptName", deptName);

		atndnAplictVO.setAtndnAplctRqstr(empId);
		// System.err.println("1 ; " + atndnAplictVO);

		// 신청내역 리스트
		List<AtndnAplictVO> list = attendanceService.getApplyList(atndnAplictVO);
		model.addAttribute("list", list);
		// System.err.println("2 ; " + list);

		String empName1 = userInfo.getEmpName();
		employeeVO.setEmpName(empName1);
		// System.err.println("3 ; " + employeeVO);

		model.addAttribute("atndnAplictVO", atndnAplictVO);
		// System.err.println("4 ; " + model);

		// 근태 신청내역 삭제
		if (deleteId != null) {
			AtndnAplictVO deleteVO = new AtndnAplictVO();
			deleteVO.setAtndnAplctId(deleteId);
			int result = attendanceService.applyDelete(deleteVO);
		}

		// 연차사용내역
//		attendanceService.useAnnual(atndnAplictVO);
//		System.err.println(atndnAplictVO);

		return "attendance/apply";
	}

	@PostMapping("/apply")
	public String applyPost(Model model, @ModelAttribute AtndnAplictVO atndnAplictVO, Authentication auth)
			throws ParseException {
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		String empId = userInfo.getUsername();
		
		atndnAplictVO.setAtndnAplctRqstr(empId);
		attendanceService.apply(atndnAplictVO);
		
		NotificationVO notiVO = new NotificationVO();

		notiVO.setNotSender(atndnAplictVO.getAtndnAplctRqstr()); // 보내는사람ID
		notiVO.setNotReceiver("EMPL00001"); // 받는사람ID
		notiVO.setNotTypeId("근태신청"); // 알림종류 - 'xx 알림이 도착했습니다.' 에서 xx를 의미
		notiVO.setNotCntntId(atndnAplictVO.getAtndnAplctId()); // 알림해당글PK
		notiVO.setNotMsg("근태신청합니다. 확인해주세요."); // 알림내용

		// 알림글URL - 알림글 URL은 detail 들어갈때의 URL을 적어줄것
		// 예시) /autho/receiveDocDetail?docId=ATDO00001&atrzAprvId=EMPL00001
		
//		String notUrl = "/attendance/applyMem?selectEmpId=" + selectEmpId +"&selectEmpName=" + selectEmpName;
		
		String notUrl = "/attendance/applyMem";
		logger.info("notUrl : " + notUrl);
		notiVO.setNotUrl(notUrl);

		notiService.insertNoti(notiVO);		

		return "redirect:/attendance/apply";
	}

	@ResponseBody
	@PostMapping("/apply_ajax")
	public List<AtndnAplictVO> applyPost(

			Model model, Authentication auth, @RequestParam(required = false) String year,
			@RequestParam(required = false) String month, AtndnAplictVO atndnAplictVO, String atndnTypeId,
			HashMap<String, String> AtndnAplictVO

	) {
		HashMap<String, String> map = new HashMap<>();
		month = (Integer.parseInt(month) + 1) + "";

		if (Integer.parseInt(month) < 10) {
			month = "0" + (Integer.parseInt(month));
		}

		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		String empId = userInfo.getUsername();

		map.put("empId", userInfo.getUsername());
		map.put("startDate", year + "-" + month + "-01 00:00:00");

		if (Integer.parseInt(month) == 12) {
			year = (Integer.parseInt(year) + 1) + "";
			month = "01";
		} else {
			if (Integer.parseInt(month) < 10) {
				month = "0" + (Integer.parseInt(month) + 1);
			} else {
				month = (Integer.parseInt(month) + 1) + "";
			}
		}

		map.put("endDate", year + "-" + month + "-01 00:00:00");

		atndnAplictVO.setAtndnAplctRqstr(empId);

		List<AtndnAplictVO> list = attendanceService.applyList(map);

		return list;
	}

	@RequestMapping(value = "/applyMem", method = RequestMethod.GET)
	public String applyMem(Model model, AtndnAplictVO atndnAplictVO, AtndnDlyVO atndnDlyVO, EmployeeVO employeeVO,
			Authentication auth, Date atndnDlyDt, String atndnDlyId, Date atndnStrtDt, Date atndnEndDt,
			String atndnTypeId, String atndnAplctRsn, String empName, HashMap<String, String> AtndnAplictVO,
			@RequestParam(required = false) String deleteId, @RequestParam(required = false) String acceptId,
			@RequestParam(required = false) String state, @RequestParam(required = false) String selectEmpId,
			@RequestParam(required = false) String selectEmpName, @RequestParam(required = false) String selectEmpId2,
			@RequestParam(required = false) String selectEmpName2,HttpServletResponse response, DepartmentVO departmentVO

	) throws UnsupportedEncodingException {
		response.setContentType("application/text;charset=UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setHeader("Content-Type", "text/html;charset=utf-8");

		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		String empId = userInfo.getUsername();
		String deptName = userInfo.getDeptName();

		model.addAttribute("deptName", deptName);
		atndnDlyVO.setEmpId(empId);

		// System.err.println("1 : " + atndnAplictVO);
		// 조직도 접근
		if (selectEmpId == null) {
			atndnAplictVO.setAtndnAplctRqstr(empId);
		} else {
			atndnAplictVO.setAtndnAplctRqstr(selectEmpId);
		}
		System.err.println("2: " + atndnAplictVO);

		model.addAttribute("selectEmpName", selectEmpName);
		model.addAttribute("selectEmpId", selectEmpId);
		

		// 근태신청내역 리스트
		List<AtndnAplictVO> list = attendanceService.getApplyList(atndnAplictVO);
		model.addAttribute("list", list);
		System.err.println("list : " + list);
		
		// 사원 부서명 가져오기*
//		String selectDeptName = attendanceService.bringDeptName(empId);
		String selectDeptName = attendanceService.bringDeptName(list.get(0).getAtndnAplctRqstr());
		System.err.println("selectDeptName : " + selectDeptName);
		model.addAttribute("selectDeptName", selectDeptName);
		// System.err.println("5: " + model);

		String empName1 = userInfo.getEmpName();
		employeeVO.setEmpName(empName1);
		// System.err.println("4: " + employeeVO);

		System.out.println("===============\\\\\\==");
		System.err.println(deleteId);
		System.out.println("====================");
		
		
		
		String temp_selectEmpName = null;
		// 근태 신청내역 승인취소
		if (deleteId != null) {
			AtndnAplictVO deleteVO = new AtndnAplictVO();
			deleteVO.setAtndnAplctId(deleteId);
			int result = attendanceService.applyDelete(deleteVO);
			// System.err.println("!!중호:"+selectEmpName2);
			temp_selectEmpName = URLEncoder.encode(selectEmpName2, "UTF-8");
			return "redirect:/attendance/applyMem?selectEmpId=" + selectEmpId2 + "&selectEmpName=" + temp_selectEmpName;
		}

		System.out.println("=====================");
		System.err.println(acceptId);
		System.out.println("=====================");
		
		// 근태 신청내역 승인
		if (acceptId != null && state.equals("승인대기중")) {
			 System.err.println(acceptId);
			AtndnAplictVO acceptVO = new AtndnAplictVO();
			acceptVO.setAtndnAplctId(acceptId);
			acceptVO.setAtndnAplctState(state);
			int result = attendanceService.applyAccept(acceptVO);
			// System.err.println("selectEmpName2 : "+selectEmpName2);
			temp_selectEmpName = URLEncoder.encode(selectEmpName2, "UTF-8");
			// System.err.println("2:"+temp_selectEmpName+"/3:"+selectEmpId2);
			return "redirect:/attendance/applyMem?selectEmpId=" + selectEmpId2 + "&selectEmpName=" + temp_selectEmpName;
		}
		if (acceptId != null && state.equals("승인완료")) {
			temp_selectEmpName = URLEncoder.encode(selectEmpName2, "UTF-8");
			return "redirect:/attendance/applyMem?selectEmpId=" + selectEmpId2 + "&selectEmpName=" + temp_selectEmpName;
		}

		// System.err.println(atndnAplictVO);

		return "attendance/applyMem";
	}

	@ResponseBody
	@PostMapping("/applyMem_ajax")
	public List<AtndnAplictVO> applyMemPost(@RequestParam(required = false) String year, Model model,
			AtndnAplictVO atndnAplictVO, @RequestParam(required = false) String month, Authentication auth,
			String atndnTypeId, HashMap<String, String> AtndnAplictVO,
			@RequestParam(required = false) String selectEmpId) {
		HashMap<String, String> map = new HashMap<>();
		month = (Integer.parseInt(month) + 1) + "";

		if (Integer.parseInt(month) < 10) {
			month = "0" + (Integer.parseInt(month));
		}

		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		String empId = userInfo.getUsername();

		// 조직도 접근
		if (selectEmpId == "") {
			map.put("empId", userInfo.getUsername());
		} else {
			// System.err.println("ttttt");
			map.put("empId", selectEmpId);
			// System.err.println(selectEmpId);
		}
		// System.err.println("!@#! : "+map);
		map.put("startDate", year + "-" + month + "-01 00:00:00");

		// logger.info("startDate : " + (year + "-" + month + "-01 00:00:00"));

		if (Integer.parseInt(month) == 12) {
			year = (Integer.parseInt(year) + 1) + "";
			month = "01";
		} else {
			if (Integer.parseInt(month) < 9) {
				month = "0" + (Integer.parseInt(month) + 1);
			} else {
				month = (Integer.parseInt(month) + 1) + "";
			}
		}

		map.put("endDate", year + "-" + month + "-01 00:00:00");
		// logger.info("endDate : " + (year + "-" + month + "-01 00:00:00"));

		atndnAplictVO.setAtndnAplctRqstr(empId);

		List<AtndnAplictVO> list = attendanceService.applyList(map);
		// System.err.println("!@#! : list : "+list);
		return list;
	}

}
