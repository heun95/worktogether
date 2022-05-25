package kr.or.workTogether.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SecurityController {
	private static final Logger logger = LoggerFactory.getLogger(SecurityController.class);
	
	//Authentication : 인증(로그인), Authorization : 인가(접근 제어)
	//접근 거부 처리자가 보낸 요청과 메소드를 매핑
	@RequestMapping("/accessError")
	public String accessDenied(Authentication auth, Model model) {
		logger.info("access Denied : " + auth);
		
		model.addAttribute("msg", "Access Denied");
		
		return "error/accessError";
	}
}








