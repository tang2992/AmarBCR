<%@ page language="java" import="com.amarsoft.are.*" pageEncoding="GBK"%><%
/*
��鵼���Ƿ����
*/
if(session.getAttribute("CheckExportPage"+request.getParameter("rand"))==null){
	out.print("false");
}else{
	session.removeAttribute("CheckExportPage"+request.getParameter("rand"));
	ARE.getLog().trace("clear session:" + "CheckExportPage"+request.getParameter("rand"));
	out.print("true");
}
%>