<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBegin.jsp"%><%
	/*
		Content: ���ҿ��ҳ�� ,��������
	 */
	String sAreaCode = CurPage.getParameter("AreaCode");
%><%@include file="/Resources/CodeParts/Frame03.jsp"%>
<script type="text/javascript">
	myleft.width=340;
	OpenPage("/Common/ToolsA/AreaCodeSelect.jsp?AreaCode=<%=sAreaCode%>","frameleft","");
	OpenPage("/Blank.jsp?TextToShow=�������б���ѡ��һ��","frameright","");
</script>	
<%@ include file="/IncludeEnd.jsp"%>