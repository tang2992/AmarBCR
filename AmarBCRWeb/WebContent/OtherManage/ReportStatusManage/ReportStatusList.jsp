<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List00;Describe=注释区;]~*/%>
	<%
	/*
		Author: shhu
		Tester:
		Content: 数据上报情况列表页面
		Input Param:
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List01;Describe=定义页面属性;]~*/%>
	<%
	String PG_TITLE = "数据上报情况列表页面"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List03;Describe=定义数据对象;]~*/%>
<%	
	String sSql;
	String sHeaders[][] = {
						   {"SessionID","期次"},
						   {"MessageType","报文类型"},
						   {"RetryType","是否重报"},
						   {"RecordNumber","上报数据量"},
					       {"FeedbackNumber","反馈数据量"},
					       {"FeedbackDate","反馈解析日期"}
						  };
	sSql = "select SessionID,getCodeName('1101',MessageType) as MessageType,case RetryType when '0' then '否' else '是' end as RetryType," +
		   "RecordNumber,FeedbackNumber,FeedbackDate " +
		   "from ECR_REPORTSTATUS where 1 = 1 order by SessionID desc";
	       
	ASDataObject doTemp = new ASDataObject(sSql);
	doTemp.setHeader(sHeaders);

	//设置过滤器
	doTemp.setFilter(Sqlca,"1","SessionID","Operators=BeginsWith,EndWith,Contains,EqualsString;");
 	doTemp.setFilter(Sqlca,"2","MessageType","Operators=BeginsWith,EndWith,Contains,EqualsString;");
 	doTemp.setFilter(Sqlca,"3","RetryType","Operators=BeginsWith,EndWith,Contains,EqualsString;");
	doTemp.parseFilterData(request,iPostChange);
	CurPage.setAttribute("FilterHTML",doTemp.getFilterHtml(Sqlca));
	
	String sStyle = "style= \"cursor:hand\" ondblclick=\"javascript:parent.viewAndEdit();\"";
	doTemp.appendHTMLStyle("",sStyle);
	doTemp.setHTMLStyle("SessionID"," style={width:90px;}");
	doTemp.setHTMLStyle("MessageType"," style={width:200px;}");
	doTemp.setHTMLStyle("RetryType"," style={width:60px;}");
	doTemp.setHTMLStyle("RecordNumber"," style={width:70px;}");
	doTemp.setHTMLStyle("FeedbackNumber"," style={width:70px;}");
	doTemp.setHTMLStyle("FeedbackTime"," style={width:85px;}");
	
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
		
	String sButtons[][] = {};
	
	%> 
<%/*~END~*/%>

<%/*~BEGIN~不可编辑区~[Editable=false;CodeAreaID=List05;Describe=主体页面;]~*/%>
	<%@include file="/Resources/CodeParts/List05.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=List06;Describe=自定义函数;]~*/%>

<%/*~END~*/%>

<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=List07;Describe=页面装载时，进行初始化;]~*/%>
<script language=javascript>	
	AsOne.AsInit();
	init();
	my_load(2,0,'myiframe0');
</script>	
<%/*~END~*/%>

<%@ include file="/IncludeEnd.jsp"%>
