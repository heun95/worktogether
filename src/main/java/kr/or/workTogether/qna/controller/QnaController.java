package kr.or.workTogether.qna.controller;

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

import kr.or.workTogether.common.util.ArticlePage;
import kr.or.workTogether.common.vo.BoardReplyVO;
import kr.or.workTogether.common.vo.BoardVO;
import kr.or.workTogether.common.vo.EmployeeVO;
import kr.or.workTogether.qna.service.QnaService;
import kr.or.workTogether.security.CustomUser;

@RequestMapping("/qna")
@Controller
public class QnaController {

	
	
	private static final Logger log = LoggerFactory.getLogger(QnaController.class);

	@Autowired
	QnaService qnaService;

	// Model에 데이터, 주소, 파일명 등을 담아서 view 로 보내기 위해서
	// 목록 및 페이징
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model, @RequestParam(defaultValue = "1") int currentPage,
			@RequestParam(defaultValue = "5", required = false) int size,
			@RequestParam(required = false) String keyWord) {

		// System.out.println(currentPage);
		int start = currentPage * size - (size - 1);
		int end = currentPage * size;

		// <key,value>
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("size", size);
		map.put("start", start);
		map.put("end", end);
		map.put("keyWord", keyWord);

		List<BoardVO> list = this.qnaService.list(map);

		// 상품분류 별 거래처 목록 행의 수
		int total = this.qnaService.listCount(map);

		model.addAttribute("list", list);
		model.addAttribute("page", new ArticlePage(total, currentPage, size, 5, start, end));
		model.addAttribute("total", total);

		// forwarding
		return "qna/list";
	}

	@GetMapping("/detail")
	public String detail(@RequestParam String brdId, Model model, @RequestParam int currentPage,
			BoardReplyVO boardReplyVO, Authentication auth, BoardVO boardVO) {
		
		CustomUser user = (CustomUser)auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		boardVO.setBrdWrtr(user.getUsername());
		model.addAttribute("boardVO", boardVO);
		
		qnaService.updateViewCnt(brdId);

		boardVO = this.qnaService.detail(brdId);

		model.addAttribute("boardVO", boardVO);
		model.addAttribute("currentPage", currentPage);

		// 댓글 리스트
		CustomUser ruser = (CustomUser)auth.getPrincipal();
		log.info("ruser : " + ruser.toString());
		EmployeeVO ruserInfo = ruser.getUser();
		log.info("user.getUsername() : " + ruser.getUsername());
		boardReplyVO.setBrdRplyWrtr(ruser.getUsername());
		model.addAttribute("boardRplyVO", boardReplyVO);
		
		List<BoardReplyVO> rlist = qnaService.rlist(boardReplyVO);
		model.addAttribute("rlist", rlist);

		log.info(rlist.toString());

		// 로그인한 아이디만 수정,삭제보이기
		String loginName = userInfo.getEmpName();
		model.addAttribute("userName", loginName);
		
		// 조회수 증가. 기존의 게시글 자세히 보기에서 추가

		return "qna/detail";
	}

	@PostMapping("/rinsert")
	public String rinsert(Model model, BoardReplyVO boardReplyVO, @RequestParam String brdId,
			@RequestParam int currentPage, Authentication auth) {

		CustomUser user = (CustomUser)auth.getPrincipal();
		log.info("user : " + user.toString());
		EmployeeVO userInfo = user.getUser();
		log.info("user.getUsername() : " + user.getUsername());
		boardReplyVO.setBrdRplyWrtr(user.getUsername());
		model.addAttribute("boardRplyVO", boardReplyVO);
		
		// 댓글 등록
		qnaService.rinsert(boardReplyVO);
		model.addAttribute("boardReplyVO", boardReplyVO);
		// System.err.println("brdId:"+brdId+"currentPage:"+currentPage);
		return "redirect:/qna/detail?brdId=" + brdId + "&currentPage=" + currentPage;
	}

	@GetMapping("/rdetail")
	public String rdetail(Model model, BoardReplyVO boardReplyVO, @RequestParam String brdId,
			@RequestParam String brdRplyId, @RequestParam int currentPage, Authentication auth) {

//		CustomUser user = (CustomUser)auth.getPrincipal();
//		EmployeeVO userInfo = user.getUser();
//		boardReplyVO.setBrdRplyWrtr(user.getUsername());
//		model.addAttribute("boardReplyVO", boardReplyVO);
		
		// 댓글 상세 정보가져오기
		boardReplyVO = this.qnaService.rdetail(brdRplyId);
		model.addAttribute("boardReplyVO", boardReplyVO);
		return "qna/detail?brdId=" + brdId + "&currentPage=" + currentPage;
	}

	@GetMapping("/rupdate")
	public String rupdate(Model model, BoardReplyVO boardReplyVO, @RequestParam String brdId,
			@RequestParam String brdRplyId, @RequestParam int currentPage) {

		log.info("boardReplyVO : " + boardReplyVO.toString());

		int updateResult = qnaService.rupdate(boardReplyVO);
		log.info("board updateResult : " + updateResult);

		if (updateResult > 0) {// 등록 성공

			// 목록으로 이동
			return "redirect:/qna/detail?brdId=" + brdId + "&currentPage=" + currentPage;
		} else {// 등록 실패
				// 등록 화면으로 forwarding
			return "qna/detail?brdId=" + brdId + "&currentPage=" + currentPage;
		}
		// 댓글 수정
//		qnaService.rupdate(boardReplyVO);
//		model.addAttribute("boardReplyVO", boardReplyVO);
//		return "redirect:/qna/detail?brdId=" + brdId + "&currentPage=" + currentPage;
	}

	@PostMapping(value = "/rupdate")
	public String rupdatePost( BoardReplyVO boardReplyVO, BindingResult result, @RequestParam String brdId,
			@RequestParam int currentPage) {

		log.info("boardReplyVO : " + boardReplyVO.toString());

		int updateResult = qnaService.rupdate(boardReplyVO);
		log.info("board updateResult : " + updateResult);

		if (updateResult > 0) {// 등록 성공

			// 목록으로 이동
			return "redirect:/qna/detail?brdId=" + brdId + "&currentPage=" + currentPage;
		} else {// 등록 실패
				// 등록 화면으로 forwarding
			return "qna/detail?brdId=" + brdId + "&currentPage=" + currentPage;
		}

	}

	@GetMapping("/rdelete")
	public String rdelete(@RequestParam String brdRplyId, @RequestParam String brdId, @RequestParam int currentPage) {
		this.qnaService.rdelete(brdRplyId);

		// 목록으로 이동
		return "redirect:/qna/detail?brdId=" + brdId + "&currentPage=" + currentPage;
	}

	@GetMapping("/insert") // url 주소
	public String insert(Model model, Authentication auth, BoardVO boardVO) {
		
		CustomUser user = (CustomUser)auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		boardVO.setBrdWrtr(user.getUsername());
		model.addAttribute("boardVO", boardVO);

		return "qna/insert";
	}

	@PostMapping("/insert")
	public String insertPost(@Validated BoardVO boardVO, BindingResult result, Authentication auth) {

		// 검증 오류 발생
		if (result.hasErrors()) {
			List<ObjectError> allErrors = result.getAllErrors();
			List<ObjectError> globalErrors = result.getGlobalErrors();
			List<FieldError> fieldErrors = result.getFieldErrors();
			// validation 중에 어떤 오류가 나왔는지 확인..
			for (int i = 0; i < allErrors.size(); i++) {
				ObjectError objectError = allErrors.get(i);
				log.info("objectError : " + objectError);
			}

			for (ObjectError objectError : globalErrors) {
				log.info("objectError : " + objectError);
			}

			for (FieldError fieldError : fieldErrors) {
				log.info("fieldError : " + fieldError.getDefaultMessage());
			}

			// redirect(X) => 데이터를 보낼 수 없음
			// forwarding(o)
			return "qna/insert";
		}

		// insert처리
		log.info("boardVO : " + boardVO.toString());

		int insertResult = qnaService.insert(boardVO);
		log.info("board insertResult : " + insertResult);

		if (insertResult > 0) {// 등록 성공
			// 목록으로 이동
			return "redirect:/qna/list";
		} else {// 등록 실패
				// 등록 화면으로 forwarding
			return "qna/insert";
		}

	}

	@GetMapping(value = "/update")
	public String update(Model model, @RequestParam String brdId) {
		// 수정form에 들어가 데이터 가져오기
		BoardVO boardVO = this.qnaService.detail(brdId);

		model.addAttribute("boardVO", boardVO);

		return "qna/update";
	}

	@PostMapping(value = "/update")
	public String updatePost(@Validated BoardVO boardVO, BindingResult result) {

		// 검증 오류 발생
		if (result.hasErrors()) {
			List<ObjectError> allErrors = result.getAllErrors();
			List<ObjectError> globalErrors = result.getGlobalErrors();
			List<FieldError> fieldErrors = result.getFieldErrors();
			// validation 중에 어떤 오류가 나왔는지 확인..
			for (int i = 0; i < allErrors.size(); i++) {
				ObjectError objectError = allErrors.get(i);
				log.info("objectError : " + objectError);
			}

			for (ObjectError objectError : globalErrors) {
				log.info("objectError : " + objectError);
			}

			for (FieldError fieldError : fieldErrors) {
				log.info("fieldError : " + fieldError.getDefaultMessage());
			}

			// redirect(X) => 데이터를 보낼 수 없음
			// forwarding(o)
			return "qna/update";
		}

		// update처리
		log.info("boardVO : " + boardVO.toString());

		int updateResult = qnaService.update(boardVO);
		log.info("board insertResult : " + updateResult);

		if (updateResult > 0) {// 등록 성공

			// 목록으로 이동
			return "redirect:/qna/list";
		} else {// 등록 실패
				// 등록 화면으로 forwarding
			return "qna/update";
		}

	}

	@GetMapping("/delete")
	public String delete(@RequestParam String brdId) {
		this.qnaService.delete(brdId);

		// 목록으로 이동
		return "redirect:/qna/list";
	}

}
