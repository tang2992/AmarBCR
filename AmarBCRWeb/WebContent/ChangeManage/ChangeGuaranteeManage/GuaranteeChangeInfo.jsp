<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%>
<%
	/* 页面说明: 示例详情页面 */
	String PG_TITLE = "融资性担保业务变更信息详情";

	// 获得页面参数
	String sNode = CurPage.getParameter("sNode");
	if(sNode==null) sNode="";
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
	
	//通过JBO产生ASObjectModel对象doTemp
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.bcr.BCR_GUARANTEECHANGE");
	ASObjectModel doTemp = new ASObjectModel(boManager);
	doTemp.setJboWhere(jboWhere.length()>0?jboWhere:"");
	
	doTemp.setVisible("*", false);
	doTemp.setRequired("FinanceCode,GBusinessNo,NEWGBusinessNo,UpdateDate",true);
	doTemp.setVisible("FinanceCode,GBusinessNo,NEWGBusinessNo,UpdateDate", true);	
	doTemp.setDefaultValue("UpdateDate", DateX.format(new java.util.Date()));
	doTemp.setEditStyle("UpdateDate", "Date");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
   	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	if("UnChange".equals(sNode))dwTemp.ReadOnly = "0"; // 设置是否只读 1:只读 0:可写
	else dwTemp.ReadOnly = "1";
   	
	dwTemp.genHTMLObjectWindow(args.length()>0?args:"%");

	String sButtons[][] = {
		{sNode.equals("UnChange")?"true":"false","","Button","保存","保存所有修改","saveRecord()","","","",""},
		{sNode.equals("UnChange")?"true":"false","","Button","保存并返回","保存并返回列表","saveAndGoBack()","","","",""},
		{"true","","Button","返回","返回列表页面","goBack()","","","",""}
	};
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">

	function saveRecord(sPostEvents){
		as_save("myiframe0",sPostEvents);
	}
	
	function saveAndGoBack(){
		saveRecord("goBack()");
	}
	
	function goBack(){
		var sNode="<%=sNode%>";
		if(sNode=='UnChange'){
			AsControl.OpenView("/ChangeManage/ChangeGuaranteeManage/GuaranteeChangeList.jsp","node=UnChange","right");
		}else if(sNode=='Change'){
			AsControl.OpenView("/ChangeManage/ChangeGuaranteeManage/GuaranteeChangeList.jsp","node=Change","right");
		}else {
			AsControl.OpenView("/ChangeManage/ChangeGuaranteeManage/GuaranteeChangeList.jsp","node=Result","right");
		}		
	}

	function initRow(){
		if (getRowCount(0)==0){//如当前无记录，则新增一条
			//setItemDisabled(0,0,"DeleteTypes",true);
			setItemValue(0,0,"UpdateDate","<%=DateX.format(new java.util.Date())%>");
			setItemValue(0,0,"SessionID","1111111111");
			setItemValue(0,0,"IncrementFlag","1");
			setItemValue(0,0,"Modflag","1");
			setItemValue(0,0,"RecordFlag","40");
		}
    }
	
	initRow();
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
