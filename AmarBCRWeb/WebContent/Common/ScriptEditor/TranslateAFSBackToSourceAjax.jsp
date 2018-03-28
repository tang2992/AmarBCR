<%@page import="com.amarsoft.app.alarm.StringTool"%>
<%@page import="com.amarsoft.biz.finance.*" %>
<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBeginMDAJAX.jsp"%><%
	String sReturnValue="";
	String sScriptText = CurPage.getParameter("AFScriptSourceAfterEdit");
	if (sScriptText==null) sScriptText="";
	sScriptText = StringFunction.replace(sScriptText,"$[wave]","~");
	sScriptText = Report.transExpression(1,sScriptText.trim(),Sqlca);
	sScriptText = SpecialTools.real2Amarsoft(sScriptText);

	out.println(sScriptText);
%><%@ include file="/IncludeEndAJAX.jsp"%>