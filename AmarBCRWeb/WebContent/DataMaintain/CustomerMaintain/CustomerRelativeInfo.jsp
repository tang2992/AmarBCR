<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>

	<%
	String PG_TITLE = "���������б�"; // ��������ڱ��� <title> PG_TITLE </title>

	//�������
	//��ȡ�������
	//KeyName(Ҫ���ҵı�ҵ��Ĺؼ���),KeyValue(Ҫ���ҵı�ҵ��Ĺؼ��ֵ�ֵ)
	//TableFlag��ʾ������ʾhis��,����ecr��
	//���������Ĳ�����(���ڸ�ҳ���ǹ�����ҳ��,���ڲ�ͬ��ҳ��İ�ť�ǲ�ͬ��,����������ť����ʾЧ������;)
	String sTableName = CurPage.getParameter("sTableName");
	if(sTableName == null) sTableName = "";
	sTableName = sTableName.toUpperCase();
	String sTableFlag = CurPage.getParameter("TableFlag");
	if(sTableFlag == null) sTableFlag = "";
	String sKeyValue = CurPage.getParameter("KeyValue");
	if(sKeyValue == null) sKeyValue = "";
	//��ֻ�ܲ�ѯ��ģ�������ر��水ť
	String sIsQuery = CurPage.getParameter("IsQuery");
	if(sIsQuery == null) sIsQuery = "";
	//�����ڴ���ҳ���еı������ذ�ť������
	String sQueryType = CurPage.getParameter("QueryType");
	if(sQueryType == null) sQueryType = "";
	String sType = CurPage.getParameter("Type");
	if(sType == null) sType = "";

	String keyStr,valueStr,jboWhere="",args="";
	if(sKeyValue.length()>0){
		String[] kv = sKeyValue.split("~");
		keyStr = kv[0];
		valueStr = kv[1];
		String[] kArr = keyStr.split("`");
		String[] vArr = valueStr.split("`");
		for(int ii=0; ii<kArr.length; ii++){
			String k = kArr[ii];
			String v = vArr[ii];
			jboWhere = jboWhere+" and "+k+"=:"+k;
			args = args+","+v;
		}
		jboWhere = jboWhere.substring(4);
		args = args.substring(1);
	}
	
	//��ȡҳ�����
	String sShow = "true";
	//ֻҪ��HIS��,�������ۺϲ�ѯ���õ�ҳ��,����ӵ�в鿴Ȩ�޶���ӵ��ά��Ȩ��,��ô�����ذ�ť
	if(sQueryType.equals("ERROR")){
		if(sTableFlag.equals("HIS")||sIsQuery.equals("true")||(CurUser.hasRole("0200")&&!CurUser.hasRole("0201"))){
		sShow = "false";
		}	
	}else{
		if(sTableFlag.equals("HIS")||sIsQuery.equals("true")||(CurUser.hasRole("0100")&&!CurUser.hasRole("0101"))){
			sShow = "false";
		}	
	}

	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
	ASObjectModel doTemp = new ASObjectModel(boManager);
	doTemp.setJboWhere(jboWhere);
	doTemp.setVisible("*",true);
	doTemp.setColCount(2);
	doTemp.setReadOnly("CustomerID",true);
	if(sTableFlag.equals("ECR"))
		doTemp.setVisible("TRACENUMBER,MODFLAG,SESSIONID,SESSIONIDNAME,ERRORCODE,RECORDFLAG",false);
	
	doTemp.setEditStyle("REPORTTYPE,REPORTSUBTYPE,REPORTYEAR,Incrementflag", "Select");
	doTemp.setEditStyle("Occurdate,AUDITDATE", "Date");
	doTemp.setDDDWJbo("REPORTTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7507'");
	doTemp.setDDDWJbo("REPORTSUBTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7651'");
	//������ʾ����ģ������
	String date = StringFunction.getToday().substring(0,4);
	int iDate = Integer.valueOf(date).intValue();
	String sDate=date+","+date;
	for(int i=iDate-1,j=2;i>iDate-100;i--,j++) 
		sDate= sDate +","+ i+","+ String.valueOf(i);
	//����������
	doTemp.setDDDWCodeTable("REPORTYEAR",sDate);
	doTemp.setDDDWCodeTable("INCREMENTFLAG", "1,����,2,ҵ����,4,ɾ��,6,�ֹ��ս�,8,��Ǩ��");//��Ϣ����״̬
	doTemp.setRequired("CUSTOMERID,CUSTOMERNAME,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE,OCCURDATE,FINANCEID,Loancardno,M9537,M9567,M9587,M9617,M9631,M9635,M9671,M9673", true);
	doTemp.setRequired("M9675,M9701,M9711,M9747,M9755",true);
	doTemp.setRequired("M9813,M9833,M9851,M9855",true);
	doTemp.setRequired("M9111,M9129,M9130,M9143,M9151,M9152,M9158,M9159",true);
	doTemp.setRequired("M9170,M9180,M9184,M9186",true);
	doTemp.setRequired("M9208,M9220,M9229,M9231,M9233",true);
	doTemp.setRequired("M9282,M9293,M9294,M9303,M9311,M9319,M9320",true);
	doTemp.setRequired("M9358,M9361",true);
	doTemp.setRequired("Lawno,Plaintiffname,Currency,Executesum,Executedate,Executeresult,Appellcause",true);
	doTemp.setRequired("Factno,Describe",true);
	//�������������Ҷ���
	for(DataElement de:boManager.getManagedClass().getAttributes()){
		if(de.getType()==DataElement.DOUBLE || de.getType()==DataElement.INT || de.getType()==DataElement.LONG){
			doTemp.setAlign(de.getName(), "3");
		}
	}
  
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	if("false".equals(sShow))
		dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	else dwTemp.ReadOnly = "0";
    dwTemp.setPageSize(20);

    dwTemp.genHTMLObjectWindow(args);
	
