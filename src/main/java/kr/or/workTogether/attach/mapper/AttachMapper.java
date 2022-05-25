package kr.or.workTogether.attach.mapper;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Mapper;
import kr.or.workTogether.common.vo.AttachVO;

@Mapper
public interface AttachMapper {
	
	// 첨부파일 업로드
	public void insertAttachFiles(List<AttachVO> attachVO);
	
	//첨부파일 목록 보이기
	public List<AttachVO> selectFileList(String atchRelId);
	
	// 첨부파일 삭제
	public int fileDelete (String atchId);

	public void fileDownLoad(HttpServletRequest request, HttpServletResponse response, int boardId, int atchId);
	
}
