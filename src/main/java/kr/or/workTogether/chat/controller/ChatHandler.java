package kr.or.workTogether.chat.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.workTogether.chat.service.ChatService;
import kr.or.workTogether.common.vo.ChatVO;

@Component
public class ChatHandler extends TextWebSocketHandler {

	// (<"bang_id", 방ID>, <"session", 세션>) - (<"bang_id", 방ID>, <"session", 세션>) - (<"bang_id", 방ID>, <"session", 세션>) 형태 
	private List<Map<String, Object>> sessionList = new ArrayList<Map<String, Object>>();
	
	@Autowired
	ChatService chatService;
	
	// 클라이언트가 서버로 메세지 전송 처리
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

		super.handleTextMessage(session, message);
        
		// JSON --> Map으로 변환
		ObjectMapper objectMapper = new ObjectMapper();
		Map<String, String> mapReceive = objectMapper.readValue(message.getPayload(), Map.class);

		switch (mapReceive.get("cmd")) {
		
		// CLIENT 입장
		case "CMD_ENTER":
			// 세션 리스트에 저장
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("chatbangId", mapReceive.get("chatbangId"));
			map.put("session", session);
			sessionList.add(map);
			
			// 같은 채팅방에 입장 메세지 전송
			for (int i = 0; i < sessionList.size(); i++) {
				Map<String, Object> mapSessionList = sessionList.get(i);
				String chatbangId = (String) mapSessionList.get("chatbangId");
				WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");
				
				if(chatbangId.equals(mapReceive.get("chatbangId"))) {
					Map<String, String> mapToSend = new HashMap<String, String>();
					mapToSend.put("chatbangId", chatbangId);
					mapToSend.put("cmd", "CMD_ENTER");
					mapToSend.put("msg", (String)session.getAttributes().get("userId") +  "님이 입장 했습니다.");
					
					String jsonStr = objectMapper.writeValueAsString(mapToSend);
					sess.sendMessage(new TextMessage(jsonStr));
				}
			}
			break;
			
		// CLIENT 메세지
		case "CMD_MSG_SEND":
			// 같은 채팅방에 메세지 전송
			for (int i = 0; i < sessionList.size(); i++) {
				Map<String, Object> mapSessionList = sessionList.get(i);
				String chatbangId = (String) mapSessionList.get("chatbangId");
				WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");
				
				SimpleDateFormat sDate = new SimpleDateFormat("hh:mm");
				Date date = new Date();
				String formatDate = sDate.format(date);
				
				if (chatbangId.equals(mapReceive.get("chatbangId"))) {
					Map<String, String> mapToSend = new HashMap<String, String>();
					mapToSend.put("chatbangId", chatbangId);
					mapToSend.put("cmd", "CMD_MSG_SEND");
					mapToSend.put("userId", (String)session.getAttributes().get("userId"));
					mapToSend.put("userNm", (String)session.getAttributes().get("userNm"));
					mapToSend.put("userPhoto", (String)session.getAttributes().get("empPhoto"));
					mapToSend.put("date", formatDate);
					mapToSend.put("msg",  mapReceive.get("msg"));
					
					//채팅내용 DB에 저장하기
					ChatVO chatVO = new ChatVO();
					chatVO.setChatbangId(chatbangId);
					chatVO.setChatCntnt(mapReceive.get("msg"));
					chatVO.setChatWrtDt(date);
					chatVO.setChatWrtr((String)session.getAttributes().get("userId"));
					chatService.insertChat(chatVO);
					
					String jsonStr = objectMapper.writeValueAsString(mapToSend);
					sess.sendMessage(new TextMessage(jsonStr));
				}
			}
			break;
		}
	}

	// 클라이언트가 연결을 끊음 처리
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		super.afterConnectionClosed(session, status);
        
		ObjectMapper objectMapper = new ObjectMapper();
		String now_chatbangId = "";
		
		// 사용자 세션을 리스트에서 제거
		for (int i = 0; i < sessionList.size(); i++) {
			Map<String, Object> map = sessionList.get(i);
			String chatbangId = (String) map.get("chatbangId");
			WebSocketSession sess = (WebSocketSession) map.get("session");
			
			if(session.equals(sess)) {
				now_chatbangId = chatbangId;
				sessionList.remove(map);
				break;
			}	
		}
		
		// 같은 채팅방에 퇴장 메세지 전송 
		for (int i = 0; i < sessionList.size(); i++) {
			Map<String, Object> mapSessionList = sessionList.get(i);
			String chatbangId = (String) mapSessionList.get("chatbangId");
			WebSocketSession sess = (WebSocketSession) mapSessionList.get("session");

			if (chatbangId.equals(now_chatbangId)) {
				Map<String, String> mapToSend = new HashMap<String, String>();
				mapToSend.put("chatbangId", chatbangId);
				mapToSend.put("cmd", "CMD_EXIT");
				mapToSend.put("msg", (String)session.getAttributes().get("userId") + "님이 퇴장 했습니다.");

				String jsonStr = objectMapper.writeValueAsString(mapToSend);
				sess.sendMessage(new TextMessage(jsonStr));
			}
		}
	}
}
