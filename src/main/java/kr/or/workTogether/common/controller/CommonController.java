package kr.or.workTogether.common.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.workTogether.authorization.service.AuthorizationService;
import kr.or.workTogether.common.service.CommonService;
import kr.or.workTogether.common.util.ArticlePage;
import kr.or.workTogether.common.vo.AtndnDlyVO;
import kr.or.workTogether.common.vo.AtrzDocVO;
import kr.or.workTogether.common.vo.BoardVO;
import kr.or.workTogether.common.vo.DepartmentVO;
import kr.or.workTogether.common.vo.EmployeeVO;
import kr.or.workTogether.common.vo.NotificationVO;
import kr.or.workTogether.common.vo.ProjWorkReplyVO;
import kr.or.workTogether.common.vo.ProjWorkVO;
import kr.or.workTogether.common.vo.ProjectVO;
import kr.or.workTogether.common.vo.ScheduleVO;
import kr.or.workTogether.email.service.EmailService;
import kr.or.workTogether.notice.service.NoticeService;
import kr.or.workTogether.notification.service.NotificationService;
import kr.or.workTogether.schedule.service.ScheduleService;
import kr.or.workTogether.security.CustomUser;

@Controller
public class CommonController {
	
	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);
	
	@Autowired
	private NotificationService notiService;
	@Autowired
	private CommonService commonService;
	@Autowired
	private AuthorizationService authoService;
	@Autowired
	private NoticeService noticeService;
	@Autowired
	private EmailService emailService;
	@Autowired
	ScheduleService scheduleService;
	
	//메인페이지
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String homeMain(Locale locale
			, Model model
			, ProjectVO projectVO
			, ProjWorkVO projWorkVO
			, ProjWorkReplyVO projWorkReplyVO 
			, Authentication auth ){
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		
		String userId = userInfo.getUsername();
		
		AtndnDlyVO atndnDaily = commonService.atndnDaily(userId);
		model.addAttribute("atndnDaily", atndnDaily);
		
		Map<String, Object> map = new HashMap<>();
		map.put("schdlWrtr", userId);
		
		List<ScheduleVO> scheduleList = scheduleService.getScheduleList(map);
		
		model.addAttribute("scheduleList", scheduleList);
		
		return "common/main";
	}
	
	// 업무데이터
	@PostMapping("/mainWorkList")
	@ResponseBody
	public List<AtrzDocVO> mainWorkList(Model model
			, Authentication auth
			,@RequestParam String division){
		
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		
		String userId = userInfo.getUsername();
		List<AtrzDocVO> docList = new ArrayList<AtrzDocVO>();
		
		if(division == "get") {
			docList = authoService.getReceiveDocList(userId);
			
		}else {
			docList = authoService.getSendDocList(userId);
		}
		
		return docList;
		
	}
	
	// 결재데이터
	@PostMapping("/mainAuthoList")
	@ResponseBody
	public Map<String, Object> mainAuthoList(Model model
			,@RequestBody Map<String, Object> map) {
		
		List<AtrzDocVO> authoList = authoService.mainDocList(map);
		
		int total = authoService.listCount(map);
		int currentPage = (int) map.get("currentPage");
		int size = (int) map.get("size");
		int start = (int) map.get("start");
		int end = (int) map.get("end");
		
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("authoList", authoList);
		resultMap.put("page", new ArticlePage(total, currentPage, size, 5, start, end));
		resultMap.put("total", total);
		
		return resultMap;
	}
	
	// 공지사항데이터
	@PostMapping("/mainNoticeList")
	@ResponseBody
	public Map<String, Object> mainNoticeList(Model model
			,@RequestBody Map<String, Object> map) {

		// <key,value>

		List<BoardVO> noticeList = noticeService.list(map);

		int total = noticeService.listCount(map);
		int currentPage = (int) map.get("currentPage");
		int size = (int) map.get("size");
		int start = (int) map.get("start");
		int end = (int) map.get("end");
	
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("noticeList", noticeList);
		resultMap.put("page", new ArticlePage(total, currentPage, size, 5, start, end));
		resultMap.put("total", total);
		
		return resultMap;
	}
	
	// 메일데이터
	@PostMapping("/mainMailList")
	@ResponseBody
	public Map<String, Object> mainMailList(Model model
			,@RequestBody Map<String, Object> map) {
		
		// <key,value>
		logger.info("***mainMailList");
		logger.info("mainMailList" + map.toString());
		List<BoardVO> noticeList = emailService.mainMailList(map);
		
		int total = emailService.mainMailCount(map);
		int currentPage = (int) map.get("currentPage");
		int size = (int) map.get("size");
		int start = (int) map.get("start");
		int end = (int) map.get("end");
		
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("mailList", noticeList);
		resultMap.put("page", new ArticlePage(total, currentPage, size, 5, start, end));
		resultMap.put("total", total);
		
		return resultMap;
	}
	
	// 일정데이터
	@PostMapping("/mainSchdlList")
	@ResponseBody
	public Map<String, Object> mainSchdlList(Model model
			, Authentication auth ){
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		
		String userId = userInfo.getUsername();
		
		Map<String, Object> map = new HashMap<>();
		map.put("schdlWrtr", userId);
		
		// <key,value> schdlWrtr
		logger.info("***mainSchdlList");
		logger.info("mainSchdlList" + map.toString());
		List<ScheduleVO> scheduleList = scheduleService.getScheduleList(map);
		
		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("scheduleList", scheduleList);

		return resultMap;
	}
	
	//조직도 페이지
	@GetMapping("/common/jojikdo")
	public String jojikdo(Model model) {
		return "common/jojikdo";
	}
	
	//조직도 조회
	@ResponseBody
	@PostMapping("/common/treeList")
	public List<DepartmentVO> treeList(Model model, @RequestBody Map<String,Object> map){
		String treeSelect = (String)map.get("treeSelect");
		List<DepartmentVO> treeList = commonService.getTreeList(treeSelect);
		logger.info("treeList : "+treeList);
		return treeList;
	}
	
	@GetMapping("/common/webRtc")
	public String webRtc() {
		return "common/webRtc";
	}
	
	@GetMapping("/common/notiWebRtc")
	public String notiWebRtc(Authentication auth) {
		CustomUser user = (CustomUser)auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		
		NotificationVO notiVO = new NotificationVO();

		notiVO.setNotSender(userInfo.getUsername()); //보내는사람ID
		notiVO.setNotReceiver("EMPL00001"); //받는사람ID
		notiVO.setNotTypeId("화상회의 요청"); //알림종류 - 'xx 알림이 도착했습니다.' 에서 xx를 의미
		notiVO.setNotCntntId("WEBR00001"); //알림해당글PK
		notiVO.setNotMsg("화상회의를 요청하셨습니다."); //알림내용

		//알림글URL - 알림글 URL은 detail 들어갈때의 URL을 적어줄것
		//예시) /autho/receiveDocDetail?docId=ATDO00001&atrzAprvId=EMPL00001
		String notUrl = "/common/webRtc";
		notiVO.setNotUrl(notUrl); 

		notiService.insertNoti(notiVO);
		
		return "meeting/videoConference";
	}
}
