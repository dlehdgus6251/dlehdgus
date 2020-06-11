package kr.web.freeBoard.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.web.commonCode.service.CommCodeService;
import kr.web.freeBoard.dto.FreeBoardDto;
import kr.web.freeBoard.service.FreeBoardService;

@Controller
public class FreeBoardController {
	
	@Autowired
	private FreeBoardService freeBoardService;
	@Autowired
	private CommCodeService commCodeService;
	@RequestMapping("/main.do")
	public ModelAndView main(
			@RequestParam(value="searchType", defaultValue="ALL")String searchType,
			@RequestParam(value="searchWord", defaultValue="")String searchWord ,
			@RequestParam(value="firstDate", defaultValue="")String firstDate ,
			@RequestParam(value="secondDate", defaultValue="")String secondDate ,
			@RequestParam(defaultValue="1") int curPage
			){
		
		ModelAndView mav = new ModelAndView();
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("CODE", "com001");
		List<HashMap<String,Object>> searchCode = commCodeService.selectCommonCodeList(map);
		map.put("searchCode", searchCode);
		map.put("CODE", "com002");
		List<HashMap<String,Object>> searchCode2 = commCodeService.selectCommonCodeList(map);
		map.put("searchCode2", searchCode2);
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);
		map.put("firstDate", firstDate);
		map.put("secondDate", secondDate);
		map.put("curPage", curPage);
		map.put("list", freeBoardService.freeBoardList(map));
		
		mav.setViewName("boardMain");
		mav.addObject("map",map);
	
		return mav;
	}
	@ResponseBody
	@RequestMapping("/search.do")
	public HashMap<String, Object> search(HttpServletRequest request,
			@RequestParam(value="searchType", defaultValue="")String searchType,
			@RequestParam(value="searchWord", defaultValue="")String searchWord,
			@RequestParam(value="firstDate", defaultValue="")String firstDate ,
			@RequestParam(value="secondDate", defaultValue="")String secondDate ,
			@RequestParam(defaultValue="1") int curPage
			){
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("CODE", "com001");
		List<HashMap<String,Object>> searchCode = commCodeService.selectCommonCodeList(map);
		map.put("searchCode", searchCode);
		map.put("CODE", "com002");
		List<HashMap<String,Object>> searchCode2 = commCodeService.selectCommonCodeList(map);
		map.put("searchCode2", searchCode2);
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);
		map.put("firstDate", firstDate);
		map.put("secondDate", secondDate);
		map.put("curPage", curPage);
		map.put("list", freeBoardService.freeBoardList(map));
		System.out.println(map);
		
		return map;
		
	}
	@RequestMapping("/freeBoardInsert.do")
	public String freeBoardInsert(){
		return "freeBoardInsert";
	}
	/*@ResponseBody
	@RequestMapping("/freeBoardInsertPro.do")
	public HashMap<String,Object> freeBoardInsertPro(HttpServletRequest request){
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		map.put("name", request.getParameter("name"));
		map.put("title", request.getParameter("title"));
		map.put("content", request.getParameter("content"));
		freeBoardService.freeBoardInsertPro(map);
		System.out.println(map.get("reusltStr"));
		return map;
		
	}*/
	
	@RequestMapping("/freeBoardDetail.do")
	public ModelAndView freeBoardDetail(HttpServletRequest request, @RequestParam("num")int num){
		FreeBoardDto freeBoardDto = freeBoardService.getDetailByNum(num);
		return new ModelAndView("freeBoardDetail", "freeBoardDto", freeBoardDto);
	}
	
	/*@ResponseBody
	@RequestMapping("/freeBoardModify.do")
	public HashMap<String,Object> freeBoardModify(HttpServletRequest request){
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("num", request.getParameter("num"));
		map.put("content", request.getParameter("content"));
		map.put("title", request.getParameter("title"));
		freeBoardService.freeBoardModify(map);
		
		return map;

	}*/
	
	@ResponseBody
	@RequestMapping("/freeBoardDelete.do")
	public HashMap<String,Object> FreeBoardDelete(HttpServletRequest request){
			System.out.println("delete.......");
			HashMap<String,Object> map = new HashMap<String,Object>();
			map.put("num",request.getParameter("num"));
			freeBoardService.freeBoardDelete(map);
						
			return map;
	}
	
	@ResponseBody
	@RequestMapping("/freeBoardFunction.do")
	public HashMap<String,Object> freeBoardFunction(HttpServletRequest request
			, @RequestParam(value="num", defaultValue="-1")int num){
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("num", num);
		map.put("name", request.getParameter("name"));
		map.put("content", request.getParameter("content"));
		map.put("title", request.getParameter("title"));
		
		freeBoardService.freeBoardFunction(map);
		
		return map;

	}
}