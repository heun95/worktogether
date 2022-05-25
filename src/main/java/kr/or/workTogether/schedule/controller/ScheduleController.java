package kr.or.workTogether.schedule.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.workTogether.common.vo.EmployeeVO;
import kr.or.workTogether.common.vo.ScheduleVO;
import kr.or.workTogether.schedule.service.ScheduleService;
import kr.or.workTogether.security.CustomUser;

@RequestMapping("/schedule")
@Controller
public class ScheduleController {

	@Autowired
	ScheduleService scheduleService;

	@GetMapping("/main")
	public String main(Model model, Authentication auth,
					   @RequestParam(required = false) String selector,
					   @RequestParam(required = false) String schdlId,
					   @RequestParam(required = false) String selectType) {
		CustomUser user = (CustomUser)auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		//System.err.println("selectType : "+selectType);
		if(selector != null) {
			ScheduleVO scheduleVO = scheduleService.getSchedule(schdlId);
			model.addAttribute("scheduleVO", scheduleVO);
			//System.err.println(scheduleVO);
		}
		
		Map<String,Object> map = new HashMap<String,Object>();
		if(selectType != null && !selectType.equals("전체")) {
			map.put("schdlTypeId", selectType);
		}
		
		map.put("schdlWrtr", userInfo.getUsername());
		//System.err.println("mpa : "+map);
		List<ScheduleVO> scheduleList = scheduleService.getScheduleList(map);
		
		model.addAttribute("scheduleList", scheduleList);
		
		return "schedule/main";
	}
	
	@PostMapping("/create")
	public String create(Model model, @ModelAttribute ScheduleVO scheduleVO, Authentication auth) {
		CustomUser user = (CustomUser)auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		
		//System.err.println("scheduleVO : "+scheduleVO);
	
		scheduleVO.setSchdlWrtr(userInfo.getUsername());
		scheduleService.insertSchedule(scheduleVO);
		return "redirect:/schedule/main";
	}
	
	@GetMapping("/delete")
	public String delete(Model model, @RequestParam String schdlId) {
		//System.out.println("schdlId : "+schdlId);
		//System.out.println("scheduleVO : "+scheduleVO);
		scheduleService.deleteSchedule(schdlId);
		
		return "redirect:/schedule/main";
	}
	
	@PostMapping("/update")
	public String update(Model model, ScheduleVO scheduleVO) {
		System.out.println("update : scheduleVO : "+scheduleVO);
		scheduleService.updateSchedule(scheduleVO);
		return "redirect:/schedule/main";
	}
	
	
	
	
//	@GetMapping("/detail")
//	public String detail(@RequestParam String schdlId) {
//		System.err.println("schlId : "+schdlId);
//		ScheduleVO scheduleVO = scheduleService.getSchedule(schdlId);
//		
//		return scheduleVO;
//	}
//	
	
/*
 	//민정
	//일정 보이기
	@RequestMapping("/main")
	public String main(Model model, @ModelAttribute ScheduleVO scheduleVO){
		return "schedule/main";
	}
 	 
	//일정 데이터 가져오기 ajax
	@GetMapping("/caldata")
	@ResponseBody
	public List<CalendarVO> caldata(@RequestParam String schdlId){
		List<CalendarVO>calendar = scheduleService.calendar(schdlId);
		return calendar;
	}
*/
}
