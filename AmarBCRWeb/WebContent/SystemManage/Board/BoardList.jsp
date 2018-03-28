<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%
	String PG_TITLE = "通知列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>
<%	
	/*
        Author: #{author} #{createddate}
        Content: 
        History Log: 
    */
	ASObjectModel doTemp = new ASObjectModel(JBOFactory.getBizObjectManager("jbo.ecr.BOARD_LIST"));
    doTemp.setColumnFilter("*", false);
    doTemp.setColumnFilter("BoardName,BoardTitle", true);
    doTemp.setVisible("*", false);
    doTemp.setVisible("BoardName,BoardTitle,BoardDesc,IsPublish,IsNew,IsEject", true);
	doTemp.setAlign("IsNew,IsEject,IsPublish","2");
	doTemp.setHTMLStyle("IsNew,IsEject,IsPublish"," style={width:60px} ");
	doTemp.setHTMLStyle("BoardTitle"," style={width:300px}");
	doTemp.setDDDWCodeTable("IsPublish,IsNew,IsEject", "1,是,2否");
     
     
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--设置为Grid风格--
	//dwTemp.MultiSelect = true;	 //多选/**修改模板时请不要修改这一行*/
	//dwTemp.ShowSummary="1";	 	 //汇总/**修改模板时请不要修改这一行*/
	dwTemp.ReadOnly = "1";	 //只读模式
	dwTemp.setPageSize(10);
	//双击打开详情
	String sStyle = "style= \"cursor:hand\" ondblclick=\"javascript:viewAndEdit();\" ";
	doTemp.appendHTMLStyle("",sStyle);
	
	dwTemp.genHTMLObjectWindow("");

	//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
	String sButtons[][] = {
		{"true","","Button","新增","新增公告","newRecord()","","","btn_icon_add",""},
		{"true","","Button","详情","查看详情","viewAndEdit()","","","btn_icon_detail",""},
		{"true","","Button","删除","删除公告","deleteRecord()","","","btn_icon_delete",""}						
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		AsControl.PopView("/SystemManage/Board/BoardInfo.jsp","Flag=New","dialogWidth=400px;dialogHeight=350px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
		reloadSelf();
	}
	function viewAndEdit(){
		var sBoardNo = getItemValue(0,getRow(),"BoardNo");
		if (typeof(sBoardNo)=="undefined" || sBoardNo.length==0)
		{
			alert(getHtmlMessage('1'));//请选择一条信息！
			return;
		}
	    AsControl.PopView("/SystemManage/Board/BoardInfo.jsp","BoardNo="+sBoardNo,"");
		reloadSelf();
	}
	function deleteRecord(){
		sBoardNo = getItemValue(0,getRow(),"BoardNo");	
		if (typeof(sBoardNo)=="undefined" || sBoardNo.length==0)
		{
			alert(getHtmlMessage('1'));//请选择一条信息！
			return;
		}
		if(confirm(getHtmlMessage('2')))//您真的想删除该信息吗？
		{
			as_delete('myiframe0');
			as_save('myiframe0');  //如果单个删除，则要调用此语句
		}	
	}
	
	function mySelectRow()
	{		
	}
	function initRow()
	{
		if (getRowCount(0)==0)
		{
		 	as_add("myiframe0");
		}		
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>