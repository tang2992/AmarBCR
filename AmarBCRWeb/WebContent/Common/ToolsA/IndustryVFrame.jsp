<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBegin.jsp"%><%
	/*
		Content: 左右框架页面
	 */
	String sIndustryType = CurPage.getParameter("IndustryType");
%><%@include file="/Resources/CodeParts/Frame03.jsp"%>
<script type="text/javascript">
	myleft.width=340;
	OpenPage("/Common/ToolsA/IndustryTypeSelect.jsp?IndustryType=<%=sIndustryType%>","frameleft","");
	OpenPage("/Blank.jsp?TextToShow=请在左方列表中选择一项","frameright","");
</script>	
<%@ include file="/IncludeEnd.jsp"%>