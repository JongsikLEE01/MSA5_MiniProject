<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Calendar.DTO.Calendar"%>
<%@page import="java.util.List"%>
<%@page import="Calendar.Service.CalendarServiceImpl"%>
<%@page import="Calendar.Service.CalendarService"%>
<%@page import="Calendar.MyCalendar"%>
<%@page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>학사 일정</title>
	<jsp:include page="/layout/link.jsp"/>
	<link href="<%= request.getContextPath()%>/schedule/css/style.css" rel="stylesheet">
</head>
<body>
<%
	// 년, 월 받아오기
	Date date = new Date();
	int year = date.getYear() +1900;
	int month = date.getMonth() +1;
				
	//	오류사항 걸러주기	
	try{
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
						
		if(month>=13){
			year++;
			month =1;
		}else if(month <=0){
			year--;
			month =12;
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
	// 날짜 데이터 불러오기
	CalendarService calendarService = new CalendarServiceImpl();
	List<Calendar> calendarList = calendarService.list();
	
	// 날짜 포맷
	SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
	
%>
	<!-- 헤더 -->
	<jsp:include page="/layout/header.jsp"/>

	<!-- 컨텐츠 -->
	<div class="container">
		<h1>학사 일정</h1>
		<div class="months">
			<div class="select">
				<input type="button" value="이전 달" class="selectbtn" onclick="location.href='?year=<%=year%>&month=<%=month-1%>'">
					<span id="year"><%=year%>년 학사일정</span>
				<input type="button" value="다음 달" class="selectbtn" onclick="location.href='?year=<%=year%>&month=<%=month+1%>'">
			</div>
		</div>
		<div class="calendar">
			<!-- 달력 출력 -->
			<table width="700" align="center" cellpadding="5" cellspacing="0">
				<tr>
					<th id="title" colspan="7">
						<%=month%>월
					</th>
				</tr>
				<!-- 요일 표시 -->
				<tr id="weekend">
					<td class="sunday">일</td>
					<td class="etcday">월</td>
					<td class="etcday">화</td>
					<td class="etcday">수</td>
					<td class="etcday">목</td>
					<td class="etcday">금</td>
					<td class="saturday">토</td>
				</tr>
				<tr>
				<%
					//	1일의 요일을 계산
					int first = MyCalendar.weekDay(year, month, 1);
					// 해당 월의 전 달의 마지막 날짜의 시작일 계산
					int start = month == 1? MyCalendar.lastDay(year-1, 12)- first : MyCalendar.lastDay(year, month-1)- first;
			
					// 1일 출력 위치를 맞추기
					for(int i= 1; i<= first; i++){
						if(i==1){
							out.println("<td></td>");
						}else{
							out.println("<td></td>");
						}
					}
			
					// 1일부터 마지막 날까지 반복해 날짜 출력
					for(int i = 1; i <= MyCalendar.lastDay(year, month); i++){
						// 요일 출력
						switch(MyCalendar.weekDay(year, month, i)){
							case 0 :
								// 일요일
								out.println("<td class='sun'>" +i +"</td>");
								break;
							case 6 :
								// 토요일
								out.println("<td class='sat'>" +i +"</td>");
								break;
							default :
								// 평일
								out.println("<td>" + i +"</td>");
								break;
						}
						// 출력한 날짜가 토요일이면서 마지막 달이면 줄바꿈
						if(MyCalendar.weekDay(year, month, i) == 6 && i != MyCalendar.lastDay(year, month)){
							out.println("</tr><tr>");			
						}
					}
				%>
				</tr>
			</table>
		</div><!-- 캘린터 끝 -->
		<div class="info">
			<h1>상세 일정</h1>
			<table>
				<tr>
					<th>번호</th>
					<th>일정</th>
					<th>내용</th>
				</tr>
				<% if( calendarList == null || calendarList.size() == 0 ) { %>
				<tr>
					<td colspan="5">해당 월의 행사는 아직 정해지지 않았습니다.</td>
				</tr>
				<% } else {
						for(Calendar calendar : calendarList) {
				%>
							<tr>
								<td><a href="<%= request.getContextPath()%>/schedule/schedule_read.jsp?no=<%= calendar.getNo()%>"><%= calendar.getNo()%></a></td>
								<td>
									<%
										// 시작월 종료월 확인 후 출력
										if(sdf.format(calendar.getStrDate()) == sdf.format(calendar.getEndDate())){
											out.print(sdf.format(calendar.getStrDate()));
										}else{
											out.print(sdf.format(calendar.getStrDate()));
											out.print(" ~ "); 
											out.print(sdf.format(calendar.getEndDate()));
										}
									%>
								</td>
								<td><%= calendar.getContent() %></td>
							</tr>
				<%		}
					}
				%>
			</table>
		</div><!-- info 끝 -->
	</div>
	<!-- 푸터 -->
	<jsp:include page="/layout/footer.jsp"/>

	<!-- 스크립트 -->
</body>
</html>