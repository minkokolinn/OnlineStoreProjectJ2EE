<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="header.jsp">
	<jsp:param value="Error" name="pageTitle" />
	<jsp:param value="error" name="pageName" />
</jsp:include>

<%
if (request.getAttribute("error") != null) {
%>
<div class="alert alert-danger mx-5 my-3"><%=request.getAttribute("error") %></div>
<%
}
%>

<jsp:include page="footer.jsp"></jsp:include>