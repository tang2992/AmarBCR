<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>

	<%
		String PG_TITLE = "机构管理列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>

<%

	//定义变量
	//获取组件参数
	//参数主要有:sTableName(数据库中要查找的字段),KeyName(要查找的本业务的关键字),KeyValue(要查找的本业务的关键字的值)
	//TableFlag表示：是显示his表,还是ecr表
	//对于其他的参数：(由于该页面是公共的页面,对于不同的页面的按钮是不同的,是用来区别按钮的显示效果的用途)
	String sTableName = CurComp.getParameter("sTableName");
	if(sTableName == null) sTableName = "";
	String sTableFlag = CurComp.getParameter("TableFlag");
	if(sTableFlag == null) sTableFlag = "";
	String sKeyName = CurComp.getParameter("KeyName");
	if(sKeyName == null) sKeyName = "";
	String sKeyValue = CurComp.getParameter("KeyValue");
	
	
	//对主键名和键值进行对应,设置where子句
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
	
	//获取页面参数
	
%>

<%	
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTableName.toUpperCase());
	ASObjectModel doTemp = new ASObjectModel(boManager);
	doTemp.setJboWhere(jboWhere);

	//设置显示日期模块数据
	String date = StringFunction.getToday().substring(0,4);
	int iDate = Integer.valueOf(date).intValue();
	String sDate=date+","+date;
	for(int i=iDate-1,j=2;i>iDate-100;i--,j++) 
		sDate= sDate +","+ i+","+ String.valueOf(i);
	//设置下拉框
	doTemp.setDDDWCodeTable("SETUPDATE,REPORTYEAR",sDate);
	
	//获取该表的所有的关键字
	String[] sName = boManager.getManagedClass().getKeyAttributes();
		String sKeyStr="";
	for(String key: sName){
		sKeyStr += key+"@";
	}
	
    ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
    dwTemp.ReadOnly = "0";
    dwTemp.setPageSize(20);

    dwTemp.genHTMLObjectWindow(args);
%>

	<%
	String sButtons[][] = {
			{"true","","Button","保存","保存","saveRecord()","","","",""},
			{"true","","Button","修改业务发生日期","修改业务发生日期","changeOccurDate()","","","",""},
		};
	%> 

	<%@include file="/Frame/resources/include/ui/include_info.jspf"%>

	<script language=javascript>
  
	//---------------------定义按钮事件------------------------------------
	function saveRecord()
	{
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
			var returnValue = popComp("ChangeOccurDate","/ErrorManage/FeedBackManage/FeedBackBusiness/ChangeOccurDate.jsp","DBTableName=<%=sTableName%>&KeyName=<%=sKeyStr%>&KeyValue="+sKeyValueS+"&OCCURDATE="+sOCCURDATE,"dilogWidth=19;dialogHeight=14;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
			reloadSelf();
		}
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
		var sReturn = PopComp("GetMyFrame","/DataMaintain/GetMyFrame.jsp","DataType=5527&IniteValue="+sREGIONCODE,"dialogWidth:320px;dialogHeight:540px;resizable:no;scrollbars:no;status:no;help:no");
		if(typeof(sReturn)=="undefined" || sReturn=="") return;
		var sReturnvalues = sReturn.split("@");
		setItemValue(0,0,"REGIONCODE",sReturnvalues[0]);
		setItemValue(0,0,"REGIONCODENAME",sReturnvalues[1]);
	}

	/*~[Describe=返回列表页面;InputParam=无;OutPutParam=无;]~*/
	function goBack(){
		top.close();
	}
	
	</script>
<%@ include file="/IncludeEnd.jsp"%>
