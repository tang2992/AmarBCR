<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
 	/*�������ֶΣ�ColActualName��ͬ����List����*/
	ASObjectModel doTemp = new ASObjectModel("DemoEntList");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";		//--����ΪGrid���--
	dwTemp.ReadOnly = "0";	//ֻ��ģʽ
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {
		{"true","All","Button","����","���������޸�","as_save(0)","","","","btn_icon_save"},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function mySelectRow(){
		alert("��"+(getRow()+1)+"�е�CI�ͻ���ţ�"+getItemValue(0,getRow(),"V.CUSTOMERID1")+",EI�ͻ���ţ�"+getItemValue(0,getRow(),"CUSTOMERID"));
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
