<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%
	/* ҳ��˵��: ʾ������ҳ�� */
	String PG_TITLE = "����������Ϣ����";

	// ���ҳ�����
	String sCIFCustomerID =  CurPage.getParameter("sCIFCustomerID");
	if(sCIFCustomerID==null) sCIFCustomerID="";
	String sKeyValue =  CurPage.getParameter("sKeyValue");
	if(sKeyValue==null||"".equals(sKeyValue)) sKeyValue=sCIFCustomerID+"@";
	String sKeyName= CurPage.getParameter("sKeyName");
	if(sKeyName==null) sKeyName="";
	String sSessionID= CurPage.getParameter("sSessionID");
	if(sSessionID==null) sSessionID="";
	String sTable =  CurPage.getParameter("sTable");
	if(sTable==null) sTable="";
	String sFlag =  CurPage.getParameter("sFlag");
	if(sFlag==null) sFlag="";
	String sFlags =  CurPage.getParameter("sFlags");
	if(sFlags==null) sFlags="";
	//��ֻ�ܲ�ѯ��ģ�������ر��水ť
	String sIsQuery = CurComp.getParameter("IsQuery");
	if(sIsQuery == null) sIsQuery = "";
	//�����ڴ���ҳ���еı������ذ�ť������
	String sQueryType = CurComp.getParameter("QueryType");
	if(sQueryType == null) sQueryType = "";

	String sShow = "true";
	//ֻҪ��HIS��,�������ۺϲ�ѯ���õ�ҳ��,����ӵ�в鿴Ȩ�޶���ӵ��ά��Ȩ��,��ô�����ذ�ť
	if(sQueryType.equals("ERROR")){
		if(sFlag.equals("his")||sIsQuery.equals("true")||(CurUser.hasRole("0200")&&!CurUser.hasRole("0201"))){
		sShow = "false";
		}	
	}else{
		if(sFlag.equals("his")||sIsQuery.equals("true")||(CurUser.hasRole("0100")&&!CurUser.hasRole("0101"))){
			sShow = "false";
		}	
	}
	
	//��ʷ��from��������
	if(sFlag.equals("his"))
		sTable=sTable.replace("ECR_", "HIS_");
	
	ASObjectModel doTemp = null;
	if(sTable.toUpperCase().equals("ECR_ORGANATTRIBUTE") ||sTable.toUpperCase().equals("HIS_ORGANATTRIBUTE")){
		 doTemp = new ASObjectModel("OrgAttributeInfo");
		 doTemp.setJboClass("jbo.ecr."+sTable);
	}else{ 
		BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTable.toUpperCase());
		doTemp = new ASObjectModel(boManager);
		//�������������Ҷ���
		for(DataElement de:boManager.getManagedClass().getAttributes()){
			if(de.getType()==DataElement.DOUBLE || de.getType()==DataElement.INT || de.getType()==DataElement.LONG){
				doTemp.setAlign(de.getName(), "3");
			}
		}
	}

	//����where����
	String jBOWhere="";
	String args="";

	if(sKeyName.isEmpty()&&(!sFlag.equals("new"))){
		 jBOWhere="CIFCustomerID=:CIFCustomerID";
	     args=sCIFCustomerID;
	}else{
		String[] nameArr=sKeyName.split("@");
		String[] valueArr=sKeyValue.split("@");
		for(int i=0; i<nameArr.length; i++){
			String k = nameArr[i];
			String v = valueArr[i];
			jBOWhere =jBOWhere+" and "+k+"=:"+k;
			args = args+","+v;
		}
		jBOWhere = jBOWhere.substring(4);
		args = args.substring(1);
	} 
	//��ʷ��from��������
	/* 	if(sFlag.equals("his")){			
			for(int i=0;i<sKeyName.split("@").length-1;i++)
			doTemp.WhereClause+=" and  "+sKeyName.split("@")[i]+"='"+sKeyValue.split("@")[i]+"' " +" and SESSIONID='"+sSessionID+"'" ;
		} */
    doTemp.setJboWhere(jBOWhere);
	
	doTemp.setVisible("ATTRIBUTE1,MODFLAG,TRACENUMBER,RECORDFLAG,ERRORCODE,SESSIONID,OCCURDATE", false);
	doTemp.setReadOnly("CIFCustomerID", true);
	doTemp.setRequired("CIFCustomerID,FINANCEID,CUSTOMERTYPE,GATHERDATE,UPDATEDATE", true);
    //���ڸ�ʽ
    doTemp.setEditStyle("GATHERDATE,OCCURDATE,REGISTERDATE,REGISTERDUEDATE,UPDATEDATE","Date");
    
    doTemp.setEditStyle("REGISTERTYPE,CAPITALCURRENCY,CUSTOMERTYPE,ORGTYPE,ORGNATURE,ORGTYPESUB,SCOPE,ACCOUNTSTATUS,INCREMENTFLAG,ORGSTATUS,MANAGERTYPE,CERTTYPE,STOCKHOLDERTYPE,RELATIONSHIP,MEMBERRELATYPE,MANAGERCERTTYPE,MEMBERCERTTYPE", "Select");
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
	doTemp.setDDDWJbo("STOCKHOLDERTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9048'");//�ɶ�����
	if(sTable.equals("ECR_ORGANSTOCKHOLDER")||sTable.equals("HIS_ORGANSTOCKHOLDER"))
		doTemp.setDDDWJbo("CERTTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname in ('9047','9039')");//֤������
	else
		doTemp.setDDDWJbo("CERTTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9047'");//֤������
	doTemp.setDDDWJbo("MEMBERRELATYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='5555'");
	doTemp.setDDDWJbo("MANAGERCERTTYPE,MEMBERCERTTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9047'");//֤������
	doTemp.setDDDWJbo("RELATIONSHIP", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9049'");//������ҵ��������
	doTemp.setUnit("RegistercountryName","<input type=button class=inputDate   value=\"...\" name=button1 onClick=\"javascript:getRegisterCountryAnIndustry('5509');\"> ");
	doTemp.setUnit("IndustryName","<input type=button class=inputDate   value=\"...\" name=button2 onClick=\"javascript:getRegisterCountryAnIndustry('5525');\"> ");
	doTemp.setDefaultValue("UPDATEDATE",DateX.format(new java.util.Date(), "yyyy/MM/dd")); 
     
	doTemp.setColCount(2);
   
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      // ����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; // �����Ƿ�ֻ�� 1:ֻ�� 0:��д
	if("false".equals(sShow))dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	else dwTemp.ReadOnly = "0";
	dwTemp.genHTMLObjectWindow(args);//�������,���ŷָ� 
	
	
	String sButtons[][] = {
		{sShow,"","Button","����","���������޸�","saveRecord()","","","",""},
		{((sFlags.equals("Info")&&!sFlag.equals("his"))||"syn".equals(sFlag))?"false":"true","","Button","����","�����б�ҳ��","goBack('"+sFlag+"')","","","",""},
		{(sFlags.equals("Info")&&!sFlag.equals("his"))?"true":"false","","Button","�鿴��ʷ��¼","�鿴��ʷ��¼","showHISContent('"+sTable+"','"+sKeyValue.split(",")[0]+"')","","","",""} 
	};
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function saveRecord(){
		if (!ValidityCheck()) return;
		as_save("myiframe0");
	}
	//���У����Ϣ
	function ValidityCheck(){
		var sTable="<%=sTable%>";
		if("ECR_ORGANINFO"==sTable || "HIS_ORGANINFO"==sTable){
			//�������ô���У��
			var CreditCode = getItemValue(0,0,"CREDITCODE");
			if(CreditCodeCheck(CreditCode)==false&&typeof(CreditCode)!="undefined"&&CreditCode!=""){
				alert("�������ô����ʽ����");
				return false;
			}
			//��֯��������У��
			var sCorpID=getItemValue(0,0,"CORPID");
			if(typeof(sCorpID)!="undefined"&&sCorpID!=""){
				if(!CheckORG(sCorpID)){
					alert('��֯����������������!');
					return false;
				}
			}
		}
		//������У��
		var sLoanCardNo = getItemValue(0,0,"LOANCARDNO");
		if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
			if(!CheckLoanCardID(sLoanCardNo)){
				alert('��������������!');
				return false;
			}
		}
	
		var sSTOCKHOLDERTYPE = getItemValue(0,0,"STOCKHOLDERTYPE");
		var sCERTID=getItemValue(0,0,"CERTID");
		var sCORPID=getItemValue(0,0,"CORPID");
		var sCREDITCODE=getItemValue(0,0,"CREDITCODE");
		if(sSTOCKHOLDERTYPE=="2"){
			if((sCERTID==""||sCERTID==null)&&(sCORPID==""||sCORPID==null)&&(sCREDITCODE==""||sCREDITCODE==null)){
             alert("֤������/�Ǽ�ע����롢��֯�������롢�������ô��벻��ȫΪ�գ�");
	         return false;
		   }
		}		
		return true;
	}
	
	//��ȡ����;�����ҵ����
 	function getRegisterCountryAnIndustry(scolName){
		var sReturn = PopComp("GetMyFrame","/DataMaintain/GetMyFrame.jsp","DataType="+scolName,"dialogWidth:320px;dialogHeight:540px;resizable:no;scrollbars:no;status:no;help:no");
		if(typeof(sReturn)=="undefined" || sReturn=="") return;
		var sReturnvalues = sReturn.split("@");
		 if(scolName=="5509"){
		    setItemValue(0,0,"REGISTERCOUNTRY",sReturnvalues[0]);
		    setItemValue(0,0,"RegistercountryName",sReturnvalues[1]);	
		}else if(scolName="5525"){
			 setItemValue(0,0,"INDUSTRY",sReturnvalues[0]);
			 setItemValue(0,0,"IndustryName",sReturnvalues[1]);	
		}else{
			return;
		} 
	}  
	
	//������ҵ����

		function CreditCodeCheck(CreditCode){
			var patt1 = new RegExp("[A-Z]{1}[0-9]{16}[0-9A-Z\\*]{1}");
			var result = patt1.test(CreditCode);
			return result;
		}

	function goBack(sFlag){
		if(sFlag=="his"){
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","sTable=<%=sTable%>&sFlag=his&sCIFCustomerID=<%=sKeyValue.split("@")[0]%>&IsQuery=<%=sIsQuery%>","_self");
		}else{					
		 OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","sTable=<%=sTable%>&sFlag=Detail&sCIFCustomerID=<%=sKeyValue.split("@")[0]%>&IsQuery=<%=sIsQuery%>","_self");
		}
	}
	
	//��ʾ��ʷ��¼
	function showHISContent(sTable){
		AsControl.OpenView("/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","sFlag=his&sTable="+sTable+"&sCIFCustomerID=<%=sKeyValue.split("@")[0]%>","_blank","");
	}
	
	function initRow(){
		if (getRowCount(0)==0){//�統ǰ�޼�¼��������һ��
			setItemValue(0,getRow(),"CIFCustomerID","<%=sCIFCustomerID%>");
		}
    }
	
	initRow();
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
