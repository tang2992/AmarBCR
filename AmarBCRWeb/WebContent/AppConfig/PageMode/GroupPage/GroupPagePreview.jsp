<%@page import="com.amarsoft.awe.ui.layout.grouppage.*"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin.jspf"%><%
	String sGroupID = CurPage.getParameter("GroupID");
	try{
		//Ԥ��ҳ��ʹ�õ����Ĺ�����
		GroupModelManager m = new PreviewManager(sGroupID,CurUser);
		//��Ⱦ
		out.println(m.getHtmlText());
	}catch(Exception e){
%>
	<script type="text/javascript">
		setDialogTitle("�Բ�������ʧ�ܣ�");
	</script>
<%		throw e;
	}
%><%@ include file="/Frame/resources/include/include_end.jspf"%>