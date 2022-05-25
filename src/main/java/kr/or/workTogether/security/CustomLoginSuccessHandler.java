package kr.or.workTogether.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	
	private static final Logger logger = LoggerFactory.getLogger(CustomLoginSuccessHandler.class);
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws ServletException, IOException {
		logger.warn("onAuthenticationSuccess");
		
		//loginForm.jsp의 계정id와 비밀번호 정보를 authentication 객체로 받아옴
		User customUser = (User)authentication.getPrincipal();
		logger.info("username : " + customUser.getUsername());
		logger.info("password : " + customUser.getPassword());
		
		super.onAuthenticationSuccess(request, response, authentication);
	}
	
}





