<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
	String PG_TITLE = "һ���໧"; // ��������ڱ��� <title> PG_TITLE </title>
	%>

<%
	ASObjectModel doTemp = new ASObjectModel("OneCardToUserList");
	//����datawindow
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	doTemp.setHTMLStyle("ChineseName"," style={width:220px} ");
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	//���õ�ҳ��ʾ20��
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");
	
%>

	<%
	String sButtons[][] = {
		{"false","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		{"false","","Button","����EXCEL","����EXCEL","as_defaultExport()","","","",""}
		};
	%> 

<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
	<script language=javascript>

	//---------------------���尴ť�¼�------------------------------------
	/*~[Describe=�鿴/�޸�����;InputParam=��;OutPutParam=��;]~*/
	function viewAndEdit()
	{
		var sPutoutNO=getItemValue(0,getRow(),"AccountNo");	
		if (typeof(sPutoutNO)=="undefined" || sPutoutNO.length==0)
		{
			alert("��ѡ��һ����¼��");
			return;
		}	
		popComp("PayPlanInfo","/Icr/BusinessData/Current/PayPlanInfo.jsp","PutoutNO="+sPutoutNO,"dialogWidth=350px;dialogHeight=430px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
		reloadSelf();
	}
	 
	</script>

<%@ include file="/Frame/resources/include/include_end.jspf"%>
