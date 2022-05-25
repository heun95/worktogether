package kr.or.workTogether.project.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.workTogether.common.util.FileUpload;
import kr.or.workTogether.common.vo.AttachVO;
import kr.or.workTogether.common.vo.CalendarVO;
import kr.or.workTogether.common.vo.EmployeeVO;
import kr.or.workTogether.common.vo.GanttChartVO;
import kr.or.workTogether.common.vo.ProjMemVO;
import kr.or.workTogether.common.vo.ProjWorkReplyVO;
import kr.or.workTogether.common.vo.ProjWorkVO;
import kr.or.workTogether.common.vo.ProjectVO;
import kr.or.workTogether.common.vo.WorkMngrVO;
import kr.or.workTogether.project.mapper.ProjectMapper;
import kr.or.workTogether.project.service.ProjectService;

@Service
@Transactional
public class ProjectServiceImpl implements ProjectService {
	@Autowired
	ProjectMapper projectMapper;
	@Autowired
	FileUpload fileUpload;
	

	@Override
	public int projInsert(ProjectVO projectVO) {
		return projectMapper.projInsert(projectVO);
	}
	
	@Override
	public List<ProjectVO> projList(String empId) {
		return projectMapper.projList(empId);
	}

	@Override
	public ProjectVO projDetail(String projId) {
		return projectMapper.projDetail(projId);
	}

	@Override
	public List<EmployeeVO> memberList(String projId) {
		return projectMapper.memberList(projId);
	}

	@Override
	public int insertWork(ProjWorkVO projWorkVO) throws Exception{
		
		// 업무 인서트
		int insertWork = projectMapper.insertWork(projWorkVO);
		System.out.println("insertWork : " + insertWork);
		
		List<String> workMngrIdList = projWorkVO.getWorkMngrId();
		
		List<WorkMngrVO> WorkMngrVOList = new ArrayList<>();
		int insertMngr =0;
		System.out.println("workMngrIdList : " + workMngrIdList);
		if(workMngrIdList != null) {
			for(String workMngrId : workMngrIdList) {
				WorkMngrVO workMngrVO = new WorkMngrVO();
				workMngrVO.setWorkId(projWorkVO.getWorkId());
				workMngrVO.setWorkMngrId(workMngrId);
				
				WorkMngrVOList.add(workMngrVO);
			}
			
			insertMngr = projectMapper.insertMngr(WorkMngrVOList);
			System.out.println("insertMngr : " + insertMngr);
		}
		
		
		
		// 파일 업로드
		MultipartFile[] uploadFile = projWorkVO.getUploadFile();
		
		String path = "work/" + projWorkVO.getWorkId();

		String atchRelId = projWorkVO.getWorkId();
		
		System.out.println(uploadFile.toString());
		System.out.println(path);
		System.out.println(atchRelId);
		
		if (uploadFile.length > 0) {
			List<String> insertFileNames = fileUpload.insert(path, uploadFile, atchRelId, projWorkVO.getWorkRqstr());
		}
		

		
		return insertMngr;
	}

	@Override
	public List<ProjWorkVO> workList(Map<String, Object> map) {
		return projectMapper.workList(map);
	}

	@Override
	public ProjWorkVO worktDetail(String workId) {
		return projectMapper.worktDetail(workId);
	}

	@Override
	public List<ProjWorkVO> workHomeList(Map<String, Object> map) {
		return projectMapper.workHomeList(map);
	}

	@Override
	public int updateWork(ProjWorkVO projWorkVO) throws Exception {

		
		projectMapper.deleteMngr(projWorkVO.getWorkId());
		
		List<String> workMngrIdList = projWorkVO.getWorkMngrId();
		
		List<WorkMngrVO> WorkMngrVOList = new ArrayList<>();
		System.out.println("workMngrIdList : " + workMngrIdList);
		
		if(workMngrIdList != null) {
			for(String workMngrId : workMngrIdList) {
				WorkMngrVO workMngrVO = new WorkMngrVO();
				workMngrVO.setWorkId(projWorkVO.getWorkId());
				workMngrVO.setWorkMngrId(workMngrId);
				
				WorkMngrVOList.add(workMngrVO);
			}
			
			int insertMngr = projectMapper.insertMngr(WorkMngrVOList);
			System.out.println("insertMngr : " + insertMngr);
		}
		

		
		return projectMapper.updateWork(projWorkVO);
	}
	
	@Override
	public int deleteWork(String workId) {
		return projectMapper.deleteWork(workId);
	}

	@Override
	public int insertRpl(ProjWorkReplyVO projWorkReplyVO) {
		return projectMapper.insertRpl(projWorkReplyVO);
	}

	@Override
	public List<ProjWorkReplyVO> rplList(String workId) {
		return projectMapper.rplList(workId);
	}

	@Override
	public int deleteRpl(int workReplyId) {
		return projectMapper.deleteRpl(workReplyId);
	}

	@Override
	public List<CalendarVO> calendarList(String projId) {
		return projectMapper.calendarList(projId);
	}

	@Override
	public List<GanttChartVO> gantList(String projId) {
		return projectMapper.gantList(projId);
	}

	@Override
	public Map<String, Object> projChart(String projId) {
		return projectMapper.projChart(projId);
	}

	@Override
	public int listCount(Map<String, Object> map) {
		return projectMapper.listCount(map);
	}

	@Override
	public List<Map<String, String>> workCountDate(Map<String, Object> map) {
		return projectMapper.workCountDate(map);
	}

	@Override
	public List<AttachVO> fileList(String projId) {
		return projectMapper.fileList(projId);
	}

	@Override
	public int projMemInsert(Map<String, Object> map) {
		return projectMapper.projMemInsert(map);
	}

	@Override
	public String projName(String projId) {
		return projectMapper.projName(projId);
	}

	


}
