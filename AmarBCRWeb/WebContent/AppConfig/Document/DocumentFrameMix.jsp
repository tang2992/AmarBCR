<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
/*
	--ҳ��˵��: ���ҿ��ҳ��,���Ϊ�ĵ�������Ϣ���Ҳ�Ϊ������Ϣ--
 */
%><%@include file="/Resources/CodeParts/Frame03.jsp"%>
<script type="text/javascript">
	myleft.width=480;//�������������
	AsControl.OpenComp("/AppConfig/Document/DocumentInfo.jsp","","frameleft","");
	AsControl.OpenComp("/AppConfig/Document/AttachmentFrame.jsp", "", "frameright");
</script>
<%@ include file="/IncludeEnd.jsp"%>