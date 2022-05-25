package kr.or.workTogether.memo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.workTogether.common.vo.EmployeeVO;
import kr.or.workTogether.common.vo.MemoVO;
import kr.or.workTogether.email.controller.EmailController;
import kr.or.workTogether.memo.service.MemoService;
import kr.or.workTogether.security.CustomUser;

@Controller
@RequestMapping("/memo")
public class MemoController {
	private static final Logger logger = LoggerFactory.getLogger(EmailController.class);

	@Autowired
	MemoService memoService;

	// 메모 작성하기 Get
	@GetMapping("/writeMemo")
	public String getInsertMemo(@ModelAttribute MemoVO memoVO) {
		return "memo/selectMemo";
	}

	// 메모 작성하기 POST
	@PostMapping("/writeMemo")
	public String postInsertMemo(@Validated @ModelAttribute MemoVO memoVO, Authentication auth) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		memoVO.setMemoWrtr(userInfo.getUsername());
		
		memoService.writeMemo(memoVO);

		return "redirect:/memo/selectMemo";

	}
	
	//메모 조회하기
	@RequestMapping("/selectMemo")
	public String selectMemo(@Validated Authentication auth,Model model, @ModelAttribute MemoVO memoVO) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memoWrtr", userInfo.getUsername());
		
		List<MemoVO> list=memoService.selectMemo(map);
		System.out.println("=================================");
		System.out.println(list);
		System.out.println("=================================");

		model.addAttribute("list",list);
		
		return "memo/selectMemo";
	}
	
	//메모 수정하기
	@RequestMapping(value="/updateMemo")
	@ResponseBody
	public String updateMemo(@RequestParam("memoId")String memoId,
			@RequestParam("memoCntnt")String memoCntnt,Authentication auth) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memoWrtr", userInfo.getUsername());
		map.put("memoId",memoId);
		map.put("memoCntnt",memoCntnt);
		
		int result = this.memoService.updateMemo(map);
		String res="fail";
		if (result > 0) {
			res="success";
		}
		return res;
	}
	
	//메모 삭제하기
	@RequestMapping(value="/deleteMemo")
	@ResponseBody
	public String deleteMemo(@RequestParam("memoId") String memoId,
			Authentication auth) {
		
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memoWrtr", userInfo.getUsername());
		map.put("memoId",memoId);
		int result = this.memoService.deleteMemo(map);
		String res="fail";
		if (result > 0) {
			res="success";
		}
		return res;
	}
		
}
