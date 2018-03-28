<%@page import="com.amarsoft.awe.dw.ASObjectWindow"%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>

	<%
		String PG_TITLE = "业务相关数据列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>

<%

	//定义变量
	//获取组件参数
    //TableFlag表示：是显示his表,还是ecr表
	//对于其他的参数：(由于该页面是公共的页面,对于不同的页面的按钮是不同的,是用来区别按钮的显示效果的用途)
	
	String sTableName = CurPage.getParameter("sTableName");
	if(sTableName == null) sTableName = "";
	String sTableFlag = CurPage.getParameter("TableFlag");
	if(sTableFlag == null) sTableFlag = "";
	String sKeyName = CurPage.getParameter("KeyName");
	if(sKeyName == null) sKeyName = "";
	String sKeyValue = CurPage.getParameter("KeyValue");
	if(sKeyValue == null) sKeyValue = "";
	//用于在查询界面中隐藏保存按钮
	String sIsQuery = CurPage.getParameter("IsQuery");
	if(sIsQuery == null) sIsQuery = "";
	//用于在校验错误中隐藏保存按钮
	String sQueryType = CurPage.getParameter("QueryType");
	if(sQueryType == null) sQueryType = "";
	String sReportType = CurPage.getParameter("ReportType");
	if(sReportType == null) sReportType = "";
	String sType = CurPage.getParameter("Type");
	if(sType == null) sType = "";

	//当主键发生变更的情况时，重新载入页面进行值替换即可
	//当主键变更的情况，有三种情况：OCCURDATE,EXTENTIMES,RETURNTIMES
	//当主键变化的时候,重新载入当前的用户,根据新的值进行载入
	String sNewName = "";
	String sNewValue = (String) session.getAttribute("ALOANCARDNO");
	if(sNewValue==null){
	}else{
		sNewName = "ALOANCARDNO";
		session.removeAttribute("ALOANCARDNO");
	}
	
%>

