<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%><%	

	String sType = CurComp.getParameter("type");
	if(sType == null) sType = "";

    ASObjectModel doTemp = new ASObjectModel(JBOFactory.getBizObjectManager("jbo.ecr.ECR_TRANSFERFILTER"));
    doTemp.setVisible("UpdateTime,Operator", false);
    doTemp.setColumnFilter("UpdateTime,Note,RecordScope,Operator", false);
    doTemp.setHTMLStyle("Note","size=30");
	doTemp.setDDDWJbo("FilterCause","jbo.ecr.CODE_LIBRARY,ItemNo,ItemName,CodeNo='FilterCause'");
	doTemp.setDDDWJbo("Recordscope","jbo.ecr.CODE_LIBRARY,ItemNo,ItemName,CodeNo='Recordscope'");
	String sStyle = "style= \"cursor:hand\" ondblclick=\"javascript:viewAndEdit();\"";
	doTemp.appendHTMLStyle("",sStyle);
    String jBOWhere="";
    jBOWhere=(sType.equals("1")?"FilterCause='T'":"FilterCause<>'T'");

	doTemp.setJboWhere(jBOWhere);
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--设置为Grid风格--
	//dwTemp.MultiSelect = true;	 //多选/**修改模板时请不要修改这一行*/
	//dwTemp.ShowSummary="1";	 	 //汇总/**修改模板时请不要修改这一行*/
	dwTemp.ReadOnly = "1";	 //只读模式
	dwTemp.setPageSize(10);
	dwTemp.genHTMLObjectWindow("");//生成window

	//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
	String sButtons[][] = {
		{sType.equals("1")?"true":"false","All","Button","新增","新增","newRecord()","","","","btn_icon_add",""},
		{"true","","Button","详情","详情","viewAndEdit()","","","","btn_icon_detail",""},
		{"true","","Button","删除","删除","deleteRecord()","","","","btn_icon_delete",""},
		{sType.equals("1")?"true":"false","","Button","导出EXCEL","导出EXCEL","as_defaultExport()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		 //AsControl.PopView("/OtherManage/TransferManage/TransferInfo.jsp","","dialogWidth=800;dialogHeight=400;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
		 popComp("TransferInfo","/OtherManage/TransferManage/TransferInfo.jsp","sType=<%=sType%>","dialogWidth=645px;dialogHeight=350px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;"); 
		 reloadSelf();
	}
	
	function deleteRecord(){
		var sMainBusinessNo = getItemValue(0,getRow(),"MainBusinessNo");
		if (typeof(sMainBusinessNo)=="undefined" || sMainBusinessNo.length==0)
		{
			alert("请选择一条记录！");
			return;
		}
		if(confirm("您真的想删除该信息吗？")) 
		{
			as_delete("myiframe0","reloadSelf()");
		}
	}
	
	function viewAndEdit(){

		var sMainBusinessNo = getItemValue(0,getRow(),"MainBusinessNo");
		var sRecordScope = getItemValue(0,getRow(),"RecordScope");
		var sFilterCause = getItemValue(0,getRow(),"FilterCause");
		if (typeof(sMainBusinessNo)=="undefined" || sMainBusinessNo.length==0)
		{
			alert("请选择一条记录！");
			return;
		}
		popComp("TransferInfo","/OtherManage/TransferManage/TransferInfo.jsp","MainBusinessNo="+sMainBusinessNo+"&RecordScope="+sRecordScope+"&FilterCause="+sFilterCause+"&sType=<%=sType%>","dialogWidth=645px;dialogHeight=350px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
		reloadSelf();
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>