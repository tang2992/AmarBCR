<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
		String PG_TITLE = "机构管理列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>

<%

	//定义变量
	//获取组件参数
	//该页面是所有业务的显示的公共页面,对于本系统所有的业务列表都是由本页面生成的
	//参数主要有：sTableName(数据库中要查找的字段),KeyName(要查找的本业务的关键字),KeyValue(要查找的本业务的关键字的值)
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
	
	String sIsPatch = CurComp.getParameter("IsPatch");
	if(sIsPatch == null) sIsPatch = "";
	
	//对多个主键进行处理：建立主键名和主键值的对应关系
	String[] stName = sKeyNameMain.split("@");
	String[] stValue = sKeyValueMain.split("@");
	String sWhereClause = "";
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
			sWhereClause = stName[j] + " in (" + sValueStr + ")";
		}else{
			sWhereClause =stName[j] + " ='" + stValue[j] +"'";	
		}
	}
	
%>

<%	
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
	ASObjectModel doTemp = new ASObjectModel(boManager);
	//设置查询条件where子句
    doTemp.setJboWhere(sWhereClause);
	//设置排序条件order子句
    doTemp.setJboOrder("  OCCURDATE desc ");
    doTemp.setVisible("*", false);
    //贷款
    doTemp.setVisible("Lcontractno,LoancardNo,Financeid,CustomerName,Startdate,Enddate,Availabstatus,Occurdate,Lduebillno,Putoutamount,Balance,Putoutdate,Putoutenddate,Extenflag,Returntimes,Returndate,Returnmode,Returnsum,Extentimes,Extensum,Extenstartdate,Extenenddate", true);
    doTemp.setVisible("Contractno,Assurecontno,Aloancardno,Assurername,Occurdate,Incrementflag,Createdate,Certid,Availabstatus,Reporttype,Guarantycontno,Guarantyserialno,Pledgorname,Gloancardno,Guarantysum,Impawncontno,Impawserialno,Impawno,Impawnname,Iloancardno,Impawnsum",true);
    //保理
    doTemp.setVisible("Factoringno,Customername,Factoringstatus,Businesssum,Businessdate,Guarantyflag,Fduebillno,Tracenumber,Sessionid,Errorcode", true); 
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
	
	//获取所有的主键
		String[] sKeyName= boManager.getManagedClass().getKeyAttributes();
	String sKeyStr="";
	for(String key: sKeyName){
		sKeyStr += key+"@";
	}
	
	//设置显示详情的组件和组件路径,以及传递的参数
	String sCompNameInfo = "FeedBackRelativeInfo";
	String sCompPathInfo = "/ErrorManage/FeedBackManage/FeedBackBusiness/FeedBackRelativeInfo.jsp";
	String sParamInfo = "saTableName="+sTableName+"&TableFlag="+sTableFlag+"&KeyName="+sKeyStr;
	
	//设置双击打开详情页面
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:openBusinessInfo()\"");
	
    ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(10);
	
	dwTemp.genHTMLObjectWindow("");
	
%>

	<%
	//从反馈页面跳转过来的页面才显示重报相关按钮
	String sButtons[][] = {
			{sIsPatch.equals("true")?"false":"true","","Button","重新上报","重报该条记录","report(2)","","","",""},
			{sIsPatch.equals("true")?"false":"true","","Button","暂不上报","暂不重报该条记录","report(3)","","","",""},
			{sIsPatch.equals("true")?"false":"true","","Button","漏报补报","补报该条漏报的记录","report(4)","","","",""},
		};
	%> 

<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script language=javascript>
		
	//---------------------定义按钮事件------------------------------------
	//双击打开选中的记录
    function openBusinessInfo()
    {
    	var sKeyValue = getItemValue(0,getRow(),"<%=sKeyName[0]%>");
    	<%
    		for(int i=1;i<sKeyName.length;i++){
    	%>
    			sKeyValue = sKeyValue +  "@" + getItemValue(0,getRow(),"<%=sKeyName[i]%>");
    	<%				
    		}
    	%>
    	popComp("<%=sCompNameInfo%>","<%=sCompPathInfo%>","<%=sParamInfo%>&KeyValue="+sKeyValue,""); 
    	reloadSelf();
    }	 
 
	</script>
<%@include file="/ErrorManage/FeedBackManage/FeedBackFunction.jsp"%>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
