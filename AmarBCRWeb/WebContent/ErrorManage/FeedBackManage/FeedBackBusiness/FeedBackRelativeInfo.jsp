<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>

	<%
		String PG_TITLE = "业务相关数据列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>

<%

	//定义变量
	//获取组件参数
	//参数主要有：sTableName(数据库中要查找的字段),KeyName(要查找的本业务的关键字),KeyValue(要查找的本业务的关键字的值)
	//TableFlag表示：是显示his表,还是ecr表
	//对于其他的参数：(由于该页面是公共的页面,对于不同的页面的按钮是不同的,是用来区别按钮的显示效果的用途)
	String sTableName = CurComp.getParameter("sTableName");
	if(sTableName == null) sTableName = "";
	String sTableFlag = CurComp.getParameter("TableFlag");
	if(sTableFlag == null) sTableFlag = "";
	String sKeyName = CurComp.getParameter("KeyName");
	if(sKeyName == null) sKeyName = "";
	String sKeyValue = CurComp.getParameter("KeyValue");
	if(sKeyValue == null) sKeyValue = "";

	//当主键发生变更的情况时，重新载入页面进行值替换即可
	//当主键变更的情况，有三种情况：OCCURDATE,EXTENTIMES,RETURNTIMES
	//当主键变化的时候,重新载入当前的用户,根据新的值进行载入
	String occurDate =(String) session.getAttribute("OCCURDATE");
	if(occurDate==null) occurDate = "OCCURDATE";session.removeAttribute("OCCURDATE");
	String extenTimes = (String) session.getAttribute("EXTENTIMES");
	if(extenTimes==null) extenTimes = "EXTENTIMES";session.removeAttribute("EXTENTIMES");
	String returnTimes = (String) session.getAttribute("RETURNTIMES");
	if(returnTimes==null) returnTimes = "RETURNTIMES";session.removeAttribute("RETURNTIMES");
	
	//对主键名和键值进行对应,设置where子句
		//更改where条件
		String jBOWhere="";
		String args="";
		
		String[] stName=sKeyName.split("@");
		String[] stValue=sKeyValue.split("@");
		for(int i=0; i<stName.length; i++){
			String k = stName[i];
			String v = stValue[i];
			if("OCCURDATE".equalsIgnoreCase(k)&&!occurDate.equals("OCCURDATE"))
				k = occurDate;
			if("EXTENTIMES".equalsIgnoreCase(k)&&!extenTimes.equals("EXTENTIMES"))
				k = extenTimes;
			if("RETURNTIMES".equalsIgnoreCase(k)&&!returnTimes.equals("RETURNTIMES"))
				k = returnTimes;
	
			jBOWhere =jBOWhere+" and "+k+"=:"+k;
			args = args+","+v;
		}
		jBOWhere = jBOWhere.substring(4);
		if(!args.isEmpty())
			args = args.substring(1);
%>

