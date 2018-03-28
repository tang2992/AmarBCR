<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%>
<%
	/* 页面说明: 示例详情页面 */
	String PG_TITLE = "机构删除信息详情";

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
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr.HIS_BATCHDELETEORGAN");
	ASObjectModel doTemp = new ASObjectModel(boManager);
	doTemp.setJboWhere(jboWhere.length()>0?jboWhere:"");
	
	doTemp.setVisible("*", false);
	doTemp.setRequired("Cifcustomerid,Segmenttype,Updatedate,FinanceId",true);
	doTemp.setVisible("Cifcustomerid,Segmenttype,Updatedate,FinanceId", true);
	
	doTemp.setDDDWCodeTable("SEGMENTTYPE", "B,全部,C,基本属性段,D,机构状态段,E,联络信息段,F,高管及主要关系人段,G,重要股东段,H,主要关联企业段,I,主管单位段");
	doTemp.setDDDWCodeTable("MANAGERTYPE", "0,实际控制人,1,董事长,2,总经理/主要负责人,3,财务负责人,4,监事长 ,5,法定代表人");
	doTemp.setHTMLStyle("SEGMENTTYPE", "onChange=\"parent.getRelative()\"");
	doTemp.setDefaultValue("OCCURDATE", DateX.format(new java.util.Date()));
	doTemp.setEditStyle("Updatedate", "Date");
	doTemp.setEditStyle("SEGMENTTYPE", "Select");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
   	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	if("UnDelete".equals(sNode))dwTemp.ReadOnly = "0"; // 设置是否只读 1:只读 0:可写
	else dwTemp.ReadOnly = "1";
   	
	dwTemp.genHTMLObjectWindow(args.length()>0?args:"%");

	String sButtons[][] = {
		{sNode.equals("UnDelete")?"true":"false","","Button","保存","保存所有修改","saveRecord()","","","",""},
		{sNode.equals("UnDelete")?"true":"false","","Button","保存并返回","保存并返回列表","saveAndGoBack()","","","",""},
		{"true","","Button","返回","返回列表页面","goBack()","","","",""}
	};
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	 function getRelative(){
		var type=getItemValue(0,0,"SEGMENTTYPE");
		
		if(type=="F"){
			 setItemDisabled(0,0,"MANAGERTYPE",false);
		}else{
			setItemValue(0,0,"MANAGERTYPE","");
			setItemDisabled(0,0,"MANAGERTYPE",true);
		}
	
	 }

	function saveRecord(sPostEvents){
		if(!beforeSave()){
			return false;
		}
		as_save("myiframe0",sPostEvents);
	}
	
	function beforeSave(){
		var sUpdateDate=getItemValue(0,0,"UPDATEDATE");
		var sSEGMENTTYPE=getItemValue(0,0,"SEGMENTTYPE");
		if(sUpdateDate=='2012/01/01'&&sSEGMENTTYPE!='B'){
			alert("删除该段时，2012/01/01不是合法的更新日期!");
			return false;
		}		
		return true;
	}
	
	function saveAndGoBack(){
		saveRecord("goBack()");
	}
	
	function goBack(){
		var sNode="<%=sNode%>";
		if(sNode=='UnDelete'){
			AsControl.OpenView("/BatchDeleteManage/OrganizationDeleteManage/OrganBatchDeleteList.jsp","node=UnDelete","right");
		}else if(sNode=='Deleted'){
			AsControl.OpenView("/BatchDeleteManage/OrganizationDeleteManage/OrganBatchDeleteList.jsp","node=Deleted","right");
		}else {
			AsControl.OpenView("/BatchDeleteManage/OrganizationDeleteManage/OrganBatchDeleteList.jsp","node=Result","right");
		}		
	}

	function initRow(){
		if (getRowCount(0)==0){//如当前无记录，则新增一条
			setItemDisabled(0,0,"MANAGERTYPE",true);
			setItemValue(0,0,"OccurDate","<%=DateX.format(new java.util.Date())%>");
			setItemValue(0,0,"SessionID","0000000000");
			setItemValue(0,0,"IncrementFlag","1");
			setItemValue(0,0,"RecordFlag","40");
		}else{
			var type=getItemValue(0,0,"SEGMENTTYPE");			
			if(type=="F"){
				 setItemDisabled(0,0,"MANAGERTYPE",false);
			}else{
				setItemValue(0,0,"MANAGERTYPE","");
				 setItemDisabled(0,0,"MANAGERTYPE",true);
			}
		}
    }
	
	initRow();
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
