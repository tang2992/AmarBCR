<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*�û�����ʱ����־*/
	sASWizardHtml = "<font color=red>��ҳ���������ϴ���ͨ����ѯ������ѯ</font>";
	String sToday = StringFunction.getToday();
	ASObjectModel doTemp = new ASObjectModel("AuditUserPageList");
	doTemp.setJboWhereWhenNoFilter(" and 1 = 2 "); //�������������ν���ҳ���ʱ���Զ���ѯ
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����ΪGrid���
	dwTemp.ReadOnly = "1"; //����Ϊֻ��
	dwTemp.setPageSize(40); 	//��������ҳ
	dwTemp.genHTMLObjectWindow(sToday);
				
	String sButtons[][] = {};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
</script>
<%@include file="/Frame/resources/include/include_end.jspf"%>