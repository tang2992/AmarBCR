<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
/*
	ҳ��˵��: �����������ҳ��
 */
%><%@include file="/Resources/CodeParts/Frame02.jsp"%>
<script type="text/javascript">
	mytoptd.height = "200";
	AsControl.OpenView("/Common/SecurityAudit/UserLogonWelcomeList.jsp","","rightup","");
	AsControl.OpenView("/Blank.jsp","TextToShow=����ѡ����Ӧ���û���Ϣ!","rightdown","");
</script>
<%@ include file="/IncludeEnd.jsp"%>