<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBeginMD.jsp"%>

<html>
<head>
<title>���ʱ��</title>

<%
	String	sReturn	= StringFunction.getToday();
%>

<script language=javascript>
	top.returnValue = "<%=sReturn%>";
	top.close();
</script>
<%@ include file="/IncludeEnd.jsp"%>
