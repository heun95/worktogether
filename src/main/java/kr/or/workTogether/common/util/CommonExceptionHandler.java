package kr.or.workTogether.common.util;

import java.nio.file.AccessDeniedException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

//스프링 컨트롤러에서.. 발생된 예외를 처리하는 핸들러 클래스임을 명시함
@ControllerAdvice
public class CommonExceptionHandler {
	
	private static final Logger logger = LoggerFactory.getLogger(CommonExceptionHandler.class);
	
	@ExceptionHandler(AccessDeniedException.class)
	public void handleAccessDeniedException(AccessDeniedException ex, HttpServletRequest resquest, HttpServletResponse response) throws Exception{
		System.err.println("ADSfDSAFASDFASDFASDF");
		logger.info("커먼잎셉션핸들러");
		response.sendRedirect("/login");
	}
	//괄호 안에 설정한 예외 타입을 해당 메서드가 처리한다는 것을 의미함
	//<exception-type>java.lang.Exception</exception-type> 
	// 없는 URL 요청 예외(X)
	// 수정 화면 생성 시 뷰 파일(jsp)에서 예외(X)
//	@ExceptionHandler(Exception.class)
//	public String handle(Exception e, Model model) {
//		logger.info(e.toString());
//		model.addAttribute("exception", e);
//		//forwarding
//		return "error/Exception";
//	}
}





