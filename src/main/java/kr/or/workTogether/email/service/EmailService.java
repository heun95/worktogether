package kr.or.workTogether.email.service;

import java.util.List;
import java.util.Map;

import kr.or.workTogether.common.vo.AttachVO;
import kr.or.workTogether.common.vo.BoardVO;
import kr.or.workTogether.common.vo.EmailVO;

public interface EmailService {

	// 메일 전송하기
	public int sendMail(EmailVO emailVO);

	// 임시 보관하기
	public int unsentMail(EmailVO emailVO);

	// 보낸 메일함 조회
	public List<EmailVO> sendMailBox(Map<String, Object> map);

	// 보낸 메일함 리스트 totalCount
	public int sendListCount(Map<String, Object> map);

	// 임시보관함 조회
	public List<EmailVO> unsentMailBox(Map<String, Object> map);

	// 임시보관함 리스트 totalCount
	public int unsentListCount(Map<String, Object> map);

	// 보낸 메일의 상세정보
	public List<EmailVO> sendMailDetail(String emailId);

	// 임시보관 메일의 상세정보
	public EmailVO unsentMailDetail(String emailId);

	// 보낸 메일 삭제하기
	public int sendMailDel(Map<String, Object> map);

	// 임시보관메일 삭제하기
	public int unsentMailDel(Map<String, Object> map);

	// 임시보관메일 전송하기
	public int unsentMailSend(EmailVO emailVO);

	// 휴지통리스트 조회
	public List<EmailVO> trashMailBox(Map<String, Object> map);

	// 휴지통 리스트 totalCount
	public int trashListCount(Map<String, Object> map);

	// 휴지통 비우기
	public int deleteAll();

	// 휴지통에서 선택한 메일 복구하기
	public int restoreMail(String emailId);

	// 체크박스로 선택한 메일만 삭제되도록 하기 (휴지통영구삭제)
	public int deletechoice(String emailId);

	// 체크박스로 선택한 메일만 삭제되도록 하기 (보낸메일함)
	public int deletesendChoice(Map<String, Object> map);

	// 체크박스로 선택한 메일만 삭제되도록 하기 (임시보관함)
	public int deleteunsentChoice(Map<String, Object> map);

	// 받은 메일함 리스트 출력하기
	public List<EmailVO> reMailBox(Map<String, Object> map);

	// 받은 메일함의 토탈 카운트
	public int reListCount(Map<String, Object> map);

	// 체크박스로 선택한 메일만 삭제되도록 하기 (받은메일함)
	public int deletereChoice(Map<String, Object> map);

	// 받은 메일의 상세정보
	public List<EmailVO> reMailDetail(String emailId);

	// 받은메일 삭제하기
	public int reMailDel(Map<String, Object> map);

	// 읽음여부 처리하기
	public int readUpdate(String emailId);

	//임시저장파일불러오기
	public AttachVO selectAttach(String emailId); 
	
	//받은메일함 파일 불러오기
	public AttachVO reDownFile (Map<String ,Object>map);
	
	//보낸메일함 파일 불러오기
	public AttachVO sendDownFile (Map<String ,Object>map);
	
	// 메인페이지 보낸 메일 조회하기
	public List<EmailVO> sendMailMain(Map<String, Object> map);
	
	// 메인페이지 받은 메일 조회하기
	public List<EmailVO> reMailMain(Map<String, Object> map);
	
	// 메인페이지 임시보관 메일 조회하기
	public List<EmailVO> unsentMailMain(Map<String, Object> map);
	
	// 메인페이지 휴지통 조회하기
	public List<EmailVO> trashMailMain(Map<String, Object> map);
	
	// 받은메일함에서 확인여부 처리하기
	public int checkUpdate(String emailId);
	
	//메인페이지 받은 메일함 확인여부 
	public String noCheckCount(Map<String, Object> map);
	
	//메인페이지 받은 메일함 총 갯수 
	public String reMailCount(Map<String , Object> map);
	
	//메인페이지 보낸 메일함 총 갯수 
	public String sendMailCount(Map<String , Object> map);

	//임시보관함  총 갯수 
	public String unsentMailCount(Map<String , Object> map);
	
	//휴지통  총 갯수 
	public String trashMailCount(Map<String , Object> map);
	
	// 메인 메일카운트
	public int mainMailCount(Map<String, Object> map);
	
	// 메인 메일리스트
	public List<BoardVO> mainMailList(Map<String, Object> map);
}