package kr.web.freeBoard.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import kr.web.freeBoard.dto.FreeBoardDto;
@Service
public interface FreeBoardService {
	//게시물 갯수
	public int getCount(HashMap<String,Object> map);
	//게시물 출력
	public List<HashMap<String, Object>> freeBoardList(HashMap<String, Object> map);
	//게시물 등록
	/*public void freeBoardInsertPro(HashMap<String,Object> map);*/
	//게시물 상세
	public FreeBoardDto getDetailByNum(int num);
	//게시물 번호
	public int getNewNum();
	//게시물 수정
	/*public void freeBoardModify (Map<String, Object> map);*/
	//게시물 삭제
	public void freeBoardDelete (Map<String, Object> map);
	//프로시저
	public void freeBoardFunction(Map<String, Object> map);
}