<%	
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
	ASObjectModel doTemp = new ASObjectModel(boManager);
	
	doTemp.setJboWhere(jBOWhere);
	doTemp.setColCount(2); //分栏
	doTemp.setVisible("MODFLAG,Recordflag",false);
	
	//贷款业务的详情展示
	doTemp.setReadOnly("Lcontractno,Lduebillno,Contractno,Assurecontno,Guarantycontno,Impawncontno,Occurdate", true);
	doTemp.setEditStyle("Occurdate,Startdate,Enddate,Putoutdate,Putoutenddate,Returndate,Extenstartdate,Extenenddate,Createdate,Evaluatedate,Registdate", "Date");
	doTemp.setRequired("*", true);
	doTemp.setRequired("Customerid,Modflag,Tracenumber,Recordflag,Oldfinanceid,Creditno,Sessionid,Errorcode,Aloancardno,Gloancardno,Evaluatecurrency,Evaluatesum,Evaluatedate,Evaluateoffice,Evaluateofficeid,Registdate,Classify4,Updatedate", false);
	doTemp.setEditStyle("IncrementFlag,Bankflag,Guarantyflag,Availabstatus,Currency,Recycle,Returnmode,Businesstype,Form,Loancharacter,Way,Kind,Extenflag,Classify5,Classify4,Assurecurrency,Assureform,Evaluatecurrency,Guarantytype,Guarantycurrency,Valuecurrency,Impawntype,Impawncurrency", "Select");
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
	doTemp.setDDDWJbo("Way", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7535'");
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
	//获取该表的所有的关键字
	String[] sName= boManager.getManagedClass().getKeyAttributes();
	String sKeyStr="";
	for(String key: sName){
		sKeyStr += key+"@";
	}

	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	dwTemp.genHTMLObjectWindow(args);
%>

	<%
	//对于三个按钮的显示：修改业务发生日期,修改还款次数,修改展期次数是根据不同的状态来决定的
	//对于修改业务发生日期按钮,只有历史表才能显示
	//对于修改还款次数按钮,只有还款表才能显示
	//对于修改展期次数按钮,只有展期表才能显示
	//对于从查询模块入口跳转过来的页面,不显示任何修改按钮
	String sReturnTimes = "false",sExtensionTimes="false",sChangeOccurdate="false",sSave="true";
	if((sTableName.equals("HIS_LOANRETURN")||sTableName.equals("ECR_FINARETURN"))){
		sReturnTimes = "true";
	}
	if(sTableName.equals("HIS_LOANEXTENSION")||sTableName.equals("ECR_FINAEXTENSION")){
		sExtensionTimes = "true";
	}
	
	String sButtons[][] = {
			{"true","","Button","保存","保存","saveRecord()","","","",""},
			{"true","","Button","修改业务发生日期","修改业务发生日期","changeOccurDate()","","","",""},
			{sReturnTimes,"","Button","修改还款次数","修改还款次数","changeReturnTimes()","","","",""},
			{sExtensionTimes,"","Button","修改展期次数","修改展期次数","changeExtensionTimes()","","","",""},
		};
	%> 
	<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
	<script language=javascript>
  
	//---------------------定义按钮事件------------------------------------
	function saveRecord()
	{	
		if (!ValidityCheck()) return;
		as_save("myiframe0");
	}

	//修改业务发生日期
	function changeOccurDate(){
		var sOCCURDATE = getItemValue(0,getRow(),"OCCURDATE");
		if(typeof(sOCCURDATE) != "undefined"&&sOCCURDATE.length!=0){
			var sKeyValueS = getItemValue(0,getRow(),"<%=sName[0]%>");
    	<%
    		for(int i=1;i<sName.length;i++){
    	%>
    			sKeyValueS = sKeyValueS +  "@" + getItemValue(0,getRow(),"<%=sName[i]%>");
    	<%				
    		}
    	%>
			var returnValue = popComp("ChangeOccurDate","/ErrorManage/FeedBackManage/FeedBackBusiness/ChangeOccurDate.jsp","sTableName=<%=sTableName%>&KeyName=<%=sKeyStr%>&KeyValue="+sKeyValueS+"&OCCURDATE="+sOCCURDATE,"dilogWidth=19;dialogHeight=14;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
			reloadSelf();
		}
	}
	//修改还款次数
	function changeReturnTimes(){
		var sReturnTimes = getItemValue(0,getRow(),"RETURNTIMES");
		var sOccurDate = getItemValue(0,getRow(),"OCCURDATE");
		if(typeof(sReturnTimes) != "undefined"&&sReturnTimes.length!=0){
			var sKeyValueS = getItemValue(0,getRow(),"<%=sName[0]%>");
    	<%
    		for(int i=1;i<sName.length;i++){
    	%>
    			sKeyValueS = sKeyValueS +  "@" + getItemValue(0,getRow(),"<%=sName[i]%>");
    	<%				
    		}
    	%>
			var returnValue = popComp("ChangeOccureTimes","/ErrorManage/FeedBackManage/FeedBackBusiness/ChangeOccureTimes.jsp","sTableName=<%=sTableName%>&KeyName=<%=sKeyStr%>&KeyValue="+sKeyValueS+"&RETURNTIMES="+sReturnTimes+"&OccurDate="+sOccurDate,"dilogWidth=19;dialogHeight=14;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
			reloadSelf();
		}
	}
	//修改展期次数
	function changeExtensionTimes(){
		var sExtensionTimes = getItemValue(0,getRow(),"EXTENTIMES");
		var sOccurDate = getItemValue(0,getRow(),"OCCURDATE");
		if(typeof(sExtensionTimes) != "undefined"&&sExtensionTimes.length!=0){
			var sKeyValueS = getItemValue(0,getRow(),"<%=sName[0]%>");
    	<%
    		for(int i=1;i<sName.length;i++){
    	%>
    			sKeyValueS = sKeyValueS +  "@" + getItemValue(0,getRow(),"<%=sName[i]%>");
    	<%				
    		}
    	%>
			var returnValue = popComp("ChangeOccureTimes","/ErrorManage/FeedBackManage/FeedBackBusiness/ChangeOccureTimes.jsp","sTableName=<%=sTableName%>&KeyName=<%=sKeyStr%>&KeyValue="+sKeyValueS+"&EXTENTIMES="+sExtensionTimes+"&OccurDate="+sOccurDate,"dilogWidth=19;dialogHeight=14;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
			reloadSelf();
		}
	}
	
	/*~[Describe=贷款投向;InputParam=无;OutPutParam=无;]~*/
	function getWay()
	{	
		var sWay = getItemValue(0,0,"WAY");
		var sReturn = PopComp("IndustryVFrame","/DataMaintain/IndustryVFrame.jsp","IndustryType="+sWay,"dialogWidth:730px;dialogHeight:540px;resizable:no;scrollbars:no;status:no;help:no");
		if(typeof(sReturn)=="undefined" || sReturn=="") return;
		var sReturnvalues = sReturn.split("@");
		setItemValue(0,0,"WAY",sReturnvalues[0]);
		setItemValue(0,0,"WAYNAME",sReturnvalues[1]);
	}
	
	/*~[Describe=返回列表页面;InputParam=无;OutPutParam=无;]~*/
	function goBack(){
		top.close();
	}
	/*~[Describe=页面装载时，对DW进行初始化;InputParam=无;OutPutParam=无;]~*/
	function initRow()
	{
		if (getRowCount(0)==0) //如果没有找到对应记录，则新增一条，并设置字段默认值
		{
			as_add("myiframe0");//新增记录
			bIsInsert = true;
		}
    }

	/*~[Describe=有效性检查;InputParam=无;OutPutParam=通过true,否则false;]~*/
	function ValidityCheck()
	{	
		var sTableName = "<%=sTableName%>";
		if(sTableName=="HIS_LOANCONTRACT"||sTableName=="HIS_FACTORING"||sTableName=="HIS_DISCOUNT"||sTableName=="HIS_FINAINFO"
		   ||sTableName=="HIS_CREDITLETTER"||sTableName=="HIS_GUARANTEEBILL"||sTableName=="HIS_ACCEPTANCE"||sTableName=="HIS_CUSTOMERCREDIT"
		   ||sTableName=="HIS_FLOORFUND"||sTableName=="HIS_INTERESTDUE"){
			
			//贷款卡编号校验
			var sLoanCardNo = getItemValue(0,0,"LOANCARDNO");
			if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
				if(!CheckLoanCardID(sLoanCardNo)){
					alert('贷款卡编号输入有误!');
					return false;
				}
			}
		
		}
		if(sTableName=="HIS_ASSURECONT") {
			
		}else if(sTableName=="HIS_GUARANTYCONT") {
			
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
		}else if(sTableName=="HIS_IMPAWNCONT") {
			var sLoanCardNo = getItemValue(0,0,"ILOANCARDNO");
			if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
				if(!CheckLoanCardID(sLoanCardNo)){
					alert('贷款卡编号输入有误!');
					return false;
				}
			}
		}else if(sTableName=="HIS_CREDITLETTER") {
			
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
	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
