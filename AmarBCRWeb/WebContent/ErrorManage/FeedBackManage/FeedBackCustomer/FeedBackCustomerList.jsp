<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
		String PG_TITLE = "机构管理列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>

<%

	//定义变量
	//获取页面参数
	//参数主要有sTableName(数据库中要查找的字段),KeyName(要查找的本业务的关键字),KeyValue(要查找的本业务的关键字的值)
	//TableFlag表示：是显示his表,还是ecr表
	//对于其他的参数：(由于该页面是公共的页面,对于不同的页面的按钮是不同的,是用来区别按钮的显示效果的用途)
	String sTableName = CurPage.getParameter("sTableName");
	if(sTableName == null) sTableName = "";
	
	String sTableFlag = CurPage.getParameter("TableFlag");
	if(sTableFlag == null) sTableFlag = "";
	String sCustomerID = CurPage.getParameter("CustomerID");
	if(sCustomerID == null) sCustomerID = "";
	String sKeyNameMain = CurComp.getParameter("KeyName");
	if(sKeyNameMain == null) sKeyNameMain = "";
	String sKeyValueMain = CurComp.getParameter("KeyValue");
	
	String sIsShow = CurPage.getParameter("IsShow");
	if(sIsShow == null) sIsShow = "";
	
	String sIsPatch = CurComp.getParameter("IsPatch");
	if(sIsPatch == null) sIsPatch = "";
	String sWhereClause = "";
	//对多个主键进行处理：建立主键名和主键值的对应关系
	if(!sKeyNameMain.equals("")){
		String[] stName = sKeyNameMain.split("@");
		String[] stValue = sKeyValueMain.split("@");
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
				sWhereClause = sWhereClause + " and " + stName[j] + " in (" + sValueStr + ")";
			}else{
				sWhereClause = sWhereClause + " and " +  stName[j] + " ='" + stValue[j] +"'";	
			}
		}
	}
	
%>

<%	
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
	ASObjectModel doTemp = new ASObjectModel(boManager);
	//设置生成源数据SQL语句的where子句
	doTemp.setJboWhere("  CustomerID =: CustomerID" + sWhereClause);

	//获取该表的所有的关键字
	String[] sKeyName = boManager.getManagedClass().getKeyAttributes();
		String sKeyStr="";
	for(String key: sKeyName){
		sKeyStr += key+"@";
	}

	//设置客户详情组件和组件路径
	String sCompNameInfo = "FeedBackCustomerInfo";
	String sCompPathInfo = "/ErrorManage/FeedBackManage/FeedBackCustomer/FeedBackCustomerInfo.jsp";
	//设置参数
	String sParamInfo = "sTableName="+sTableName+"&TableFlag="+sTableFlag+"&KeyName="+sKeyStr;
	
	//设置双击事件
   doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");

	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(10);

	dwTemp.genHTMLObjectWindow(sCustomerID);
	
%>

	<%
	//依次为：
	String sButtons[][] = {
			{sIsShow.equals("true")?"true":"false","","Button","重新上报","重报该条记录","report(2)","","","",""},
			{sIsShow.equals("true")?"false":"true","","Button","暂不上报","暂不重报该条记录","report(3)","","","",""},
			{sIsPatch.equals("true")?"true":"false","","Button","漏报补报","补报该条漏报的记录","report(4)","","","",""},
		};
	%> 

	<%@include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script language=javascript>
		
	//---------------------定义按钮事件------------------------------------
	//打开客户详情页面
    function openCustomerInfo(){
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
