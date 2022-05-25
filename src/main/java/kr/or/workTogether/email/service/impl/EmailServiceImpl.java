package kr.or.workTogether.email.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.workTogether.common.vo.AttachVO;
import kr.or.workTogether.common.vo.BoardVO;
import kr.or.workTogether.common.vo.EmailVO;
import kr.or.workTogether.email.mapper.EmailMapper;
import kr.or.workTogether.email.service.EmailService;

@Service
public class EmailServiceImpl implements EmailService {

	@Autowired
	EmailMapper emailMapper;

	// 메일 전송하기
	@Override
	public int sendMail(EmailVO emailVO) {
		return this.emailMapper.sendMail(emailVO);
	}

	// 임시보관하기
	@Override
	public int unsentMail(EmailVO emailVO) {
		return this.emailMapper.unsentMail(emailVO);
	}

	// 보낸 메일함 조회하기
	@Override
	public List<EmailVO> sendMailBox(Map<String, Object> map) {
		return this.emailMapper.sendMailBox(map);
	}

	// 보낸 메일함 리스트 totalCount
	public int sendListCount(Map<String, Object> map) {
		return this.emailMapper.sendListCount(map);
	}

	// 임시보관함 조회하기
	@Override
	public List<EmailVO> unsentMailBox(Map<String, Object> map) {
		return this.emailMapper.unsentMailBox(map);
	}

	// 임시보관함 리스트 totalCount
	@Override
	public int unsentListCount(Map<String, Object> map) {
		return this.emailMapper.unsentListCount(map);
	}

	// 보낸 메일의 상세정보
	@Override
	public List<EmailVO> sendMailDetail(String emailId) {
		return this.emailMapper.sendMailDetail(emailId);
	}

	// 임시보관 메일의 상세정보
	@Override
	public EmailVO unsentMailDetail(String emailId) {
		return this.emailMapper.unsentMailDetail(emailId);
	}

	// 보낸 메일 삭제하기
	@Override
	public int sendMailDel(Map<String, Object> map) {
		return this.emailMapper.sendMailDel(map);
	}

	// 임시보관메일 삭제하기
	@Override
	public int unsentMailDel(Map<String, Object> map) {
		return this.emailMapper.unsentMailDel(map);
	}

	// 임시보관메일 전송하기
	public int unsentMailSend(EmailVO emailVO) {
		return this.emailMapper.unsentMailSend(emailVO);
	}

	// 휴지통리스트 조회
	public List<EmailVO> trashMailBox(Map<String, Object> map) {
		return this.emailMapper.trashMailBox(map);
	}

	// 휴지통 리스트 totalCount
	public int trashListCount(Map<String, Object> map) {
		return this.emailMapper.trashListCount(map);
	}

	// 휴지통 비우기
	public int deleteAll() {
		return this.emailMapper.deleteAll();
	}

	// 휴지통에서 선택한 메일 복구하기
	public int restoreMail(String emailId) {
		return this.emailMapper.restoreMail(emailId);
	}

	// 체크박스로 선택한 메일만 삭제되도록 하기 (휴지통영구삭제)
	public int deletechoice(String emailId) {
		return this.emailMapper.deletechoice(emailId);
	}

	// 체크박스로 선택한 메일만 삭제되도록 하기 (보낸메일함)
	public int deletesendChoice(Map<String, Object> map) {
		return this.emailMapper.deletesendChoice(map);
	}

	// 체크박스로 선택한 메일만 삭제되도록 하기 (임시보관함)
	public int deleteunsentChoice(Map<String, Object> map) {
		return this.emailMapper.deleteunsentChoice(map);
	}

	// 받은 메일함 리스트 출력하기
	public List<EmailVO> reMailBox(Map<String, Object> map) {
		//map : {emailSendId=EMPL00001, emailRcvId=EMPL00001}
		return this.emailMapper.reMailBox(map);
	}

	// 받은 메일함의 토탈 카운트
	public int reListCount(Map<String, Object> map) {
		return this.emailMapper.reListCount(map);
	}

	// 체크박스로 선택한 메일만 삭제되도록 하기 (받은메일함)
	public int deletereChoice(Map<String, Object> map) {
		return this.emailMapper.deletereChoice(map);
	}
	
	// 받은 메일의 상세정보
	public List<EmailVO> reMailDetail(String emailId) {
		return this.emailMapper.reMailDetail(emailId);
	}
	
	// 받은메일 삭제하기
	public int reMailDel(Map<String, Object> map) {
		return this.emailMapper.reMailDel(map);
	}
	
	// 읽음여부 처리하기
	public int readUpdate(String emailId) {
		return this.emailMapper.readUpdate(emailId);
	}
	
	//임시저장파일불러오기
	public AttachVO selectAttach(String emailId) {
		return this.emailMapper.selectAttach(emailId);
	}

	//받은메일함 파일 불러오기
	public AttachVO reDownFile (Map<String ,Object>map) {
		return this.emailMapper.reDownFile(map);
	}
	
	//보낸메일함 파일 불러오기
	public AttachVO sendDownFile (Map<String ,Object>map) {
		return this.emailMapper.sendDownFile(map);
	}
	
	// 메인페이지 보낸 메일 조회하기
	@Override
	public List<EmailVO> sendMailMain(Map<String, Object> map) {
		return this.emailMapper.sendMailMain(map);
	}
	
	// 메인페이지 받은 메일 조회하기
	public List<EmailVO> reMailMain(Map<String, Object> map){
		return this.emailMapper.reMailMain(map);
	}
	// 메인페이지 임시보관 메일 조회하기
	public List<EmailVO> unsentMailMain(Map<String, Object> map){
		return this.emailMapper.unsentMailMain(map);
	}
	
	// 메인페이지 휴지통 조회하기
	public List<EmailVO> trashMailMain(Map<String, Object> map){
		return this.emailMapper.trashMailMain(map);
	}
	
	// 받은메일함에서 확인여부 처리하기
	public int checkUpdate(String emailId) {
		return this.emailMapper.checkUpdate(emailId);
	}
	
	//메인페이지 받은 메일함 확인여부 
	public String noCheckCount(Map<String, Object> map ) {
		return this.emailMapper.noCheckCount(map);
	}
	
	//메인페이지 받은 메일함 총 갯수 
	public String reMailCount(Map<String , Object> map) {
		return this.emailMapper.reMailCount(map);
	}
	
	//메인페이지 보낸 메일함 총 갯수 
	public String sendMailCount(Map<String , Object> map) {
		return this.emailMapper.sendMailCount(map);
	}
	
	//임시보관함 총 갯수 
	public String unsentMailCount(Map<String , Object> map) {
		return this.emailMapper.unsentMailCount(map);

	}
	
	//휴지통  총 갯수 
	public String trashMailCount(Map<String , Object> map) {
		return this.emailMapper.trashMailCount(map);
	}
	
	// 메인 메일 카운트
	@Override
	public int mainMailCount(Map<String, Object> map) {
		return emailMapper.mainMailCount(map);
	}
	
	// 메인 메일 리스트
	@Override
	public List<BoardVO> mainMailList(Map<String, Object> map) {
		return emailMapper.mainMailList(map);
	}
}
