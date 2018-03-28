<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
		String PG_TITLE = "综合信息维护列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>

<%

	//定义变量
	//获取组件参数
	//该页面是所有业务的显示的公共页面,对于本系统所有的业务列表都是由本页面生成的
	//参数主要有五个：MetaTableName(xml配置name),DBTableName(数据库中要查找的字段),KeyName(要查找的本业务的关键字),KeyValue(要查找的本业务的关键字的值)
	//TableFlag表示：是显示his表,还是ecr表
	//对于其他的三个参数：QueryType,Query,IsPatch(由于该页面是公共的页面,对于不同的页面的按钮是不同的,是用来区别按钮的显示效果的用途)
	String sTableName = CurComp.getParameter("sTableName");
	if(sTableName == null) sTableName = "";
	String sTableFlag = CurComp.getParameter("TableFlag");
	if(sTableFlag == null) sTableFlag = "";
	String sKeyNameMain = CurComp.getParameter("KeyName");
	if(sKeyNameMain == null) sKeyNameMain = "";
	String sKeyValueMain = CurComp.getParameter("KeyValue");
	if(sKeyValueMain == null) sKeyValueMain = "";
	

	//对多个主键进行处理：建立主键名和主键值的对应关系
	String[] stName = sKeyNameMain.split("@");
	String[] stValue = sKeyValueMain.split("@");
	String jBOWhere = "";
	String args="";
	for(int j=0;j<stName.length;j++){
		//对于反馈和一个合同多个借据的情况设置的或条件处理方法
		if(stValue[j].indexOf("-")>0){
			String[] sValue = stValue[j].split("-");
			String sValueStr = "";
			for(int i=0;i<sValue.length;i++){
				if(sValueStr.equals(""))
					sValueStr = sValueStr + "'" + sValue[i] +"'";
				else
					sValueStr = sValueStr + ",'" + sValue[i] +"'";
			}
			jBOWhere +=  " and " + stName[j] + " in (" + sValueStr + ")";
		}else{
			jBOWhere += " and " +  stName[j] + " =:" + stName[j];	
			args += ","+stValue[j];
		}
	}
	
	jBOWhere = jBOWhere.substring(4);
	if(!args.isEmpty()) 
		args = args.substring(1);
%>

<%	
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
	ASObjectModel doTemp = new ASObjectModel(boManager);
	
	String[] keyAttrs= boManager.getManagedClass().getKeyAttributes();
	String sKeyName="";
	for(String key: keyAttrs){
		sKeyName += key+"@";
	}
	//设置查询条件where子句
	doTemp.setJboWhere(jBOWhere);
	//设置排序条件order子句
	doTemp.setJboOrder (" OCCURDATE desc");
	//设置双击打开详情页面
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:openBusinessInfo()\"");
	
	doTemp.setVisible("Modflag,Tracenumber,Recordflag,Oldfinanceid,Creditno,Sessionid,Errorcode,Bankflag,Currency,Availabbalance,Recycle,Classify4,Classify5,Factoringtype,Factoringstatus,Businessdate,Balancechangedate,Floorflag,Billtype,Acceptername,Aloancardno,Billsum", false);
	doTemp.setVisible("Payterm,Logoutdate,Balance,Depositscale,Balancereportdate,Guaranteetype,Balanceoccurdate,Acceppaydate,Assurescale,Creditlogoutdate,Creditlogoutcause,Floortype,Returnmode", false);
    
	//doTemp.setVisible("Lcontractno,Occurdate,incrementflag,customerid,loancardno,customername,financeid,Putoutamount,Startdate,Enddate,guarantyflag,availabstatus", true);
    doTemp.setColumnFilter("*", false);
    doTemp.setColumnFilter("Lcontractno,Fcontractno,Factoringno,Billno,Creditletterno,Guaranteebillno,Acontractno,Acceptance,Floorfundno,Ccontractno", true);
    doTemp.setDDDWJbo("guarantyflag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7523'");
	doTemp.setDDDWJbo("Billstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7561'");
	doTemp.setDDDWJbo("Creditstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7501'");
	doTemp.setDDDWJbo("Guaranteestatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7583'");
	doTemp.setDDDWJbo("Draftstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7591'");
	doTemp.setDDDWCodeTable("IncrementFlag", "1,新增,2,业务变更,4,删除,6,手工终结,8,已迁移");//信息操作状态
	doTemp.setDDDWJbo("Availabstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7525'");
	
    ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(10);
	
	dwTemp.genHTMLObjectWindow(args);
		
	//设置显示详情的组件和组件路径,以及传递的参数
	String sCompNameInfo = "SynthesisMaintanceRelativeInfo";
	String sCompPathInfo = "/DataMaintain/SynthesisMaintance/SynthesisMaintanceRelativeInfo.jsp";
	String sParamInfo = "sTableName="+sTableName+"&TableFlag="+sTableFlag+"&KeyName="+sKeyName;
	
