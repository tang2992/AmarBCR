<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
	String PG_TITLE = "�ͻ���Ϣά��"; // ��������ڱ��� <title> PG_TITLE </title>
	%>

<%
	ASObjectModel doTemp = new ASObjectModel("QueryCustomerList");
	 
	if(!CurUser.getUserID().equals("system")){
		doTemp.setJboWhere(doTemp.getJboWhere()+" and  O.FINANCEID IN (select OI.ORGID from jbo.ecr.ORG_TASK_INFO OI where OI.OrgCode='"+CurUser.getRelativeOrgID()+"')");
	}
	
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(20);//��ҳ��ʾ
	dwTemp.genHTMLObjectWindow("");
	
%>
<%

	String sButtons[][] = {
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","","btn_icon_detail",""},
		};
	%> 

	<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
	<script language=javascript>

	//---------------------���尴ť�¼�------------------------------------
	/*~[Describe=������¼;InputParam=��;OutPutParam=��;]~*/

	function viewAndEdit()
	{
		var sCustomerID  = getItemValue(0,getRow(),"CIFCUSTOMERID");
		if(typeof(sCustomerID)=="undefined" || sCustomerID.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
            return ;
		}
		popComp("CustomerInfoDetail","/DataMaintain/CustomerMaintain/CustomerInfoDetail.jsp","CustomerID="+sCustomerID+"&Query=true","");
		reloadSelf();
	}
	 
	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>