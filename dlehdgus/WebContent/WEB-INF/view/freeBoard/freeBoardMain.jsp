<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#search").click(function() {
	var searchType = $("#searchType").val();
	var searchWord = $("#searchWord").val();
	var firstDate2 = $("#firstDate").val();
	var secondDate2 = $("#secondDate").val(); 
	var date_pattern = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/; 
	var arr1 = firstDate2.split("-");
	var arr2 = secondDate2.split("-");
	var date1 = new Date(arr1[0],arr1[1],arr1[2]);
	var date2 = new Date(arr2[0],arr2[1],arr2[2]);
    var firstYear = Number(date1.getFullYear());
    var firstMonth = Number(date1.getMonth());
    var firstDay = Number(date1.getDate()); 
    var secondYear = Number(date2.getFullYear());
    var secondMonth = Number(date2.getMonth());
    var secondDay = Number(date2.getDate());
	if(firstDate2 !="" && secondDate2 !=""){
		if(!date_pattern.test(firstDate2)){
			alert("날짜형식이 맞지않습니다");
			return false;
		}
		if(!date_pattern.test(secondDate2)){
			alert("날짜형식이 맞지않습니다");
			return false;
		}
	}
	if(secondDate2 != ""){
		if(firstDate2 > secondDate2){
			alert("검색 범위가 올바르지 않습니다.");
			return false;
		}
	}
	
	if(firstYear < secondYear){
		alert("날짜검색은 한달 이상의 기간은 검색이 불가합니다.");
		return false;
	}
	if(firstMonth +1 < secondMonth){
		alert("날짜검색은 한달 이상의 기간은 검색이 불가합니다.");
		return false;
	}
	if(firstMonth < secondMonth){
		if(firstDay < secondDay){
			alert("날짜검색은 한달 이상의 기간은 검색이 불가합니다.");
			return false;
		}
	}
		/* var OrgFirst = $("#firstDate").val(); 
		var OrgSecond = $("#secondDate").val();
		var StringFirstDate = OrgFirst.replace(/\-/g,'');
		var StringSecondDate = OrgSecond.replace(/\-/g,'');
		var IntFirstDate = Number(StringFirstDate);   
		var IntSecondDate = Number(StringSecondDate);  */
	/* if(IntFirstDate+100 < IntSecondDate){
		alert("날짜검색은 한달 이상의 기간은 검색이 불가합니다.");
		return false;
	} */
	if(firstDate2 != "" && secondDate2 != "" ){
		
		var firstDate = "";
		var secondDate = "";
			
			for(var i = 0; i < 3; i++){
				firstDate += arr1[i]	
			}
			for(var i = 0; i < 3; i++){
				secondDate += arr2[i]	
			}
		
	}else{
		var firstDate = firstDate2.replace(/\-/g,'');
		var secondDate = secondDate2.replace(/\-/g,'');
	}
		
	console.log(firstDate);
	
	var map = { "searchType" : searchType,
	    		"searchWord" : searchWord,
	    		"firstDate" : firstDate,
	    		"secondDate" : secondDate
	    		};
	var exp = /[^0-9]/g;
	if(searchType == "NUM"){
		if(exp.test(searchWord)){
			alert("숫자만 입력하세요");
			return false;
		}
	}	
		$.ajax({
			url: "search.do", // 호출하고자 하는 URL EX: /main.do
			type: "POST",  //GET , POST ->> 단순조회 일땐 GET POST 통일합니다. 
			dataType: "json", //json   
			data: map, //서버로 전달할 파라미터 {"key" , value}
			success: function(data){
				console.log(data);
				$("#list").html("");
				    	// 서버와 정상적으로 호출이 되었을때 
						// 조회가 정삭적으로 이루어졌을때 
				    	//data --> 데이터 담겨져 오겠죠 
				for (var i=0;i<data.list.length;i++) {
                    $("#list").append( "<div style='width: 50px; float: left;'>" + data.list[i].NUM + "</div>"+
                        "<div style='width: 300px; float: left;'><a href='./freeBoardDetail.do?num=" + data.list[i].NUM +"'>"+ data.list[i].TITLE + "</a></div>"+
                        "<div style='width: 150px; float: left;'>" + data.list[i].NAME +"</div>" +
                        "<div style='width: 150px; float: left;'>" + data.list[i].REGDATE + "</div>" +
                        "<hr style='width: 600px'>");
                }
				$("#page").html("");
					if(data.pageMaker.curPage > 1){
				    	$("#page").append(
				    		"<a href='./main.do?curPage=1&totBlock=" + data.pageMaker.totBlock +
				    		"&searchType=" + data.searchType + 
				    		"&searchWord=" + data.searchWord + 
				    		"&firstDate=" + data.firstDate+ 
				    		"&secondDate=" + data.secondDate + "'>[처음]</a>");
				    }
				    if(data.pageMaker.curPage > 1){
				    	$("#page").append(
				    		"<a href='./main.do?curPage=" + data.pageMaker.prevPage + 
				    		"&totBlock=" + data.pageMaker.totBlock +
				    		"&searchType=" + data.searchType + 
				    		"&searchWord=" + data.searchWord + 
				    		"&firstDate=" + data.firstDate+ 
				    		"&secondDate=" + data.secondDate + "'>[이전]</a>");
				    }
				    	
					for(var i=1; i<=data.pageMaker.blockEnd; i++){
				    	var num = i;
				    	if(num == data.pageMaker.curPage){
				    		$("#page").append(
				    			"<span style='color: red'>"+num+"</span>");
				    	}else{
				    		$("#page").append(
				    				"<a href='./main.do?curPage=" + num + 
				    			"&totBlock=" + data.pageMaker.totBlock + 
				    			"&searchType=" + data.searchType + 
				    			"&searchWord=" + data.searchWord + 
				    			"&firstDate=" + data.firstDate+ 
				    			"&secondDate=" + data.secondDate + "'>" + num + "</a>");
				    	}
				    }
				    if(data.pageMaker.curPage < data.pageMaker.totPage){
			    		$("#page").append(
			    			"<a href='./main.do?curPage=" + data.pageMaker.nextPage + 
			    			"&totBlock=" + data.pageMaker.totBlock + 
			    			"&searchType=" + data.searchType + 
			    			"&searchWord=" + data.searchWord + 
			    			"&firstDate=" + data.firstDate + 
			    			"&secondDate=" + data.secondDate + "'>[다음]</a>");
			    	}
			    	if(data.pageMaker.curPage < data.pageMaker.totPage){
			    		$("#page").append(
			    	    	"<a href='./main.do?curPage=" + data.pageMaker.totPage + 
			    	    	"&totBlock=" + data.pageMaker.totBlock + 
			    	    	"&searchType=" + data.searchType + 
			    	    	"&searchWord=" + data.searchWord + 
			    	    	"&firstDate=" + data.firstDate + 
			    	    	"&secondDate=" + data.secondDate +  "'>[끝]</a>");
			    	}
				    },
				    error: function (request, status, error){        
						// 서버와 정상적으로 호출하지 못했을때 
						 alert(error);
				    }
				  }); //ajax end
		 	}); //search() end
	$("#firstDate").keyup(function() {
        if( this.value.length > 10){
             this.value = this.value.substr(0, 10);
         }
         var val         = this.value.replace(/\D/g, ''); // 숫자가 아닌 문자를 찾아 지움
         var original    = this.value.replace(/\D/g, '').length; 
         var conversion  = '';
         for(i=0;i<2;i++){
             if (val.length > 4 && i===0) {
                 conversion += val.substr(0, 4) + '-';
                 val         = val.substr(4);
             }
             else if(original>6 && val.length > 2 && i===1){
                 conversion += val.substr(0, 2) + '-';
                 val         = val.substr(2);
             }
         }
         conversion += val;
         this.value = conversion;
     });// firstDate end
	$("#secondDate").keyup(function() {
        if( this.value.length > 10){
             this.value = this.value.substr(0, 10);
         }
         var val         = this.value.replace(/\D/g, '');
         var original    = this.value.replace(/\D/g, '').length;
         var conversion  = '';
         for(i=0;i<2;i++){
             if (val.length > 4 && i===0) {
                 conversion += val.substr(0, 4) + '-';
                 val         = val.substr(4);
             }
             else if(original>6 && val.length > 2 && i===1){
                 conversion += val.substr(0, 2) + '-';
                 val         = val.substr(2);
             }
         }
         conversion += val;
         this.value = conversion;
     });// secondDate end
}); //end

