package kr.or.workTogether.login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.workTogether.common.service.CommonService;

@Controller
@RequestMapping(value = { "/session" })
public class LoginController {
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	@Autowired
	CommonService commonService;
	
	@RequestMapping("/login")
	public String loginForm(String error, String logout, Model model) {
		logger.info("error : " + error);
		logger.info("logout : " + logout);

		if (error != null) {
			model.addAttribute("error", "Login Error!");
		}

		if (logout != null) {
			model.addAttribute("logout", "Logout되었습니다");
		}

		return "login/loginForm";
	}
	
	@RequestMapping("/logout")
	public String logoutForm(HttpServletRequest request, HttpServletResponse response) throws Exception {

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//		if (auth != null) {
			new SecurityContextLogoutHandler().logout(request, response, auth);
//		}

		return "redirect:/session/login";
	}
	
	@PostMapping("/pass")
	@RequestMapping
	public String successPass(String userId) throws Exception {
		
		return commonService.successPass(userId);
	}
	
}
