<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
	String PG_TITLE = "�ͻ���Ϣά��"; // ��������ڱ��� <title> PG_TITLE </title>
	%>

<%
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr.ECR_ORGANINFO");
	ASObjectModel doTemp = new ASObjectModel(boManager);
	
	doTemp.setJboWhere("LOANCARDNO is not null");
	if(!CurUser.getUserID().equals("system")){
		doTemp.setJboWhere(doTemp.getJboWhere()+" and O.FINANCEID IN (select OI.ORGID from jbo.ecr.ORG_TASK_INFO OI where OI.ORGCODE='"+CurUser.getRelativeOrgID()+"')");
	}

	//����html��ʽ
	doTemp.setHTMLStyle("CUSTOMERNAME"," style={width:200px;} ");

	//���ù����ֶ�
	doTemp.setColumnFilter("*",false);
	doTemp.setColumnFilter("CIFCUSTOMERID,LSCUSTOMERID,CUSTOMERNAME,LOANCARDNO", true);
	doTemp.setVisible("*",false);
	doTemp.setVisible("CIFCUSTOMERID,LSCUSTOMERID,CUSTOMERNAME,FINANCEID,CORPID,LOANCARDNO,REGISTERTYPE,REGISTERNO,OCCURDATE", true);

	//����˫���¼�
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(20);//��ҳ��ʾ
	
	dwTemp.genHTMLObjectWindow("");
	
%>

	<%
	String sButtons[][] = {
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		};
	%> 

<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script language=javascript>

	//---------------------���尴ť�¼�------------------------------------
	/*~[Describe=������¼;InputParam=��;OutPutParam=��;]~*/

	//��ȡ�������
	function viewAndEdit()
	{
		var sLOANCARDNO = getItemValue(0,getRow(),"LOANCARDNO");
		var sCustomerID = getItemValue(0,getRow(),"CIFCUSTOMERID");
    	if(typeof(sLOANCARDNO)=="undefined" || sLOANCARDNO.length==0) {
			alert("��ѡ��һ����Ϣ��");//��ѡ��һ����Ϣ��
            return ;
		}
		popComp("SynthesisMaintanceInfoDetail","/DataMaintain/SynthesisMaintance/SynthesisMaintanceInfoDetail.jsp","LoanCardNo="+sLOANCARDNO+"&CustomerID="+sCustomerID,"");
		reloadSelf();
	}
	 
	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>