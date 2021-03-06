<%@page import="com.amarsoft.xquery.*"%>
<%@page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		Content: --灵活统计查询主页面
		Input Param:
		     type:查询类型
		History Log: 
		     此页面如果增加其它查询选项，需要在本页面修改一些以下内容：
		         1、增机构代码的默认值。
		         2、如果有弹出窗口选项，需要增加选择列的内容。
	 */
	//定义变量
	String sSql="";//--存放sql语句  
	String environmentOrgID   = CurOrg.getOrgID();//--当前机构
	String environmentUserID  = CurUser.getUserID();//--当前用户
	String environmentOrgName = CurOrg.getOrgName();//--当前机构名称
	//获得组件参数
	String sQueryType  =  CurPage.getParameter("type");
	if(sQueryType==null) sQueryType="";

	String xPath = "InfoManage/QueryManage/resources/images/";
	String temp[][] ={
			{"Group","汇总依据列表","none"},{"Display","输出信息项选择",""},{"Summary","合计字段列表","none"},{"Order","排序字段列表",""}
	};
	String defaultScheme = "default";//-xml的控制方式为default
	String defaultStatResult = "2";//--查询方式
	String xmlPath = "";//--存放xml路径
	String[] c = StringFunction.toStringArray(request.getRealPath(request.getServletPath()),Configure.sCurSlash);
	for(int i = 0; i< (c.length-1); i++){
		xmlPath = xmlPath + c[i] + Configure.sCurSlash;
	}
	session.setAttribute("xmlPath",xmlPath);
	session.setAttribute("queryType",sQueryType);
	XQuery query = new XQuery(xmlPath,sQueryType,"");
	int schemeSize = query.schemes.size();
%>		 	
<script type="text/javascript">
	schemeList = new Array;
	groupColumnList = new Array;
	groupColumnNameList = new Array;
	summaryColumnList = new Array;
	summaryColumnNameList = new Array;
	displayColumnList =  new Array;
	displayColumnNameList = new Array;
	orderColumnList =  new Array;
	orderColumnNameList = new Array;
<%
	for(int i=0; i<schemeSize; i++){
		XScheme currentScheme = (XScheme)query.schemes.get(i);
		out.println("schemeList["+i+"]='"+XAttribute.getAttributeValue(currentScheme.attributes,"name")+"';"+"\r");
		out.println("groupColumnList["+i+"]='"+XAttribute.getAttributeValue(currentScheme.attributes,"groupColumns")+"';"+"\r");
		out.println("summaryColumnList["+i+"]='"+XAttribute.getAttributeValue(currentScheme.attributes,"summaryColumns")+"';"+"\r");
		out.println("displayColumnList["+i+"]='"+XAttribute.getAttributeValue(currentScheme.attributes,"displayColumns")+"';"+"\r");
		out.println("orderColumnList["+i+"]='"+XAttribute.getAttributeValue(currentScheme.attributes,"orderColumns")+"';"+"\r");
		out.println("groupColumnNameList["+i+"]='"+query.getHeaders(XAttribute.getAttributeValue(currentScheme.attributes,"groupColumns"))+"';"+"\r");
		out.println("summaryColumnNameList["+i+"]='"+query.getHeaders(XAttribute.getAttributeValue(currentScheme.attributes,"summaryColumns"))+"';"+"\r");
		out.println("displayColumnNameList["+i+"]='"+query.getHeaders(XAttribute.getAttributeValue(currentScheme.attributes,"displayColumns"))+"';"+"\r");
		out.println("orderColumnNameList["+i+"]='"+query.getHeaders(XAttribute.getAttributeValue(currentScheme.attributes,"orderColumns"))+"';"+"\r");
	}
%>
</script>		 	 			 
<html>
<head>
	<title><%=XAttribute.getAttributeValue(query.attributes,"caption")%>查询</title>
	<style>
	select {overflow:scroll;overflow-x:scroll;width:165px}
	.ConditonMapTR{
		background:url("Frame/page/resources/images/strip/tit-bg.gif") repeat-x bottom;
	}
	.ConditonMapSpan{
		cursor: pointer;width: 15px;height: 15px;
		display: inline-block;
		background: url("Frame/page/resources/images/strip/expand.gif") no-repeat center;
	}
	.ConditonMapSpan.collapse{
		background: url("Frame/page/resources/images/strip/collapse.gif") no-repeat center;
	}
	</style>
</head>

