<%@ page contentType="text/html; charset=GBK"%>
<%@include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
	String PG_TITLE = "�ͻ���Ϣά��"; // ��������ڱ��� <title> PG_TITLE </title>
	
	ASObjectModel doTemp = new ASObjectModel("EcrOrginfoList");//EcrOrginfolist
	
	String jboWhere = " LSCUSTOMERID is not null";
	if(!CurUser.getUserID().equals("system")){
		jboWhere = jboWhere + " and  FINANCEID IN (select a.ORGID from jbo.ecr.ORG_TASK_INFO a where a.orgcode='"+CurUser.getRelativeOrgID()+"')";
	}
	doTemp.setJboWhere(jboWhere);
	
	/* sASWizardHtml = "<font color=red>��ҳ���������ϴ���ͨ����ѯ������ѯ</font>";
	doTemp.setJboWhereWhenNoFilter(" and 1=2 "); */
	
	doTemp.setDDDWJbo("REGISTERTYPE","jbo.ecr.WEB_CODEMAP,Pbcode,Note,Colname='9039'");	
	//doTemp.set
	//˫���¼�
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //����ΪGrid���
	//dwTemp.MultiSelect = true; //�����ѡ
	dwTemp.ReadOnly = "1";	 //�༭ģʽ
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");
	%>

	<%

	String sButtons[][] = {
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","","btn_icon_detail",""},
		};
	%> 

	<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script type="text/javascript">

	//---------------------���尴ť�¼�------------------------------------
	/*~[Describe=������¼;InputParam=��;OutPutParam=��;]~*/

	function viewAndEdit()
	{
		var sCustomerID  = getItemValue(0,getRow(),"LSCUSTOMERID");
		if(typeof(sCustomerID)=="undefined" || sCustomerID.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
            return ;
		}
		popComp("CustomerInfoDetail","/DataMaintain/CustomerMaintain/CustomerInfoDetail.jsp","CustomerID="+sCustomerID,"");
		reloadSelf();
	}
	 
	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>