package kr.or.workTogether.project.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.workTogether.common.util.ArticlePage;
import kr.or.workTogether.common.vo.AttachVO;
import kr.or.workTogether.common.vo.CalendarVO;
import kr.or.workTogether.common.vo.EmployeeVO;
import kr.or.workTogether.common.vo.GanttChartVO;
import kr.or.workTogether.common.vo.NotificationVO;
import kr.or.workTogether.common.vo.ProjMemVO;
import kr.or.workTogether.common.vo.ProjWorkReplyVO;
import kr.or.workTogether.common.vo.ProjWorkVO;
import kr.or.workTogether.common.vo.ProjectVO;
import kr.or.workTogether.notification.service.NotificationService;
import kr.or.workTogether.project.service.ProjectService;
import kr.or.workTogether.security.CustomUser;

@Controller
@RequestMapping("/project")
public class ProjectController {
	Logger logger = LoggerFactory.getLogger(ProjectController.class);

	@Autowired
	private ProjectService projectService;
	@Autowired
	private NotificationService notiService;

	@GetMapping("")
	public String main(Model model, @ModelAttribute ProjectVO projectVO, @ModelAttribute ProjWorkVO projWorkVO,
			@ModelAttribute ProjWorkReplyVO projWorkReplyVO, Authentication auth) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		EmployeeVO userInfo = user.getUser();

		String empId = userInfo.getUsername();
//		logger.info("loginuser : " + empId);

		List<ProjectVO> projList = projectService.projList(empId);

		Map<String, Object> map = new HashMap<>();

		map.put("empId", empId);
		map.put("division", "give");
		List<ProjWorkVO> giveWorkList = projectService.workHomeList(map);
		map.remove("division");
		map.put("division", "get");
		List<ProjWorkVO> getWorkList = projectService.workHomeList(map);
		map.remove("division");
		map.put("division", "issue");
		List<ProjWorkVO> issueWorkList = projectService.workHomeList(map);

		model.addAttribute("list", projList);
		model.addAttribute("giveWorkList", giveWorkList);
		model.addAttribute("getWorkList", getWorkList);
		model.addAttribute("issueWorkList", issueWorkList);