<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" style ="width:100%;height:100%;overflow-x:hidden;overflow-y:scroll">
	<table style="width: 100%;height: 99%;border: 0;background-color: #FFFFFF;" align="center" cellpadding="0" cellspacing="0">
		<tr valign="top">
			<td width="750">
				<form name="Main" method="post" action="<%=sWebRootPath%>/InfoManage/QueryManage/XResult.jsp" target="Result" >
				<input type=hidden name=CompClientID value="<%=CurComp.getClientID()%>">
				<table align="center" width="100%" border="1" cellspacing="2" cellpadding="0" bgcolor="#FFFFFF" bordercolor="#FFFFFF">
					<tr bordercolor="#FFFFFF"><td colspan=2>&nbsp;</td></tr>
					<tr bordercolor="#FFFFFF">
						<td valign="middle">&nbsp;
							<img alt="查询当前设置" border="0" src="<%=xPath%>/xquery.jpg" onclick="javascript:DataSubmit();" style="cursor: pointer;">&nbsp;&nbsp;
							<img alt="清除当前设置" border="0" src="<%=xPath%>/xclear.jpg" onclick="javascript:Reset();changeResult(Main.elements['StatResult;;Other;'].value);" style="cursor:pointer">&nbsp;</td>
						<td align="right" bgcolor="#FFFFFF" valign="top">
							<table style="border: 0;">
								<tr>
									<td nowrap align="right" width=15%>统计方式：</td>
									<td width=10% align="left">
										<select name="StatResult;;Other;"  onchange="javascript:changeResult(this.value)">
											<option value="2" <%if(defaultStatResult=="2"){out.println("selected");}%>>明细查询</option>
											<option value="1" <%if(defaultStatResult=="1"){out.println("selected");}%>>汇总查询</option>
										</select>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr bordercolor="#FFFFFF"><td colspan=2 height="20px" bgcolor="#FFFFFF">&nbsp;</td></tr>
					<%=query.getConditionString(Sqlca,environmentUserID,environmentOrgID)%>
					<tr bordercolor="#FFFFFF"><td colspan=2 height="20px" bgcolor="#FFFFFF">&nbsp;</td></tr>
<%	for(int i=0; i<temp.length; i++){ %>
					<tr id="<%=temp[i][0]%>Box" style="display:<%=temp[i][2]%>" bordercolor="#CCCCCC">
						<td style="width: 25%;vertical-align: top;">
							<table cellPadding=0 cellSpacing=0  style="cursor: pointer;width: 100%;border: 0">
								<tbody>
								<tr bgColor=#EEEEEE id="<%=temp[i][0]%>SelectTab" valign="middle" >
									<td align=right valign="middle">
										<span id="<%=temp[i][0]%>SelectTab3" onclick="javascript:showHideContent(event,'<%=temp[i][0]%>Select');" class="ConditonMapSpan"></span></td>
									<td align=left height=20 width="100%" valign="middle" onclick="javascript:document.getElementById('<%=temp[i][0]%>SelectTab3').click();">
										<font color=#000000 id="<%=temp[i][0]%>SelectTab2"><span>&nbsp;<%=temp[i][1]%>...</span></font></td>
								</tr>
								</tbody>
    						</table>
						</td>
						<td style="width: 75%;vertical-align: top;background-color: #FFFFFF;">
							<span id="<%=temp[i][0]%>SelectEmptyTag">&nbsp;</span>
							<div id="<%=temp[i][0]%>SelectContent" style="border-top: #cccccc 0px solid;border-bottom: #cccccc 0px solid; border-left: #cccccc 0px solid; border-right: #cccccc 0px solid; width: 100%;display:none">
								<table style="border: 0;width: 100%;background-color: #FFFFFF;" cellPadding=0 cellSpacing=0>
									<tbody>
									<tr valign="top">
										<td colSpan=3 align="left" bgcolor="#FFFFFF">
											<textarea onclick="javascript:do<%=temp[i][0]%>Select();" rows="6" cols="70" name="<%=temp[i][0]%>NameList;;Other;" readonly style="width: 100%;"></textarea>
											<input type="hidden" name="<%=temp[i][0]%>List;;Other;" value="">
										</td>
									</tr>
									</tbody>
								</table>
							</div>
						</td>
					</tr>
<%	} %>
					<tr bordercolor="#FFFFFF"><td valign="middle">&nbsp;
						<img alt="查询当前设置" border="0" src="<%=xPath%>/xquery.jpg" onclick="javascript:DataSubmit();" style="cursor: pointer;">&nbsp;&nbsp;
						<img alt="清除当前设置" border="0" src="<%=xPath%>/xclear.jpg" onclick="javascript:Reset();changeResult(Main.elements['StatResult;;Other;'].value);" style="cursor:pointer">&nbsp;</td>
					<tr bordercolor="#FFFFFF"><td colspan=2 height="20px" bgcolor="#FFFFFF">&nbsp;</td></tr>
					<tr bordercolor="#FFFFFF"><td colspan=2 height="200px" bgcolor="#FFFFFF">&nbsp;</td></tr>
				</table>
				</form>
			</td>
		</tr>
	</table>
	<form name="ChangeScheme" method="post" action="<%=sWebRootPath%>/InfoManage/QueryManage/XQuery.jsp" target="_right"></form>
	<iframe style="display: none;border: 0;width: 100%;height: 100%;" name=Result src=""></iframe>
