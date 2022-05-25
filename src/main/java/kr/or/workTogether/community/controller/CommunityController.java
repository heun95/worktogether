package kr.or.workTogether.community.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.or.workTogether.attach.mapper.AttachMapper;
import kr.or.workTogether.common.util.ArticlePage;
import kr.or.workTogether.common.util.FileUpload;
import kr.or.workTogether.common.vo.AttachVO;
import kr.or.workTogether.common.vo.BoardReplyVO;
import kr.or.workTogether.common.vo.BoardVO;
import kr.or.workTogether.common.vo.EmployeeVO;
import kr.or.workTogether.common.vo.NotificationVO;
import kr.or.workTogether.community.service.CommunityService;
import kr.or.workTogether.notification.service.NotificationService;
import kr.or.workTogether.security.CustomUser;
import lombok.extern.slf4j.Slf4j;
import kr.or.workTogether.common.vo.BoardReplyVO;
@Slf4j
@RequestMapping("/community")
@Controller
public class CommunityController {

	private static final Logger logger = LoggerFactory.getLogger(CommunityController.class);

	private static final String atchRelId = null;
	
	@Autowired
	CommunityService communityService;
	@Autowired
	FileUpload fileUpload;
	@Autowired
	private NotificationService notiService;
	
	// Model에 데이터, 주소, 파일명 등을 담아서 view 로 보내기 위해서
	// 목록 및 페이징
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model, @RequestParam(defaultValue = "1") int currentPage,
			@RequestParam(defaultValue = "5", required = false) int size,
			@RequestParam(required = false) String keyWord) {

		System.out.println(currentPage);
//		Map<String, String> pageHeader = new HashMap<String, String>();
//		pageHeader.put("subtitle", "Customer");
//		pageHeader.put("title", "고객 목록");
//		model.addAttribute("pageHeader", pageHeader);

		int start = currentPage * size - (size - 1);
		int end = currentPage * size;

		// <key,value>
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("size", size);
		map.put("start", start);
		map.put("end", end);
		map.put("keyWord", keyWord);

		List<BoardVO> list = this.communityService.list(map);

		// 상품분류 별 거래처 목록 행의 수
		int total = this.communityService.listCount(map);

		model.addAttribute("list", list);
		model.addAttribute("page", new ArticlePage(total, currentPage, size, 5, start, end));
		model.addAttribute("total", total);

		// forwarding
		return "community/list";
		
	}
	
	@RequestMapping(value = "/list2", method = RequestMethod.GET)
	public String list2(Model model, @RequestParam(defaultValue = "1") int currentPage,
			@RequestParam(defaultValue = "5", required = false) int size,
			@RequestParam(required = false) String keyWord) {
		
		int start = currentPage * size - (size - 1);
		int end = currentPage * size;

		// <key,value>
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("size", size);
		map.put("start", start);
		map.put("end", end);
		map.put("keyWord", keyWord);
		
		List<BoardVO> list2 = this.communityService.list2(map);
		
		// 상품분류 별 거래처 목록 행의 수
		int total = this.communityService.listCount2(map);
		
		model.addAttribute("list2", list2);
		model.addAttribute("page", new ArticlePage(total, currentPage, size, 5, start, end));
		model.addAttribute("total", total);
		
		//forwarding
		return "community/list2";
		
		}
	
	@GetMapping("/insert")
	public String insert(Model model, Authentication auth, BoardVO boardVO) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		
		logger.info("user : " + user.toString());
		
		EmployeeVO userInfo = user.getUser();
		
		logger.info("user.getUsername(): " + user.getUsername());
		
		// userInfo.getEmpId() : EMPL00001
		boardVO.setBrdWrtr(user.getUsername());
				
		logger.info("boardVO : " + boardVO.toString());
		
		model.addAttribute("boardVO", boardVO);
		
		return "community/insert";
		
	}
	
	@PostMapping("/insert")
	public String insertPost(@Validated BoardVO boardVO, BindingResult result, Authentication auth,
			MultipartFile[] uploadFile) {
//		CustomUser user = (CustomUser) auth.getPrincipal();
//		EmployeeVO userInfo = user.getUser();		
		logger.info("uploadFile : "+uploadFile);
	
		//검증 오류 발생
		if(result.hasErrors()) {
			List<ObjectError> allErrors = result.getAllErrors();
			List<ObjectError> globalErrors = result.getGlobalErrors();
			List<FieldError> fieldErrors = result.getFieldErrors();
			// validation 중에 어떤 오류가 나왔는지 확인..
			for (int i = 0; i < allErrors.size(); i++) {
				ObjectError objectError = allErrors.get(i);
				logger.info("objectError : " + objectError);
			}

			for (ObjectError objectError : globalErrors) {
				logger.info("objectError : " + objectError);
			}

			for (FieldError fieldError : fieldErrors) {
				logger.info("fieldError : " + fieldError.getDefaultMessage());
			}

			// redirect(X) => 데이터를 보낼 수 없음
			// forwarding(o)
			return "community/insert";
		}
		
		logger.info("boardVO : " + boardVO.toString());
		
		int insertResult = communityService.insert(boardVO);
		logger.info("board insertResult : " + insertResult);
		logger.info("boardVO : " + boardVO.toString());
		
		if(insertResult > 0) { //등록 성공
			//파일 업로드
			uploadFile = boardVO.getUploadFile();
			String path = "community/" + boardVO.getBrdId();
			String atchRelId = boardVO.getBrdId();
			List<String> insertFileNames = fileUpload.insert(path, uploadFile, atchRelId);
			
//			logger.info(insertFileNames.toString());
			
			// 목록으로 이동
			return "redirect:/community/list";		
		}else { //등록 실패
			//등록 화면으로 forwarding
			return "community/insert";
		}
	
	}
	
	@GetMapping("/insert2")
	public String insert2(Model model, Authentication auth, BoardVO boardVO) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		
		logger.info("user : " + user.toString());
		
		EmployeeVO userInfo = user.getUser();
		
		logger.info("user.getUsername(): " + user.getUsername());
		
		// userInfo.getEmpId() : EMPL00001
		boardVO.setBrdWrtr(user.getUsername());
		
		logger.info("boardVO : " + boardVO.toString());
		
		model.addAttribute("boardVO", boardVO);
		
		return "community/insert2";
		
	}
	
	@PostMapping("/insert2")
	public String insertPost2(@Validated BoardVO boardVO, BindingResult result, Authentication auth,
			MultipartFile[] uploadFile) {
//		CustomUser user = (CustomUser) auth.getPrincipal();
//		EmployeeVO userInfo = user.getUser();		
		logger.info("uploadFile : "+uploadFile);
		
		//검증 오류 발생
		if(result.hasErrors()) {
			List<ObjectError> allErrors = result.getAllErrors();
			List<ObjectError> globalErrors = result.getGlobalErrors();
			List<FieldError> fieldErrors = result.getFieldErrors();
			// validation 중에 어떤 오류가 나왔는지 확인..
			for (int i = 0; i < allErrors.size(); i++) {
				ObjectError objectError = allErrors.get(i);
				logger.info("objectError : " + objectError);
			}
			
			for (ObjectError objectError : globalErrors) {
				logger.info("objectError : " + objectError);
			}
			
			for (FieldError fieldError : fieldErrors) {
				logger.info("fieldError : " + fieldError.getDefaultMessage());
			}
			
			// redirect(X) => 데이터를 보낼 수 없음
			// forwarding(o)
			return "community/insert2";
		}
		
		logger.info("boardVO : " + boardVO.toString());
		
		int insertResult = communityService.insert2(boardVO);
		logger.info("board insertResult : " + insertResult);
		logger.info("boardVO : " + boardVO.toString());
		
		if(insertResult > 0) { //등록 성공
			//파일 업로드
			uploadFile = boardVO.getUploadFile();
			String path = "community/" + boardVO.getBrdId();
			String atchRelId = boardVO.getBrdId();
			List<String> insertFileNames = fileUpload.insert2(path, uploadFile, atchRelId);
			
//			logger.info(insertFileNames.toString());
			
			// 목록으로 이동
			return "redirect:/community/list2";		
		}else { //등록 실패
			//등록 화면으로 forwarding
			return "community/insert2";
		}
		
	}
	
	@GetMapping("/detail")
	public String detail(@RequestParam String brdId, Model model, 
			@RequestParam int currentPage, Authentication auth,
			BoardReplyVO boardReplyVO, BoardVO boardVO) {
		
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
//		boardVO.setBrdWrtr(userInfo.getUsername());
//		model.addAttribute("boardVO", boardVO);
		
		//조회수
		communityService.updateViewCnt(brdId);
		
		boardVO = this.communityService.detail(brdId);
		//System.err.println("중호 : boardVO : "+boardVO);
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("currentPage", currentPage);

		List<AttachVO> fileList = fileUpload.selectFileList(brdId);
		
		model.addAttribute("files", fileList);
		
		//댓글 리스트
		CustomUser ruser = (CustomUser)auth.getPrincipal();
		logger.info("ruser : " + ruser.toString());
		EmployeeVO reserInfo = ruser.getUser();
		logger.info("user.getUsername() : " + ruser.getUsername());
		boardReplyVO.setBrdRplyWrtr(ruser.getUsername());
		model.addAttribute("boardRplyVO", boardReplyVO);
		
		List<BoardReplyVO> rlist = communityService.rlist(boardReplyVO);
		model.addAttribute("rlist", rlist);
		
		logger.info(rlist.toString());
		
		//로그인한 아이디만 수정, 삭제보이기
		String loginName = userInfo.getEmpName();
		model.addAttribute("userName", loginName);
		
		return "community/detail";
		
	}

	@GetMapping(value = "/detail2")
	public String detail2(@RequestParam String brdId, Model model, 
			@RequestParam int currentPage, Authentication auth,
			BoardReplyVO boardReplyVO, BoardVO boardVO) {
		
		//권한 가진 사람 정보 가져오기
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		boardVO.setBrdWrtr(user.getUsername());
		model.addAttribute("boardVO", boardVO);
		
		//조회수
		communityService.updateViewCnt2(brdId);
		
		boardVO = this.communityService.detail2(brdId);
		
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("currentPage", currentPage);
		
		List<AttachVO> fileList = fileUpload.selectFileList(brdId);
		model.addAttribute("files", fileList);
		
		//댓글 리스트
		CustomUser ruser = (CustomUser)auth.getPrincipal();
		logger.info("ruser : " + ruser.toString());
		EmployeeVO reserInfo = ruser.getUser();
		logger.info("user.getUsername() : " + ruser.getUsername());
		boardReplyVO.setBrdRplyWrtr(ruser.getUsername());
		model.addAttribute("boardReplyVO",boardReplyVO);

		List<BoardReplyVO> rlist2 = communityService.rlist2(boardReplyVO);
		model.addAttribute("rlist2", rlist2);
		
		logger.info(rlist2.toString());
		
		//로그인한 아이디만 수정, 삭제보이기
		String loginName = userInfo.getEmpName();
		model.addAttribute("userName", loginName);
		
		return "community/detail2";
		
	}
	
	
	@GetMapping(value = "/update")
	public String update(Model model, @RequestParam String brdId) {
		// 수정form에 들어가는 데이터 가져오기
		BoardVO boardVO = this.communityService.detail(brdId);
		
		model.addAttribute("boardVO", boardVO);
		//System.err.println("boardVO : " + boardVO);
		
		// 수정 전 저장된 기존의 정보 가져오기
		List<AttachVO> fileList = fileUpload.selectFileList(brdId);
		model.addAttribute("files", fileList);
		return "community/update";
	}
	
	@GetMapping(value = "/update2")
	public String update2(Model model, @RequestParam String brdId) {
		// 수정form에 들어가는 데이터 가져오기
		BoardVO boardVO = this.communityService.detail2(brdId);
		
		model.addAttribute("boardVO", boardVO);
		//System.err.println("boardVO : " + boardVO);
		
		// 수정 전 저장된 기존의 정보 가져오기
		List<AttachVO> fileList = fileUpload.selectFileList(brdId);
		model.addAttribute("files", fileList);
		return "community/update2";
	}
	
	@PostMapping(value = "/update")
	public String updatePost(@RequestParam(required = false) String atchId, Model model, @RequestParam String brdId,
			@Validated BoardVO boardVO, BindingResult result, AttachVO attachVO, MultipartFile[] uploadFile) {
		
		//logger.info("uploadFile : "+uploadFile);
		
		if (atchId != null) {
			//logger.info("fileDelete메소드 실행");
			//첨부파일 삭제
			fileUpload.fileDelete(atchId);
		}
		
		// System.err.println("boardVO : "+boardVO);
		model.addAttribute("boardVO", boardVO);
		
		attachVO.setAtchRelId(boardVO.getBrdId());
		
		// 수정 전 저장된 기존의 정보 가져오기
		List<AttachVO> fileList = fileUpload.selectFileList(attachVO.getAtchRelId());
		model.addAttribute("files", fileList);
		
		// 검증 오류 발생
		if (result.hasErrors()) {
			List<ObjectError> allErrors = result.getAllErrors();
			List<ObjectError> globalErrors = result.getGlobalErrors();
			List<FieldError> fieldErrors = result.getFieldErrors();
			// validation 중에 어떤 오류가 나왔는지 확인..
			for (int i = 0; i < allErrors.size(); i++) {
				ObjectError objectError = allErrors.get(i);
				logger.info("objectError : " + objectError);
			}

			for (ObjectError objectError : globalErrors) {
				logger.info("objectError : " + objectError);
			}

			for (FieldError fieldError : fieldErrors) {
				logger.info("fieldError : " + fieldError.getDefaultMessage());
			}
			
		// redirect(X) => 데이터를 보낼 수 없음
		// forwarding(o)
		return "community/update";	
		
		}
		
		//update처리
		logger.info("boardVO : " + boardVO.toString());
		
		int updateResult = communityService.update(boardVO);
		//logger.info("board insertResult : " + updateResult);
		
		if (updateResult > 0) { // 등록 성공
			
			//파일 업로드
//			MultipartFile[] uploadFile = boardVO.getUploadFile();
			String path = "community/" + boardVO.getBrdId();
			String atchRelId = boardVO.getBrdId();
			List<String> insertFileNames = fileUpload.insert(path, uploadFile, atchRelId);
			
				if(atchId != null) {
					return "redirect:/community/update?brdId=" + boardVO.getBrdId();
				
				}else {
					//목록으로 이동
					return "redirect:/community/list";
				}
			
		}else {//등록 실패
				//등록화면으로 forwarding
				return "redirect:/community/update?brdId=" + boardVO.getBrdId();
			}
		}
	
	@PostMapping(value = "/update2")
	public String updatePost2(@RequestParam(required = false) String atchId, Model model, @RequestParam String brdId,
			@Validated BoardVO boardVO, BindingResult result, AttachVO attachVO, MultipartFile[] uploadFile) {
		
		//logger.info("uploadFile : "+uploadFile);
		
		if (atchId != null) {
			//logger.info("fileDelete메소드 실행");
			//첨부파일 삭제
			fileUpload.fileDelete(atchId);
		}
		
		// System.err.println("boardVO : "+boardVO);
		model.addAttribute("boardVO", boardVO);
		
		attachVO.setAtchRelId(boardVO.getBrdId());
		
		// 수정 전 저장된 기존의 정보 가져오기
		List<AttachVO> fileList = fileUpload.selectFileList(attachVO.getAtchRelId());
		model.addAttribute("files", fileList);
		
		// 검증 오류 발생
		if (result.hasErrors()) {
			List<ObjectError> allErrors = result.getAllErrors();
			List<ObjectError> globalErrors = result.getGlobalErrors();
			List<FieldError> fieldErrors = result.getFieldErrors();
			// validation 중에 어떤 오류가 나왔는지 확인..
			for (int i = 0; i < allErrors.size(); i++) {
				ObjectError objectError = allErrors.get(i);
				logger.info("objectError : " + objectError);
			}
			
			for (ObjectError objectError : globalErrors) {
				logger.info("objectError : " + objectError);
			}
			
			for (FieldError fieldError : fieldErrors) {
				logger.info("fieldError : " + fieldError.getDefaultMessage());
			}
			
			// redirect(X) => 데이터를 보낼 수 없음
			// forwarding(o)
			return "community/update2";	
			
		}
		
		//update처리
		logger.info("boardVO : " + boardVO.toString());
		
		int updateResult = communityService.update2(boardVO);
		//logger.info("board insertResult : " + updateResult);
		
		if (updateResult > 0) { // 등록 성공
			
			//파일 업로드
//			MultipartFile[] uploadFile = boardVO.getUploadFile();
			String path = "community/" + boardVO.getBrdId();
			String atchRelId = boardVO.getBrdId();
			List<String> insertFileNames = fileUpload.insert2(path, uploadFile, atchRelId);
			
			if(atchId != null) {
				return "redirect:/community/update2?brdId=" + boardVO.getBrdId();
				
			}else {
				//목록으로 이동
				return "redirect:/community/list2";
			}
			
		}else {//등록 실패
			//등록화면으로 forwarding
			return "redirect:/community/update2?brdId=" + boardVO.getBrdId();
		}
	}
		
	@GetMapping("/delete")
	public String delete(@RequestParam String brdId) {
		this.communityService.delete(brdId);
		
		//목록으로 이동
		return "redirect:/community/list";
	}
	
	@GetMapping("/delete2")
	public String delete2(@RequestParam String brdId) {
		this.communityService.delete2(brdId);
		
		//목록으로 이동
		return "redirect:/community/list2";
	}
		
	@PostMapping("/rinsert")
	public String rinsert(Model model, BoardReplyVO boardReplyVO, @RequestParam String brdId,
			@RequestParam int currentPage, Authentication auth,
			@RequestParam String brdRcvId) {
		//System.err.println("중호 : boardVO :"+brdRcvId);
		
		NotificationVO notiVO = new NotificationVO();
		
		//세션같은 것 : 로그인한 유저 정보 가져오기
		CustomUser user = (CustomUser)auth.getPrincipal();
		logger.info("user : " + user.toString());
		EmployeeVO userInfo = user.getUser();
		logger.info("user.getUsername() : " + user.getUsername());
		boardReplyVO.setBrdRplyWrtr(user.getUsername());
		model.addAttribute("boardRplyVO", boardReplyVO);
		
		//댓글 등록
		communityService.rinsert(boardReplyVO);
		model.addAttribute("boardReplyVO", boardReplyVO);
		
		notiVO.setNotSender(userInfo.getUsername()); //보내는사람ID
		notiVO.setNotReceiver(brdRcvId); //받는사람ID
		notiVO.setNotTypeId("자유게시판댓글"); //알림종류 - 'xx 알림이 도착했습니다.' 에서 xx를 의미
		notiVO.setNotCntntId(brdId); //알림해당글PK
		notiVO.setNotMsg("자유게시판에 댓글이 등록되었습니다."); //알림내용

		//알림글URL - 알림글 URL은 detail 들어갈때의 URL을 적어줄것
		//예시) /autho/receiveDocDetail?docId=ATDO00001&atrzAprvId=EMPL00001
		String notUrl = "/community/detail?brdId="+brdId+"&currentPage=1";
		notiVO.setNotUrl(notUrl); 
		//System.err.println("중호! : "+notiVO);
		notiService.insertNoti(notiVO);
		
		return "redirect:/community/detail?brdId="+brdId+"&currentPage="+currentPage;
		
	}
	
	@PostMapping("/rinsert2")
	public String rinsert2(Model model, BoardReplyVO boardReplyVO, @RequestParam String brdId,
			@RequestParam int currentPage, Authentication auth,
		    @RequestParam String brdRcvId) {
		
		NotificationVO notiVO = new NotificationVO();
		
		//세션같은것: 로그인한 유저 정보 가져오기
		CustomUser user = (CustomUser)auth.getPrincipal();
		logger.info("user:"+user.toString());
		EmployeeVO userInfo = user.getUser();
		logger.info("user.getUsername() : " + user.getUsername());
		boardReplyVO.setBrdRplyWrtr(user.getUsername());
		model.addAttribute("boardRplyVO", boardReplyVO);
		
		//댓글 등록
		communityService.rinsert2(boardReplyVO);
		model.addAttribute("boardReplyVO", boardReplyVO);
		
		notiVO.setNotSender(userInfo.getUsername()); //보내는사람ID
		notiVO.setNotReceiver(brdRcvId); //받는사람ID
		notiVO.setNotTypeId("익명게시판댓글"); //알림종류 - 'xx 알림이 도착했습니다.' 에서 xx를 의미
		notiVO.setNotCntntId(brdId); //알림해당글PK
		notiVO.setNotMsg("익명게시판에 댓글이 등록되었습니다."); //알림내용
		
		//알림글URL - 알림글 URL은 detail 들어갈때의 URL을 적어줄것
		//예시) /autho/receiveDocDetail?docId=ATDO00001&atrzAprvId=EMPL00001
		String notUrl = "/community/detail2?brdId="+brdId+"&currentPage=1";
		notiVO.setNotUrl(notUrl); 

		notiService.insertNoti(notiVO);
		
		return "redirect:/community/detail2?brdId="+brdId+"&currentPage="+currentPage;
		
	}
	
	@GetMapping("/rupdate")
	public String rupdate(Model model, BoardReplyVO boardReplyVO, @RequestParam String brdId,
			@RequestParam String brdRplyId, @RequestParam int currentPage) {
		
		logger.info("boardReplyVO : " + boardReplyVO.toString());
		
		int updateResult = communityService.rupdate(boardReplyVO);
		logger.info("board updateResult : " + updateResult);
		
		if(updateResult > 0) { //등록 성공
			//목록으로 이동
			return "redirect:/community/detail?brdId=" + brdId + "&currentPage=" + currentPage;
			
		}else { //등록 실패
			//등록 화면으로 forwarding
			return "community?detail?brdId=" + brdId + "&currentPage=" + currentPage;
		}
		
	}
	
	@GetMapping("/rupdate2")
	public String rupdate2(Model model, BoardReplyVO boardReplyVO, @RequestParam String brdId,
			@RequestParam String brdRplyId, @RequestParam int currentPage) {
		
		logger.info("boardReplyVO : " + boardReplyVO.toString());
		
		int updateResult = communityService.rupdate2(boardReplyVO);
		logger.info("board updateResult : " + updateResult);
		
		if(updateResult > 0) { //등록 성공
			//목록으로 이동
			return "redirect:/community/detail2?brdId=" + brdId + "&currentPage=" + currentPage;
			
		}else { //등록 실패
			//등록 화면으로 forwarding
			return "community?detail2?brdId=" + brdId + "&currentPage=" + currentPage;
		}
		
	}
	
	@PostMapping(value = "/rupdate")
	public String rupdatePost(BoardReplyVO boardReplyVO, BindingResult result, @RequestParam String brdId,
			@RequestParam int currentPage) {
		logger.info("boardReplyVO : " + boardReplyVO.toString());
		
		int updateResult = communityService.rupdate(boardReplyVO);
		logger.info("board updateResult : " + updateResult);
		
		if(updateResult > 0) { //수정 성공
			//목록으로 이동
			return "redirect:/community/detail?brdId=" + brdId + "&currentPage=" + currentPage;
		}else { //수정 실패
			// 등록 화면으로 forwarding
			return "community/detail?brdId=" + brdId + "&currentPage=" + currentPage;
		}
	}
	
	@PostMapping(value = "/rupdate2")
	public String rupdatePost2(BoardReplyVO boardReplyVO, BindingResult result, @RequestParam String brdId,
			@RequestParam int currentPage) {
		logger.info("boardReplyVO : " + boardReplyVO.toString());
		
		int updateResult = communityService.rupdate2(boardReplyVO);
		logger.info("board updateResult : " + updateResult);
		
		if(updateResult > 0) { //수정 성공
			//목록으로 이동
			return "redirect:/community/detail2?brdId=" + brdId + "&currentPage=" + currentPage;
		}else { //수정 실패
			// 등록 화면으로 forwarding
			return "community/detail2?brdId=" + brdId + "&currentPage=" + currentPage;
		}
	}
	
	//수정하기 위해서는 기존의 댓글을 가져와야하기 때문에 rdetail이 필요함!! 수정과 세트로 알아둘것!!
	@GetMapping("/rdetail")
	public String rdetail(Model model, BoardReplyVO boardReplyVO, @RequestParam String brdId,
			@RequestParam String brdRplyId, @RequestParam int currentPage, Authentication auth) {
		
		//댓글 상세 정보 가져오기
		boardReplyVO = this.communityService.rdetail(brdRplyId);
		model.addAttribute("boardReplyVO", boardReplyVO);
		return "community/detail?brdId=" + brdId + "&currentPage=" + currentPage;
		
	}
	
	//수정하기 위해서는 기존의 댓글을 가져와야하기 때문에 rdetail이 필요함!! 수정과 세트로 알아둘것!!
	@GetMapping("/rdetail2")
	public String rdetail2(Model model, BoardReplyVO boardReplyVO, @RequestParam String brdId,
			@RequestParam String brdRplyId, @RequestParam int currentPage, Authentication auth) {
		
		//댓글 상세 정보 가져오기
		boardReplyVO = this.communityService.rdetail2(brdRplyId);
		model.addAttribute("boardReplyVO", boardReplyVO);
		return "community/detail2?brdId=" + brdId + "&currentPage=" + currentPage;
		
	}
	
	@GetMapping("/rdelete")
	public String rdelete(@RequestParam String brdRplyId, @RequestParam String brdId,
			@RequestParam int currentPage) {
		this.communityService.rdelete(brdRplyId);
		
		//목록으로 이동
		return "redirect:/community/detail?brdId=" +brdId+"&currentPage=" + currentPage;
		
	}
	
	@GetMapping("/rdelete2")
	public String rdelete2(@RequestParam String brdRplyId, @RequestParam String brdId,
			@RequestParam int currentPage) {
		this.communityService.rdelete2(brdRplyId);
		
		//목록으로 이동
		return "redirect:/community/detail2?brdId=" +brdId+"&currentPage=" + currentPage;
		
	}
	
	
}
