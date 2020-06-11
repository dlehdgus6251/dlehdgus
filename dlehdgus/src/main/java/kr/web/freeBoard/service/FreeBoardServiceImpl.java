package kr.web.freeBoard.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.web.freeBoard.common.util.PageMaker;
import kr.web.freeBoard.dto.FreeBoardDto;
import kr.web.freeBoard.mapper.FreeBoardDao;
@Service
public class FreeBoardServiceImpl implements FreeBoardService {
	@Autowired
	private FreeBoardDao Dao;
	
	@Override
	public int getCount(HashMap<String, Object> map) {
		
		return Dao.getCount(map);
	}

	@Override
	public List<HashMap<String, Object>> freeBoardList(HashMap<String, Object> map) {
		int curPage = (int) map.get("curPage");
		int count = Dao.getCount(map);
		PageMaker pageMaker = new PageMaker(count,curPage);
		map.put("count", count);
		map.put("pageMaker", pageMaker);
		map.put("curPage", curPage);
		map.put("begin", pageMaker.getPageBegin());
		map.put("end", pageMaker.getPageEnd());
		return Dao.freeBoardList(map);
	}

/*	@Override
	public void freeBoardInsertPro(HashMap<String, Object> map) {
		try {
			
			int result = 0;
			
			result =Dao.freeBoardInsertPro(map);
			
			if(result == 1) {
				map.put("reusltStr", "success");
				System.out.println("wewewqerwr");
			}
			else {
				map.put("reusltStr", "fail");
			}
		}catch(Exception e) {
			map.put("reusltStr", "fail");
		}
	
	}*/

	@Override
	public FreeBoardDto getDetailByNum(int num) {
		// TODO Auto-generated method stub
		return Dao.getDetailByNum(num);
	}

	@Override
	public int getNewNum() {
		// TODO Auto-generated method stub
		return Dao.getNewNum();
	}

/*	@Override
	public void freeBoardModify(Map<String, Object> map) {
		try {
			
			int result = 0;
			
			result = Dao.freeBoardModify(map);
			
			if(result == 1) {
				map.put("reusltStr", "success");
			}
			else {
				map.put("reusltStr", "fail");
			}
		}catch(Exception e) {
			map.put("reusltStr", "fail");
		}
	}*/

	@Override
	public void freeBoardDelete(Map<String, Object> map) {
		try {
			
			int result = 0;
			
			result = Dao.freeBoardDelete(map);
			
			if(result == 1) {
				map.put("reusltStr", "success");
			}
			else {
				map.put("reusltStr", "fail");
			}
		}catch(Exception e) {
			map.put("reusltStr", "fail");
		}
		
	}
	
	@Override
	public void freeBoardFunction(Map<String, Object> map) {
		try {
			
			HashMap<String,Object> result = null;
			
			result = Dao.freeBoardFunction(map);
			System.out.println("result="+map.get("result"));
			if(result == map.get("1")) {
				map.put("reusltStr", "success");
			}
			else {
				map.put("reusltStr", "fail");
			}
		}catch(Exception e) {
			e.printStackTrace();
			map.put("reusltStr", "fail");
		}
	}

}
