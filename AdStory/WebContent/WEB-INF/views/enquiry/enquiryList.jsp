<%@page import="java.util.*" %>
<%@page import="enquiry.model.vo.Enquiry" %>
<%@page import="enquiry.model.service.EnquiryService" %>
<%@page import="member.model.service.MemberService" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>


<%
	List<Enquiry> list = (List<Enquiry>)request.getAttribute("list");
%>
<%
	Enquiry enquiry = (Enquiry)request.getAttribute("enquiry");

%>

<div class = "max-w-screen-lg m-auto my-10">
<img id="enquiryImg" src="<%=request.getContextPath() %>/images/enquiry.jpg" alt="공지사항" />
<style>
#enquiryImg{
	width: 100%;
	height:400px;
	opacity: 0.9;
}

section#board-container{width:100%; margin:0 auto; text-align:center;}
table#tbl-board{width:100%; margin:0 auto; border-collapse:collapse; clear:both; }
table#tbl-board th, table#tbl-board td { text-align: center;  padding: 8px;} 
table#tbl-board th  { background-color: white; color:  rgba(36, 124, 58, 0.781);}
table#tbl-board th {
 	background-color: white; 
	border-top: 3px solid rgba(36, 124, 58, 0.5); 
	border-bottom: 3px solid rgba(36, 124, 58, 0.5); 
 	color:  rgba(36, 124, 58, 0.781);}
table#tbl-board tr:nth-child(even) {background-color: rgba(80, 199, 109, 0.13);}

#btn-add{
 background-color: white;
  color: rgba(36, 124, 58, 0.781);
  padding: 10px 10px;
  border-radius: 12px;
  border: 3px solid rgba(36, 124, 58, 0.5);
  cursor: pointer;
  width: 80px;
  opacity: 0.9;
  float: right;

}
#btn-add:hover{
	background-color: rgba(80, 199, 109, 0.4);
	color: white;
}

</style>


	<section id="board-container">
		
		<br /><br />	
		<table id="tbl-board">
			<tr>
				<th>번호</th>
				<th class = "w-1/2">제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>답변여부</th>
			
			</tr>
	
	<% 	if(list == null || list.isEmpty()){  %>		
			<tr>
				<th colspan="6">조회된 게시물이 없습니다.</th>
			</tr>
	<% 	
		} else {
			for(Enquiry eq : list){
	%>	
		<tr class = "border-b">
		<% if(memberLoggedIn!=null && 
			(eq.getMemberId().equals(memberLoggedIn.getMemberId())
			|| MemberService.ADMIN_MEMBER_ROLE.equals(memberLoggedIn.getMemberRole())) ) { %>
			<td><%= eq.getKey() %></td>
			<td>
				<a class= "font-bold text-gray-700 float-left hover:underline" href="<%= request.getContextPath() %>/enquiry/view?enquiryNo=<%= eq.getKey() %>">
				<%= eq.getTitle() %>
				</a>
			</td>
			
			<td><%= eq.getMemberId() %></td>
			<td><%= eq.getEnrollDate() %></td> 				
			<td><% if(eq.getStatus().equals("T")) { %>
					<p class="font-bold text-red-500">답변완료</p>				 			
				<%} else {%>
				<p class= "text-gray-700">답변중</p>
				<%} %>
			</td> 
			<%} %>
		</tr>
				
	
	<%
			}
		} 
	%>		
		</table>
	<br />
	
		<% 	if(memberLoggedIn != null){ %>
		<input type="button" value="글쓰기" id="btn-add" 
			   onclick="location.href='<%= request.getContextPath() %>/enquiry/insert';" />
		<% 	} %>
	<br />
	<br />
	
			 <div class="align-middle flex justify-center">
				         <div class="flex rounded-md mt-8">
				             <%= request.getAttribute("pageBar") %>
			             </div>
				    </div>
	</section>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>