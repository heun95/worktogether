package kr.or.workTogether.authorization.controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

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
import kr.or.workTogether.common.vo.NotificationVO;
import kr.or.workTogether.common.vo.ScheduleVO;
import kr.or.workTogether.notification.service.NotificationService;
import kr.or.workTogether.security.CustomUser;

@RequestMapping("/autho")
@Controller
public class AuthorizationController {
	
	private static final Logger logger = LoggerFactory.getLogger(AuthorizationController.class);

	@Autowired
	private AuthorizationService authoService;
	@Autowired
	private NotificationService notiService;
	@Autowired
	FileUpload fileUpload;
	
	
	//전자결재 - 메인페이지(PAGE)
	@GetMapping("/main")
	public String mainPage(Model model, Authentication auth, @ModelAttribute ScheduleVO scheduleVO) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		String userId = userInfo.getUsername();
		
		List<AtrzDocVO> receiveDocList = authoService.getReceiveDocList(userId);
		model.addAttribute("receiveDocList", receiveDocList);
		model.addAttribute("userInfo",userInfo);
		
		List<AtrzDocVO> sendDocList = authoService.getSendDocList(userId);
		model.addAttribute("sendDocList", sendDocList);
		
		System.err.println("\n/autho/main(GET), 넘긴 데이터");
		logger.info("receiveDocList : " + receiveDocList);
		logger.info("sendDocList : " + sendDocList);
		logger.info("userInfo : " + userInfo);
		
