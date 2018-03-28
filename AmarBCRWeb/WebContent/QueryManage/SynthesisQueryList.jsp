<%@ page contentType="text/html; charset=GBK"
		import="com.amarsoft.ECRDataWindowXml"%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List00;Describe=注释区;]~*/%>
	<%
	/*
		Author: hywang
		Tester:
		Content: 综合信息查询列表
		Input Param:
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List01;Describe=定义页面属性;]~*/%>
	<%
	String PG_TITLE = "客户查询列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List03;Describe=定义数据对象;]~*/%>
<%	
	ECRDataWindowXml ecrDWX = new ECRDataWindowXml("ECR_DATACHECK","ECR_DATACHECK","ECR");
	//2.生成源数据SQL语句
	ecrDWX.setWhereSql(" where 1=1 ");
	//3.创建ASDataObject对象
	ASDataObject doTemp =  ecrDWX.generateASDataObject("List");
	
	//设置下拉框
	doTemp.setColumnAttribute(ecrDWX.getFilter(),"IsFilter","1");
	doTemp.generateFilters(Sqlca);
	doTemp.parseFilterData(request,iPostChange);
	CurPage.setAttribute("FilterHTML",doTemp.getFilterHtml(Sqlca));
	
	String sStyle = "style= \"cursor:hand\" ondblclick=\"javascript:parent.shoDetail();\"";
	doTemp.appendHTMLStyle("",sStyle);
	
	if(!doTemp.haveReceivedFilterCriteria()) doTemp.WhereClause+="   ";//可加and 1=2
	ASDataWindow dwTemp = new ASDataWindow(CurPage ,doTemp,Sqlca);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(20);
	
	//生成HTMLDataWindow
	Vector vTemp = dwTemp.genHTMLDataWindow("%");
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));
	
%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List04;Describe=定义按钮;]~*/%>
	<%
	//依次为：
		//0.是否显示
		//1.注册目标组件号(为空则自动取当前组件)
		//2.类型(Button/ButtonWithNoAction/HyperLinkText/TreeviewItem/PlainText/Blank)
		//3.按钮文字
		//4.说明文字
		//5.事件
		//6.资源图片路径
	String sButtons[][] = {
		{"true","","Button","统计","统计","shoDetail()",sResourcesPath},
		{"true","","Button","详情","查看/修改详情","viewAndEdit()",sResourcesPath},
		};
	%> 
<%/*~END~*/%>

<%/*~BEGIN~不可编辑区~[Editable=false;CodeAreaID=List05;Describe=主体页面;]~*/%>
	<%@include file="/Resources/CodeParts/List05.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=List06;Describe=自定义函数;]~*/%>
	<script language=javascript>
	
	/*~[Describe=查看及修改详情;InputParam=无;OutPutParam=无;]~*/
	function shoDetail()
	{
		var sLoanCardNo = getItemValue(0,getRow(),"LOANCARDNO");
		if (typeof(sLoanCardNo)=="undefined" || sLoanCardNo.length==0)
		{
			alert("请选择一条记录！");
			return;
		}
		popComp("SynthesisQueryInfoDetail","/QueryManage/SynthesisQueryInfoDetail.jsp","LoanCardNo="+sLoanCardNo,"");
		reloadSelf();
	}
	
	function viewAndEdit(){
		var sLoanCardNo = getItemValue(0,getRow(),"LOANCARDNO");
		var sChinaName = getItemValue(0,getRow(),"CUSTOMERNAME");
		if (typeof(sLoanCardNo)=="undefined" || sLoanCardNo.length==0)
		{
			alert("请选择一条记录！");
			return;
		}
		popComp("SynthesisQueryInfo","/QueryManage/SynthesisQueryInfo.jsp","LoanCardNo="+sLoanCardNo,"");
		reloadSelf();
	}
	
	</script>
<%/*~END~*/%>

<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=List07;Describe=页面装载时，进行初始化;]~*/%>
<script language=javascript>	
	AsOne.AsInit();
	init();
	my_load(2,0,'myiframe0');
</script>	
<%/*~END~*/%>

<%@ include file="/IncludeEnd.jsp"%>