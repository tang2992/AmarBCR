<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin.jspf"%>
<%
	String sObjectNo = CurPage.getParameter("ObjectNo");
%>
<div>
<%=new Button("��һ��", "", "parent.wizard.toPrevStep()").getHtmlText()%>
<%=new Button("��һ��", "", "parent.wizard.toNextStep()").getHtmlText()%>
</div>
<div>
	<span>�����ţ�</span><span><%=sObjectNo%></span>
</div>
<%@ include file="/Frame/resources/include/include_end.jspf"%>