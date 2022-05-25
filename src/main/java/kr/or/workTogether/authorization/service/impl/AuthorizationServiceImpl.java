package kr.or.workTogether.authorization.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.workTogether.authorization.mapper.AuthorizationMapper;
import kr.or.workTogether.authorization.service.AuthorizationService;
import kr.or.workTogether.common.util.FileUpload;
import kr.or.workTogether.common.vo.AtrzDocVO;
import kr.or.workTogether.common.vo.AtrzLineDetailVO;
import kr.or.workTogether.common.vo.AtrzLineVO;
import kr.or.workTogether.common.vo.AtrzVO;
import kr.or.workTogether.common.vo.AttachVO;
import kr.or.workTogether.common.vo.CommonCodeVO;
import kr.or.workTogether.common.vo.DepartmentVO;
import kr.or.workTogether.common.vo.EmployeeVO;
import kr.or.workTogether.security.CustomUser;

@Service
public class AuthorizationServiceImpl implements AuthorizationService {

	@Autowired
	private AuthorizationMapper authoMapper;
	
	@Autowired
	private FileUpload fileUpload;
	
	//조직도 가져오기
	@Override
	public List<DepartmentVO> getTreeList() {
		return authoMapper.getTreeList();
	}
	//문서양식 가져오기
	@Override
	public List<CommonCodeVO> getDocFormList() {
		return authoMapper.getDocFormList();
	}
	//보존연한 가져오기
	@Override
	public List<CommonCodeVO> getDocRetentionList() {
		return authoMapper.getDocRetentionList();
	}
	//결재문서 등록하기
	@Override
	public String insertAtrzDoc(AtrzDocVO atrzDocVO) {
		authoMapper.insertAtrzDoc(atrzDocVO);
		return atrzDocVO.getDocId();
	}
	//결재선 등록하기
	@Override
	public String insertAtrzLine(AtrzLineVO atrzLineVO) {
		authoMapper.insertAtrzLine(atrzLineVO);
		return atrzLineVO.getAtrzLineId();
	}
	//결재선상세 등록하기
	@Override
	public int insertAtrzLineDetail(AtrzLineDetailVO atrzLineDetailVO) {
		return authoMapper.insertAtrzLineDetail(atrzLineDetailVO);
	}
	//임시문서함 가져오기(LIST)
	@Override
	public List<AtrzDocVO> getTempDocList(String docWrtr) {
		return authoMapper.getTempDocList(docWrtr);
	}
	//임시문서 가져오기(DETAIL)
	@Override
	public AtrzDocVO getTempDoc(String docId) {
		return authoMapper.getTempDoc(docId);
	}
	//결재선상세 가져오기(LIST)
	@Override
	public List<AtrzLineDetailVO> getAtrzLineDetailList(String atrzLineId) {
		return authoMapper.getAtrzLineDetailList(atrzLineId);
	}
	//임시문서함의 결재문서 수정하기
	@Override
	public int updateTempDoc(AtrzDocVO atrzDocVO) {
		return authoMapper.updateTempDoc(atrzDocVO);
	}
	//임시문서함의 결재선상세 삭제하기
	@Override
	public int deleteAtrzLineDetail(String atrzLineId) {
		return authoMapper.deleteAtrzLineDetail(atrzLineId);
	}
	//임시문서함의 결재선 삭제하기
	@Override
	public int deleteAtrzLine(String atrzLineId) {
		return authoMapper.deleteAtrzLine(atrzLineId);
	}
	//보낸문서함 가져오기(LIST)
	@Override
	public List<AtrzDocVO> getSendDocList(String docWrtr) {
		return authoMapper.getSendDocList(docWrtr);
	}
	//보낸문서함 가져오기(DETAIL)
	@Override
	public AtrzDocVO getSendDoc(String docId) {
		return authoMapper.getSendDoc(docId);
	}
	//받은문서함 가져오기(LIST)
	@Override
	public List<AtrzDocVO> getReceiveDocList(String docWrtr) {
		return authoMapper.getReceiveDocList(docWrtr);
	}
	//받은문서함 가져오기(DETAIL)
	@Override
	public AtrzDocVO getReceiveDoc(Map<String,Object> map) {
		return authoMapper.getReceiveDoc(map);
	}
	//결재 등록하기
	@Override
	public int insertAtrz(AtrzVO atrzVO) {
		return authoMapper.insertAtrz(atrzVO);
	}
	//첨부파일 가져오기(ONE)
	@Override
	public AttachVO getAttach(String atchRelId) {
		return authoMapper.getAttach(atchRelId);
	}
	//전자결재설정의 전자서명 등록하기
	@Override
	public AttachVO doInsertSign(MultipartFile[] uploadFile, Authentication auth) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		
		String path = "autho/sign/"+userInfo.getUsername();
		String atchRelId = "SIGN"+userInfo.getUsername().substring(4);
		AttachVO attachVO = authoMapper.getAttach(atchRelId);
		//System.err.println("1:"+attachVO);
		if(attachVO != null) {
			authoMapper.deleteAttach(atchRelId);
		}
		fileUpload.insert(path, uploadFile, atchRelId);
		
		
		Map<String,Object> map = new HashMap<>();
		map.put("empSign", atchRelId); 
		map.put("empId", userInfo.getUsername());
		authoMapper.updateEmpSign(map);
		attachVO = authoMapper.getAttach(atchRelId);
		return attachVO;
	}
	//직원 가져오기(ONE)
	@Override
	public EmployeeVO getEmployee(String empId) {
		return authoMapper.getEmployee(empId);
	}
	
	//결재 가져오기(ONE)
	@Override
	public AtrzVO getAtrz(Map<String, Object> map) {
		return authoMapper.getAtrz(map);
	}
	
//	//결재 하기
//	@Override
//	public int doAtrz(AtrzVO atrzVO) {
//		authoMapper.updateAtrzDoc(atrzVO);
//		authoMapper.updateAtrz(atrzVO);
//		
//		return 0;
//	}
	
	//결재하기 - 문서변경(UPDATE)
	@Override
	public int updateAtrzDoc(AtrzVO atrzVO) {
		return authoMapper.updateAtrzDoc(atrzVO);
	}
	
	//결재하기 - 결재변경(UPDATE)
	@Override
	public int updateAtrz(AtrzVO atrzVO) {
		return authoMapper.updateAtrz(atrzVO);
	}
	
	//결재문서의 문서코드 가져오기(ONE)
	@Override
	public String getMaxDocId() {
		return authoMapper.getMaxDocId();
	}
	@Override
	public List<AtrzVO> getNextAtrzList(String docId) {
		return authoMapper.getNextAtrzList(docId);
	}
	
	// 메인 리스트
	@Override
	public List<AtrzDocVO> mainDocList(Map<String, Object> map) {
		return authoMapper.mainDocList(map);
	}
	//메인 리스트 카운트
	@Override
	public int listCount(Map<String, Object> map) {
		return authoMapper.listCount(map);
	}
	

	


}
