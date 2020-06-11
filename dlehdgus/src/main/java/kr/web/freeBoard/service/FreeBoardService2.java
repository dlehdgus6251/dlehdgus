package kr.web.freeBoard.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.web.freeBoard.dto.FreeBoardDto;

@Service
public class FreeBoardService2 {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	public int getCount(HashMap<String,Object> map){
		return sqlSessionTemplate.selectOne("getCount", map);
	}
	public List<HashMap<String, Object>> freeBoardList(HashMap<String, Object> map){
	
		return sqlSessionTemplate.selectList("freeBoardGetList",map);
	}
	
	
	public int freeBoardInsertPro(HashMap<String,Object> map){
		return sqlSessionTemplate.insert("freeBoardInsertPro",map);
	}
	
	public FreeBoardDto getDetailByNum(int num){
		return sqlSessionTemplate.selectOne("freeBoardDetailByNum", num);
	}
	
	public int getNewNum(){
		return sqlSessionTemplate.selectOne("freeBoardNewNum");
	}
	
	public int freeBoardModify(Map<String, Object> map){
		
		return sqlSessionTemplate.update("freeBoardModify", map);
	}

	public int freeBoardDelete (Map<String, Object> map) {
		return sqlSessionTemplate.delete("freeBoardDelete", map);
		
	}


	
}
