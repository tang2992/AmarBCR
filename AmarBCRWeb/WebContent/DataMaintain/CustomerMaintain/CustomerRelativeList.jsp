<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>

	<%
		String PG_TITLE = "机构管理列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>

<%

	//定义变量
	//获取页面参数
    //TableFlag表示：是显示his表,还是ecr表
	//对于其他的参数：(由于该页面是公共的页面,对于不同的页面的按钮是不同的,是用来区别按钮的显示效果的用途)
	String sTableName = CurPage.getParameter("sTableName");
	if(sTableName == null) sTableName = "";
	String sTableFlag = CurPage.getParameter("TableFlag");
	if(sTableFlag == null) sTableFlag = "";
	String sCustomerID = CurPage.getParameter("CustomerID");
	if(sCustomerID == null) sCustomerID = "";
	String sFeedBack = CurPage.getParameter("FeedBack");
	if(sFeedBack == null) sFeedBack = "";
	//在只能查询的模块中隐藏保存按钮
	String sIsQuery = CurComp.getParameter("IsQuery");
	if(sIsQuery == null) sIsQuery = "";
	//客户信息Organ取得，主键where条件需变更
	String sType = CurComp.getParameter("Type");
	if(sType == null) sType = "";
	
	String sFlag = CurPage.getParameter("sFlag");
	if(sFlag == null) sFlag = "";
	String sIsShow = CurPage.getParameter("IsShow");
	if(sIsShow == null) sIsShow = "";
	
	String sIsPatch = CurComp.getParameter("IsPatch");
	if(sIsPatch == null) sIsPatch = "";
	
	String whereSql ;
	if("organ".equals(sType))
		whereSql = " LSCustomerID=:CustomerID " ;
	else 
		whereSql = " CustomerID =:CustomerID ";
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
	String[] sKeyName = boManager.getManagedClass().getKeyAttributes();
	//获取该表的所有的关键字
	String keyStr = "";
	for(String key: sKeyName){
		keyStr += key+"`";
	}
	ASObjectModel doTemp = new ASObjectModel(boManager);
	doTemp.setJboWhere(whereSql);
	doTemp.setVisible("*",false);
	doTemp.setColumnFilter("*", false);
	if(sTableName.equals("ECR_CUSTOMERLAW")){
		doTemp.setVisible("Customerid,Lawno,Executedate,Executesum,Occurdate,Incrementflag,Loancardno",true);
		doTemp.setColumnFilter("Lawno", true);
	}else if(sTableName.equals("ECR_CUSTOMERFACT")){
		doTemp.setVisible("Customerid,Factno,Occurdate,Incrementflag,Loancardno",true);
		doTemp.setColumnFilter("Factno", true);
	}else{
		doTemp.setVisible("Customerid,CUSTOMERNAME,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE,AUDITFIRM,AUDITOR,AUDITDATE,Incrementflag",true);
		doTemp.setColumnFilter("REPORTYEAR,REPORTTYPE,REPORTSUBTYPE", true);
	}
	doTemp.setDDDWJbo("REPORTTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7507'");
	doTemp.setDDDWJbo("REPORTSUBTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='7651'");
	doTemp.setDDDWCodeTable("Incrementflag", "1,新增,2,更新,8,已迁移");
	//设置客户详情组件和组件路径
	String sCompNameInfo = "CustomerRelativeInfo";
	String sCompPathInfo = "/DataMaintain/CustomerMaintain/CustomerRelativeInfo.jsp";
	//设置参数
	String sParamInfo = "sTableName="+sTableName+"&TableFlag="+sTableFlag+"&KeyName="+keyStr;
	
	//设置双击事件
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:openCustomerInfo()\"");
	//生成datawindow
    ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
    dwTemp.setPageSize(20);

    dwTemp.genHTMLObjectWindow(sCustomerID);
    
	String sButtons[][] = {
			{"true","","Button","详情","查看/修改详情","openCustomerInfo()","","","","btn_icon_detail",""},
			{(sTableFlag.equals("HIS")||sFlag.equals("Feedback"))?"false":"true","","Button","查看历史记录","查看历史记录","showHISContent()","","","","",""},
			{sFlag.equals("Feedback")?"true":"false","","Button","重新上报","重报该条记录","report(2)","","","",""},
			{sFlag.equals("Feedback")?"true":"false","","Button","暂不上报","暂不重报该条记录","report(3)","","","",""},
			{sFlag.equals("Feedback")?"true":"false","","Button","漏报补报","补报该条漏报的记录","report(4)","","","",""},
		};
	%> 

	<%@ include file="/Frame/resources/include/ui/include_list.jspf"%>

	<script type="text/javascript">
	//查看历史记录
	 function showHISContent(){
		 var sTableName="<%=sTableName%>";
		 sTableName=sTableName.replace("ECR","HIS");
		 var sParamInfo="sTableName="+sTableName+"&CustomerID=<%=sCustomerID%>&TableFlag=HIS&IsQuery=<%=sIsQuery%>";
	    AsControl.OpenView("/DataMaintain/CustomerMaintain/CustomerRelativeList.jsp",sParamInfo,"_blank");	      
	 }
    var sCurCodeNo=""; //记录当前所选择行的代码号
		
	//---------------------定义按钮事件------------------------------------
	//打开客户详情页面
    function openCustomerInfo(){
    	var keys = "<%=keyStr.substring(0, keyStr.length()-1)%>";
    	var keyArr = keys.split("`");
    	var values = "";
    	for(var k_i=0; k_i<keyArr.length; k_i++){
    		values = values+getItemValue(0,getRow(), keyArr[k_i])+"`";
    	}
    	var sParamInfo="sTableName=<%=sTableName%>&CustomerID=<%=sCustomerID%>&TableFlag=HIS&IsQuery=<%=sIsQuery%>";
    	values = values.substring(0, values.length-1);
    	var keyValue = keys+"~"+values;
    	var value = getItemValue(0,getRow(), keyArr[0]);
    	if(typeof(value)=="undefined" || value==null || value=="" || value=="undefined"){
			alert("请选择一条记录!");
			return;
		}
    	AsControl.PopView("<%=sCompPathInfo%>", "<%=sParamInfo%>&KeyValue="+keyValue, "");
    }	   
	</script>
<%@include file="/ErrorManage/FeedBackManage/FeedBackFunction.jsp"%>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