</script>
</head>
<body>

	<div>
		<h1>자유게시판</h1>
	</div>
	<!-- 검색폼 -->
<div class="search">
	<select name="searchType" id="searchType">
		<option value="">전체</option>
			<c:forEach var="CODE" items="${map.searchCode }" >
				<option value="${CODE.DCODE }">${CODE.DCODE_NAME }</option>
			</c:forEach>
	</select>
	
	<select>
	<option value="">월</option>
	<c:forEach var="CODE" items="${map.searchCode2 }" >
		<option value="${CODE.DCODE }">${CODE.DCODE_NAME }</option>
		</c:forEach>
	</select>
	<input type="text" name="searchWord" class="searchWord" id="searchWord" value="${map.searchWord }">
	<button name="search"id="search">검색</button> 
	<br>
	<input type="text" style="width:100px;" name="firstDate" class="firstDate" id="firstDate" value="${map.firstDate }"> ~ 
	<input type="text" style="width:100px;" name="secondDate" class="secondDate" id="secondDate" value="${map.secondDate }">
</div>
	
	<div style="width:650px;" align="right">
		<a href="./freeBoardInsert.do">글쓰기</a>
	</div>
	<hr style="width: 600px">
	<div id="list">
	<c:forEach items="${map.list }" var="map">
	<div  id="table">
		
			<div style="width: 50px; float: left;">${map.NUM }</div>	
			<div style="width: 300px; float: left;"><a href="./freeBoardDetail.do?num=${map.NUM }">${map.TITLE }</a></div>
			<div style="width: 150px; float: left;">${map.NAME }</div>
			<div style="width: 150px; float: left;">${map.REGDATE }</div>
		<hr style="width: 600px">
		</div>
	</c:forEach>
	</div>
	<div id="page">