		return "autho/main";
	}
	
	//전자결재 - 작성하기(PAGE)
	@GetMapping("/create")
	public String createPage(Model model, @ModelAttribute AtrzDocVO atrzDocVO) {
		//문서양식 리스트
		List<CommonCodeVO> docFormList = authoService.getDocFormList();
		Map<String, Object> docFormMap = new HashMap<String, Object>();
		Map<String, Object> docContentMap = new HashMap<String, Object>();
		
		for(CommonCodeVO vo : docFormList) {
			docFormMap.put(vo.getCmmnId(), vo.getCmmnGroupName());
			docContentMap.put(vo.getCmmnId(), vo.getCmmnClob());
		}
		model.addAttribute("docForm", docFormMap);
		model.addAttribute("docContent", docContentMap);
		
		//보존연한 리스트
		List<CommonCodeVO> docRetentionList = authoService.getDocRetentionList();
		Map<String, Object> docRetentionMap = new HashMap<String, Object>();
		for(CommonCodeVO vo : docRetentionList) {
			docRetentionMap.put(vo.getCmmnId(), vo.getCmmnGroupName());
		}
		model.addAttribute("docRetention", docRetentionMap);
		
		
		List<DepartmentVO> tList = authoService.getTreeList();
		model.addAttribute("tList",tList);
		
		System.err.println("\n/autho/create(GET), 받아온 데이터 ");
		logger.info("docForm : "+docFormMap);
		logger.info("docContent : "+docContentMap);
		logger.info("docRetention : "+docRetentionMap);
		logger.info("tList : "+tList);
		
		return "autho/create";
	}
	
	//전자결재 - 작성하기(CREATE)
	@PostMapping("/create")
	public String create(Model model, 
						 @ModelAttribute AtrzDocVO atrzDocVO, 
						 @RequestParam String atrzAprv, 
						 @RequestParam String atrzLineDetailId,
						 @RequestParam String atrzLineDetailPositionName,
						 @RequestParam String atrzLineDetailDeptName,
						 Authentication auth) throws IOException {
		
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		
		System.err.println("\n/autho/create(POST), 받아온 데이터");
		logger.info("atrzDocVO : "+atrzDocVO);
		logger.info("atrzAprv : "+atrzAprv);
		logger.info("atrzLineDetailId : "+atrzLineDetailId);
		logger.info("atrzLineDetailPositionName : "+atrzLineDetailPositionName);
		logger.info("atrzLineDetailDeptName : "+atrzLineDetailDeptName);
		//System.err.println("uploadFile : "+uploadFile);
		
		//결재선(Name) 처리
		atrzAprv = atrzAprv.replaceAll(",,", ",").replaceAll(",,",",");
		if(atrzAprv.lastIndexOf(",")==atrzAprv.length()-1) {
			atrzAprv = atrzAprv.substring(0,atrzAprv.length()-1);
		}
		String[] atrzLineDetailNameList = atrzAprv.split(",");
		
		//결재선(Id) 처리
		atrzLineDetailId = atrzLineDetailId.replaceAll(",,", ",").replaceAll(",,",",");
		if(atrzLineDetailId.lastIndexOf(",")==atrzLineDetailId.length()-1) {
			atrzLineDetailId = atrzLineDetailId.substring(0,atrzLineDetailId.length()-1);
		}
		String[] atrzLineDetailIdList  = atrzLineDetailId.split(",");
		
		//결재선(Position) 처리
		atrzLineDetailPositionName = atrzLineDetailPositionName.replaceAll(",,", ",").replaceAll(",,",",");
		if(atrzLineDetailPositionName.lastIndexOf(",")==atrzLineDetailPositionName.length()-1) {
			atrzLineDetailPositionName = atrzLineDetailPositionName.substring(0,atrzLineDetailPositionName.length()-1);
		}
		String[] atrzLineDetailPositionNameList  = atrzLineDetailPositionName.split(",");
		
		//결재선(DeptName) 처리
		atrzLineDetailDeptName = atrzLineDetailDeptName.replaceAll(",,", ",").replaceAll(",,",",");
		if(atrzLineDetailDeptName.lastIndexOf(",")==atrzLineDetailDeptName.length()-1) {
			atrzLineDetailDeptName = atrzLineDetailDeptName.substring(0,atrzLineDetailDeptName.length()-1);
		}
		String[] atrzLineDetailDeptNameList  = atrzLineDetailDeptName.split(",");
		
		//결재선(AtrzDocLine) 등록
		AtrzLineVO atrzLineVO = new AtrzLineVO();
		atrzLineVO.setAtrzLineName("결재선명");
		atrzLineVO.setAtrzAprvId(atrzDocVO.getDocWrtr());
		atrzLineVO.setAtrzLineStr(atrzAprv);
		String atrzLineId = authoService.insertAtrzLine(atrzLineVO);
	
		//결재문서(AtrzDoc) 등록
		atrzDocVO.setAtrzLineStr(atrzAprv);
		atrzDocVO.setAtrzLineId(atrzLineId);
		System.err.println("아아아악 : "+atrzDocVO);
		String atrzDocId = authoService.insertAtrzDoc(atrzDocVO);
		
		//결재선상세(AtrzDocLineDetail) 등록
		for(int i=0; i<atrzLineDetailNameList.length; i++) {
			AtrzLineDetailVO atrzLineDetailVO = new AtrzLineDetailVO();
			atrzLineDetailVO.setAtrzLineId(atrzLineId);
			atrzLineDetailVO.setAtrzLineLevel((i+1));
			atrzLineDetailVO.setAtrzAprvId(atrzLineDetailIdList[i]);
			atrzLineDetailVO.setAtrzName(atrzLineDetailNameList[i]);
			atrzLineDetailVO.setPositionName(atrzLineDetailPositionNameList[i]);
			atrzLineDetailVO.setDeptName(atrzLineDetailDeptNameList[i]);
			int result3 = authoService.insertAtrzLineDetail(atrzLineDetailVO);
		}
		
		if(atrzDocVO.getDocState().equals("대기중")) {
			for(int i=0; i<atrzLineDetailNameList.length; i++) {
				AtrzVO atrzVO = new AtrzVO();
				atrzVO.setDocId(atrzDocId);
				atrzVO.setAtrzLevel(atrzLineDetailNameList.length-i);
				atrzVO.setAtrzTypeId("대기중");
				atrzVO.setAtrzWrtDt(new Date());
				atrzVO.setAtrzAprvId(atrzLineDetailIdList[i]);
				//EmployeeVO empVO = authoService.getEmployee(atrzLineDetailIdList[i]);
				atrzVO.setAtrzSign("SIGN00000");
				authoService.insertAtrz(atrzVO);
//!@#!$%#@!%#@!%!@#!$%#@!%#@!%!@#!$%#@!%#@!%!@#!$%#@!%#@!%!@#!$%#@!%#@!%!@#!$%#@!%#@!%!@#!$%#@!%#@!%!@#!$%#@!%#@!%
				
				if((atrzLineDetailNameList.length-i) == 1) {
					NotificationVO notiVO = new NotificationVO();
					notiVO.setNotSender(userInfo.getUsername()); //보내는사람ID
					notiVO.setNotReceiver(atrzLineDetailIdList[i]); //받는사람ID
					notiVO.setNotTypeId("결재요청"); //알림종류 - 알림종류는 '일반,긴급' 중 하나 선택
					notiVO.setNotCntntId(atrzDocId); //알림해당글PK
					notiVO.setNotMsg("결재 요청이 왔습니다."); //알림내용
					String notUrl = "/autho/receiveDocDetail?docId="+atrzDocId+"&atrzAprvId="+atrzLineDetailIdList[i];
					notiVO.setNotUrl(notUrl); //알림글URL - 알림글 URL은 detail 들어갈때의 URL을 적어줄것
					//예시) /autho/receiveDocDetail?docId=ATDO00001&atrzAprvId=EMPL00001
					notiService.insertNoti(notiVO);
				}
				
				
//!@#!$%#@!%#@!%!@#!$%#@!%#@!%!@#!$%#@!%#@!%!@#!$%#@!%#@!%!@#!$%#@!%#@!%!@#!$%#@!%#@!%!@#!$%#@!%#@!%!@#!$%#@!%#@!%
			}
			
			try {
				Thread.sleep(4000);
			}catch(Exception e) {
				System.out.println(e);
			}
			
			return "redirect:/autho/sendDocDetail?docId="+atrzDocId+"&selectB=B";
		}
		
		return "redirect:/autho/tempDoc";
	}
	
	//조직도(LIST)
	@ResponseBody
	@GetMapping("/treeList")
	public List<DepartmentVO> treeListGet(Model model, @ModelAttribute DepartmentVO departVO){
		List<DepartmentVO> treeList = authoService.getTreeList();
		System.err.println("\n/autho/treeList(GET,ajax), 넘긴 데이터");
		logger.info("treeList : "+treeList);
		
		return treeList;
	}

	
	//전자결재 - 임시문서(LIST)
	@GetMapping("/tempDoc")
	public String tempDoc(Model model, Authentication auth) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		
		String docWrtr = userInfo.getUsername();
		List<AtrzDocVO> atrzDocList = authoService.getTempDocList(docWrtr);
		model.addAttribute("atrzDocList", atrzDocList);
		System.err.println("\n/autho/tempDoc(GET), 넘긴 데이터");
		logger.info("atrzDocList : "+atrzDocList);
		
		return "autho/tempDoc";
	}
	
	//전자결재 - 임시문서(DETAIL)
	@GetMapping("/tempDocDetail")
	public String tempDocDetail(Model model, @ModelAttribute AtrzDocVO atrzDocVO, @RequestParam String docId) {
		System.err.println("\n/autho/tempDocDetail(GET), 받아온 데이터");
		logger.info("docId : "+docId);
		
		//임시문서(ONE)
		atrzDocVO = authoService.getTempDoc(docId);
		model.addAttribute("atrzDocVO", atrzDocVO);
		
		//문서양식 리스트
		List<CommonCodeVO> docFormList = authoService.getDocFormList();
		Map<String, Object> docFormMap = new HashMap<String, Object>();
		Map<String, Object> docContentMap = new HashMap<String, Object>();
		
		for(CommonCodeVO vo : docFormList) {
			docFormMap.put(vo.getCmmnId(), vo.getCmmnGroupName());
			docContentMap.put(vo.getCmmnId(), vo.getCmmnClob());
		}
		model.addAttribute("docForm", docFormMap);
		model.addAttribute("docContent", docContentMap);
		
		//보존연한 리스트
		List<CommonCodeVO> docRetentionList = authoService.getDocRetentionList();
		Map<String, Object> docRetentionMap = new HashMap<String, Object>();
		for(CommonCodeVO vo : docRetentionList) {
			docRetentionMap.put(vo.getCmmnId(), vo.getCmmnGroupName());
		}
		model.addAttribute("docRetention", docRetentionMap);
		
		
		List<DepartmentVO> tList = authoService.getTreeList();
		model.addAttribute("tList",tList);
		model.addAttribute("docId",docId);
		System.err.println("\n/autho/tempDocDetail(GET), 보낸 데이터");
		logger.info("atrzDocVO : "+atrzDocVO);
		logger.info("docForm : "+docFormMap);
		logger.info("docContent : "+docContentMap);
		logger.info("docRetention : "+docRetentionMap);
		logger.info("tList : "+tList);
		
		return "autho/tempDocDetail";
	}
	
	//전자결재 - 임시문서(UPDATE)
	@PostMapping("/tempDocUpdate")
	public String tempDocUpdate(Model model, 
								@ModelAttribute AtrzDocVO atrzDocVO, 
								@RequestParam String docId,
								@RequestParam String atrzName, 
								@RequestParam String atrzLineDetailId,
								@RequestParam String atrzLineDetailPositionName,
								@RequestParam String atrzLineDetailDeptName,
								Authentication auth) throws IOException {
		
		CustomUser user = (CustomUser)auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		
		System.err.println("\n/autho/tempDocUpdate(POST), 받아온 데이터");
		logger.info("atrzDocVO : "+atrzDocVO);
		logger.info("atrzName : "+atrzName);
		logger.info("atrzLineDetailId : "+atrzLineDetailId);
		logger.info("atrzLineDetailPositionName : "+atrzLineDetailPositionName);
		logger.info("atrzLineDetailDeptName : "+atrzLineDetailDeptName);
		
		AtrzDocVO temp_atrzDocVO = authoService.getTempDoc(docId);
		String deleteAtrzLineId = temp_atrzDocVO.getAtrzLineId();
		
		
		//결재선(Name) 처리
		atrzName = atrzName.replaceAll(",,", ",").replaceAll(",,",",");
		if(atrzName.lastIndexOf(",")==atrzName.length()-1) {
			atrzName = atrzName.substring(0,atrzName.length()-1);
		}
		String[] atrzLineDetailNameList = atrzName.split(",");
		
		//결재선(Id) 처리
		atrzLineDetailId = atrzLineDetailId.replaceAll(",,", ",").replaceAll(",,",",");
		if(atrzLineDetailId.lastIndexOf(",")==atrzLineDetailId.length()-1) {
			atrzLineDetailId = atrzLineDetailId.substring(0,atrzLineDetailId.length()-1);
		}
		String[] atrzLineDetailIdList  = atrzLineDetailId.split(",");
		
		//결재선(Position) 처리
		atrzLineDetailPositionName = atrzLineDetailPositionName.replaceAll(",,", ",").replaceAll(",,",",");
		if(atrzLineDetailPositionName.lastIndexOf(",")==atrzLineDetailPositionName.length()-1) {
			atrzLineDetailPositionName = atrzLineDetailPositionName.substring(0,atrzLineDetailPositionName.length()-1);
		}
		String[] atrzLineDetailPositionNameList  = atrzLineDetailPositionName.split(",");
		
		//결재선(DeptName) 처리
		atrzLineDetailDeptName = atrzLineDetailDeptName.replaceAll(",,", ",").replaceAll(",,",",");
		if(atrzLineDetailDeptName.lastIndexOf(",")==atrzLineDetailDeptName.length()-1) {
			atrzLineDetailDeptName = atrzLineDetailDeptName.substring(0,atrzLineDetailDeptName.length()-1);
		}
		String[] atrzLineDetailDeptNameList  = atrzLineDetailDeptName.split(",");
		
		//결재선(AtrzDocLine) 등록
		AtrzLineVO atrzLineVO = new AtrzLineVO();
		atrzLineVO.setAtrzLineName("결재선명");
		atrzLineVO.setAtrzAprvId(atrzDocVO.getDocWrtr());
		atrzLineVO.setAtrzLineStr(atrzName);
		String atrzLineId = authoService.insertAtrzLine(atrzLineVO);

		//결재선상세(AtrzDocLineDetail) 등록
		for(int i=0; i<atrzLineDetailNameList.length; i++) {
			AtrzLineDetailVO atrzLineDetailVO = new AtrzLineDetailVO();
			atrzLineDetailVO.setAtrzLineId(atrzLineId);
			atrzLineDetailVO.setAtrzLineLevel((i+1));
			atrzLineDetailVO.setAtrzAprvId(atrzLineDetailIdList[i]);
			atrzLineDetailVO.setAtrzName(atrzLineDetailNameList[i]);
			atrzLineDetailVO.setPositionName(atrzLineDetailPositionNameList[i]);
			atrzLineDetailVO.setDeptName(atrzLineDetailDeptNameList[i]);
			authoService.insertAtrzLineDetail(atrzLineDetailVO);
		}
		
		//결재문서(AtrzDoc) 등록
		atrzDocVO.setAtrzLineStr(atrzName);
		atrzDocVO.setAtrzLineId(atrzLineId);
		authoService.updateTempDoc(atrzDocVO);

		//결재선상세(AtrzLineDetail) 삭제
		authoService.deleteAtrzLineDetail(deleteAtrzLineId);
		
		//결재선(AtrzLine) 삭제
		authoService.deleteAtrzLine(deleteAtrzLineId);
		
		if(atrzDocVO.getDocState().equals("대기중")) {
			for(int i=0; i<atrzLineDetailNameList.length; i++) {
				AtrzVO atrzVO = new AtrzVO();
				atrzVO.setDocId(docId);
				atrzVO.setAtrzLevel(atrzLineDetailNameList.length-i);
				atrzVO.setAtrzTypeId("대기중");
				atrzVO.setAtrzWrtDt(new Date());
				atrzVO.setAtrzAprvId(atrzLineDetailIdList[i]);
				//EmployeeVO empVO = authoService.getEmployee(atrzLineDetailIdList[i]);
				atrzVO.setAtrzSign("SIGN00000");
				authoService.insertAtrz(atrzVO);
				
				if((atrzLineDetailNameList.length-i) == 1) {
					NotificationVO notiVO = new NotificationVO();
					notiVO.setNotSender(userInfo.getUsername()); //보내는사람ID
					notiVO.setNotReceiver(atrzLineDetailIdList[i]); //받는사람ID
					notiVO.setNotTypeId("결재요청"); //알림종류 - 알림종류는 '일반,긴급' 중 하나 선택
					notiVO.setNotCntntId(docId); //알림해당글PK
					notiVO.setNotMsg("결재 요청이 왔습니다."); //알림내용
					String notUrl = "/autho/receiveDocDetail?docId="+docId+"&atrzAprvId="+atrzLineDetailIdList[i];
					notiVO.setNotUrl(notUrl); //알림글URL - 알림글 URL은 detail 들어갈때의 URL을 적어줄것
					//예시) /autho/receiveDocDetail?docId=ATDO00001&atrzAprvId=EMPL00001
					notiService.insertNoti(notiVO);
				}
			}
			return "redirect:/autho/tempDoc";
		}else {
			
			try {
				Thread.sleep(4000);
			}catch(Exception e) {
				System.out.println(e);
			}
			
			return "redirect:/autho/tempDocDetail?docId="+atrzDocVO.getDocId();
		}
	}
	
	//전자결재 - 보낸결재함(LIST)
	@GetMapping("/sendDoc")
	public String sendDoc(Model model, Authentication auth) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		String docWrtr = userInfo.getUsername();
		
		Map<String,Object> map = new HashMap<>();
		map.put("docWrtr", docWrtr);
		
		List<AtrzDocVO> sendDocList = authoService.getSendDocList(docWrtr);
		model.addAttribute("sendDocList", sendDocList);
		System.err.println("\n/autho/sendDoc(GET), 넘긴 데이터");
		logger.info("sendDocList : " + sendDocList);
		
		return "autho/sendDoc";
	}
	
	//전자결재 - 보낸결재함(DETAIL)
	@GetMapping("/sendDocDetail")
	public String sendDocDetail(Model model, @ModelAttribute AtrzDocVO atrzDocVO, @RequestParam String docId) {
		System.err.println("\n/autho/sendDocDetail(GET), 받아온 데이터");
		logger.info("docId : " + docId);
		atrzDocVO = authoService.getSendDoc(docId);
		
		model.addAttribute("atrzDocVO",atrzDocVO);
		
		List<AtrzLineDetailVO> atrzLineDetailList = atrzDocVO.getAtrzLineDetailList();
		List<String> atrzPathList = new ArrayList<>();
		System.out.println("atrzLineDetailList : "+atrzLineDetailList);
		
		for(AtrzLineDetailVO vo : atrzLineDetailList) {
			String temp_id = vo.getAtrzAprvId();
			//String empSign = authoService.getEmployee(temp_id).getEmpSign();
			Map<String,Object> atrzMap = new HashMap<>();
			atrzMap.put("docId", docId);
			atrzMap.put("atrzAprvId",temp_id);
			AtrzVO aprzVO = authoService.getAtrz(atrzMap);
			
			String aprzSign = aprzVO.getAtrzSign();
			//System.err.println("aprzSign : "+aprzSign);
			
			AttachVO attachVO = authoService.getAttach(aprzSign);
			//System.err.println("attachVO : "+attachVO);
			
			String atchPath = attachVO.getAtchPath();
			//System.err.println("atchPath : "+atchPath);
			
			atrzPathList.add(atchPath);
		}
		model.addAttribute("atrzPathList",atrzPathList);
		
		
		System.err.println("\n/autho/sendDocDetail(GET), 보낸 데이터");
		logger.info("atrzDocVO : " + atrzDocVO);
		return "autho/sendDocDetail";
	}
	
	//전자결재 - 받은결재함(LIST)
	@GetMapping("/receiveDoc")
	public String receiveDoc(Model model, Authentication auth) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		String docWrtr = userInfo.getUsername();
		
		List<AtrzDocVO> receiveDocList = authoService.getReceiveDocList(docWrtr);
		model.addAttribute("receiveDocList", receiveDocList);
		model.addAttribute("userInfo",userInfo);
		
		System.err.println("\n/autho/receiveDoc(GET), 넘긴 데이터");
		logger.info("receiveDocList : " + receiveDocList);
		logger.info("userInfo : " + userInfo);
		
		return "autho/receiveDoc";
	}
	
	//전자결재 - 받은결재함(DETAIL)
	@GetMapping("/receiveDocDetail")
	public String receiveDocDetail(Model model, @ModelAttribute AtrzDocVO atrzDocVO, @ModelAttribute AtrzVO atrzVO, @RequestParam String docId, @RequestParam String atrzAprvId) {
		System.err.println("\n/autho/receiveDocDetail(GET), 받아온 데이터");
		logger.info("docId : " + docId);
		logger.info("atrzAprvId : " + atrzAprvId);
		//atrzAprvId = 로그인유저
		Map<String,Object> map = new HashMap<>();
		map.put("docId", docId);
		map.put("atrzAprvId", atrzAprvId);
		
		//AtrzDocVO atrzDocVO = new AtrzDocVO();
		
		atrzDocVO = authoService.getReceiveDoc(map);
		
		List<AtrzLineDetailVO> atrzLineDetailList = atrzDocVO.getAtrzLineDetailList();
		List<String> atrzPathList = new ArrayList<>();
		
		for(AtrzLineDetailVO vo : atrzLineDetailList) {
			String temp_id = vo.getAtrzAprvId();
			//String empSign = authoService.getEmployee(temp_id).getEmpSign();
			Map<String,Object> atrzMap = new HashMap<>();
			atrzMap.put("docId", docId);
			atrzMap.put("atrzAprvId",temp_id);
			AtrzVO aprzVO = authoService.getAtrz(atrzMap);
			String aprzSign = aprzVO.getAtrzSign();
			//System.err.println("aprzVO : "+aprzVO);
			//System.err.println("aprzSign : "+aprzSign);
			//System.err.println("authoService.getAttach(aprzSign) : "+authoService.getAttach(aprzSign));
			
			String atchPath = authoService.getAttach(aprzSign).getAtchPath();
			//System.err.println("atchPath : "+atchPath);
			atrzPathList.add(atchPath);
		}
		model.addAttribute("atrzPathList",atrzPathList);
		 
		model.addAttribute("atrzDocVO",atrzDocVO);
		
		String loginSign = authoService.getEmployee(atrzAprvId).getEmpSign();
		model.addAttribute("loginSign",loginSign);

		Map<String,Object> atrzMap = new HashMap<>();
		atrzMap.put("docId",docId);
		atrzMap.put("atrzAprvId", atrzAprvId);
		
		String loginAtrzTypeId = authoService.getAtrz(atrzMap).getAtrzTypeId(); 
		
		model.addAttribute("loginAtrzTypeId",loginAtrzTypeId);
		
		System.err.println("\n/autho/receiveDocDetail(GET), 보낸 데이터");
		logger.info("atrzDocVO : " + atrzDocVO);
		return "autho/receiveDocDetail";
	}

	//전자결재 - 받은결재함(결재완료)
	@PostMapping("/receiveDocSuccess")
	public String receiveDocSuccess(Model model, @ModelAttribute AtrzVO atrzVO, Authentication auth, @RequestParam String docWriter) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		System.err.println("\n/autho/receiveDocSuccess(POST), 받아온 데이터");
		logger.info("atrzVO : " + atrzVO);
		
		List<AtrzVO> atrzList = authoService.getNextAtrzList(atrzVO.getDocId());
		
		atrzVO.setAtrzAprvId(userInfo.getUsername());
		if(atrzVO.getAtrzTypeId().equals("승인")) {
			atrzVO.setAtrzSign("SIGN"+userInfo.getUsername().substring(4));
			authoService.updateAtrz(atrzVO);
			
			atrzList = authoService.getNextAtrzList(atrzVO.getDocId());
			//System.err.println("@@@atrzList : "+atrzList);
			if(atrzList.size() != 0) {
				NotificationVO notiVO = new NotificationVO();
				notiVO.setNotSender(userInfo.getUsername()); //보내는사람ID
				notiVO.setNotReceiver(atrzList.get(0).getAtrzAprvId()); //받는사람ID
				notiVO.setNotTypeId("결재요청"); //알림종류 - 'xx 알림이 도착했습니다.' 에서 xx를 의미 
				notiVO.setNotCntntId(atrzVO.getDocId()); //알림해당글PK
				notiVO.setNotMsg("결재 요청이 왔습니다."); //알림내용
				String notUrl = "/autho/receiveDocDetail?docId="+atrzVO.getDocId()+"&atrzAprvId="+atrzList.get(0).getAtrzAprvId();
				notiVO.setNotUrl(notUrl); //알림글URL - 알림글 URL은 detail 들어갈때의 URL을 적어줄것
				//예시) /autho/receiveDocDetail?docId=ATDO00001&atrzAprvId=EMPL00001
				notiService.insertNoti(notiVO);
				//System.err.println("@@@notiVO : "+notiVO );
			}
			
		}
		else if(atrzVO.getAtrzTypeId().equals("반려")) {
			AtrzVO tempAtrzVO = atrzVO;
			atrzVO.setAtrzSign("SIGN99999");
			authoService.updateAtrz(atrzVO);
			for(int i=1; i<atrzList.size(); i++) {
				tempAtrzVO.setAtrzAprvId(atrzList.get(i).getAtrzAprvId());
				tempAtrzVO.setAtrzSign("SIGN00000");
				authoService.updateAtrz(tempAtrzVO);
			}
			
		
			NotificationVO notiVO = new NotificationVO();
			notiVO.setNotSender(userInfo.getUsername()); //보내는사람ID
			notiVO.setNotReceiver(docWriter); //받는사람ID
			notiVO.setNotTypeId("결재 반려"); //알림종류 - 'xx 알림이 도착했습니다.' 에서 xx를 의미 
			notiVO.setNotCntntId(atrzVO.getDocId()); //알림해당글PK
			notiVO.setNotMsg("결재가 반려되었습니다."); //알림내용
			String notUrl = "/autho/sendDocDetail?docId="+atrzVO.getDocId();
			notiVO.setNotUrl(notUrl); //알림글URL - 알림글 URL은 detail 들어갈때의 URL을 적어줄것
			//예시) /autho/receiveDocDetail?docId=ATDO00001&atrzAprvId=EMPL00001
			notiService.insertNoti(notiVO);
			//System.err.println("@@@notiVO : "+notiVO );
			
			
		}
		
		authoService.updateAtrzDoc(atrzVO);
		System.err.println("@@@atrzVO: "+atrzVO);
		return "redirect:/autho/receiveDocDetail?docId="+atrzVO.getDocId()+"&atrzAprvId="+userInfo.getUsername();
	}
	
	//전자결재 - 전자결재 설정(PAGE)
	@GetMapping("/setting")
	public String setting(Model model, Authentication auth) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		String empSign = authoService.getEmployee(userInfo.getUsername()).getEmpSign();
		
		//System.err.println("@@"+userInfo.getEmpName());
		//System.err.println("!!"+empSign);
		AttachVO attachVO = authoService.getAttach(empSign);
		
		model.addAttribute("attachVO",attachVO);
		
		
		System.err.println("\n/autho/setting(GET), 보낸 데이터");
		logger.info("attachVO : " + attachVO);
		return "autho/setting";
	}
	
	//전자결재 - 전자결재 설정의 싸인 등록(INSERT)
	@PostMapping("/signInsert")
	public String signInsert(Model model, @RequestParam MultipartFile[] uploadFile, Authentication auth) {
		System.err.println("\n/autho/signInsert(POST), 받아온 데이터");
		logger.info("MultipartFile[0] : " + uploadFile[0].getOriginalFilename());
	
		authoService.doInsertSign(uploadFile, auth);
		try {
			Thread.sleep(4000);
		}catch(Exception e) {
			System.out.println(e);
		}
		model.addAttribute("settingA", "A");
		return "redirect:/autho/setting";
	}
	
	//전자결재 - 문서내용 이미지화
	@ResponseBody
	@PostMapping("/docCntntImg")
	public String ImgSaveTest(Model model,
								@RequestParam Map<Object, Object> param, 
								final HttpServletRequest request, 
								final HttpServletResponse response) throws Exception {
		String binaryData = request.getParameter("imgSrc");
		String docId = request.getParameter("docId");
		//System.err.println("docId : "+docId);
		String docContentPath = null;
		String fileName = null;
		FileOutputStream stream = null;
		try{
			if(binaryData == null || binaryData.trim().equals("")) {
				throw new Exception();
			}
			binaryData = binaryData.replaceAll("data:image/png;base64,", "");
			byte[] file = Base64.decodeBase64(binaryData);
			
			
			if(docId != null) {
				fileName = docId;
			}else {
				fileName = authoService.getMaxDocId();
			}
			//System.err.println(fileName);
			String uploadFolder = "D:/A_TeachingMaterial/7.LastProject/workspace/workTogether/src/main/webapp/resources/upload/autho/content/";
			docContentPath = uploadFolder+fileName+".png";
			stream = new FileOutputStream(docContentPath);
			stream.write(file);
			stream.close();
			//System.out.println("캡처 저장");
		}catch(Exception e){
			e.printStackTrace();
			//System.out.println("에러 발생");
		}finally{
			if(stream != null) {
				stream.close();
			}
		}
		return "/resources/upload/autho/content/"+fileName+".png";
	}
	
	//!@#!#@!#@!#@!#@!#@!#@!#@!#!@#!@
