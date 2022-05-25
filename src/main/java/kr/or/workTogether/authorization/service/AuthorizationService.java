package kr.or.workTogether.authorization.service;

import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.web.multipart.MultipartFile;

import kr.or.workTogether.common.vo.AtrzDocVO;
import kr.or.workTogether.common.vo.AtrzLineDetailVO;
import kr.or.workTogether.common.vo.AtrzLineVO;
import kr.or.workTogether.common.vo.AtrzVO;
import kr.or.workTogether.common.vo.AttachVO;
import kr.or.workTogether.common.vo.CommonCodeVO;
import kr.or.workTogether.common.vo.DepartmentVO;
import kr.or.workTogether.common.vo.EmployeeVO;

public interface AuthorizationService {
	
	//조직도 가져오기(LIST)
	public List<DepartmentVO> getTreeList();
	
	//문서양식 가져오기(LIST)
	public List<CommonCodeVO> getDocFormList();
	
	//보존연한 가져오기(LIST)
	public List<CommonCodeVO> getDocRetentionList();
	
	//결재문서 등록하기
	public String insertAtrzDoc(AtrzDocVO atrzDocVO);
	
	//결재선 등록하기
	public String insertAtrzLine(AtrzLineVO atrzLineVO);
	
	//결재선상세 등록하기
	public int insertAtrzLineDetail(AtrzLineDetailVO atrzLineDetailVO);
	
	//임시문서함 가져오기(LIST)
	public List<AtrzDocVO> getTempDocList(String docWrtr);
	
	//임시문서 가져오기(DETAIL)
	public AtrzDocVO getTempDoc(String docId);
	
	//결재선상세 가져오기(LIST)
	public List<AtrzLineDetailVO> getAtrzLineDetailList(String atrzLineId);
	
	//임시문서함의 결재문서 수정하기
	public int updateTempDoc(AtrzDocVO atrzDocVO);
		
	//임시문서함의 결재선상세 삭제하기
	public int deleteAtrzLineDetail(String atrzLineId);
	
	//임시문서함의 결재선 삭제하기
	public int deleteAtrzLine(String atrzLineId);
	
	//보낸문서함 가져오기(LIST)
	public List<AtrzDocVO> getSendDocList(String docWrtr);
	
	//보낸문서함 가져오기(DETAIL)
	public AtrzDocVO getSendDoc(String docId);
	
	//받은문서함 가져오기(LIST)
	public List<AtrzDocVO> getReceiveDocList(String docWrtr);
	
	//받은문서함 가져오기(DETAIL)
	public AtrzDocVO getReceiveDoc(Map<String,Object> map);

	//결재 등록하기
	public int insertAtrz(AtrzVO atrzVO);
	
	//첨부파일 가져오기(ONE)
	public AttachVO getAttach(String atchRelId);
	
	//전자결재설정의 전자서명 등록하기
	public AttachVO doInsertSign(MultipartFile[] uploadFile, Authentication auth);
	
	//직원 가져오기(ONE)
	public EmployeeVO getEmployee(String empId);
	
	//결재 가져오기(ONE)
	public AtrzVO getAtrz(Map<String,Object> map);
	
//	//결재 하기
//	public int doAtrz(AtrzVO atrzVO);

	//결재하기 - 문서변경(UPDATE)
	public int updateAtrzDoc(AtrzVO atrzVO);
	
	//결재하기 - 결재변경(UPDATE)
	public int updateAtrz(AtrzVO atrzVO);
	
	//결재문서의 문서코드 가져오기(ONE)
	public String getMaxDocId();
	
	//다음 결재자 리스트
	public List<AtrzVO> getNextAtrzList(String docId);
	
	// 메인화면 리스트
	public List<AtrzDocVO> mainDocList(Map<String, Object> map);
	
	// 메인화면 리스트 카운트
	public int listCount(Map<String, Object> map);
	
}
