package kr.or.workTogether.humanresource.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.workTogether.common.util.ArticlePage;
import kr.or.workTogether.common.util.FileUpload;
import kr.or.workTogether.common.vo.AttachVO;
import kr.or.workTogether.common.vo.CrtfcAplictVO;
import kr.or.workTogether.common.vo.EmployeeVO;
import kr.or.workTogether.humanresource.service.HumanresourceService;
import kr.or.workTogether.security.CustomUser;

@RequestMapping("/human")
@Controller
public class HumanresourceController {
	private static final Logger logger = LoggerFactory.getLogger(HumanresourceController.class);

	@Autowired
	HumanresourceService humanresourceService;
	@Autowired
	FileUpload fileUpload;

	//직원 리스트
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model, @RequestParam(defaultValue = "1") int currentPage,
			@RequestParam(defaultValue = "10", required = false) int size,
			@RequestParam(required = false) String keyWord, 
			@RequestParam(defaultValue = "") String pos, 
			@RequestParam(defaultValue = "") String dep) {

		int start = currentPage * size - (size - 1);
		int end = currentPage * size;

		// <key,value>
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("size", size);
		map.put("start", start);
		map.put("end", end);
		map.put("keyWord", keyWord);
		map.put("pos", pos);
		map.put("dep", dep);
		
		logger.info("keyword : " + keyWord);
		logger.info("pos : " + pos);
		logger.info("dep : " + dep);

		List<EmployeeVO> list = this.humanresourceService.list(map);

		// 상품분류 별 거래처 목록 행의 수
		int total = this.humanresourceService.listCount(map);
		logger.info("emp Listcount : " + total);

		model.addAttribute("list", list);
		model.addAttribute("page", new ArticlePage(total, currentPage, size, 5, start, end));
		model.addAttribute("total", total);
		if(pos != "") {
			model.addAttribute("pos", pos);
		}
		if(dep != "") {
			model.addAttribute("dep", dep);
		}
		// forwarding
		return "human/list";
	}
	
	
	
	//증명서 리스트(자신것만)
	@RequestMapping(value = "/certilist", method=RequestMethod.GET)
	public String certilist(Model model, @RequestParam(defaultValue = "1") int currentPage,
			@RequestParam(defaultValue = "10", required = false) int size,
			@RequestParam(required = false) String keyWord) {
		
		int start = currentPage * size - (size - 1);
		int end = currentPage * size;
		
		//<key, value>
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("size", size);
		map.put("start", start);
		map.put("end", end);
		map.put("keyWord", keyWord);
		
		List<CrtfcAplictVO> list2 = this.humanresourceService.list2(map);
		
		//증명서 목록 행의 수
		int total = this.humanresourceService.listCount2(map);
		logger.info("crt Listcount : " + total);
		
		model.addAttribute("list2", list2);
		model.addAttribute("page" , new ArticlePage(total, currentPage, size, 5, start, end));
		model.addAttribute("total", total);
		
		return "human/certilist";
		
	}
		
	// 직원 등록
	@GetMapping("/insertemp")
	public String insertmap(Model model, EmployeeVO employeeVO) {
		// String employee = humanresourceService.insertemp(employee);

		// forwarding
		return "human/insertemp";
	}

	@PostMapping("/insertemp")
	@ResponseBody
	public String insertPost(@Validated EmployeeVO employeeVO, BindingResult result) {
		logger.info("왔다1");
		// 검증 오류 발생
		if (result.hasErrors()) {
			logger.info("왔다2");
			
			List<ObjectError> allErrors = result.getAllErrors();
			List<ObjectError> globalErrors = result.getGlobalErrors();
			
			for(int i=0;i<allErrors.size();i++) {
				ObjectError objectError = allErrors.get(i);
				logger.info("allError = " + objectError);
			}
			
			// redirect(X) => 데이터를 보낼 수 없음
			// forwarding(o)
			return "human/insertemp";
		}
		logger.info("왔다3");
		// 주소 = 우편번호 + 주소 + 상세주소
		// empAddr = postno + addr + detAddr
		// String insertAddrs = employeeVO.getPostno() + " " + employeeVO.getAddr() + "
		// " + employeeVO.getDetAddr();

		// employeeVO.setEmpAddr(insertAddrs);

		// insert처리
		logger.info("EmployeeVO 전 : " + employeeVO.toString());
		int insertResult = humanresourceService.insertemp(employeeVO);
		logger.info("EmployeeVO 후 : " + employeeVO.toString());
		
		
		Map<String, Object> authMap = new HashMap<String,Object>();
		authMap.put("empId", employeeVO.getEmpId());
		authMap.put("auth", "ROLE_MEMBER");
		humanresourceService.insertEmpAuth(authMap);
		
		//권한부여
		if(employeeVO.getEmpPosition().equals("H205") || employeeVO.getEmpPosition().equals("H206") || employeeVO.getEmpPosition().equals("H207")) {
			Map<String, Object> authMap2 = new HashMap<String,Object>();
			authMap2.put("empId", employeeVO.getEmpId());
			authMap2.put("auth", "ROLE_BUJANG");
			humanresourceService.insertEmpAuth(authMap2);
		}
		
		// 파일 업로드
		MultipartFile[] uploadFile = employeeVO.getUploadFile();

		String path = "empl/" + employeeVO.getEmpId();

		String atchRelId = employeeVO.getEmpId();

		if (uploadFile != null) {
			logger.info("check2721: " + path );
			logger.info("check2722: " + uploadFile );
			logger.info("check2723: " + atchRelId );
			List<String> insertFileNames = fileUpload.insert(path, uploadFile, atchRelId);
		}

//		
//		employeeVO.setEmpPhoto(insertFileNames.get(0));
//		

		if (insertResult > 0) { // 고객 등록 성공
			// 목록으로 이동
			//return "redirect:/human/list";
			return "success";
		} else {// 고객 등록 실패
				// 등록 화면으로 forwarding
			//return "human/insertemp";
			return "fail";
		}
	}
	
	//신청 등록
	@GetMapping("/insertcertificate")
	public String insertcertificate(Model model, CrtfcAplictVO crtfcAplictVO) {
		// String employee = humanresourceService.insertemp(employee);

		// forwarding
		return "human/insertcertificate";
	}

	@PostMapping("/insertcertificate")
	public String insertcertPost( CrtfcAplictVO crtfcAplictVO,
			BindingResult result, Authentication auth) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();
		
		logger.info("loginuser : " + userInfo);
		// 검증 오류 발생
		if (result.hasErrors()) {

			// redirect(X) => 데이터를 보낼 수 없음
			// forwarding(o)
			logger.info("-------------- hasErrors");
			return "human/insertcertificate";
		}
		
		crtfcAplictVO.setCrtfcAplctEmpId(userInfo.getUsername());
		
		logger.info("CrtfcAplictVO => " + crtfcAplictVO);
		int insertcertResult = humanresourceService.insertcert(crtfcAplictVO);
		
		logger.info(insertcertResult+" <--------------" );
		if(insertcertResult>0) {//고객 등록 성공
			return "redirect:/human/insertcertificate";
		}else {//고객 등록 실패
			return "human/insertcertificate";
		}
		
	}
	
	
	/// employee/detail?cusNum=1
	// 고객 상세 정보
	@GetMapping("/detail")
	public String detail(Model model, @RequestParam String empId, @ModelAttribute EmployeeVO employeeVO) {

		employeeVO = this.humanresourceService.detail(empId);
		logger.info("경로:" + employeeVO.getAtchPath());
		//System.err.println("임플로이브이오: "+employeeVO);
		model.addAttribute("employeeVO", employeeVO);

		// forwarding
		return "human/detail";
	}

	@PostMapping("/detail")
	public String postDetail() {
		// System.out.println("디테일");
		return "redirect:/human/detail";
	}

	// 게시글 수정
	@PostMapping(value = "/update")
	public String update(EmployeeVO employeeVO, AttachVO attachVO) {
		System.out.println("수정");

		int updateResult1 = humanresourceService.update1(employeeVO);
		
		int updateResult2 = humanresourceService.update2(attachVO);

		if (updateResult1 > 0 ) {// 등록 성공
			logger.info("된것!!");
			return "redirect:/human/detail?empId=" + employeeVO.getEmpId();
		} else { // 등록 실패
			logger.info("안된것!!");
			return "human/detail?empId=" + employeeVO.getEmpId();

		}
	}

	// 게시판 삭제
	@PostMapping(value = "/delete")
	public String delete(EmployeeVO employeeVO) {

		System.out.println("삭제");
		System.out.println(employeeVO.getEmpId());
		int deleteResult = humanresourceService.delete(employeeVO.getEmpId());
		System.out.println(deleteResult);

		if (deleteResult > 0) {
			return "redirect:/human/list";
		} else {
			return "human/list";
		}

	}

}
