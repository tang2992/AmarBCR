<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
 <%
	/*
		页面说明: 示例列表页面
	 */
	String PG_TITLE = "机构基础信息";
	//获得页面参数
	String sCIFCustomerID =  CurPage.getParameter("sCIFCustomerID");
	if(sCIFCustomerID==null) sCIFCustomerID="";
	String sFlag =  CurPage.getParameter("sFlag");
	if(sFlag==null) sFlag="";
	String sTable =  CurPage.getParameter("sTable");
	if(sTable==null) sTable="";
	//在只能查询的模块中隐藏保存按钮
	String IsQuery = CurComp.getParameter("IsQuery");
	if(IsQuery == null) IsQuery = "";

	   //历史表将from条件更改
	if(sFlag.equals("his")||sFlag.equals("Feedback")){		
		sTable=sTable.replace("ECR_", "HIS_");
	}
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTable.toUpperCase());
	//获取该表的所有的关键字
	String[] keyAttrs = boManager.getManagedClass().getKeyAttributes();
		String sKeyName="";
	for(String key: keyAttrs){
		sKeyName += key+"@";
	}
		
	ASObjectModel doTemp = new ASObjectModel(boManager);
	
	 String jBOWhere="";
	jBOWhere="CIFCustomerID=:CIFCustomerID";
	doTemp.setJboWhere(jBOWhere);
	doTemp.setVisible("Mfcustomerid,Customertype,Nationaltaxno,Localtaxno,Accountpermitno,Gatherdate,Attribute1,oldFinanceid,Modflag,Recordflag,Tracenumber,Sessionid,Errorcode,Manageorgid,Registerdate,Registerduedate,Capitalcurrency,Orgtypesub,Updatedate", false);
	doTemp.setVisible("Registercountry,Industry,incrementflag,Financeid,Tracenumber,Englishname,Registerareacode,Capitalcurrency", false);
	if(sFlag.equals("Feedback")){
		doTemp.setVisible("Sessionid,Errorcode", true);
	}
	doTemp.setHTMLStyle("RELATIONSHIP", "style={width:200px}");
	doTemp.setHTMLStyle("Relativeentname", "style={width:200px}");
	
	doTemp.setDDDWJbo("REGISTERTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9039'"); //注册类型
	doTemp.setDDDWJbo("CAPITALCURRENCY", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='1501'"); //币种
	doTemp.setDDDWJbo("CUSTOMERTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9040'");
	doTemp.setDDDWJbo("ORGTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9043'");//组织机构类别
	doTemp.setDDDWJbo("ORGNATURE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9044'");//经济类型
    doTemp.setDDDWJbo("ORGTYPESUB", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9045'");//组织机构类别细分
	doTemp.setDDDWJbo("SCOPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9050'");//企业规模
	doTemp.setDDDWJbo("ACCOUNTSTATUS", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9042'");//基本户状态
	doTemp.setDDDWCodeTable("INCREMENTFLAG", "1,新增,2,业务变更,4,删除,6,手工终结,8,已迁移");//信息操作状态
	doTemp.setDDDWJbo("ORGSTATUS", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9041'");//机构状态
	doTemp.setDDDWJbo("MANAGERTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9046'");//关系人类型
	if(sTable.equals("ECR_ORGANSTOCKHOLDER")||sTable.equals("HIS_ORGANSTOCKHOLDER"))
		doTemp.setDDDWJbo("CERTTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname in ('9047','9039')");//证件类型
	else
		doTemp.setDDDWJbo("CERTTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9047'");//证件类型
	doTemp.setDDDWJbo("STOCKHOLDERTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9048'");//股东类型
	doTemp.setDDDWJbo("MEMBERRELATYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='5555'");
	doTemp.setDDDWJbo("MANAGERCERTTYPE,MEMBERCERTTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9047'");//证件类型
	doTemp.setDDDWJbo("RELATIONSHIP", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9049'");//关联企业关联类型
	//doTemp.setDDDWJbo("Registercountry", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='5509'");
	//doTemp.setDDDWJbo("INDUSTRY", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='5525'");
	
	doTemp.setColumnFilter("*", false);
	doTemp.setColumnFilter("CIFCUSTOMERID,FINANCEID,LOANCARDNO,Managertype,Certid,Relativeentname,Relationship,Superiorname,Managername,SESSIONID", true);


 	//双击事件
    doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
		
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(10);

	dwTemp.genHTMLObjectWindow(sCIFCustomerID);

	String sButtons[][] = {
		//{sFlag.equals("his")?"true":"false","","Button","新增","查看/修改详情","newRecord()","","","",""},
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
		{sFlag.equals("Detail")?"true":"false","","Button","查看历史记录","查看历史记录","showHISContent('"+sTable+"','"+sCIFCustomerID+"')","","","",""},
		{sFlag.equals("his")?"true":"false","","Button","返回","返回","goBack()","","","",""},
		{sFlag.equals("Feedback")?"true":"false","","Button","重新上报","重新上报","report(2)","","","",""},
		{sFlag.equals("Feedback")?"true":"false","","Button","暂不上报","暂不上报","report(3)","","","",""},
		{sFlag.equals("Feedback")?"true":"false","","Button","漏报补报","补报该条漏报的记录","report(4)","","","",""},
	};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		var sTable="<%=sTable%>";
		AsControl.OpenView("/DataMaintain/OrgnizationManage/OrgnizationBaseInfo.jsp","sFlag=new&sTable="+sTable+"&IsQuery=<%=IsQuery%>","_self","");
	}

	function goBack(){
		top.close();
	}
		
	function viewAndEdit(){
		var sFlag="<%=sFlag%>";
		var sCIFCustomerID = getItemValue(0,getRow(),"CIFCUSTOMERID");
		var sSessionID = getItemValue(0,getRow(),"SESSIONID");
		if (typeof(sCIFCustomerID)=="undefined" || sCIFCustomerID.length==0){
			alert("请选择一条记录！");
			return;
		}
		var sKeyValue="";
		var sKeyName="<%=sKeyName%>";
		var sTable="<%=sTable%>";
		for(var i=0;i<sKeyName.split("@").length-1;i++){ 
			sKeyValue+= getItemValue(0,getRow(),sKeyName.split("@")[i])+"@";
		}
		AsControl.OpenView("/DataMaintain/OrgnizationManage/OrgnizationBaseInfo.jsp","sSessionID="+sSessionID+"&sKeyName="+sKeyName+"&sKeyValue="+sKeyValue+"&sTable="+sTable+"&IsQuery=<%=IsQuery%>&sFlag="+sFlag,"_self","");
	}
	//显示历史记录
	function showHISContent(sTable,sCIFCustomerID){
		AsControl.OpenView("/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","sFlag=his&sTable="+sTable+"&sCIFCustomerID="+sCIFCustomerID,"_blank","");
	}
	function report(action){
		var sTableName = "<%=sTable%>";
		var sTraceNumber = getItemValue(0,getRow(),"TRACENUMBER");
		var sSessionID = getItemValue(0,getRow(),"SESSIONID");
		var sCIFCustomerID = getItemValue(0,getRow(),"CIFCUSTOMERID");
		var sWhere;
		var sReturn;
		
		if(typeof(sSessionID)=="undefined"||sSessionID==''){
			alert("请先选择一条记录!");
			return;		
		}
		//正常已经上报过的业务不能补报或者暂不报
		if(typeof(sSessionID) != "undefined" && sSessionID!="9999999999" && sSessionID!="1111111111" && sSessionID!="0000000000" && sSessionID!="6666666666" &&(action=="2"||action=="3"))
		{
			if(confirm("该笔业务已经上报过了,是否从反馈错误表中删除该条记录?")){
				PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TraceNumber="+sTraceNumber,"_self","");
				alert("该条记录已从反馈错误表中删除!");
				return;
			}
		}
		//没有信息跟踪编号,不能重新上报
		if((typeof(sTraceNumber) == "undefined" || sTraceNumber.length == 0)&&action=="2")
		{
			alert("信息跟踪编号不存在,无法进行重报!");
			return;
		}
		if(action=="2"){
			if(confirm("确定重新上报?")){
				sWhere = "and TRACENUMBER = '"+sTraceNumber+"'";
				sReturn = PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TableName="+sDBTableName+"&TraceNumber="+sTraceNumber+"&Where="+sWhere+"&Action="+action,"_self","");
				if(sReturn == "Success"){
					alert("设置重报标志成功!");
				}else{
					alert("设置重报标志失败!");
				}
			}
		}else if(action=="3"){
			if(confirm("确定暂不上报?")){
				sWhere = "and TRACENUMBER = '"+sTraceNumber+"'";
				sReturn = PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TableName="+sDBTableName+"&TraceNumber="+sTraceNumber+"&Where="+sWhere+"&Action="+action,"_self","");
				if(sReturn == "Success"){
					alert("设置暂不上报标志成功!");
				}else{
					alert("设置暂不上报标志失败!");
				}
			}
		}else if(action=="4"){
			if(confirm("确定反馈补报?")){
			 	var sKeyName="<%=sKeyName%>".split("@");
			var sWhere = " where 1=1 and   "+sKeyName[0]+"='" + getItemValue(0,getRow(), sKeyName[0]) + "'";
	   
	     	
	    		for(var  i=1;i<sKeyName.length;i++){

	    			sKeyValue =  getItemValue(0,getRow(),sKeyName[i]);
	    			if("CIFCUSTOMERID"=="RETURNTIMES")
	    				sWhere = sWhere + " and  "+sKeyName[i]+" ='" + sKeyValue+"'";
	    			else
	    				sWhere = sWhere + " and  "+sKeyName[i]+"='" + sKeyValue + "'";
			 		}
				sReturn = PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TableName="+sDBTableName+"&Where="+sWhere+"&Action="+action,"_self","");
				if(sReturn == "Success"){
					alert("设置补报标志成功!");
				}else{
					alert("设置补报标志失败!");
				}
			}
		}
		reloadSelf();
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>
