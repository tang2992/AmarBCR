<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
	String PG_TITLE = "������Ϣ�б�"; // ��������ڱ��� <title> PG_TITLE </title>
	%>

<%	

	String sRecordType = CurComp.getParameter("recordType");
	if(sRecordType == null) sRecordType = "";
	
	/* BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr.ECR_FEEDBACK");
	ASObjectModel doTemp = new ASObjectModel(boManager); */
	ASObjectModel doTemp = new ASObjectModel("ECRFEEDBACK"); 
	
	String jBOWhere =" recordType not in ('73','74') ";//ɾ����������Ҫ����ɾ��ֻ��֪���Ƿ�ɹ�
	if(!sRecordType.equals("")){
		jBOWhere  += "  and  recordType =:recordType";
	}
	if(!CurUser.getUserID().equals("system")){
		jBOWhere = jBOWhere+" and O.FINANCEID IN (select UO.Orgid from jbo.ecr.ORG_TASK_INFO UO where UO.OrgCode='"+CurUser.getRelativeOrgID()+"')";
	}  
	doTemp.setJboWhere(jBOWhere);
	
	//����˫������
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewDetail()\"");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	//���õ�ҳ��ʾ20�� 
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow(sRecordType);

%>

	<%
	String sButtons[][] = {
			{"true","","Button","����","�����޸Ľ���","viewDetail()","","","",""},
			{"true","","Button","ɾ��","ȷ�����޸�,ɾ���ü�¼","deleteRecord()","","","",""},
	    	{"true","","Button","����EXCEL","����EXCEL","as_defaultExport()","","","",""},
		};
	%> 

	<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script type="text/javascript">

	//---------------------���尴ť�¼�------------------------------------
	
	/*~[Describe=�鿴/�޸�����;InputParam=��;OutPutParam=��;]~*/

	function viewDetail(){
		var sTRACENUMBER = getItemValue(0,getRow(),"TRACENUMBER");
		if (typeof(sTRACENUMBER)=="undefined" || sTRACENUMBER.length==0)
		{
			alert("��ѡ��һ����¼��");
			return;
		}

		var sMAINBUSINESSNO = getItemValue(0,getRow(),"MAINBUSINESSNO");
		var sLOANCARDNO = getItemValue(0,getRow(),"LOANCARDNO");
		var sCUSTOMERID = getItemValue(0,getRow(),"CUSTOMERID");
		var sRECORDTYPE = getItemValue(0,getRow(),"RECORDTYPE");
		var sRECORDKEY  = getItemValue(0,getRow(),"RECORDKEY");

		if(!(typeof(sMAINBUSINESSNO)=="undefined" || sMAINBUSINESSNO.length==0)){
			if((parseInt(sRECORDTYPE )<8) || (parseInt(sRECORDTYPE)>=43&&parseInt(sRECORDTYPE)<=47)){
				var sRetrun = popComp("FeedBackInfoDetail","/ErrorManage/FeedBackManage/FeedBackInfoDetail.jsp","CUSTOMERID="+sCUSTOMERID+"&sRECORDTYPE="+sRECORDTYPE,"");
				if(sRetrun=="false"){
					alert("����������Ϣ��Ӧ��ҵ����Ϣ�Ѿ�������,��ɾ��������¼!");
				}
			}else if(parseInt(sRECORDTYPE)>70 && parseInt(sRECORDTYPE)<=78){//��������
				var sRetrun = popComp("FeedBackOrganDetail","/ErrorManage/FeedBackManage/FeedbackOrgan/FeedBackOrganTreeview.jsp","MAINBUSINESSNO="+sMAINBUSINESSNO+"&sRECORDTYPE="+sRECORDTYPE,"");
				if(sRetrun=="false"){
					alert("����������Ϣ��Ӧ��ҵ����Ϣ�Ѿ�������,��ɾ��������¼!");
				}
			}else{
				var sRetrun = popComp("FeedBackInfoDetail","/ErrorManage/FeedBackManage/FeedBackInfoDetail.jsp","MAINBUSINESSNO="+sMAINBUSINESSNO+"&LOANCARDNO="+sLOANCARDNO+"&RECORDKEY="+sRECORDKEY+"&sRECORDTYPE="+sRECORDTYPE,"");
				if(sRetrun=="false"){
					alert("����������Ϣ��Ӧ��ҵ����Ϣ�Ѿ�������,��ɾ��������¼!");
				}
			}
		}
		reloadSelf();
	}
	function deleteRecord()
	{
		var sTRACENUMBER = getItemValue(0,getRow(),"TRACENUMBER");
		if (typeof(sTRACENUMBER)=="undefined" || sTRACENUMBER.length==0)
		{
			alert("��ѡ��һ����¼��");
			return;
		}
		
		if(confirm("�������ɾ������Ϣ��")) 
		{
			as_delete("myiframe0","reloadSelf()");
		}
	}

	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>