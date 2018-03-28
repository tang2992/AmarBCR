<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>

	<%
		String PG_TITLE = "业务相关数据列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>

<%

	//定义变量
	//获取组件参数
	//TableFlag表示：是显示his表,还是ecr表
	//对于其他的参数：(由于该页面是公共的页面,对于不同的页面的按钮是不同的,是用来区别按钮的显示效果的用途)
	String sTableName = CurComp.getParameter("sTableName");
	if(sTableName == null) sTableName = "";
	String sTableFlag = CurComp.getParameter("TableFlag");
	if(sTableFlag == null) sTableFlag = "";
	String sKeyName = CurComp.getParameter("KeyName");
	if(sKeyName == null) sKeyName = "";
	String sKeyValue = CurComp.getParameter("KeyValue");
%>

<%	
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
	ASObjectModel doTemp = new ASObjectModel(boManager);
	//设置数字类型右对齐
	for(DataElement de:boManager.getManagedClass().getAttributes()){
		if(de.getType()==DataElement.DOUBLE || de.getType()==DataElement.INT || de.getType()==DataElement.LONG){
			doTemp.setAlign(de.getName(), "3");
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
	
	if(sTableFlag.equals("ECR"))
		doTemp.setVisible("TRACENUMBER,MODFLAG,SESSIONID,SESSIONIDNAME,ERRORCODE",false);
	//贷款业务的详情展示
	doTemp.setReadOnly("Lcontractno,Lduebillno", true);
	doTemp.setEditStyle("Occurdate,Startdate,Enddate,Putoutdate,Putoutenddate,Returndate,Extenstartdate,Extenenddate", "Date");
	doTemp.setRequired("*", true);
	doTemp.setRequired("Customerid,Modflag,Tracenumber,Recordflag,Oldfinanceid,Creditno,Sessionid,Errorcode,Classify4", false);
	doTemp.setEditStyle("IncrementFlag,Bankflag,Guarantyflag,Availabstatus,Currency,Recycle,Returnmode,Businesstype,Form,Loancharacter,Way,Kind,Extenflag,Classify5,Classify4", "Select");
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
		}
	doTemp.setDDDWJbo("Form", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7531'");
	doTemp.setDDDWJbo("Loancharacter", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7533'");
	doTemp.setDDDWJbo("Way", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7535'");
	doTemp.setDDDWJbo("Kind", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7537'");
	doTemp.setDDDWJbo("Extenflag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7573'");
	doTemp.setDDDWJbo("Classify5", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7541'");
	doTemp.setDDDWJbo("Classify4", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7539'");
	
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
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
 
	dwTemp.genHTMLObjectWindow(args);
	
%>

	<%
	
	String sButtons[][] = {
			{sTableFlag.equals("ECR")?"true":"false","","Button","保存","保存","saveRecord()","","","",""},
		};
	%> 
	<%@include file="/Frame/resources/include/ui/include_info.jspf"%>

	<script type="text/javascript">
  
	//---------------------定义按钮事件------------------------------------
	function saveRecord()
	{	
		if (!ValidityCheck()) return;
		as_save("myiframe0");
	}
	
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
        if(sTableName=="ECR_CREDITLETTER") {
			
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
	
	/*~[Describe=返回列表页面;InputParam=无;OutPutParam=无;]~*/
	function goBack(){
		top.close();
	}
	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
