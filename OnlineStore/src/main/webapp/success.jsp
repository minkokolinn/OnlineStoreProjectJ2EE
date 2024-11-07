<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="header.jsp">
	<jsp:param value="Success" name="pageTitle" />
	<jsp:param value="success" name="pageName" />
</jsp:include>

<%
if (request.getAttribute("success") != null) {
%>
<div class="alert alert-success mx-5 my-3"><%=request.getAttribute("success") %></div>
<%
}
%>

<jsp:include page="footer.jsp"></jsp:include>