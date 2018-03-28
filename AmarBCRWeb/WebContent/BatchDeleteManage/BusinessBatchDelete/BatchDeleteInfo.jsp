<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Info01;Describe=定义页面属性;]~*/%>
	<%
	String PG_TITLE = "批量删除数据详情页面"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>
<%/*~END~*/%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Info02;Describe=定义变量，获取参数;]~*/%>
<%
	String isReport = CurPage.getParameter("isReport");	//0-未上报，1-已上报，2-批删结果
	if(isReport == null) isReport = "";
	String sReadOnly = CurPage.getParameter("ReadOnly");
	if(sReadOnly==null) sReadOnly="T";
	String isNew = CurPage.getParameter("isNew");
	if(isNew==null) isNew="0";
	String keyValue = CurPage.getParameter("keyValue");//主键
	if(keyValue == null) keyValue = "";
	String keyStr = null;
	String valueStr = null;
	String jboWhere = "";
	String args = "";
	if(keyValue.length()>0){
		String[] kv = keyValue.split("~");
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

	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr.HIS_BATCHDELETE");
	ASObjectModel doTemp = new ASObjectModel(boManager);
	doTemp.setJboWhere((!"1".equals(isNew)&&jboWhere.length()>0)?jboWhere:"1=2");
	//分栏
	//doTemp.setColCount(2);
	doTemp.setVisible("ModFlag,RecordFlag,TraceNumber,IncrementFlag,ErrorCode,SessionID",false);
	doTemp.setRequired("OccurDate,ContractNo,BusinessType,LoanCardNo,FinanceID",true);
	doTemp.setDDDWCodeTable("BusinessType","01,贷款业务,02,保理,03,票据贴现,04,贸易融资,05,信用证,06,保函,07,承兑汇票,08,公开授信,09,垫款,10,欠息");
	doTemp.setEditStyle("OccurDate", "Date");
	doTemp.setEditStyle("BusinessType", "Select");
	 
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	if(isReport.equals("0"))
		dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	else
		dwTemp.ReadOnly = "1"; 
	dwTemp.genHTMLObjectWindow(args.length()>0?args:"%");

	%>
<%/*~END~*/%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Info04;Describe=定义按钮;]~*/%>
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
		{isReport.equals("0")?"true":"false","","Button","保存","保存","saveRecord()","","","",""},
		{"true","","Button","返回","返回列表页面","goBack()","","","",""}
		};
	%> 
<%/*~END~*/%>

<%@include file="/Frame/resources/include/ui/include_info.jspf"%>

<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=Info06;Describe=定义按钮事件;]~*/%>
	<script type="text/javascript">

	//---------------------定义按钮事件------------------------------------
	/*~[Describe=返回列表页面;InputParam=无;OutPutParam=无;]~*/
	function saveRecord()
	{	
		//return true;
		var sLoanCardNo = getItemValue(0,0,"LoanCardNo");
		if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
			if(!CheckLoanCardID(sLoanCardNo)){
				alert('贷款卡编号输入有误!');
				return false;
			}
		} 
        as_save("myiframe0","");
	}
	function goBack()
	{
		var sReadOnly="<%=sReadOnly%>";
		if(sReadOnly=='F'){
			AsControl.OpenView("/BatchDeleteManage/BusinessBatchDelete/BatchDeleteList.jsp","&isReport=<%=isReport%>","right");
		}else if(sReadOnly=='T'){
			AsControl.OpenView("/BatchDeleteManage/BusinessBatchDelete/BatchDeleteList.jsp","&isReport=<%=isReport%>","right");
		}else if(sReadOnly=='T2'){
			AsControl.OpenView("/BatchDeleteManage/BusinessBatchDelete/BatchDeleteList.jsp","&isReport=<%=isReport%>","right");
		}
	}
	function initRow(){
		if (getRowCount(0)==0) //如果没有找到对应记录，则新增一条，并设置字段默认值
		{	
			setItemValue(0,0,"OccurDate","<%=DateX.format(new java.util.Date())%>");
			setItemValue(0,0,"SessionID","0000000000");
			setItemValue(0,0,"IncrementFlag","1");
			setItemValue(0,0,"RecordFlag","40");
		}
	}
	</script>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=Info08;Describe=页面装载时，进行初始化;]~*/%>
<script type="text/javascript">
	initRow();
</script>	
<%/*~END~*/%>

<%@ include file="/Frame/resources/include/include_end.jspf"%>