<%	
	String sShow = "true";
	//只要是HIS表,或者是综合查询调用的页面,并且拥有查看权限而不拥有维护权限,那么就隐藏按钮
	if(sQueryType.equals("ERROR")){
		if(sTableFlag.equals("HIS")||sIsQuery.equals("true")||(CurUser.hasRole("0200")&&!CurUser.hasRole("0201"))){
		sShow = "false";
		}	
	}else{
		if(sTableFlag.equals("HIS")||sIsQuery.equals("true")||(CurUser.hasRole("0100")&&!CurUser.hasRole("0101"))){
			sShow = "false";
		}	
	}

	ASObjectModel doTemp = null;
	if(sTableName.toUpperCase().equals("ECR_LOANDUEBILL") ||sTableName.toUpperCase().equals("HIS_LOANDUEBILL")){
		 doTemp = new ASObjectModel("LoanduebillInfo");
		 doTemp.setJboClass("jbo.ecr."+sTableName);
	}else{ 

		BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
		doTemp = new ASObjectModel(boManager);

	//设置数字类型右对齐
	for(DataElement de:boManager.getManagedClass().getAttributes()){
		if(de.getType()==DataElement.DOUBLE || de.getType()==DataElement.INT || de.getType()==DataElement.LONG){
			doTemp.setAlign(de.getName(), "3");
		}
	}
	}

	//更改where条件
	String jBOWhere="";
	String args="";
	
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

	doTemp.setJboWhere(jBOWhere);
	doTemp.setColCount(2); //分栏

	if(sTableFlag.equals("ECR")){
		doTemp.setVisible("TRACENUMBER,MODFLAG,SESSIONID,ERRORCODE,Recordflag,Updatedate",false);
	}else if(sTableFlag.equals("HIS")){
		doTemp.setVisible("MODFLAG,Recordflag,Updatedate",false);
	}

	if(sReportType.equals("2"))
	{   
		 if(sTableName.equals("ECR_ASSURECONT"))
		doTemp.setVisible("ALoanCardNo,REPORTTYPE",false);
		if(sTableName.equals("ECR_GUARANTYCONT"))//抵押
		doTemp.setVisible("GLoanCardNo,REPORTTYPE",false);
		if(sTableName.equals("ECR_IMPAWNCONT"))//质押
		 doTemp.setVisible("ILoanCardNo,REPORTTYPE",false);
	   
	}else{
		 doTemp.setVisible("CERTTYPE,CERTID,REPORTTYPE",false);
	}
	//贷款业务的详情展示
	doTemp.setReadOnly("Lcontractno,Lduebillno,Contractno,Assurecontno,Guarantycontno,Impawncontno,WayName", true);
	doTemp.setEditStyle("Occurdate,Startdate,Enddate,Putoutdate,Putoutenddate,Returndate,Extenstartdate,Extenenddate,Createdate,Evaluatedate,Registdate", "Date");
	doTemp.setRequired("*", true);
	doTemp.setRequired("Customerid,Modflag,Tracenumber,Recordflag,Oldfinanceid,Creditno,Sessionid,Errorcode,Aloancardno,Gloancardno,Evaluatecurrency,Evaluatesum,Evaluatedate,Evaluateoffice,Evaluateofficeid,Registdate,Classify4,Updatedate", false);
	doTemp.setEditStyle("IncrementFlag,Bankflag,Guarantyflag,Availabstatus,Currency,Recycle,Returnmode,Businesstype,Form,Loancharacter,Kind,Extenflag,Classify5,Classify4,Assurecurrency,Assureform,Evaluatecurrency,Guarantytype,Guarantycurrency,Valuecurrency,Impawntype,Impawncurrency", "Select");
	doTemp.setDDDWCodeTable("IncrementFlag", "1,新增,2,业务变更,4,删除,6,手工终结,8,已迁移");//信息操作状态
	doTemp.setDDDWJbo("Bankflag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7521'");
	doTemp.setDDDWJbo("Guarantyflag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7523'");
	doTemp.setDDDWJbo("Availabstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7525'");
	doTemp.setDDDWJbo("Currency", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='1501'");
	doTemp.setDDDWCodeTable("Recycle", "1,是,2,否");//信息操作状态
	doTemp.setDDDWJbo("Returnmode", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7545'");
	if(sTableName.equals("ECR_LOANDUEBILL")){
		doTemp.setDDDWJbo("Businesstype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7529'");
	} else if (sTableName.equals("ECR_FINADUEBILL")){
		doTemp.setDDDWJbo("Businesstype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7569'");
		}else{
		doTemp.setDDDWJbo("Businesstype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7605'");
		}
	doTemp.setDDDWJbo("Form", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7531'");
	doTemp.setDDDWJbo("Loancharacter", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7533'");
	doTemp.setDDDWJbo("Kind", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7537'");
	doTemp.setDDDWJbo("Extenflag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7573'");
	doTemp.setDDDWJbo("Classify5", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7541'");
	doTemp.setDDDWJbo("Classify4", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7539'");
	doTemp.setDDDWJbo("Assurecurrency", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='1501'");
	doTemp.setDDDWJbo("Assureform", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7603'");
	doTemp.setDDDWJbo("Evaluatecurrency", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='1501'");
	doTemp.setDDDWJbo("Guarantytype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7617'");
	doTemp.setDDDWJbo("Guarantycurrency", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='1501'");
	doTemp.setDDDWJbo("Valuecurrency", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='1501'");
	doTemp.setDDDWJbo("Impawntype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7621'");
	doTemp.setDDDWJbo("Impawncurrency", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='1501'");
	doTemp.setUnit("WayName","<input type=button class=inputDate   value=\"...\" name=button2 onClick=\"javascript:getWay();\"> ");
	
	//保理业务的详情展示
	doTemp.setReadOnly("Factoringno", true);
	doTemp.setEditStyle("Businessdate,Balancechangedate", "Date");
	doTemp.setEditStyle("Factoringtype,Factoringstatus,Floorflag", "Select");
	doTemp.setDDDWJbo("Factoringtype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7549'");
	doTemp.setDDDWJbo("Factoringstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7551'");
	doTemp.setDDDWJbo("Floorflag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7513'");
	//票据贴现业务的详情展示
	doTemp.setReadOnly("Billno", true);
	doTemp.setRequired("Acceptername,Aloancardno", false);
	doTemp.setEditStyle("Discountdate,Acceptmaturity", "Date");
	doTemp.setEditStyle("Billtype,Billstatus", "Select");
	doTemp.setDDDWJbo("Billtype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7555'");
	doTemp.setDDDWJbo("Billstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7561'");
	//贸易融资业务的详情展示
	doTemp.setReadOnly("Fcontractno,Fduebillno", true);
	doTemp.setRequired("Acceptername,Aloancardno", false);
	doTemp.setEditStyle("Discountdate,Acceptmaturity", "Date");
	doTemp.setEditStyle("Billtype,Billstatus", "Select");
	doTemp.setDDDWJbo("Billtype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7555'");
	doTemp.setDDDWJbo("Billstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7561'");
	//信用证业务的详情展示
	doTemp.setReadOnly("Creditletterno", true);
	doTemp.setRequired("Logoutdate", false);
	doTemp.setEditStyle("Availabterm,Logoutdate,Balancereportdate", "Date");
	doTemp.setEditStyle("Payterm,Creditstatus", "Select");
	doTemp.setDDDWJbo("Payterm", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='2579'");
	doTemp.setDDDWJbo("Creditstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7501'");
	//保函业务的详情展示
	doTemp.setReadOnly("Guaranteebillno", true);
	doTemp.setRequired("Enddate", false);
	doTemp.setEditStyle("Balanceoccurdate", "Date");
	doTemp.setEditStyle("Guaranteetype,Guaranteestatus", "Select");
	doTemp.setDDDWJbo("Guaranteetype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='2579'");
	doTemp.setDDDWJbo("Guaranteestatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7501'");
	//承兑汇票业务的详情展示
	doTemp.setReadOnly("Acontractno,Acceptno", true);
	doTemp.setRequired("Acceppaydate", false);
	doTemp.setEditStyle("Accepdate,Accependdate,Acceppaydate", "Date");
	doTemp.setEditStyle("Draftstatus", "Select");
	doTemp.setDDDWJbo("Draftstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7591'");
	//公开授信业务的详情展示
	doTemp.setReadOnly("Ccontractno", true);
	doTemp.setRequired("Creditlogoutdate,Creditlogoutcause", false);
	doTemp.setEditStyle("Creditstartdate,Creditenddate,Creditlogoutdate", "Date");
	doTemp.setEditStyle("Creditlogoutcause", "Select");
	doTemp.setDDDWJbo("Creditlogoutcause", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='8511'");
	//垫款业务的详情展示
	doTemp.setReadOnly("Floorfundno", true);
	doTemp.setEditStyle("Floordate", "Date");
	doTemp.setEditStyle("Floortype", "Select");
	doTemp.setDDDWJbo("Floortype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7625'");
	//欠息业务的详情展示
	doTemp.setEditStyle("Changedate", "Date");
	doTemp.setEditStyle("Interesttype", "Select");
	doTemp.setDDDWJbo("Interesttype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7631'");
	//不良资产处置业务的详情展示
	doTemp.setReadOnly("Businessno", true);
	doTemp.setRequired("Loancardno,Organizationcode,Businessregistryno,Recoveryamount", false);
	doTemp.setEditStyle("Disposedate", "Date");
	doTemp.setEditStyle("Disposetype", "Select");
	doTemp.setDDDWJbo("Disposetype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7639'");

	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform

	if("false".equals(sShow))dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	else dwTemp.ReadOnly = "0";
	
	dwTemp.genHTMLObjectWindow(args);
%>

	<%
	
	String sButtons[][] = {
			{sShow,"","Button","保存","保存","saveRecord()","","","",""},
			//{sShow.equals("true")&&sTableName.equals("ECR_ASSURECONT")?"true":"false","","Button","更改保证人贷款卡编号","更改保证人贷款卡编号","changeALoanCardNo()","","","",""},
			{"info".equals(sType)?"true":"false","","Button","查看历史记录","查看历史记录","showHISContent()","","","",""},
		};
	%> 

	<%@include file="/Frame/resources/include/ui/include_info.jspf"%>

	<script type="text/javascript">
	function saveRecord()
	{	
		if (!ValidityCheck()) return;
		as_save("myiframe0");
	}
	//显示历史信息
 	function showHISContent(){
	<%-- 	<%
			if(sTableName.indexOf("HIS")>=0)
				sTableName = StringFunction.replace(sTableName,"HIS","ECR");
		%> --%>
			popComp("","/DataMaintain/BusinessMaintain/BusinessRelativeList.jsp","sTableName=<%=StringFunction.replace(sTableName,"ECR","HIS")%>&KeyName=<%=sKeyName%>&KeyValue=<%=sKeyValue%>&TableFlag=HIS&IsQuery=<%=sIsQuery%>&QueryType=<%=sQueryType%>","");         
	}
	//---------------------定义按钮事件------------------------------------

	/*~[Describe=返回列表页面;InputParam=无;OutPutParam=无;]~*/
	function goBack(){
		top.close();
	}
	
	/*~[Describe=有效性检查;InputParam=无;OutPutParam=通过true,否则false;]~*/
	function ValidityCheck()
	{	
		var sTableName = "<%=sTableName%>";
		if(sTableName=="ECR_LOANCONTRACT"||sTableName=="ECR_FACTORING"||sTableName=="ECR_DISCOUNT"||sTableName=="ECR_FINAINFO"
		   ||sTableName=="ECR_CREDITLETTER"||sTableName=="ECR_GUARANTEEBILL"||sTableName=="ECR_ACCEPTANCE"||sTableName=="ECR_CUSTOMERCREDIT"
		   ||sTableName=="ECR_FLOORFUND"||sTableName=="ECR_INTERESTDUE"){

			//贷款卡编号校验
			var sLoanCardNo = getItemValue(0,0,"LOANCARDNO");
			if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
				if(!CheckLoanCardID(sLoanCardNo)){
					alert('贷款卡编号输入有误!');
					return false;
				}
			}
		}
		if(sTableName=="ECR_ASSURECONT") {
			//贷款卡编号校验
			var sLoanCardNo = getItemValue(0,0,"ALOANCARDNO");
			if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
				if(!CheckLoanCardID(sLoanCardNo)){
					alert('贷款卡编号输入有误!');
					return false;
				}
			}
			
		}else if(sTableName=="ECR_GUARANTYCONT") {

			//贷款卡编号校验
			var sLoanCardNo = getItemValue(0,0,"GLOANCARDNO");
			if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
				if(!CheckLoanCardID(sLoanCardNo)){
					alert('贷款卡编号输入有误!');
					return false;
				}
			}
			var sEVALUATEOFFICEID = getItemValue(0,0,"EVALUATEOFFICEID");
			if(typeof(sEVALUATEOFFICEID)!="undefined"&&sEVALUATEOFFICEID!=""){
				if(!CheckORG(sEVALUATEOFFICEID)){
					alert('评估机构组织机构代码输入有误!');
					return false;
				}
			}
		}else if(sTableName=="ECR_IMPAWNCONT") {
			var sLoanCardNo = getItemValue(0,0,"ILOANCARDNO");
			if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
				if(!CheckLoanCardID(sLoanCardNo)){
					alert('贷款卡编号输入有误!');
					return false;
				}
			}
		}else if(sTableName=="ECR_CREDITLETTER") {
			
			var sCREDITSTATUS = getItemValue(0,0,"CREDITSTATUS");
			var sLOGOUTDATE = getItemValue(0,0,"LOGOUTDATE");
			if(sCREDITSTATUS=="2") {
				if(typeof(sLOGOUTDATE)=="undefined"||sLOGOUTDATE==""){
					alert('信用证状态为注销时信用证注销日期为必输项!');
					return false;
				}	
			}else {
				if(typeof(sLOGOUTDATE)!="undefined"&&sLOGOUTDATE!=""){
					alert('信用证状态不为注销时信用证注销日期必须为空!');
					return false;
				}
			}
		}
		return true;
	}

    //获取行业投向
    function getWay(){
    	var sReturn = PopComp("GetMyFrame","/DataMaintain/GetMyFrame.jsp","DataType=7535","dialogWidth:320px;dialogHeight:540px;resizable:no;scrollbars:no;status:no;help:no");
		if(typeof(sReturn)=="undefined" || sReturn=="") return;
		var sReturnValues = sReturn.split("@");
		setItemValue(0,0,"Way",sReturnValues[0]);
		setItemValue(0,0,"WayName",sReturnValues[1]);
    }
	
    function changeALoanCardNo(){
		var sALoanCardNo = getItemValue(0,getRow(),"ALOANCARDNO");
		if(typeof(sALoanCardNo) != "undefined"&&sALoanCardNo.length!=0){
			var sKeyValueS = getItemValue(0,getRow(),"<%=sKeyName.split("@")[0]%>");
    	<%
    		for(int i=1;i<sKeyName.split("@").length;i++){
    	%>
    			sKeyValueS = sKeyValueS +  "@" + getItemValue(0,getRow(),"<%=sKeyName.split("@")[i]%>");
    	<%				
    		}
    	%>
			var returnValue = popComp("ChangeALoanCardNo","/ErrorManage/ValidateErrorManage/ChangeALoanCardNo.jsp","DBTableName=<%=sTableName%>&KeyName=<%=sKeyName%>&KeyValue="+sKeyValueS+"&ALOANCARDNO="+sALoanCardNo,"dilogWidth=19;dialogHeight=14;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
			reloadSelf();
		}
	}
	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
