package kr.or.workTogether.chat.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

import kr.or.workTogether.chat.service.ChatService;
import kr.or.workTogether.common.vo.ChatBangVO;
import kr.or.workTogether.common.vo.ChatVO;
import kr.or.workTogether.common.vo.EmployeeVO;
import kr.or.workTogether.security.CustomUser;


@Controller
@RequestMapping("")
public class ChatController {
	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);

	@Autowired
	ChatService chatService;
	
	@GetMapping(value = "/chat")
	public String list(Model model, Authentication auth) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		
		String empId = userInfo.getUsername();
		
		List<ChatBangVO> bangList = this.chatService.chatBangList(empId);
		model.addAttribute("bangList", bangList);
		

		logger.info("chatList : " + bangList.toString());
		return "chat/chatview";
	}
	
	// 채팅목록
	@GetMapping(value = "/chat/bangList")
	@ResponseBody
	public List<ChatBangVO> bangList(Model model, Authentication auth) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		
		String empId = userInfo.getUsername();
		
		List<ChatBangVO> bangList = this.chatService.chatBangList(empId);
		
		logger.info("chatList : " + bangList.toString());
		
		return bangList;
	}
	
	// 채팅방 입장
	@RequestMapping(value = "/chat.do", method = RequestMethod.GET)
	public String view_chat(Authentication auth, HttpSession session, HttpServletRequest request, HttpServletResponse response, Model model, @RequestParam(required=false)String chatbangId) throws Exception {
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		
		String empId = userInfo.getUsername();
		String empName = userInfo.getEmpName();
		String empPhoto = userInfo.getAtchPath();
		
		session.setAttribute("userId", empId);
		session.setAttribute("userNm", empName);
		session.setAttribute("empPhoto", empPhoto);
		
		logger.info("userid : " + empId);
		logger.info("userNm : " + empName);
		logger.info("empPhoto : " + empPhoto);
		
		List<ChatBangVO> bangList = this.chatService.chatBangList(empId);
		List<ChatVO> chatMsgList = chatService.chatMsgList(chatbangId);
		
		logger.info("chatMsgList : " + chatMsgList);

		model.addAttribute("bangList", bangList);
		model.addAttribute("chatMsgList", chatMsgList);
		
		return "chat/chatview";
	}
	
	// 채팅방 중복체크
	@GetMapping("/chat/bangCheck")
	@ResponseBody
	public String bangCheck(Authentication auth
			, @RequestParam String empId) {
		
		logger.info("empId : " + empId);
		
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		
		String userId = userInfo.getUsername();
		
		List<String> empList = new ArrayList<String>();
		empList.add(empId);
		empList.add(userId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("empList", empList);
		map.put("empCnt", empList.size());
		
		String bangCheck = chatService.bangCheck(map);
		
		return bangCheck;
		
	}
	
	// 채팅방 만들기
	@PostMapping("/chat/insertBang")
	@ResponseBody
	public Map<String, Object> insertBang(@RequestBody Map<String, Object> map) {
		logger.info("empList : " + map);
		
		int insertBang = chatService.insertBang(map);
		
		logger.info("empListtest : " + map);
		
		return map;
	}
	
	// 채팅방 나가기
	@PostMapping("/chat/bangDelete")
	@ResponseBody
	public int bangDelete(String chatbangId) {
		logger.info("chatbangId : " + chatbangId);
		
		int bangDelete = chatService.bangDelete(chatbangId);
		
		
		return bangDelete;
	}
}
