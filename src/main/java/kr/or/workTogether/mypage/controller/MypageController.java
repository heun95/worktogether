package kr.or.workTogether.mypage.controller;

import java.util.HashMap;
import java.util.Map;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.or.workTogether.common.vo.EmployeeVO;
import kr.or.workTogether.email.controller.EmailController;
import kr.or.workTogether.mypage.service.MypageService;
import kr.or.workTogether.security.CustomUser;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	
	private static final Logger logger = LoggerFactory.getLogger(EmailController.class);

	@Autowired MypageService mypageservice;
	
	@RequestMapping("/updateEmpl")
	@ResponseBody
	public String updateEmpl(@RequestParam("changedata")String changedata, Authentication auth) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		
		logger.info("=======================");
		logger.info("changedata"+changedata);
		logger.info("=======================");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empPassword",changedata);
		map.put("empId",userInfo.getUsername());
		
		int result = mypageservice.updateEmpl(map);
		String res="fail";
		if(result>0) {
			res="success";
		}
		return res;
	}
}
