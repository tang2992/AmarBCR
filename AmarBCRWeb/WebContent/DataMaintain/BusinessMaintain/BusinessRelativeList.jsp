<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
		String PG_TITLE = "机构管理列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>

<%

	//定义变量
	//获取组件参数
	//该页面是所有业务的显示的公共页面,对于本系统所有的业务列表都是由本页面生成的
    //TableFlag表示：是显示his表,还是ecr表
	//对于其他的三个参数：QueryType,Query,IsPatch(由于该页面是公共的页面,对于不同的页面的按钮是不同的,是用来区别按钮的显示效果的用途)
	String sTableName = CurPage.getParameter("sTableName");
	if(sTableName == null) sTableName = "";
	String sTableName1 = CurPage.getParameter("sTableName1");
	if(sTableName1 == null) sTableName1 = "";
	String sTableFlag = CurPage.getParameter("TableFlag");
	if(sTableFlag == null) sTableFlag = "";
	String sMainName = CurPage.getParameter("KeyName");
	if(sMainName == null) sMainName = "";
	String sKeyValue= CurPage.getParameter("KeyValue");
	if(sKeyValue == null) sKeyValue = "";

	//仅查询模块传入的参数,用于在查询界面中隐藏保存按钮
	String sIsQuery = CurPage.getParameter("IsQuery");
	if(sIsQuery == null) sIsQuery = "";
	//对检验错误页面传入的参数,用于在查询界面中隐藏按钮
	String sQueryType = CurPage.getParameter("QueryType");
	if(sQueryType == null) sQueryType = "";
	//担保，抵押，质押时增加传入的主键 
	String sKeyName1 = CurPage.getParameter("KeyName1");
	if(sKeyName1 == null) sKeyName1 = "";
	String sKeyValue1 = CurPage.getParameter("KeyValue1");
	if(sKeyValue1 == null) sKeyValue1 = "";
	String sIsPatch = CurComp.getParameter("IsPatch");
	if(sIsPatch == null) sIsPatch = "";
	String sFlag = CurComp.getParameter("sFlag");
	if(sFlag == null) sFlag = "";
%>

