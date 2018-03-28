<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Frame00;Describe=注释区;]~*/%>
	<%
	/*
		Author:
		Tester:
		Content: 行政区划选择
		Input Param:
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Frame01;Describe=定义变量，获取参数;]~*/%>
<%
	String sRegionCode = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("RegionCode"));
	//System.out.println("----------"+sRegionCode);
%>
<%/*~END~*/%>
 

<%/*~BEGIN~不可编辑区~[Editable=false;CodeAreaID=Frame02;Describe=主体页面;]~*/%>
	<%@include file="/Resources/CodeParts/Frame03.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=Frame03;Describe=自定义函数;]~*/%>
	<script language=javascript>
	
	</script>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=Frame04;Describe=页面装载时，进行初始化;]~*/%>
<script language=javascript>
	myleft.width=340;
	OpenPage("/DataMaintain/RegionCodeSelect.jsp?RegionCode=<%=sRegionCode%>","frameleft","");
	OpenPage("/Blank.jsp?TextToShow=请在左方列表中选择一项","frameright","");
</script>	
<%/*~END~*/%>

<%@ include file="/IncludeEnd.jsp"%>