<c:if test="${map.pageMaker.curPage > 1}">
    <a href="./main.do?curPage=1&totBlock=${map.pageMaker.totBlock}&searchType=${map.searchType}&searchWord=${map.searchWord}&firstDate=${map.firstDate }&secondDate=${map.secondDate }">[처음]</a>
</c:if>
<!-- **이전페이지 블록으로 이동 : 현재 페이지 블럭이 1보다 크면 [이전]하이퍼링크를 화면에 출력 -->
<c:if test="${map.pageMaker.curPage > 1}">
    <a href="./main.do?curPage=${map.pageMaker.prevPage}&totBlock=${map.pageMaker.totBlock}&searchType=${map.searchType}&searchWord=${map.searchWord}&firstDate=${map.firstDate }&secondDate=${map.secondDate }">[이전]</a>
</c:if>
<c:forEach var="num" begin="${map.pageMaker.blockBegin}" end="${map.pageMaker.blockEnd}">
	<!-- **현재페이지이면 하이퍼링크 제거 -->
    <c:choose>
        <c:when test="${num == map.pageMaker.curPage}">
            <span style="color: red">${num}</span> 
        </c:when>
        <c:otherwise>
            <a href="./main.do?curPage=${num}&totBlock=${map.pageMaker.totBlock}&searchType=${map.searchType}&searchWord=${map.searchWord}&firstDate=${map.firstDate }&secondDate=${map.secondDate }">${num}</a> 
        </c:otherwise>
    </c:choose>
</c:forEach>
<c:if test="${map.pageMaker.curPage < map.pageMaker.totPage}">
    <a href="./main.do?curPage=${map.pageMaker.nextPage}&totBlock=${map.pageMaker.totBlock}&searchType=${map.searchType}&searchWord=${map.searchWord}&firstDate=${map.firstDate }&secondDate=${map.secondDate }">[다음]</a>
</c:if>
<!-- **끝페이지로 이동 : 현재 페이지가 전체 페이지보다 작거나 같으면 [끝]하이퍼링크를 화면에 출력 -->
<c:if test="${map.pageMaker.curPage < map.pageMaker.totPage}">
	<a href="./main.do?curPage=${map.pageMaker.totPage}&totBlock=${map.pageMaker.totBlock}&searchType=${map.searchType}&searchWord=${map.searchWord}&firstDate=${map.firstDate }&secondDate=${map.secondDate }">[끝]</a>
</c:if>	
</div>
</body>
</html>