</body>
<script type="text/javascript">
	//字符串替换
	function replace(a,b,c){
		var result="";
		var t = a.split("|");
		for(var i=0; i<t.length; i++){
			if(i==0){
				result = t[i];
			}else{
				result = result + c + t[i];
			}
		}
		return result;
	}

	//改变查询方式
	function changeResult(sValue){
		if (sValue=="2") {
			GroupBox.style.display="none";
			SummaryBox.style.display="none";
			DisplayBox.style.display="";
			OrderBox.style.display="";
		}else{
			GroupBox.style.display="";
			SummaryBox.style.display="";
			DisplayBox.style.display="none";
			OrderBox.style.display="none";
		}
	}

	function showLayer(sLayer){
		if(Main.item(sLayer).style.display=="none") Main.item(sLayer).style.display="";
		else Main.item(sLayer).style.display="none";
	}

	//显示汇总字段选择框
	function doGroupSelect(){
		sReturn ="";
		iniString=Main.elements["GroupList;;Other;"].value;

		sReturn = PopPage("/InfoManage/QueryManage/XSelect.jsp?iniString="+Main.elements["GroupList;;Other;"].value+"&disableString=<%=query.DisAvailableGroupColumns%>&scope=<%=query.availableGroupColumns%>&type=all&nametype=2&rand="+randomNumber(),"","dialogWidth=500px;dialogheight=320px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;statusbar:no");
		if (sReturn!="" && typeof(sReturn)!="undefined"){
			if(sReturn=="@"){
				Main.elements["GroupList;;Other;"].value="";
				Main.elements["GroupNameList;;Other;"].value="";
			}else{
				pos = sReturn.indexOf("@");
				if (pos>0){
					Main.elements["GroupNameList;;Other;"].value=sReturn.substring(0,pos);
					Main.elements["GroupList;;Other;"].value=sReturn.substring(pos+1,sReturn.length);
				}
			}
		}
	}

	//显示合计字段选择框
	function doSummarySelect(){
		sReturn ="";
		sReturn = PopPage("/InfoManage/QueryManage/XSelect.jsp?iniString="+Main.elements["SummaryList;;Other;"].value+"&disableString=<%=query.DisAvailableSummaryColumns%>&scope=<%=query.availableSummaryColumns%>&type=number&nametype=2&rand="+randomNumber(),"","dialogWidth=500px;dialogheight=320px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;statusbar:no");
		if (sReturn!="" && typeof(sReturn)!="undefined"){
			if(sReturn=="@"){
				Main.elements["SummaryList;;Other;"].value="";
				Main.elements["SummaryNameList;;Other;"].value="";
			}else{
				pos = sReturn.indexOf("@");
				if (pos>0){
					Main.elements["SummaryNameList;;Other;"].value=sReturn.substring(0,pos);
					Main.elements["SummaryList;;Other;"].value=sReturn.substring(pos+1,sReturn.length);
				}
			}
		}
	}

	//显示显示字段选择框
	function doDisplaySelect(){
		sReturn ="";
		sReturn = PopPage("/InfoManage/QueryManage/XSelect.jsp?iniString="+Main.elements["DisplayList;;Other;"].value+"&disableString=<%=query.DisAvailableDisplayColumns%>&scope=<%=query.availableDisplayColumns%>&type=all&nametype=1&rand="+randomNumber(),"","dialogWidth=500px;dialogheight=320px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;statusbar:no");
		if (sReturn!="" && typeof(sReturn)!="undefined"){
			if(sReturn=="@"){
				Main.elements["DisplayList;;Other;"].value="";
				Main.elements["DisplayNameList;;Other;"].value="";
				Main.elements["OrderNameList;;Other;"].value="";
				Main.elements["OrderList;;Other;"].value="";
			}else{
				pos = sReturn.indexOf("@");
				if (pos>0){
					Main.elements["DisplayNameList;;Other;"].value=sReturn.substring(0,pos);
					Main.elements["DisplayList;;Other;"].value=sReturn.substring(pos+1,sReturn.length);
					Main.elements["OrderNameList;;Other;"].value="";
					Main.elements["OrderList;;Other;"].value="";
				}
			}
		}
	}

	//显示排序字段选择框
	function doOrderSelect(){
		sReturn =PopPage("/InfoManage/QueryManage/XSelect.jsp?iniString="+Main.elements["OrderList;;Other;"].value+"&scope="+Main.elements["DisplayList;;Other;"].value+"&type=all&nametype=1&rand="+randomNumber(),"","dialogWidth=500px;dialogheight=320px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;statusbar:no");
		if (sReturn!="" && typeof(sReturn)!="undefined"){
			if(sReturn=="@"){
				Main.elements["OrderList;;Other;"].value="";
				Main.elements["OrderNameList;;Other;"].value="";
			}else{
				pos = sReturn.indexOf("@");
				if (pos>0){
					Main.elements["OrderNameList;;Other;"].value=sReturn.substring(0,pos);
					Main.elements["OrderList;;Other;"].value=sReturn.substring(pos+1,sReturn.length);
				}
			}
		}
	}

	//改变查询定义
	function changeScheme(name){
		var a11 = document.getElementById("GroupSelect"+"Content");
		var a12 = document.getElementById("GroupSelect"+"Tab3");
		var a21 = document.getElementById("SummarySelect"+"Content");
		var a22 = document.getElementById("SummarySelect"+"Tab3");
		var a31 = document.getElementById("DisplaySelect"+"Content");
		var a32 = document.getElementById("DisplaySelect"+"Tab3");
		var a41 = document.getElementById("OrderSelect"+"Content");
		var a42 = document.getElementById("OrderSelect"+"Tab3");
		for(var i=0; i<schemeList.length; i++){
			if(schemeList[i]==name){
	   			Main.elements["DisplayList;;Other;"].value=displayColumnList[i];
	   			Main.elements["DisplayNameList;;Other;"].value=replace(displayColumnNameList[i],"|","\r");
	   			if((displayColumnList[i].length>0)&&(a31.style.display == "none")){
	   				a32.click();
	   			}
	   			if((displayColumnList[i].length==0)&&(a31.style.display != "none")){
	   				a32.click();
	   			}
	   			Main.elements["OrderList;;Other;"].value=orderColumnList[i];
	   			Main.elements["OrderNameList;;Other;"].value=replace(orderColumnNameList[i],"|","\r");
	   			if((a41.style.display == "none")&&(orderColumnList[i].length>0)){
	   				a42.click();
	   			}
	   			if((a41.style.display != "none")&&(orderColumnList[i].length==0)){
	   				a42.click();
	   			}
	   			Main.elements["SummaryList;;Other;"].value=summaryColumnList[i];
	   			Main.elements["SummaryNameList;;Other;"].value=replace(summaryColumnNameList[i],"|","\r");
	   			if((summaryColumnList[i].length>0)&&(a21.style.display == "none")){
   					a22.click();
   				}
   				if((summaryColumnList[i].length==0)&&(a21.style.display != "none")){
   					a22.click();
   				}
   				Main.elements["GroupList;;Other;"].value=groupColumnList[i];
   				Main.elements["GroupNameList;;Other;"].value=replace(groupColumnNameList[i],"|","\r");
   				if((groupColumnList[i].length>0)&&(a11.style.display == "none")){
   					a12.click();
   				}
   				if((groupColumnList[i].length==0)&&(a11.style.display != "none")){
   					a12.click();
   				}
   				return;
   			}
   		}
	}

	function selectDate(name){
		var date = Main.elements[name].value;
		sReturn ="";
		sReturn = PopPage("/Common/ToolsA/SelectDate.jsp?d="+date,"","dialogWidth=300px;dialogHeight=220px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;statusbar:no");
		if(typeof(sReturn)!="undefined") Main.elements[name].value=sReturn;
	}
	
	function selectMonth(name){
		var date = Main.elements[name].value;
		sReturn ="";
		sReturn = PopPage("/Common/ToolsA/SelectMonth.jsp?d="+date,"","dialogWidth=300px;dialogHeight=220px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;statusbar:no");
		if(typeof(sReturn)!="undefined") Main.elements[name].value=sReturn;
	}
	
	//选取列的限制
	function DataSubmit(){
		if(Main.elements["DisplayList;;Other;"].value == "" && Main.elements['StatResult;;Other;'].value == 2){ //明细查询
			alert("请选择输出信息项！");
			return;
		}
		
		if(Main.elements["GroupNameList;;Other;"].value == "" && Main.elements['StatResult;;Other;'].value == 1){ //汇总查询
			alert("请选择汇总信息项！");
			return;
		}
		Main.submit();
	}

	//用以控制几个条件区的显示或隐藏
	function showHideContent(event,id){
		var bOn = false;
		var oTab      = document.getElementById(id+"Tab");
		var oTab2     = document.getElementById(id+"Tab2");
		var oImage    = document.getElementById(id+"Tab3");
		var oContent  = document.getElementById(id+"Content");
		var oEmptyTag = document.getElementById(id+"EmptyTag");

		if (!oTab || !oTab2 || !oImage || !oContent)
		return;

		var obj = event.srcElement || event.target;
		if (obj){
			bOn = (oContent.style.display.toLowerCase() == "none");
		}

		if (bOn == false){
			$(oContent).slideUp(function(){
				oImage.className = "ConditonMapSpan";
			});
		}else{
			oImage.className = "ConditonMapSpan collapse";
			$(oContent).slideDown();
		}
	}

	//release in 2008/04/10,2008/02/15 for xquery
	//下拉列表多选项
	/* function ShowSelect(sName){
		var sSelectCol="",iLength = Main.elements[sName].options.length;
		var sSelectedCol=Main.elements[sName].item(0).value;
		
		for(i=1;i<=iLength-1;i++){
			if(i==1){
				sSelectCol=Main.elements[sName].item(i).value+"@"+Main.elements[sName].item(i).text;
			}else{
				sSelectCol=sSelectCol+"@@"+Main.elements[sName].item(i).value+"@"+Main.elements[sName].item(i).text;
			}
		}

		sReturn = PopPage("/InfoManage/QueryManage/XSelectX.jsp?ColName="+sName+"&SelectedCol="+sSelectedCol+"","",
					"dialogWidth=480px;dialogheight=370px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;statusbar:no");		
		if(typeof(sReturn)!= "undefined" && sReturn.length!=0 && sReturn!=""&&sReturn!="XXXXXXXXXXXXXXX"){
			var sTemp1=sReturn.split("@@");
			var s1="",s2="";
			for(s=0;s<sTemp1.length;s++){
				var sTemp2=sTemp1[s].split("@");
				if(s==0){
					s1=sTemp2[1];
					s2=sTemp2[0];
				}else{
					s1=s1+"@"+sTemp2[1];
					s2=s2+","+sTemp2[0];
				}
			}

			Main.elements[sName].item(0).text=s2.substring(0,16);
			Main.elements[sName].item(0).value=s1+"@";
			Main.elements[sName].item(0).selected=true;
		}else if(typeof(sReturn)== "undefined" || sReturn.length==0 || sReturn=="" ){
			Main.elements[sName].item(0).text="";
			Main.elements[sName].item(0).value="";
			Main.elements[sName].item(0).selected=true;
		}
	} */
	
	//blocked in 2008/04/10,2008/02/15 for xquery
	function ShowSelect(sInputName,sColName){
		var sSelected=Main.elements[sInputName].value;

		sReturn = PopPage("/InfoManage/QueryManage/XSelectX.jsp?SelectedCol="+sSelected+"&InputName="+sInputName+"&ColName="+sColName+"","",
				"dialogWidth=480px;dialogheight=370px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;statusbar:no");
		if(typeof(sReturn)!= "undefined" && sReturn.length!=0 && sReturn!=""&&sReturn!="XXXXXXXXXXXXXXX"){
			var sTemp1=sReturn.split("@@");
			var s1="",s2="";
			for(s=0;s<sTemp1.length;s++){
				var sTemp2=sTemp1[s].split("@");
				if(s==0){
					s1=sTemp2[1];
					s2=sTemp2[0];
				}else{
					s1=s1+"@"+sTemp2[1];
					s2=s2+","+sTemp2[0];
				}
			}
			Main.elements["NOTCONDITION_"+sColName].value=s2.substring(0,16);
			Main.elements[sInputName].value=s1+"@";
		}else if(typeof(sReturn)== "undefined" || sReturn.length==0 || sReturn=="" ){
			Main.elements["NOTCONDITION_"+sColName].value="";
			Main.elements[sInputName].value="";
		}
	}
	
	function Reset(){
		Main.reset();
		for(var k=0;k<Main.elements.length;k++){
			try{
				if(Main.elements[k].name!="StatResult;;Other;")
					Main.elements[k].item(0).text="";
			}catch(e){
				var a=1;
			}
		}
		changeScheme('<%=defaultScheme%>');
		changeResult('<%=defaultStatResult%>');
	}
	
	changeScheme('<%=defaultScheme%>');
	changeResult('<%=defaultStatResult%>');
	//document.getElementById("OrderBox").style.display = "none";
</script>
</html>
<%@ include file="/IncludeEnd.jsp"%>