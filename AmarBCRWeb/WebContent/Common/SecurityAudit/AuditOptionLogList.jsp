<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*��ȫѡ�������*/
 	ASObjectModel doTemp = new ASObjectModel("AuditOptionLogList");
 	doTemp.setJboWhereWhenNoFilter(" and BeginTime like '"+StringFunction.getToday()+"%'");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����ΪGrid���
	dwTemp.ReadOnly = "1"; //����Ϊֻ��
	dwTemp.setPageSize(40); 	//��������ҳ
	dwTemp.genHTMLObjectWindow("");
				
	String sButtons[][] = {};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
</script>
<%@include file="/Frame/resources/include/include_end.jspf"%>