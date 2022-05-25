package kr.or.workTogether.common.util;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrorController {
	@RequestMapping("/error/400")
	public String error400() {
		return "error/400";
	}
	
	@RequestMapping("/error/404")
	public String error405() {
		return "error/404";
	}
	
	@RequestMapping("/error/500")
	public String error500() {
		return "error/500";
	}
}
