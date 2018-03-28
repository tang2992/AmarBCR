<%@ page contentType="text/html; charset=GBK"
		import="com.amarsoft.ECRDataWindowXml,com.amarsoft.app.datax.ecr.common.Tools,java.util.*"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

<%
	//定义变量
	//获取组件参数
	String sTableName = CurComp.getParameter("TableName");
	if(sTableName == null) sTableName = "";
	int index = 0;
%>

	<%
	String PG_TITLE = "业务信息维护"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>

<%	
	String occurDate = "";
	Calendar cal = Calendar.getInstance();
	cal.setTime(new java.util.Date());
	occurDate=Tools.getCurrentDay("1");
	if(cal.get(Calendar.HOUR_OF_DAY)<22)  //22点之前取昨天，22点之后取当天
		occurDate=Tools.getLastDay("1");
	String[][] sTable  = {
			{"ECR_LOANCONTRACT","AVAILABSTATUS='1' and EndDate<'" + occurDate + "'"},
			{"ECR_FACTORING","BALANCE>0 and FactoringStatus='2'"},//保理业务状态：正常,逾期,所以不能有此字段,用余额进行判断
			{"ECR_DISCOUNT","BILLSTATUS<>'2' and AcceptMaturity<'" + occurDate + "'"},//正常,结清,转贴现
			{"ECR_FINAINFO","AVAILABSTATUS='1' and EndDate<'" + occurDate + "'"},//正常,结清
			{"ECR_CREDITLETTER","CREDITSTATUS='1' and AvailabTerm<'" + occurDate + "'"},//正常和注销
			{"ECR_GUARANTEEBILL","GUARANTEESTATUS='1' and EndDate<'" + occurDate + "'"},//正常和解除
			{"ECR_ACCEPTANCE","DRAFTSTATUS<>'3' and AccepEndDate<'" + occurDate + "'"},//正常,未用退出,结清
			{"ECR_CUSTOMERCREDIT","(CreditLogOutCause is null and CreditEndDate > '"+occurDate+"') or CreditLogOutDate > '"+occurDate+"' and CreditEndDate<'" + occurDate + "'"}
		};

	for(int i=0;i<sTable.length;i++){
		if(sTable[i][0].equals(sTableName)){
			index = i;
			break;
		}
	}
	//读取metadata.xml配置,获取相关的信息
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
	ASObjectModel doTemp = new ASObjectModel(boManager);
	
	String jBOWhere="";
	jBOWhere +=sTable[index][1];
	//控制数据权限,本用户管辖的数据
    if(!CurUser.getUserID().equals("system"))
    	jBOWhere += " and  O.FINANCEID IN (select OI.ORGID from jbo.ecr.ORG_TASK_INFO OI where OI.OrgCode='"+CurUser.getRelativeOrgID()+"')" ;	
   doTemp.setJboWhere(jBOWhere);

	doTemp.setVisible("Modflag,Tracenumber,Errorcode,Recordflag,Oldfinanceid,Creditno,Sessionid,Bankflag,Recycle,Guarantyflag,Currency,Availabbalance,Customerid", false);
	doTemp.setVisible("Classify4,Classify5,Factoringtype,Factoringstatus,Businessdate,Balancechangedate,Floorflag", false);
	doTemp.setVisible("Billtype,Acceptername,Aloancardno,Billsum", false);
	doTemp.setVisible("Payterm,Depositscale,Logoutdate,Balance,Balancereportdate", false);
	doTemp.setVisible("Guaranteetype,Balanceoccurdate", false);
	doTemp.setVisible("Acceppaydate,Assurescale", false);
	doTemp.setVisible("Creditlogoutdate,Creditlogoutcause", false);
	doTemp.setVisible("Businessno,Returnmode", false);
	doTemp.setVisible("Businesstype,Assurecurrency,Assureform,Certtype,Certid", false);
	
	//查询条件
	doTemp.setColumnFilter("*", false);
	doTemp.setColumnFilter("Lcontractno,Factoringno,Billno,Fcontractno,Creditletterno,Guaranteebillno,Acontractno,Ccontractno,Floorfundno,Contractno,Assurecontno,Aloancardno,Guarantycontno,Guarantyserialno,Loancardno,CustomerID,Customername,Financeid", true);
	
	doTemp.setDDDWCodeTable("INCREMENTFLAG", "1,新增,2,业务变更,4,删除,6,手工终结,8,已迁移");//信息操作状态
	doTemp.setDDDWJbo("Availabstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7525'");
	doTemp.setDDDWJbo("Billstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7561'");
	doTemp.setDDDWJbo("Creditstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7501'");
	doTemp.setDDDWJbo("Guaranteestatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7583'");
	doTemp.setDDDWJbo("Draftstatus", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7591'");
	doTemp.setDDDWJbo("Floortype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7625'");
	doTemp.setDDDWJbo("Interesttype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7631'");
	doTemp.setDDDWCodeTable("Reporttype", "1,贷款卡号上报,2,自然人证件上报");
	
	//设置双击事件
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");

	
	//获取该业务的主键信息
	String[] sKeyName =boManager.getManagedClass().getKeyAttributes();
	String sKeyNameMain="";
	for(String key: sKeyName){
		sKeyNameMain += key+"@";
	}
	
	//设置过滤器

	//生成datawindow
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(20);//分页显示
	
	dwTemp.genHTMLObjectWindow("");
	
	//显示组件和组件路径
	String sCompName = "BusinessInfoDetail";
	String sCompPath = "/DataMaintain/BusinessMaintain/BusinessInfoDetail.jsp";
	
%>

	<%
	String sButtons[][] = {
			{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
		};
	%> 
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
	<script type="text/javascript">

	//---------------------定义按钮事件------------------------------------
	/*~[Describe=新增记录;InputParam=无;OutPutParam=无;]~*/
	
	//根据主键名,获取相应的键值
	function viewAndEdit()
	{
		var sKeyValue = getItemValue(0,getRow(),"<%=sKeyName[0]%>");
    	if(typeof(sKeyValue)=="undefined" || sKeyValue.length==0) {
			alert("请选择一条信息！");//请选择一条信息！
            return ;
		}
    	<%
    		for(int i=1;i<sKeyName.length;i++){
    	%>
    			sKeyValue = sKeyValue +  "@" + getItemValue(0,getRow(),"<%=sKeyName[i]%>");
    	<%				
    		}
    	%>
		popComp("<%=sCompName%>","<%=sCompPath%>","sTableName=<%=sTableName%>&KeyName=<%=sKeyNameMain%>&KeyValue="+sKeyValue+"&sIsQuery=true","");
		reloadSelf();
	}
	</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>