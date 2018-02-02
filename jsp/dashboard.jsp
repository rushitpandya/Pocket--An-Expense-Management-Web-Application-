<%@page import="pocket.controllers.*"%>
<%@page import="pocket.utility.*"%>
<%@page import="pocket.dao.*"%>
<%@page import="pocket.beans.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>

<%
session=request.getSession(false);
if(session.getAttribute("User") == null)
{
	%>
	<jsp:forward page="index.jsp" />
	<%
}
%>
<jsp:include page='header.jsp'/>
<jsp:include page='leftnavigation.jsp'/>
<jsp:include page='upperheader.jsp'/>
<jsp:include page='content.jsp'/>
<jsp:include page='importscripts.jsp'/>