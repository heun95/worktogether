package kr.or.workTogether.authorization.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.workTogether.common.vo.AtrzDocVO;
import kr.or.workTogether.common.vo.AtrzLineDetailVO;
import kr.or.workTogether.common.vo.AtrzLineVO;
import kr.or.workTogether.common.vo.AtrzVO;
import kr.or.workTogether.common.vo.AttachVO;
import kr.or.workTogether.common.vo.CommonCodeVO;
import kr.or.workTogether.common.vo.DepartmentVO;
import kr.or.workTogether.common.vo.EmployeeVO;

@Mapper
public interface AuthorizationMapper {
	
	//조직도 조회 : SELECT - LIST
	public List<DepartmentVO> getTreeList();
	
	//문서양식 조회 : SELECT - LIST
	public List<CommonCodeVO> getDocFormList();
	
	//보존연한 조회 : SELECT - LIST
	public List<CommonCodeVO> getDocRetentionList();
	
	//결재문서 등록 : INSERT
	public int insertAtrzDoc(AtrzDocVO atrzDocVO);
	
	//결재선 등록 : ISNERT
	public int insertAtrzLine(AtrzLineVO atrzLineVO);
	
	//결재선상세 등록 : INSERT
	public int insertAtrzLineDetail(AtrzLineDetailVO atrzLineDetailVO);
	
	//임시문서 조회 : SELECT - LIST
	public List<AtrzDocVO> getTempDocList(String docWrtr);
	
	//임시문서 조회 : SELECT - DETAIL
	public AtrzDocVO getTempDoc(String docId);
	
	//결재선상세 조회 : SELECT - LIST
	public List<AtrzLineDetailVO> getAtrzLineDetailList(String atrzLineId);
	
	//임시문서(ALL) 수정 : UPDATE
	public int updateTempDoc(AtrzDocVO atrzDocVO);
	
	//결재선상세 삭제 : DELETE
	public int deleteAtrzLineDetail(String atrzLineId);
	
	//결재선 삭제 : DELETE
	public int deleteAtrzLine(String atrzLineId);
	
	//보낸문서함 조회 : SELECT - LIST
	public List<AtrzDocVO> getSendDocList(String docWrtr);
	
	//보낸문서함 조회 : SELECT - DETAIL
	public AtrzDocVO getSendDoc(String docId);
	
	//받은문서함 조회 : SELECT - LIST
	public List<AtrzDocVO> getReceiveDocList(String docWrtr);
	
	//받은문서함 조회 : SELECT - DETAIL
	public AtrzDocVO getReceiveDoc(Map<String,Object> map);
	
	//결재 등록 : INSERT
	public int insertAtrz(AtrzVO atrzVO);
	
	//첨부파일 조회 : SELECT - ONE
	public AttachVO getAttach(String atchRelId);
	
	//첨부파일 삭제 : DELETE
	public int deleteAttach(String atchRelId);
	
	//직원(전자서명) 수정 : UPDATE
	public int updateEmpSign(Map<String,Object> map);
	
	//직원 조회 : SELECT - ONE
	public EmployeeVO getEmployee(String empId);
	
	//결재 조회 : SELECT - ONE
	public AtrzVO getAtrz(Map<String,Object> map);
	
	//결재문서(문서상태,결재단계,문서수정일자) 수정 : UPDATE
	public int updateAtrzDoc(AtrzVO atrzVO);
	
	//결재(결재결과,전자서명,결재일자) 수정 : UPDATE
	public int updateAtrz(AtrzVO atrzVO);
	
	//결재문서(문서코드+1) 조회
	public String getMaxDocId();
	
	//다음 결재자 리스트
	public List<AtrzVO> getNextAtrzList(String docId);
	
	// 메인화면 리스트
	public List<AtrzDocVO> mainDocList(Map<String, Object> map);
	
	// 메인화면 리스트 카운트
	public int listCount(Map<String, Object> map);
	
}