<%	
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
	ASObjectModel doTemp = new ASObjectModel(boManager);

	//更改where条件
	String jBOWhere="";
	String args="";

	String[] sKeyName= boManager.getManagedClass().getKeyAttributes();
	String stName="";
	for(String key: sKeyName){
		stName += key+"@";
	}

	if(("HIS".equals(sTableFlag))&&sTableName.equals(sTableName1)){
		//担保，抵押，质押时增加传入的主键进行处理：建立主键名和主键值的对应关系
		String[] stName1 = sKeyName1.split("@");
		String[] stValue1 = sKeyValue1.split("@");
		int length=2;//对于所有担保历史仅通过主合同编码及担保合同编码检索，抵质业务也不使用不使用抵质押编码
		for(int i=0;i<length;i++){
			String k=stName1[i];
			String v=stValue1[i];
			jBOWhere =jBOWhere+" and "+k+"=:"+k;
			args = args+","+v;
		}
	}else{
			//对于反馈和一个合同多个借据的情况设置的或条件处理方法
			if(sKeyValue.indexOf("-")>0){
				String[] sValue = sKeyValue.split("-");
				String sValueStr = "";
				for(int i=0;i<sValue.length;i++){
					if(sValueStr.equals(""))
						sValueStr = sValueStr + "'" + sValue[i] +"'";
					else
						sValueStr = sValueStr + ",'" + sValue[i] +"'";
				}
				jBOWhere+=" and " + sMainName +" in("+sValueStr+")";
			}else{
					jBOWhere =jBOWhere+" and "+sMainName+"=:"+sMainName;
					args = args+","+sKeyValue;
					}
			}

	jBOWhere = jBOWhere.substring(4);
	if(!args.isEmpty()) 
		args = args.substring(1);
   doTemp.setJboWhere(jBOWhere);
   doTemp.setJboOrder("  OCCURDATE desc ");
    doTemp.setVisible("*", false);
    //贷款
    doTemp.setVisible("Lcontractno,LoancardNo,Financeid,CustomerName,Startdate,Enddate,Availabstatus,Occurdate,Lduebillno,Putoutamount,Balance,Putoutdate,Putoutenddate,Extenflag,Returntimes,Returndate,Returnmode,Returnsum,Extentimes,Extensum,Extenstartdate,Extenenddate", true);
    doTemp.setVisible("Contractno,Assurecontno,Aloancardno,Assurername,Occurdate,Incrementflag,Createdate,Certid,Availabstatus,Reporttype,Guarantycontno,Guarantyserialno,Pledgorname,Gloancardno,Guarantysum,Impawncontno,Impawserialno,Impawno,Impawnname,Iloancardno,Impawnsum",true);
    //保理
    doTemp.setVisible("Factoringno,Customername,Factoringstatus,Businesssum,Businessdate,Guarantyflag,Fduebillno", true); 
    //票据贴现
     doTemp.setVisible("Billno,Discountsum,Discountdate,Acceptmaturity,Billstatus",true);
    //贸易融资
    doTemp.setVisible("Fcontractno,Discountsum,Discountdate,Acceptmaturity,Billstatus",true);
    //信用证
    doTemp.setVisible("Creditletterno,Createsum,Createdate,Availabterm,Creditstatus",true);
    //承兑汇票
    doTemp.setVisible("Acontractno,Acceptno,Accepdate,Accepsum,Accependdate,Draftstatus",true);
    //公开授信
    doTemp.setVisible("Ccontractno,Creditlimit,Creditstartdate,Creditenddate",true);
    //垫款
    doTemp.setVisible("Floorfundno,Floorsum,Floordate,Floorbalance",true);
    //欠息
    doTemp.setVisible("Customerid,Interesttype,Interestbalance",true);
    
    if(sTableFlag.equals("HIS")){
        doTemp.setVisible("SessionID", true); 
    }
    if(sFlag.equals("Feedback")){
    		doTemp.setVisible("TraceNumber,Errorcode", true); 
    }
    doTemp.setColumnFilter("*", false);
    doTemp.setColumnFilter("Lcontractno,Lduebillno,FactoringNO,Billno,Fduebillno,Fcontractno,Creditletterno,Guaranteebillno,Acontractno,Ccontractno,Billno,CustomerID,Assurecontno,Guarantycontno,Impawncontno,Occurdate", true);
    doTemp.setDDDWJbo("Extenflag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7573'");
	doTemp.setDDDWJbo("Returnmode", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7545'");
	doTemp.setDDDWCodeTable("IncrementFlag", "1,新增,2,业务变更,4,删除,6,手工终结,8,已迁移");//信息操作状态
	doTemp.setDDDWJbo("Availabstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7525'");
	doTemp.setDDDWJbo("Guarantyflag", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7523'");
	doTemp.setDDDWJbo("Factoringstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7551'");
	doTemp.setDDDWJbo("Billstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7561'");
	doTemp.setDDDWJbo("Creditstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7501'");
	doTemp.setDDDWJbo("Draftstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7591'");
	doTemp.setDDDWJbo("Interesttype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7631'");
	doTemp.setDDDWCodeTable("Reporttype", "1,机构担保,2,自然人担保");//信息操作状态
	//设置显示详情的组件和组件路径,以及传递的参数
	String sCompNameInfo = "BusinessRelativeInfo";
	String sCompPathInfo = "/DataMaintain/BusinessMaintain/BusinessRelativeInfo.jsp";
	String sParamInfo = "sTableName="+sTableName+"&TableFlag="+sTableFlag+"&KeyName="+stName+"&IsQuery="+sIsQuery+"&QueryType="+sQueryType;
	
	//设置双击打开详情页面
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:openBusinessInfo()\"");
	 
    ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(10);
	
	dwTemp.genHTMLObjectWindow(args==null ||args.length()<1 ?"%":args);
%>

	<%
	String sButtons[][] = {
			{"true","","Button","详情","查看/修改详情","openBusinessInfo()","","","",""},
			{("HIS".equals(sTableFlag)||sFlag.equals("Feedback"))?"false":"true","","Button","查看历史记录","查看历史记录","showHISContent()","","","",""},
			{(!sIsPatch.equals("true")&&sFlag.equals("Feedback"))?"true":"false","","Button","重新上报","重报该条记录","report(2)","","","",""},
			{(!sIsPatch.equals("true")&&sFlag.equals("Feedback"))?"true":"false","","Button","暂不上报","暂不重报该条记录","report(3)","","","",""},
			{(!sIsPatch.equals("true")&&sFlag.equals("Feedback"))?"true":"false","","Button","漏报补报","补报该条漏报的记录","report(4)","","","",""},
	};
	%> 

	<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script type="text/javascript">
	//显示历史信息
	function showHISContent(){
<%-- 		<%
				sTableName = StringFunction.replace(sTableName,"HIS","ECR");
		%> --%>
			popComp("","/DataMaintain/BusinessMaintain/BusinessRelativeList.jsp","sTableName=<%=StringFunction.replace(sTableName,"ECR","HIS")%>&KeyName1=<%=sKeyName1%>&KeyValue1=<%=sKeyValue1%>&KeyName=<%=sMainName%>&KeyValue=<%=sKeyValue%>&TableFlag=HIS&IsQuery=<%=sIsQuery%>&QueryType=<%=sQueryType%>","");         
	}
		
	//---------------------定义按钮事件------------------------------------
	//双击打开选中的记录
    function openBusinessInfo()
    {
    	var stKeyValue = getItemValue(0,getRow(),"<%=stName.split("@")[0]%>");
    	if(typeof(stKeyValue)=="undefined"||stKeyValue==""){
        	alert("请选择一条数据！");
			return;
    	}
    	var sReportType = getItemValue(0,getRow(),"REPORTTYPE");
    	<%
    		for(int i=1;i<stName.split("@").length;i++){
    	%>
    			stKeyValue = stKeyValue +  "@" + getItemValue(0,getRow(),"<%=stName.split("@")[i]%>");
    	<%				
    		}
    	%>
    	 popComp("<%=sCompNameInfo%>","<%=sCompPathInfo%>","<%=sParamInfo%>&KeyValue="+stKeyValue+"&ReportType="+sReportType,""); 
    	reloadSelf();
    }	  
	</script>
<%@include file="/ErrorManage/FeedBackManage/FeedBackFunction.jsp"%>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
