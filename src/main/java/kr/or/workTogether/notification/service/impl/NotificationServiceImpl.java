package kr.or.workTogether.notification.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.workTogether.common.vo.NotificationVO;
import kr.or.workTogether.notification.mapper.NotificationMapper;
import kr.or.workTogether.notification.service.NotificationService;

@Service
public class NotificationServiceImpl implements NotificationService{

	@Autowired
	private NotificationMapper notiMapper;

	@Override
	public List<NotificationVO> getNotiList(String notReceiver) {
		return notiMapper.getNotiList(notReceiver);
	}
	
	@Override
	public int getAllCountNoti(String notReceiver) {
		return notiMapper.getAllCountNoti(notReceiver);
	}

	@Override
	public List<NotificationVO> getCountNotiList(String notReceiver) {
		return notiMapper.getCountNotiList(notReceiver);
	}

	@Override
	public int insertNoti(NotificationVO notiVO) {
		return notiMapper.insertNoti(notiVO);
	}

	@Override
	public int updateNoti(String notId) {
		return notiMapper.updateNoti(notId);
	}

	@Override
	public NotificationVO getNoti(String notReceiver) {
		return notiMapper.getNoti(notReceiver);
	}

	@Override
	public int updateNoti2(String notId) {
		return notiMapper.updateNoti2(notId);
	}

	

}