//	@ResponseBody
//	@PostMapping("/docCntntImg")
//	public ModelMap ImgSaveTest(@RequestParam HashMap<Object, Object> param, final HttpServletRequest request, final HttpServletResponse response) throws Exception {
//		ModelMap map = new ModelMap();
//		System.err.println("param : "+param);
//		String binaryData = request.getParameter("imgSrc");
//		FileOutputStream stream = null;
//		try{
//			System.out.println("binary file   "  + binaryData);
//			if(binaryData == null || binaryData.trim().equals("")) {
//			    throw new Exception();
//			}
//			binaryData = binaryData.replaceAll("data:image/png;base64,", "");
//			byte[] file = Base64.decodeBase64(binaryData);
//			String fileName=  UUID.randomUUID().toString();
//			
//			stream = new FileOutputStream("d:/test2/"+fileName+".png");
//			stream.write(file);
//			stream.close();
//			System.out.println("캡처 저장");
//		    
//		}catch(Exception e){
//			e.printStackTrace();
//			System.out.println("에러 발생");
//		}finally{
//			if(stream != null) {
//				stream.close();
//			}
//		}
//		
//		map.addAttribute("resultMap", "");
//		return map;
//	}
	//!@#!#@!#@!#@!#@!#@!#@!#@!#!@#!@
	
	
	
}








