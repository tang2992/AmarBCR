<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
 <%
	/*
		ҳ��˵��: ʾ���б�ҳ��
	 */
	String PG_TITLE = "����������Ϣ";
	//���ҳ�����
	String sCIFCustomerID =  CurPage.getParameter("sCIFCustomerID");
	if(sCIFCustomerID==null) sCIFCustomerID="";
	String sFlag =  CurPage.getParameter("sFlag");
	if(sFlag==null) sFlag="";
	String sTable =  CurPage.getParameter("sTableName");
	if(sTable==null) sTable="";
	String sIsPatch = CurComp.getParameter("IsPatch");
	if(sIsPatch == null) sIsPatch = "";
System.out.println("sFlag:"+sFlag);
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTable.toUpperCase());
	//��ȡ�ñ�����еĹؼ���
	String[] keyAttrs = boManager.getManagedClass().getKeyAttributes();
		String sKeyName="";
	for(String key: keyAttrs){
		sKeyName += key+"@";
	}
		
	ASObjectModel doTemp = new ASObjectModel(boManager);
	
	 String jBOWhere="";
	jBOWhere="CIFCustomerID=:CIFCustomerID";
	doTemp.setJboWhere(jBOWhere);
	doTemp.setVisible("Mfcustomerid,Customertype,Nationaltaxno,Localtaxno,Accountpermitno,Gatherdate,Attribute1,oldFinanceid,Modflag,Recordflag,Manageorgid,Registerdate,Registerduedate,Capitalcurrency,Orgtypesub,Updatedate", false);
	doTemp.setHTMLStyle("RELATIONSHIP", "style={width:200px}");
	doTemp.setHTMLStyle("Relativeentname", "style={width:200px}");
	
	doTemp.setDDDWJbo("REGISTERTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9039'"); //ע������
	doTemp.setDDDWJbo("CAPITALCURRENCY", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='1501'"); //����
	doTemp.setDDDWJbo("CUSTOMERTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9040'");
	doTemp.setDDDWJbo("ORGTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9043'");//��֯�������
	doTemp.setDDDWJbo("ORGNATURE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9044'");//��������
    doTemp.setDDDWJbo("ORGTYPESUB", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9045'");//��֯�������ϸ��
	doTemp.setDDDWJbo("SCOPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9050'");//��ҵ��ģ
	doTemp.setDDDWJbo("ACCOUNTSTATUS", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9042'");//������״̬
	doTemp.setDDDWCodeTable("INCREMENTFLAG", "1,����,2,ҵ����,4,ɾ��,6,�ֹ��ս�,8,��Ǩ��");//��Ϣ����״̬
	doTemp.setDDDWJbo("ORGSTATUS", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9041'");//����״̬
	doTemp.setDDDWJbo("MANAGERTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9046'");//��ϵ������
		if(sTable.equals("ECR_ORGANSTOCKHOLDER"))
			doTemp.setDDDWJbo("CERTTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname in ('9047','9039')");//֤������
		else
			doTemp.setDDDWJbo("CERTTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9047'");//֤������
	doTemp.setDDDWJbo("STOCKHOLDERTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9048'");//�ɶ�����
	doTemp.setDDDWJbo("MEMBERRELATYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='5555'");
	doTemp.setDDDWJbo("MANAGERCERTTYPE,MEMBERCERTTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9047'");//֤������
	doTemp.setDDDWJbo("RELATIONSHIP", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9049'");//������ҵ��������
	doTemp.setDDDWJbo("Registercountry", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='5509'");
	doTemp.setDDDWJbo("INDUSTRY", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='5525'");
	
	doTemp.setColumnFilter("*", false);
	doTemp.setColumnFilter("CIFCUSTOMERID,FINANCEID,LOANCARDNO,Managertype,Certid,Relativeentname,Relationship,Superiorname,Managername,SESSIONID", true);


 //˫���¼�
   doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
		
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(10);

	 dwTemp.genHTMLObjectWindow(sCIFCustomerID);

		String sButtons[][] = {
				{"true","","Button","�����ϱ�","�����ϱ�","report(2)","","","",""},
				{"true","","Button","�ݲ��ϱ�","�ݲ��ϱ�","report(3)","","","",""},
				{"true","","Button","©������","��������©���ļ�¼","report(4)","","","",""},
				{"true","","Button","����","�޸�/�鿴����","viewAndEdit()","","","",""},
				};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
function report(action){
	var sTableName = "<%=sTable%>";
	var sTraceNumber = getItemValue(0,getRow(),"TRACENUMBER");
	var sSessionID = getItemValue(0,getRow(),"SESSIONID");
	var sCIFCustomerID = getItemValue(0,getRow(),"CIFCUSTOMERID");
	var sWhere;
	var sReturn;
	
	if(typeof(sSessionID)=="undefined"||sSessionID==''){
		alert("����ѡ��һ����¼!");
		return;		
	}
	//�����Ѿ��ϱ�����ҵ���ܲ��������ݲ���
	if(typeof(sSessionID) != "undefined" && sSessionID!="9999999999" && sSessionID!="1111111111" && sSessionID!="0000000000" && sSessionID!="6666666666" &&(action=="2"||action=="3"))
	{
		if(confirm("�ñ�ҵ���Ѿ��ϱ�����,�Ƿ�ӷ����������ɾ��������¼?")){
			PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TraceNumber="+sTraceNumber,"_self","");
			alert("������¼�Ѵӷ����������ɾ��!");
			return;
		}
	}
	//û����Ϣ���ٱ��,���������ϱ�
	if((typeof(sTraceNumber) == "undefined" || sTraceNumber.length == 0)&&action=="2")
	{
		alert("��Ϣ���ٱ�Ų�����,�޷������ر�!");
		return;
	}
	if(action=="2"){
		if(confirm("ȷ�������ϱ�?")){
			sWhere = "and TRACENUMBER = '"+sTraceNumber+"'";
			sReturn = PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TableName="+sDBTableName+"&TraceNumber="+sTraceNumber+"&Where="+sWhere+"&Action="+action,"_self","");
			if(sReturn == "Success"){
				alert("�����ر���־�ɹ�!");
			}else{
				alert("�����ر���־ʧ��!");
			}
		}
	}else if(action=="3"){
		if(confirm("ȷ���ݲ��ϱ�?")){
			sWhere = "and TRACENUMBER = '"+sTraceNumber+"'";
			sReturn = PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TableName="+sDBTableName+"&TraceNumber="+sTraceNumber+"&Where="+sWhere+"&Action="+action,"_self","");
			if(sReturn == "Success"){
				alert("�����ݲ��ϱ���־�ɹ�!");
			}else{
				alert("�����ݲ��ϱ���־ʧ��!");
			}
		}
	}else if(action=="4"){
		if(confirm("ȷ����������?")){
		 	var sKeyName="<%=sKeyName%>".split("@");
		var sWhere = " where 1=1 and   "+sKeyName[0]+"='" + getItemValue(0,getRow(), sKeyName[0]) + "'";
   
     	
    		for(var  i=1;i<sKeyName.length;i++){

    			sKeyValue =  getItemValue(0,getRow(),sKeyName[i]);
    			if("CIFCUSTOMERID"=="RETURNTIMES")
    				sWhere = sWhere + " and  "+sKeyName[i]+" ='" + sKeyValue+"'";
    			else
    				sWhere = sWhere + " and  "+sKeyName[i]+"='" + sKeyValue + "'";
		 		}
			sReturn = PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TableName="+sDBTableName+"&Where="+sWhere+"&Action="+action,"_self","");
			if(sReturn == "Success"){
				alert("���ò�����־�ɹ�!");
			}else{
				alert("���ò�����־ʧ��!");
			}
		}
	}
	reloadSelf();
}
function viewAndEdit(){
	var sTableName = "<%=sTable%>";
	var sCIFCustomerID = getItemValue(0,getRow(),"CIFCUSTOMERID");
	if (typeof(sCIFCustomerID)=="undefined" || sCIFCustomerID.length==0){
		alert("��ѡ��һ����¼��");
		return;
	}
	var sKeyValue="";
	var sKeyName="<%=sKeyName%>";
	for(var i=0;i<sKeyName.split("@").length-1;i++){ 
		sKeyValue+= getItemValue(0,getRow(),sKeyName.split("@")[i])+"@";
	}
	AsControl.OpenView("/ErrorManage/FeedBackManage/FeedbackOrgan/FeedBackOrganInfo.jsp","&sKeyName="+sKeyName+"&sKeyValue="+sKeyValue+"&sCIFCustomerID="+sCIFCustomerID+"&sTableName="+sTableName,"_blank","");
	reloadSelf();
	self.parent.location.reload();
}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>
