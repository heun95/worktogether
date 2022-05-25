package kr.or.workTogether.chat.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.workTogether.chat.mapper.ChatMapper;
import kr.or.workTogether.chat.service.ChatService;
import kr.or.workTogether.common.vo.ChatBangVO;
import kr.or.workTogether.common.vo.ChatVO;

@Service
public class ChatServiceImpl implements ChatService{
	
	@Autowired
	ChatMapper chatMapper;
	
	private static final Logger logger = LoggerFactory.getLogger(ChatServiceImpl.class);

	@Override
	public List<ChatBangVO> chatBangList(String empId) {
		return chatMapper.chatBangList(empId);
	}

	@Override
	public int insertChat(ChatVO chatVO) {
		return chatMapper.insertChat(chatVO);
	}
	
	@Override
	public String bangCheck(Map<String, Object> map) {
		return chatMapper.bangCheck(map);
	}

	@Override
	public List<ChatVO> chatMsgList(String chatbangId) {
		return chatMapper.chatMsgList(chatbangId);
	}

	@Override
	public int insertBang(Map<String, Object> map) {
		return chatMapper.insertBang(map);
	}

	@Override
	public int bangDelete(String chatbangId) {
		return chatMapper.bangDelete(chatbangId);
	}


	
}
