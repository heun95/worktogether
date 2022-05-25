package kr.or.workTogether.notification.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import kr.or.workTogether.common.vo.NotificationVO;
import kr.or.workTogether.notification.service.NotificationService;
import kr.or.workTogether.security.CustomUser;

@RequestMapping("/noti")
@Controller
public class NotificationController {

	private static final Logger logger = LoggerFactory.getLogger(NotificationController.class);

	@Autowired
	private NotificationService notiService;
	
	@ResponseBody
	@GetMapping("/notiAjax")
	public Map<String,Object> notiAjax(Authentication auth) {
		Map<String,Object> map = new HashMap<>();
		
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		
		List<NotificationVO> notiList = notiService.getNotiList(userInfo.getUsername());
		map.put("notiList", notiList);
		
		int cnt = notiService.getAllCountNoti(userInfo.getUsername());
		map.put("cnt", cnt);
		
		NotificationVO momentNoti = notiService.getNoti(userInfo.getUsername());
		map.put("momentNoti", momentNoti);
		
		//logger.info("notiList : " + notiList);
		return map;
	}
	
	@ResponseBody
	@GetMapping("/notiUpdateAjax")
	public String notiUpdateAjax(@RequestParam String notId) {
		notiService.updateNoti(notId);
		return "";
	}
	
	@ResponseBody
	@GetMapping("/notiUpdateAjax2")
	public String notiUpdateAjax2(@RequestParam String notId) {
		notiService.updateNoti2(notId);
		return "";
	}
	
	
	
	
	
	
	
	
	
	
	@GetMapping("/view")
	public String main(Model model, Authentication auth) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		
		model.addAttribute("userInfo", userInfo);
		return "noti/view";
	}
	
	@ResponseBody
	@GetMapping("/viewAjax")
	public List<NotificationVO> readAjax(Model model, @RequestParam(required = false) String notReceiver) {
		logger.info("notReceiver : " + notReceiver);
		List<NotificationVO> notiList = new ArrayList<>();
		
		if(notReceiver != null) {
			notiList = notiService.getNotiList(notReceiver);
			logger.info("notiList : " + notiList);
			//notiService.updateNoti(notReceiver);
		}
		
		return notiList;
	}
	
	@GetMapping("/insertNoti")
	public String insertNoti(Model model, @RequestParam String notSender, @ModelAttribute NotificationVO notiVO) {
		logger.info("notSender : " + notSender);
		model.addAttribute("notSender",notSender);
		return "noti/insert";
	}
	
	@PostMapping("/insertNoti")
	public String insertNotiPost(Model model, @ModelAttribute NotificationVO notiVO) {
		int result = notiService.insertNoti(notiVO);
		logger.info("result : " + result);
		return "noti/view";
	}
	
	
	
}
