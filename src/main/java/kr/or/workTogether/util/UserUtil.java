package kr.or.workTogether.util;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

//개발자의 편의에 의해 공통적으로 사용되는 메소드의 모음
public class UserUtil {
	private static final Logger logger = 
			LoggerFactory.getLogger(UserUtil.class);
	
	//sub제목과 제목을 파라미터로 받아 맵으로 리턴
	//뷰 페이지의 제목 영역에 표시할 수 있음
	public static Map<String,String> getPageHeader(String subtitle,String title){
		Map<String,String> pageHeader = new HashMap<String, String>();
		pageHeader.put("subtitle", subtitle);
		pageHeader.put("title", title);
		
		return pageHeader;
	}
	
	
}
