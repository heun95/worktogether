package kr.or.workTogether.notification.service;

import java.util.List;

import kr.or.workTogether.common.vo.NotificationVO;

public interface NotificationService {

	//읽지않은 알림 리스트
	public List<NotificationVO> getNotiList(String notReceiver);
	
	//읽지않은 알림 총 개수
	public int getAllCountNoti(String notReceiver);
	
	//읽지않은 알림 종류별 각 개수
	public List<NotificationVO> getCountNotiList(String notReceiver);
	
	//알림 등록
	public int insertNoti(NotificationVO notiVO);
	
	//알림 읽음 처리
	public int updateNoti(String notId);
	
	//최초 알림 읽음 처리
	public int updateNoti2(String notId);
	
	//읽지 않은 알림 ONE
	public NotificationVO getNoti(String notReceiver);
}
