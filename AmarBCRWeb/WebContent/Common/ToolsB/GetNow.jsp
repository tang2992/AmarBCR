<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBeginMD.jsp"%>

<html>
<head>
<title>���ʱ��</title>

<%
	String	sReturn	= StringFunction.getToday()+" "+StringFunction.getNow();
%>

<script language=javascript>
	self.returnValue = "<%=sReturn%>";
	self.close();
</script>
<%@ include file="/IncludeEnd.jsp"%>
