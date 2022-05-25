package kr.or.workTogether.notice.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.or.workTogether.common.util.ArticlePage;
import kr.or.workTogether.common.util.FileUpload;
import kr.or.workTogether.common.vo.AttachVO;
import kr.or.workTogether.common.vo.BoardVO;
import kr.or.workTogether.common.vo.EmployeeVO;
import kr.or.workTogether.common.vo.NotificationVO;
import kr.or.workTogether.employee.service.EmployeeService;
import kr.or.workTogether.notice.service.NoticeService;
import kr.or.workTogether.notification.service.NotificationService;
import kr.or.workTogether.security.CustomUser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/notice")
@Controller
public class NoticeController {

	private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);

	private static final String atchRelId = null;

	@Autowired
	NoticeService noticeService;
	@Autowired
	FileUpload fileUpload;
    
	@Autowired
	EmployeeService employeeService;
	
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

		List<BoardVO> list = this.noticeService.list(map);

		// 상품분류 별 거래처 목록 행의 수
		int total = this.noticeService.listCount(map);

		model.addAttribute("list", list);
		model.addAttribute("page", new ArticlePage(total, currentPage, size, 5, start, end));
		model.addAttribute("total", total);

		// forwarding
		return "notice/list";
	}

	@GetMapping("/detail")
	public String detail(@RequestParam String brdId, Model model, @RequestParam int currentPage, Authentication auth) {

		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		// userInfo.getEmpId() : EMPL00001
		// boardVO.setBrdWrtr(user.getUsername());
		// model.addAttribute("boardVO", boardVO);

		noticeService.updateViewCnt(brdId);

		BoardVO boardVO = new BoardVO();
		boardVO = this.noticeService.detail(brdId);

//		for (BoardVO boardVO : list) {
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("currentPage", currentPage);
//		}

		// System.err.println("brdId : " + brdId);
		List<AttachVO> fileList = fileUpload.selectFileList(brdId);

		// System.err.println("fileList : " + fileList);
		model.addAttribute("files", fileList);

		// 조회수 증가. 기존의 게시글 자세히 보기에서 추가

		return "notice/detail";
	}

	@GetMapping("/insert") // url 주소
	public String insert(Model model, Authentication auth, BoardVO boardVO) {
//		CustomUser user = (CustomUser) auth.getPrincipal();
//		EmployeeVO userInfo = user.getUser();
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		String empId = userInfo.getEmpId();

		logger.info("user.getUsername() : " + user.getUsername());

		// userInfo.getEmpId() : EMPL00001
		boardVO.setBrdWrtr(user.getUsername());

		logger.info("boardVO : " + boardVO.toString());

		model.addAttribute("boardVO", boardVO);

		return "notice/insert";
	}

	@PostMapping("/insert")
	public String insertPost(@Validated BoardVO boardVO, BindingResult result, Authentication auth, Model model, 
			MultipartFile[] uploadFile) {
//		CustomUser user = (CustomUser) auth.getPrincipal();
//		EmployeeVO userInfo = user.getUser();
		logger.info("uploadFile : " + uploadFile);
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
			return "notice/insert";
		}

		// insert처리
		logger.info("boardVO : " + boardVO.toString());

		int insertResult = noticeService.insert(boardVO);
		logger.info("board insertResult : " + insertResult);
		logger.info("boardVO : " + boardVO.toString());

		if (insertResult > 0) {// 등록 성공
			// 파일 업로드
			uploadFile = boardVO.getUploadFile();
			String path = "notice/" + boardVO.getBrdId();
			String atchRelId = boardVO.getBrdId();
			List<String> insertFileNames = fileUpload.insert(path, uploadFile, atchRelId);

		//	logger.info(insertFileNames.toString());
//			boardVO.setNoticeFile(insertFileNames.get(0));

			// 글 작성 된 페이지로 이동
			model.addAttribute("brdId", boardVO.getBrdId());
			model.addAttribute("currentPage", 1);
			List<EmployeeVO> empList = employeeService.list();
			for(int i=0; i<empList.size(); i++) {
				
				NotificationVO notiVO = new NotificationVO();
				
				notiVO.setNotSender(boardVO.getBrdWrtr()); // 보내는사람ID
				notiVO.setNotReceiver(empList.get(i).getEmpId()); // 받는사람ID
				notiVO.setNotTypeId("공지사항"); // 알림종류 - 'xx 알림이 도착했습니다.' 에서 xx를 의미
				notiVO.setNotCntntId(boardVO.getBrdId()); // 알림해당글PK
				notiVO.setNotMsg("공지사항있습니다. 확인해주세요."); // 알림내용
				
				// 알림글URL - 알림글 URL은 detail 들어갈때의 URL을 적어줄것
				// 예시) /autho/receiveDocDetail?docId=ATDO00001&atrzAprvId=EMPL00001
				String notUrl = "/notice/detail?brdId="+ boardVO.getBrdId()+ "&currentPage=1";
				notiVO.setNotUrl(notUrl);
				
				notiService.insertNoti(notiVO);
			}
						
			return "redirect:/notice/detail";
		} else {// 등록 실패
			// 등록 화면으로 forwarding
			return "notice/insert";
		}
	}

	@GetMapping(value = "/update")
	public String update(Model model, @RequestParam String brdId) {
		// 수정form에 들어가는 데이터 가져오기
		BoardVO boardVO = this.noticeService.detail(brdId);

		model.addAttribute("boardVO", boardVO);
		System.err.println("boardVO : " + boardVO);

		// 수정 전 저장된 기존의 정보 가져오기
		List<AttachVO> fileList = fileUpload.selectFileList(brdId);
		model.addAttribute("files", fileList);
		return "notice/update";
	}

	@PostMapping(value = "/update")
	public String updatePost(@RequestParam(required = false) String atchId, Model model, @RequestParam String brdId,
			@Validated BoardVO boardVO, BindingResult result, AttachVO attachVO, MultipartFile[] uploadFile) {

		logger.info("uploadFile : " + uploadFile);

		if (!atchId.equals("0")) {
			logger.info("fileDelete메소드 실행");
			// 첨부파일 삭제
			fileUpload.fileDelete(atchId);
		}

//		boardVO = new BoardVO();
//		boardVO = this.noticeService.detail(brdId);

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
			return "notice/update";
		}

		// update처리
		logger.info("boardVO : " + boardVO.toString());

		int updateResult = noticeService.update(boardVO);
		logger.info("board insertResult : " + updateResult);

		if (updateResult > 0) {// 등록 성공

			// 파일 업로드
//			MultipartFile[] uploadFile = boardVO.getUploadFile();
			String path = "notice/" + boardVO.getBrdId();
			String atchRelId = boardVO.getBrdId();
			List<String> insertFileNames = fileUpload.insert(path, uploadFile, atchRelId);

			if (!atchId.equals("0")) {
				return "redirect:/notice/update?brdId=" + boardVO.getBrdId();
			} else {
				// 목록으로 이동
				// brdId=BORD00021&currentPage=1

				model.addAttribute("brdId", boardVO.getBrdId());
				model.addAttribute("currentPage", 1);
				return "redirect:/notice/detail";
			}
		} else {// 등록 실패
				// 등록 화면으로 forwarding
			return "redirect:/notice/update?brdId=" + boardVO.getBrdId();
		}

	}

	@GetMapping("/delete")
	public String delete(@RequestParam String brdId) {
		this.noticeService.delete(brdId);

		// 목록으로 이동
		return "redirect:/notice/list";
	}

}