%>

	<%	
	String sButtons[][] = {
			{sShow,"","Button","����","����","saveRecord()","","","",""},
			{"Info".equals(sType)?"false":"true","","Button","����","�����б�ҳ��","goBack()","","","",""},
			{"Info".equals(sType)?"true":"false","","Button","�鿴��ʷ��¼","�鿴��ʷ��¼","showHISContent()","","","",""}
	};
	%> 
	
	<%@include file="/Frame/resources/include/ui/include_info.jspf"%>

	<script type="text/javascript">
	function showHISContent(){
		popComp("","/DataMaintain/CustomerMaintain/CustomerRelativeList.jsp","sTableName=<%=StringFunction.replace(sTableName,"ECR","HIS")%>&KeyValue=<%=sKeyValue%>&TableFlag=HIS&IsQuery=<%=sIsQuery%>&QueryType=<%=sQueryType%>&sType=organ","");         
	}
	//---------------------���尴ť�¼�------------------------------------
	function saveRecord()
	{
		if (!ValidityCheck()) return;
		as_save("myiframe0","");
	}
	function getIndustryType()
	{
		var sIndustryType = getItemValue(0,0,"INDUSTRYTYPE");
		var sReturn = PopComp("IndustryVFrame","/DataMaintain/IndustryVFrame.jsp","IndustryType="+sIndustryType,"dialogWidth:730px;dialogHeight:540px;resizable:no;scrollbars:no;status:no;help:no");
		if(typeof(sReturn)=="undefined" || sReturn=="") return;
		var sReturnvalues = sReturn.split("@");
		setItemValue(0,0,"INDUSTRYTYPE",sReturnvalues[0]);
		setItemValue(0,0,"INDUSTRYTYPENAME",sReturnvalues[1]);
	}
	function getCountryName()
	{
		var sCOUNTRYCODE = getItemValue(0,0,"COUNTRYCODE");
		var sReturn = PopComp("GetMyFrame","/DataMaintain/GetMyFrame.jsp","DataType=5509&IniteValue="+sCOUNTRYCODE,"dialogWidth:320px;dialogHeight:540px;resizable:no;scrollbars:no;status:no;help:no");
		if(typeof(sReturn)=="undefined" || sReturn=="") return;
		var sReturnvalues = sReturn.split("@");
		setItemValue(0,0,"COUNTRYCODE",sReturnvalues[0]);
		setItemValue(0,0,"COUNTRYNAME",sReturnvalues[1]);
	}
	function getRegionCodeName()
	{
		var sREGIONCODE = getItemValue(0,0,"REGIONCODE");
		//var sReturn = PopComp("GetMyFrame","/DataMaintain/GetMyFrame.jsp","DataType=5527&IniteValue="+sREGIONCODE,"dialogWidth:320px;dialogHeight:540px;resizable:no;scrollbars:no;status:no;help:no");
		var sReturn = PopComp("RegionCodeVFrame","/DataMaintain/RegionCodeVFrame.jsp","RegionCode="+sREGIONCODE,"dialogWidth:730px;dialogHeight:540px;resizable:no;scrollbars:no;status:no;help:no");
		if(typeof(sReturn)=="undefined" || sReturn=="") return;
		var sReturnvalues = sReturn.split("@");
		setItemValue(0,0,"REGIONCODE",sReturnvalues[0]);
		setItemValue(0,0,"REGIONCODENAME",sReturnvalues[1]);
	}

	/*~[Describe=�����б�ҳ��;InputParam=��;OutPutParam=��;]~*/
	function goBack(){
		top.close();
		reloadSelf();
	}
	
	/*~[Describe=ҳ��װ��ʱ����DW���г�ʼ��;InputParam=��;OutPutParam=��;]~*/
	function initRow()
	{
		if (getRowCount(0)==0) //���û���ҵ���Ӧ��¼��������һ�����������ֶ�Ĭ��ֵ
		{
			as_add("myiframe0");//������¼
			bIsInsert = true;
		}
    }
    
    /*~[Describe=��Ч�Լ��;InputParam=��;OutPutParam=ͨ��true,����false;]~*/
	function ValidityCheck()
	{	
		var sMetaTableName = "<%=sTableName%>";
			//������У��
			var sLoanCardNo = getItemValue(0,0,"LOANCARDNO");
			if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
				if(!CheckLoanCardID(sLoanCardNo)){
					alert('��������������!');
					return false;
				}
			}
			//�����ͳһ��У��
			var sCUSTOMERID=getItemValue(0,0,"CUSTOMERID");
			var sReturnLoanCardNo=RunJavaMethodSqlca("com.amarsoft.app.action.CheckLoanCardNoAction","getLoanCardNo","LOANCARDNO="+sLoanCardNo+",CUSTOMERID="+sCUSTOMERID);
			if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=sReturnLoanCardNo){
				alert("����źͿͻ��Ĵ���Ų�һ�£�");
				return false;
			}
		 if("ECR_FINANCEPS"==sMetaTableName){
			//������У��
			var sLoanCardNo = getItemValue(0,0,"LOANCARDNO");
			if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
				if(!CheckLoanCardID(sLoanCardNo)){
					alert('��������������!');
					return false;
				}
			}
			//�����ͳһ��У��
			var sCUSTOMERID=getItemValue(0,0,"CUSTOMERID");
			var sReturnLoanCardNo=RunJavaMethodSqlca("com.amarsoft.app.action.CheckLoanCardNoAction","getLoanCardNo","LOANCARDNO="+sLoanCardNo+",CUSTOMERID="+sCUSTOMERID);
			if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=sReturnLoanCardNo){
				alert("����źͿͻ��Ĵ���Ų�һ�£�");
				return false;
			}

		}else if("ECR_FINANCECF"==sMetaTableName){
		//������У��
		var sLoanCardNo = getItemValue(0,0,"LOANCARDNO");
		if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
			if(!CheckLoanCardID(sLoanCardNo)){
				alert('��������������!');
				return false;
			}
		}
		//�����ͳһ��У��
		var sCUSTOMERID=getItemValue(0,0,"CUSTOMERID");
		var sReturnLoanCardNo=RunJavaMethodSqlca("com.amarsoft.app.action.CheckLoanCardNoAction","getLoanCardNo","LOANCARDNO="+sLoanCardNo+",CUSTOMERID="+sCUSTOMERID);
		if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=sReturnLoanCardNo){
			alert("����źͿͻ��Ĵ���Ų�һ�£�");
			return false;
		}
		}
		 
		return true;
		

	}
	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>