		// forwarding
		return "project/main";
	}

	@PostMapping("/mainWorkList")
	@ResponseBody
	public Map<String, Object> mainWorkList(Model model, @ModelAttribute ProjWorkVO projWorkVO,
			@RequestBody Map<String, Object> map) {

		logger.info("map" + map);

		logger.info("*mainWorkList");

		List<ProjWorkVO> workList = projectService.workHomeList(map);

		logger.info("workList : " + workList.size());
		int total = projectService.listCount(map);
		int currentPage = (int) map.get("currentPage");
		int size = (int) map.get("size");
		int start = (int) map.get("start");
		int end = (int) map.get("end");

		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("workList", workList);
		resultMap.put("page", new ArticlePage(total, currentPage, size, 5, start, end));
		resultMap.put("total", total);

		return resultMap;

	}
	
	@GetMapping("/projInsert")
	public String getProjInsert(ProjectVO projectVO) {
		
		return "project/nolayout/insertProj";
	}

	@PostMapping("/projInsert")
	public String postProjInsert(ProjectVO projectVO, ProjWorkVO projWorkVO, ProjWorkReplyVO projWorkReplyVO) {

		logger.info(projectVO.toString());
		int projInsert = projectService.projInsert(projectVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("projId", projectVO.getProjId());
		map.put("projMemList", projectVO.getProjMemList());
		logger.info(map.toString());
		projectService.projMemInsert(map);
		
		return "redirect:/project";
	}
	
	@PostMapping("/projMemInsert")
	@ResponseBody
	public int projMemInsert(String projId, String empId) {
		
		Map<String, Object> map = new HashMap<>();
		List<String> projMemList = new ArrayList<>();
		projMemList.add(empId);
		
		map.put("projId", projId);
		map.put("projMemList", projMemList);
		int projMemInsert = projectService.projMemInsert(map);
		
		return projMemInsert;
	}

	@GetMapping("/home")
	public String home(Model model, @RequestParam String projId, @ModelAttribute ProjWorkVO projWorkVO,
			@ModelAttribute ProjWorkReplyVO projWorkReplyVO, HttpSession session) {
//		logger.info(projId);

		Map<String, Object> map = new HashMap<>();
		map.put("projId", projId);
		map.put("empId", "EMPL00004");

		ProjectVO projVO = projectService.projDetail(projId);
		List<EmployeeVO> memberList = projectService.memberList(projId);
		List<ProjWorkVO> workList = projectService.workList(map);
		Map<String, Object> projChart = projectService.projChart(projId);

//		logger.info("home() projChart : "+projChart.toString());
//		logger.info("home() projVO : "+projVO.toString());
		logger.info("home() memberList : " + memberList.toString());
//		logger.info("home() workList : "+workList.toString());

		session.setAttribute("projId", projId);
		session.setAttribute("projName", projVO.getProjName());

		model.addAttribute("memlist", memberList);
		model.addAttribute("workList", workList);
		model.addAttribute("projVO", projVO);

		// forwarding
		return "project/home";
	}

	@GetMapping("/projChart")
	@ResponseBody
	public Map<String, Object> projChart(@RequestParam String projId) {

		return projectService.projChart(projId);

	}

	@PostMapping("/workCountDate")
	@ResponseBody
	public List<Map<String, String>> workCountDate(@RequestBody Map<String, Object> paramMap) {
		logger.info("paramMap : " + paramMap.toString());

		Map<String, Object> map = new HashMap<>();
		map.put("projId", paramMap.get("projId"));
		map.put("memList", paramMap.get("memList"));

		List<Map<String, String>> workCountDate = projectService.workCountDate(map);
		logger.info("workCountDate : " + workCountDate.toString());

		return workCountDate;

	}

	@GetMapping("/work")
	public String work(Model model
			, HttpSession session
			, @ModelAttribute ProjWorkVO projWorkVO
			, @ModelAttribute ProjWorkReplyVO projWorkReplyVO
			, @RequestParam(required = false) String projId) {

		List<EmployeeVO> memberList = projectService.memberList(projId);
		logger.info("work() memberList : " + memberList.toString());

		model.addAttribute("memList", memberList);
		session.setAttribute("projName", projectService.projName(projId));
		
		return "project/work";
	}

	@GetMapping("/calendar")
	public String calendar(Model model, @ModelAttribute ProjWorkVO projWorkVO, ProjWorkReplyVO projWorkReplyVO) {

		return "project/calendar";
	}

	@GetMapping("/caldata")
	@ResponseBody
	public List<CalendarVO> caldata(Model model, @RequestParam String projId) {
		List<CalendarVO> calendarList = projectService.calendarList(projId);
		logger.info("calendarList : " + calendarList.toString());

		return calendarList;
	}

	@GetMapping("/ganttchart")
	public String ganttchart(Model model, @ModelAttribute ProjWorkVO projWorkVO,
			@ModelAttribute ProjWorkReplyVO projWorkReplyVO) {

		return "project/ganttchart";
	}

	@GetMapping("/ganttdata")
	@ResponseBody
	public List<GanttChartVO> ganttdata(Model model, @RequestParam String projId) {
		List<GanttChartVO> gantList = projectService.gantList(projId);
		logger.info("gantList : " + gantList.toString());

		return gantList;
	}

	@GetMapping("/file")
	public String file(Model model, @RequestParam String projId) {
		List<AttachVO> fileList = projectService.fileList(projId);

		model.addAttribute("fileList", fileList);

		return "project/file";
	}

	@PostMapping("/workList")
	@ResponseBody
	public Map<String, Object> workSelect(Model model, @ModelAttribute ProjWorkVO projWorkVO,
			@RequestBody Map<String, Object> map) {

		logger.info("map" + map);
		logger.info("select");
		logger.info(projWorkVO.toString());
		logger.info(map.get("projId") + " " + map.get("division") + " " + map.get("empId"));
		logger.info(map.get("wkStateList").toString());
		logger.info(map.get("priorityList").toString());

		List<ProjWorkVO> workList = projectService.workList(map);

		logger.info("workList : " + workList.size());
		int total = projectService.listCount(map);
		int currentPage = (int) map.get("currentPage");
		int size = (int) map.get("size");
		int start = (int) map.get("start");
		int end = (int) map.get("end");

		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("workList", workList);
		resultMap.put("page", new ArticlePage(total, currentPage, size, 5, start, end));
		resultMap.put("total", total);

		return resultMap;

	}

	@PostMapping("/insertWork")
	public String insertWork(Model model, ProjWorkVO projWorkVO, BindingResult result) throws Exception {
		logger.info("insertWork() : " + projWorkVO.toString());

		int insertWork = projectService.insertWork(projWorkVO);

		NotificationVO notiVO = new NotificationVO();

		List<String> workMngrList = projWorkVO.getWorkMngrId();
		logger.info("workMngrList" + workMngrList);
		if( workMngrList.size() > 0) {
			for (String mngrId : workMngrList) {
				logger.info("projWorkVO.getWorkState()" + projWorkVO.getWorkState());
				if (projWorkVO.getWorkState().equals("이슈")) {
					notiVO.setNotTypeId("이슈"); // 알림종류 - 'xx 알림이 도착했습니다.' 에서 xx를 의미
					notiVO.setNotMsg("이슈 알림이 도착했습니다."); // 알림내용
				}
				if (projWorkVO.getWorkState().equals("요청")) {
					notiVO.setNotTypeId("요청"); // 알림종류 - 'xx 알림이 도착했습니다.' 에서 xx를 의미
					notiVO.setNotMsg("요청 알림이 도착했습니다."); // 알림내용
				}
				if (projWorkVO.getWorkState().equals("완료")) {
					notiVO.setNotTypeId("완료"); // 알림종류 - 'xx 알림이 도착했습니다.' 에서 xx를 의미
					notiVO.setNotMsg("완료 알림이 도착했습니다."); // 알림내용
				}
				if (projWorkVO.getWorkState().equals("진행")) {
					notiVO.setNotTypeId("진행"); // 알림종류 - 'xx 알림이 도착했습니다.' 에서 xx를 의미
					notiVO.setNotMsg("요청 알림이 도착했습니다."); // 알림내용
				}
				notiVO.setNotSender(projWorkVO.getWorkRqstr()); // 보내는사람ID
				notiVO.setNotReceiver(mngrId); // 받는사람ID
				notiVO.setNotCntntId(projWorkVO.getWorkId()); // 알림해당글PK
				// 알림글URL - 알림글 URL은 detail 들어갈때의 URL을 적어줄것
				// 예시) /autho/receiveDocDetail?docId=ATDO00001&atrzAprvId=EMPL00001
				String notUrl = "/project/work?projId=" + projWorkVO.getProjId() + "&work=click";
				notiVO.setNotUrl(notUrl);
				
				notiService.insertNoti(notiVO);
			}
		}

		if (insertWork > 0) {
			return "redirect:/project/work?projId=" + projWorkVO.getProjId();
		}

		return "project/work?projId=" + projWorkVO.getProjId();
	}

	@PostMapping("/updateWork")
	public String updateWork(Model model, ProjWorkVO projWorkVO, BindingResult result) throws Exception {
		logger.info("updateWork() : " + projWorkVO.toString());

		int updateWork = projectService.updateWork(projWorkVO);

		if (updateWork > 0) {
			return "redirect:/project/work?projId=" + projWorkVO.getProjId();
		}

		return "project/work?projId=" + projWorkVO.getProjId();
	}

	@PostMapping("/updateWorkForm")
	@ResponseBody
	public int updateWorkForm(Model model, ProjWorkVO projWorkVO, BindingResult result) throws Exception {
		logger.info("updateWorkForm() : " + projWorkVO.toString());

		int updateWork = projectService.updateWork(projWorkVO);

		return updateWork;
	}

	@GetMapping("/deleteWork")
	@ResponseBody
	public int workDelete(String workId) {
		logger.info("workDelete");
		logger.info(workId);

		return projectService.deleteWork(workId);
	}

	@PostMapping("/workDetail")
	@ResponseBody
	public Map<String, Object> workDetail(String workId, String projId) {
		logger.info("workDetail");
		logger.info(workId);
		logger.info(projId);

		ProjWorkVO worktDetail = projectService.worktDetail(workId);
		List<EmployeeVO> memberList = projectService.memberList(projId);
		Map<String, Object> map = new HashMap<>();

		map.put("worktDetail", worktDetail);
		map.put("memberList", memberList);
		return map;
	}

	@PostMapping("/insertRpl")
	@ResponseBody
	public ProjWorkReplyVO insertRpl(String workId, ProjWorkReplyVO projWorkReplyVO) {
		logger.info("insertRpl");
		logger.info("insertRpl() : " + projWorkReplyVO.toString());

		projectService.insertRpl(projWorkReplyVO);

		return projWorkReplyVO;
	}

	@PostMapping("/rplList")
	@ResponseBody
	public List<ProjWorkReplyVO> rplList(String workId, ProjWorkReplyVO projWorkReplyVO) {
		logger.info("rplList");
		logger.info("rplList() : " + projWorkReplyVO.toString());

		List<ProjWorkReplyVO> rplList = projectService.rplList(workId);

		return rplList;
	}

	@PostMapping("/deleteRpl")
	@ResponseBody
	public int deleteRpl(int workReplyId) {
		logger.info("deleteRpl");
		logger.info("deleteRpl() : " + workReplyId);

		int deleteRes = projectService.deleteRpl(workReplyId);

		return deleteRes;
	}
}