%>

	<%
	String sButtons[][] = {
			{sTableFlag.equals("ECR")?"true":"false","","Button","插入批量删除表","将该业务插入批量删除表","batchDelete()","","","",""},
			{sTableFlag.equals("ECR")?"true":"false","","Button","全部插入批量删除表","全部插入批量删除表","batchDeleteAll()","","","",""},
		};
	%> 

	<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script language=javascript>
    var sCurCodeNo=""; //记录当前所选择行的代码号
		
	//---------------------定义按钮事件------------------------------------
	//双击打开选中的记录
    function openBusinessInfo()
    {
    	var sKeyValue = getItemValue(0,getRow(),"<%=sKeyName.split("@")[0]%>");
    	<%
    		for(int i=1;i<sKeyName.split("@").length;i++){
    	%>
    			sKeyValue = sKeyValue +  "@" + getItemValue(0,getRow(),"<%=sKeyName.split("@")[i]%>");
    	<%				
    		}
    	%>
    	popComp("<%=sCompNameInfo%>","<%=sCompPathInfo%>","<%=sParamInfo%>&KeyValue="+sKeyValue,""); 
    	reloadSelf();
    }	 
  
	/*~[Describe=;InputParam=无;OutPutParam=无;]~*/
	function batchDelete()
	{	
		var sContractNo = getItemValue(0,getRow(),"<%=sKeyName.split("@")[0]%>");
		if (typeof(sContractNo)=="undefined" || sContractNo.length==0)
		{
			alert("请选择一条记录！");
			return;
		}
		
		if(confirm("是否将该条业务记录插入批量删除表?")){
			var sTableName = "<%=sTableName%>";
			var sOccurDate = getItemValue(0,getRow(),"OCCURDATE");
			var sLoanCardNo = getItemValue(0,getRow(),"LOANCARDNO");
			var sFinanceID = getItemValue(0,getRow(),"FINANCEID");
			var sBusinessType = "";
			
			if(sTableName=="ECR_LOANCONTRACT"){sBusinessType="01"}
			else if(sTableName=="ECR_FACTORING"){sBusinessType="02"}
			else if(sTableName=="ECR_DISCOUNT"){sBusinessType="03"}
			else if(sTableName=="ECR_FINAINFO"){sBusinessType="04"}
			else if(sTableName=="ECR_CREDITLETTER"){sBusinessType="05"}
			else if(sTableName=="ECR_GUARANTEEBILL"){sBusinessType="06"}
			else if(sTableName=="ECR_ACCEPTANCE"){sBusinessType="07"}
			else if(sTableName=="ECR_CUSTOMERCREDIT"){sBusinessType="08"}
			else if(sTableName=="ECR_FLOORFUND"){sBusinessType="09"}
			else if(sTableName=="ECR_INTERESTDUE"){sBusinessType="10"}
			
			var sReturn = PopPage("/SystemManage/InsertIntoHisBatchDelete.jsp?ContractNo="+sContractNo+"&OccurDate="+sOccurDate+"&LoanCardNo="+sLoanCardNo+"&FinanceID="+sFinanceID+"&BusinessType="+sBusinessType,"_self","");
			if(sReturn=="Success"){
				alert("插入批量删除表成功!");
			}else if(sReturn=="Exist"){
				alert("该条记录已经在批量删除表里存在!");
			}else{
				alert("插入批量删除表失败!");
			}
		}
	}
	
	/*~[Describe=;InputParam=无;OutPutParam=无;]~*/
	function batchDeleteAll()
	{	
		var count = getRowCount(0);//行数
		if(count<1){
			alert("当前无任何记录！");
			return ;
		}
		
		if(confirm("是否将列表中所有业务记录插入批量删除表?")){
			var sTableName = "<%=sTableName%>";
			var sLoanCardNo = "<%=sKeyValueMain%>";
			var sBusinessType = "";
			
			if(sTableName=="ECR_LOANCONTRACT"){sBusinessType="01";}
			else if(sTableName=="ECR_FACTORING"){sBusinessType="02";}
			else if(sTableName=="ECR_DISCOUNT"){sBusinessType="03";}
			else if(sTableName=="ECR_FINAINFO"){sBusinessType="04";}
			else if(sTableName=="ECR_CREDITLETTER"){sBusinessType="05";}
			else if(sTableName=="ECR_GUARANTEEBILL"){sBusinessType="06";}
			else if(sTableName=="ECR_ACCEPTANCE"){sBusinessType="07";}
			else if(sTableName=="ECR_CUSTOMERCREDIT"){sBusinessType="08";}
			else if(sTableName=="ECR_FLOORFUND"){sBusinessType="09";}
			else if(sTableName=="ECR_INTERESTDUE"){sBusinessType="10";}
			
			var sReturn = AsControl.PopView("/SystemManage/InsertIntoHisBatchDeleteAll.jsp","LoanCardNo="+sLoanCardNo+"&BusinessType="+sBusinessType+"&TableName="+sTableName,"");
			if(sReturn=="Success"){
				alert("插入批量删除表成功!");
			}else {
				alert("插入批量删除表失败!");
			}
		}
	}
	
	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
