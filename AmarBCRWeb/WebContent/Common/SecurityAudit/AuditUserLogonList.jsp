<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
 	/*�û�����ʱ����־*/
	sASWizardHtml = "<font color=red>��ҳ���������ϴ���ͨ����ѯ������ѯ</font>";

	//���ҳ��������û���
	String sUserID = CurPage.getParameter("UserID");
	if(sUserID == null) sUserID = "";

	ASObjectModel doTemp = new ASObjectModel("AuditUserLogonList");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����ΪGrid���
	dwTemp.ReadOnly = "1"; //����Ϊֻ��
	dwTemp.setPageSize(40); //��������ҳ
	dwTemp.genHTMLObjectWindow(sUserID);

	String sButtons[][] = {};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
</script>
<%@include file="/Frame/resources/include/include_end.jspf"%>