package kr.or.workTogether.security;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

public class CustomAccessDeniedHandler implements AccessDeniedHandler {

	private static final Logger logger = LoggerFactory.getLogger(CustomAccessDeniedHandler.class);

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		logger.error(accessDeniedException.getMessage());
		// response.sendRedirect("/accessError");
		
		logger.debug(" SessionId : {}", request.getRequestedSessionId());
		logger.debug(" RemoteAddr : {}", request.getRemoteAddr());
		logger.debug(" RemoteHost : {}", request.getRemoteHost());
		
		response.setContentType("text/html; charset=euc-kr");
		PrintWriter out = response.getWriter();
//		out.print("<script>alert('접근권한이 없습니다.');");
//		out.print("history.back();</script>");
		
	}

}
