package kr.or.workTogether.common.util;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.workTogether.attach.mapper.AttachMapper;
import kr.or.workTogether.common.vo.AttachVO;

@Service
public class FileUpload {
	private Logger logger = LoggerFactory.getLogger(FileUpload.class);
	
	@Autowired
	AttachMapper attachMapper;
	
	// 첨부파일 삭제
	public int fileDelete (String atchId) {
		return attachMapper.fileDelete(atchId);
	}
	
	// 첨부파일 리스트
	public List<AttachVO> selectFileList(String atchRelId){
		return attachMapper.selectFileList(atchRelId);
	}
	
	public List<String> insert(String path, MultipartFile[] uploadFile, String atchRelId) {

		
		//업로드한 파일 객체들
//		MultipartFile[] uploadFile = cusVO.getUploadFile(); //파라미터로 받음
		
		//파일 저장 경로 설정
		String uploadFolder = "D:/A_TeachingMaterial/7.LastProject/workspace/workTogether/src/main/webapp/resources/upload/" + path;
		
//		String uploadPath = uploadFolder + path;
		
		//연/월/일 폴더 생성 시작-------
		File uploadPath = new File(uploadFolder);
//		logger.info("uploadPath : " + uploadPath);
		
		if(uploadPath.exists()==false) {//해당 경로가 없으면 생성해줘야함
			uploadPath.mkdirs();			
		}
		//연/월/일 폴더 생성 끝-------
		
		//업로드한 파일 객체들의 파일명과 크기 정보를 넣은 후 insert 할 리스트 객체
		List<AttachVO> attachFilesVO = new ArrayList<AttachVO>();
		List<String> uploadFileNames = new ArrayList<String>();
		logger.info("uploadFile ----------- " + uploadFile);
		
		//이미지 3개를 업로드 한다면 3회 반복
		for(MultipartFile multipartFile : uploadFile) {
			logger.info("-----------");
			logger.info("파일명 : " + multipartFile.getOriginalFilename());
			logger.info("파일크기 : " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			if(uploadFileName==null || "".equals(uploadFileName)) {
				return null;
			}
			String ext = uploadFileName.substring(uploadFileName.lastIndexOf(".") + 1);
			logger.info("파일확장자 : " + ext);
			
			//각 파일 별로 세팅할 VO 
			AttachVO vo = new AttachVO();
			
			//1) 파일id(기본키데이터), 파일시퀀스번호,파일명과 크기를 세팅
			vo.setAtchRelId(atchRelId);
			vo.setAtchPath("/resources/upload/" + path + "/" + uploadFileName);
			vo.setAtchName(uploadFileName);
			vo.setAtchOldname(uploadFileName);
			vo.setAtchExtns(ext);
			vo.setAtchSize(multipartFile.getSize());
			
			if(atchRelId.substring(1, 4).equals("EMPL")) {
				vo.setAtchName(atchRelId);
				uploadFileName = atchRelId;
			}
			
			uploadFileNames.add(uploadFileName);
//			vo.setUploadFileSize(""+multipartFile.getSize());
//			vo.setRegisterId("admin");//로그인 한 아디디로 교체해야 함
			
			//-----------UUID 파일명 처리 시작 ----------------------------
			//동일한 이름으로 업로드되면 기존 파일을 지우게 되므로 이를 방지하기 위함
//			UUID uuid = UUID.randomUUID();
			
//			String uploadFileName = uuid.toString() + "-" + multipartFile.getOriginalFilename();
			// c:\\upload\\gongu03.jpg으로 조립
			// 이렇게 업로드 하겠다라고 설계 uploadFolder -> uploadPath
			// /resources/upload/2022/02/21/asdfsadfsdafsda_test.jpg
//			vo.setUploadFileName("/resources/upload/" + getFolder() + "/" + uploadFileName);
			
			//-----------UUID 파일명 처리 끝 ----------------------------
			File saveFile = new File(uploadPath, uploadFileName);
			
			try {
				// transferTo() : 물리적으로 파일 업로드가 됨
				multipartFile.transferTo(saveFile);
			
				//-------썸네일 처리 시작---------
				//이미지 파일인지 체킹
//				if(checkImageType(saveFile)) {
//					logger.info("이미지 파일? true");
//					//uploadPath : 연/월/일이 포함된 경로
//					//uploadFileName : UUID가 포함된 파일명
//					FileOutputStream thumbnail = 
//							new FileOutputStream(
//									new File(uploadPath,"s_"+uploadFileName));
//					Thumbnailator.createThumbnail(multipartFile.getInputStream(),
//							thumbnail, 100, 100);
//					thumbnail.close();
//				}else {
//					logger.info("이미지 파일? false");
//				}
				//-------썸네일 처리 끝---------
				
				//파일 실제 명을 list에 담음
				attachFilesVO.add(vo);
				logger.info("attachFilesVO : " + attachFilesVO.toString());
			}catch(Exception e){
				logger.info(e.getMessage());
			}//end catch
		}// end for
		
		//attach_files 테이블로 insert
		System.out.println("attachMapper : " + attachMapper);
		attachMapper.insertAttachFiles(attachFilesVO);
		
		return uploadFileNames;
		
	}
	
	
	public List<String> insert(String path, MultipartFile[] uploadFile, String atchRelId, String userId) {
		
		
		//업로드한 파일 객체들
//		MultipartFile[] uploadFile = cusVO.getUploadFile(); //파라미터로 받음
		
		//파일 저장 경로 설정
		String uploadFolder = "D:/A_TeachingMaterial/7.LastProject/workspace/workTogether/src/main/webapp/resources/upload/" + path;
		
//		String uploadPath = uploadFolder + path;
		
		//연/월/일 폴더 생성 시작-------
		File uploadPath = new File(uploadFolder);
//		logger.info("uploadPath : " + uploadPath);
		
		if(uploadPath.exists()==false) {//해당 경로가 없으면 생성해줘야함
			uploadPath.mkdirs();			
		}
		//연/월/일 폴더 생성 끝-------
		
		//업로드한 파일 객체들의 파일명과 크기 정보를 넣은 후 insert 할 리스트 객체
		List<AttachVO> attachFilesVO = new ArrayList<AttachVO>();
		List<String> uploadFileNames = new ArrayList<String>();
		logger.info("uploadFile ----------- " + uploadFile);
		
		//이미지 3개를 업로드 한다면 3회 반복
		for(MultipartFile multipartFile : uploadFile) {
			logger.info("-----------");
			logger.info("파일명 : " + multipartFile.getOriginalFilename());
			logger.info("파일크기 : " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			if(uploadFileName==null || "".equals(uploadFileName)) {
				return null;
			}
			String ext = uploadFileName.substring(uploadFileName.lastIndexOf(".") + 1);
			logger.info("파일확장자 : " + ext);
			
			//각 파일 별로 세팅할 VO 
			AttachVO vo = new AttachVO();
			
			//1) 파일id(기본키데이터), 파일시퀀스번호,파일명과 크기를 세팅
			vo.setAtchRelId(atchRelId);
			vo.setAtchPath("/resources/upload/" + path + "/" + uploadFileName);
			vo.setAtchName(uploadFileName);
			vo.setAtchOldname(uploadFileName);
			vo.setAtchExtns(ext);
			vo.setAtchSize(multipartFile.getSize());
			vo.setAtchWrtr(userId);
			
			if(atchRelId.substring(1, 4).equals("EMPL")) {
				vo.setAtchName(atchRelId);
				uploadFileName = atchRelId;
			}
			
			uploadFileNames.add(uploadFileName);
//			vo.setUploadFileSize(""+multipartFile.getSize());
//			vo.setRegisterId("admin");//로그인 한 아디디로 교체해야 함
			
			//-----------UUID 파일명 처리 시작 ----------------------------
			//동일한 이름으로 업로드되면 기존 파일을 지우게 되므로 이를 방지하기 위함
//			UUID uuid = UUID.randomUUID();
			
//			String uploadFileName = uuid.toString() + "-" + multipartFile.getOriginalFilename();
			// c:\\upload\\gongu03.jpg으로 조립
			// 이렇게 업로드 하겠다라고 설계 uploadFolder -> uploadPath
			// /resources/upload/2022/02/21/asdfsadfsdafsda_test.jpg
//			vo.setUploadFileName("/resources/upload/" + getFolder() + "/" + uploadFileName);
			
			//-----------UUID 파일명 처리 끝 ----------------------------
			File saveFile = new File(uploadPath, uploadFileName);
			
			try {
				// transferTo() : 물리적으로 파일 업로드가 됨
				multipartFile.transferTo(saveFile);
				
				//-------썸네일 처리 시작---------
				//이미지 파일인지 체킹
//				if(checkImageType(saveFile)) {
//					logger.info("이미지 파일? true");
//					//uploadPath : 연/월/일이 포함된 경로
//					//uploadFileName : UUID가 포함된 파일명
//					FileOutputStream thumbnail = 
//							new FileOutputStream(
//									new File(uploadPath,"s_"+uploadFileName));
//					Thumbnailator.createThumbnail(multipartFile.getInputStream(),
//							thumbnail, 100, 100);
//					thumbnail.close();
//				}else {
//					logger.info("이미지 파일? false");
//				}
				//-------썸네일 처리 끝---------
				
				//파일 실제 명을 list에 담음
				attachFilesVO.add(vo);
				logger.info("attachFilesVO : " + attachFilesVO.toString());
			}catch(Exception e){
				logger.info(e.getMessage());
			}//end catch
		}// end for
		
		//attach_files 테이블로 insert
		System.out.println("attachMapper : " + attachMapper);
		attachMapper.insertAttachFiles(attachFilesVO);
		
		return uploadFileNames;
		
	}
	
	public List<String> insert2(String path, MultipartFile[] uploadFile, String atchRelId) {

		//업로드한 파일 객체들
//		MultipartFile[] uploadFile = cusVO.getUploadFile(); //파라미터로 받음
		
		//파일 저장 경로 설정
		String uploadFolder = "D:/A_TeachingMaterial/7.LastProject/workspace/workTogether/src/main/webapp/resources/upload/" + path;
		
//		String uploadPath = uploadFolder + path;
		
		//연/월/일 폴더 생성 시작-------
		File uploadPath = new File(uploadFolder);
//		logger.info("uploadPath : " + uploadPath);
		
		if(uploadPath.exists()==false) {//해당 경로가 없으면 생성해줘야함
			uploadPath.mkdirs();			
		}
		//연/월/일 폴더 생성 끝-------
		
		//업로드한 파일 객체들의 파일명과 크기 정보를 넣은 후 insert 할 리스트 객체
		List<AttachVO> attachFilesVO = new ArrayList<AttachVO>();
		List<String> uploadFileNames = new ArrayList<String>();
		logger.info("uploadFile ----------- " + uploadFile);
		
		//이미지 3개를 업로드 한다면 3회 반복
		for(MultipartFile multipartFile : uploadFile) {
			logger.info("-----------");
			logger.info("파일명 : " + multipartFile.getOriginalFilename());
			logger.info("파일크기 : " + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			if(uploadFileName==null || "".equals(uploadFileName)) {
				return null;
			}
			String ext = uploadFileName.substring(uploadFileName.lastIndexOf(".") + 1);
			logger.info("파일확장자 : " + ext);
			
			//각 파일 별로 세팅할 VO 
			AttachVO vo = new AttachVO();
			
			//1) 파일id(기본키데이터), 파일시퀀스번호,파일명과 크기를 세팅
			vo.setAtchRelId(atchRelId);
			vo.setAtchPath("/resources/upload/" + path + "/" + uploadFileName);
			vo.setAtchName(uploadFileName);
			vo.setAtchOldname(uploadFileName);
			vo.setAtchExtns(ext);
			vo.setAtchSize(multipartFile.getSize());
			
			if(atchRelId.substring(1, 4).equals("EMPL")) {
				vo.setAtchName(atchRelId);
				uploadFileName = atchRelId;
			}
			
			uploadFileNames.add(uploadFileName);
//			vo.setUploadFileSize(""+multipartFile.getSize());
//			vo.setRegisterId("admin");//로그인 한 아디디로 교체해야 함
			
			//-----------UUID 파일명 처리 시작 ----------------------------
			//동일한 이름으로 업로드되면 기존 파일을 지우게 되므로 이를 방지하기 위함
//			UUID uuid = UUID.randomUUID();
			
//			String uploadFileName = uuid.toString() + "-" + multipartFile.getOriginalFilename();
			// c:\\upload\\gongu03.jpg으로 조립
			// 이렇게 업로드 하겠다라고 설계 uploadFolder -> uploadPath
			// /resources/upload/2022/02/21/asdfsadfsdafsda_test.jpg
//			vo.setUploadFileName("/resources/upload/" + getFolder() + "/" + uploadFileName);
			
			//-----------UUID 파일명 처리 끝 ----------------------------
			File saveFile = new File(uploadPath, uploadFileName);
			
			try {
				// transferTo() : 물리적으로 파일 업로드가 됨
				multipartFile.transferTo(saveFile);
			
				//-------썸네일 처리 시작---------
				//이미지 파일인지 체킹
//				if(checkImageType(saveFile)) {
//					logger.info("이미지 파일? true");
//					//uploadPath : 연/월/일이 포함된 경로
//					//uploadFileName : UUID가 포함된 파일명
//					FileOutputStream thumbnail = 
//							new FileOutputStream(
//									new File(uploadPath,"s_"+uploadFileName));
//					Thumbnailator.createThumbnail(multipartFile.getInputStream(),
//							thumbnail, 100, 100);
//					thumbnail.close();
//				}else {
//					logger.info("이미지 파일? false");
//				}
				//-------썸네일 처리 끝---------
				
				//파일 실제 명을 list에 담음
				attachFilesVO.add(vo);
				logger.info("attachFilesVO : " + attachFilesVO.toString());
			}catch(Exception e){
				logger.info(e.getMessage());
			}//end catch
		}// end for
		
		//attach_files 테이블로 insert
		System.out.println("attachMapper : " + attachMapper);
		attachMapper.insertAttachFiles(attachFilesVO);
		
		return uploadFileNames;
	}
}
