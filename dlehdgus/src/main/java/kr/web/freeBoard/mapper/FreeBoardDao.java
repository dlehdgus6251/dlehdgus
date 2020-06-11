package kr.web.freeBoard.mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.web.freeBoard.dto.FreeBoardDto;
@Repository
public class FreeBoardDao {
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
	public HashMap<String,Object> freeBoardFunction (Map<String, Object> map) {
		System.out.println("aaaa="+map);
		
		return sqlSessionTemplate.selectOne("freeBoardfunction", map);
		
	}
}
