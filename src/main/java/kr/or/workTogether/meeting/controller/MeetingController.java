package kr.or.workTogether.meeting.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.workTogether.common.vo.MeetingVO;
import kr.or.workTogether.meeting.service.MeetingService;

@RequestMapping("/meeting")
@Controller
public class MeetingController {

	private static final Logger logger = LoggerFactory.getLogger(MeetingController.class);
	
	@Autowired
	private MeetingService meetingService;
	
	@GetMapping("/schedule")
	public String schedule(Model model) {
		return "meeting/schedule";
	}
	
	@GetMapping("/ingConference")
	public String ingConference(Model model) {
		List<MeetingVO> meetingList = meetingService.getConferenceList();
		model.addAttribute("meetingList", meetingList);
		return "meeting/ingConference";
	}
	
	@GetMapping("/intendedConference")
	public String intendedConference(Model model) {
		List<MeetingVO> meetingList = meetingService.getConferenceList();
		model.addAttribute("meetingList", meetingList);
		return "meeting/intendedConference";
	}
	
	@GetMapping("/endConference")
	public String endConference(Model model) {
		List<MeetingVO> meetingList = meetingService.getConferenceList();
		model.addAttribute("meetingList",meetingList);
		return "meeting/endConference";
	}
	
	@GetMapping("/room")
	public String room(Model model) {
		return "meeting/room";
	}
	
	@GetMapping("/videoConference")
	public String videoConference(Model model) {
		return "meeting/videoConference";
	}
	
}
