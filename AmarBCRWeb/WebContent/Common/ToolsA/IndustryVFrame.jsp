<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBegin.jsp"%><%
	/*
		Content: ���ҿ��ҳ��
	 */
	String sIndustryType = CurPage.getParameter("IndustryType");
%><%@include file="/Resources/CodeParts/Frame03.jsp"%>
<script type="text/javascript">
	myleft.width=340;
	OpenPage("/Common/ToolsA/IndustryTypeSelect.jsp?IndustryType=<%=sIndustryType%>","frameleft","");
	OpenPage("/Blank.jsp?TextToShow=�������б���ѡ��һ��","frameright","");
</script>	
<%@ include file="/IncludeEnd.jsp"%>