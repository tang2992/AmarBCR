<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBeginMD.jsp"%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Info00;Describe=注释区;]~*/%>
	<%
	/*
		Author:  
				
		Tester:
		Describe: 行政区划选择
		Input Param:
		Output Param:
			ItemNo：条目编号
			ItemName：条目名称

		HistoryLog:
			
	 */
	%>
<%/*~END~*/%>

<html>
<head>
<title>请选择行政区划 </title>
</head>

<script language=javascript>

<%
	String sRegionCodeValue = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("RegionCodeValue"));
	String sRegionCode = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("RegionCode"));
	String sOpen = "";
	String sDefaultItem = "";
	//增加判断，防止出现 null错误 add by jbye 2009/03/30
	if(sRegionCode.length()>3) sDefaultItem = sRegionCode.substring(0,3);
	if(sRegionCode!=null&&sRegionCode.length()>3) sOpen = "YES";
%>


	function TreeViewOnClick(){

		var sRegionCode=getCurTVItem().id;
		var sRegionCodeName=getCurTVItem().name;
		var sType = getCurTVItem().type;
		buff.RegionCode.value=sRegionCode+"@"+sRegionCodeName;
		<%

		if(sRegionCodeValue == null)
		{
		%>
		newBusiness();
		<%
		}
		%>
	}
	
	function TreeViewOnDBClick()
	{
		newBusiness();
	}


	function newBusiness(){
<%
	if(sRegionCodeValue == null)
	{
%>
		if(buff.RegionCode.value!=""){
			sReturnValue = buff.RegionCode.value;
			top.OpenPage("/DataMaintain/RegionCodeSelect.jsp?RegionCodeValue="+getCurTVItem().id,"frameright","");
		}
		else{
			alert("请选择具体的行政区划");
		}
<%	}
	else
	{	
%>
		var s,sValue,sName;
		var sReturnValue = "";
		s=buff.RegionCode.value;
		s = s.split('@');
		sValue = s[0];
		sName = s[1];
               
		if(buff.RegionCode.value.length<6){
			alert("请选择行政区划细类");//请选择行业种类细项！
		}else{
			if(sValue.length==6){
				top.returnValue = buff.RegionCode.value;
				top.close();
			}
		}

<%
	}
%>
	}
	//返回
	function goBack()
	{
		top.close();
	}

	//将查询出的行政区划按照TreeView展示
	function startMenu()
	{
	<%

		HTMLTreeView tviTemp = new HTMLTreeView("行政区划列表","right");
		tviTemp.TriggerClickEvent=true;
		//选择行政区划一
		if(sRegionCodeValue == null)
			tviTemp.initWithSql("PbCode","Note","PbCode","","from WEB_CODEMAP where ColName='5527' and length(PbCode) <= 2",Sqlca);
		else
			tviTemp.initWithSql("PbCode","Note","PbCode","","from WEB_CODEMAP where ColName='5527' and PbCode like '"+sRegionCodeValue+"%' and PBCode<>'"+sRegionCodeValue+"'",Sqlca);
		
		tviTemp.ImageDirectory = sResourcesPath; //设置资源文件目录（图片、CSS）
		out.println(tviTemp.generateHTMLTreeView());

	%>

	}


</script>

<body bgcolor="#DCDCDC">
<center>
<form  name="buff">
<input type="hidden" name="RegionCode" value="">
<table width="90%" align=center border='1' height="98%" cellspacing='0' bordercolor='#999999' bordercolordark='#FFFFFF'>
<tr>
        <td id="myleft"  colspan='3' align=center width=100%><iframe name="left" src="" width=100% height=100% frameborder=0 scrolling=no ></iframe></td>
</tr>



<tr height=4%>
<%
	if(sRegionCodeValue == null){
%>
<span class="STYLE9"></span>
<p align="left" class="black9pt">行政区划大类</p>
<td nowrap align="right" class="black9pt" bgcolor="#F0F1DE" >
</td>
<%
	}else{
%>
<span class="STYLE9"></span>
<p align="left" class="black9pt">行政区划子类</p>
<td nowrap align="right" class="black9pt" bgcolor="#F0F1DE" >
	<%=HTMLControls.generateButton("确定","确定","javascript:newBusiness()",sResourcesPath)%>
</td>
<td nowrap bgcolor="#F0F1DE" >
	<%=HTMLControls.generateButton("取消","取消","javascript:goBack()",sResourcesPath)%>
</td>
<%};%>

</tr>

</table>
</form>
</center>
</body>
</html>

<script language="JavaScript">
	startMenu();
	expandNode('root');
	selectItem('<%=sDefaultItem%>');//自动点击树图，目前写死，也可以设置到 code_library中进行设定
	selectItem('<%=sRegionCode%>');//自动点击树图，目前写死，也可以设置到 code_library中进行设定
	expandNode('<%=sRegionCodeValue%>');
</script>

<%@ include file="/IncludeEnd.jsp"%>
