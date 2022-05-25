package kr.or.workTogether.chat.service;

import java.util.List;
import java.util.Map;

import kr.or.workTogether.common.vo.ChatBangVO;
import kr.or.workTogether.common.vo.ChatVO;

public interface ChatService {
	
	// 채팅방리스트
	public List<ChatBangVO> chatBangList(String empId);
	
	// 채팅내용 저장하기
	public int insertChat(ChatVO chatVO);
	
	// 채팅방 중복체크
	public String bangCheck(Map<String, Object> map);
	
	// 채팅내용 가져오기
	public List<ChatVO> chatMsgList(String chatbangId);
	
	// 채팅방 만들기
	public int insertBang(Map<String, Object> map);
	
	// 채팅방 나가기
	public int bangDelete(String chatbangId);
}
