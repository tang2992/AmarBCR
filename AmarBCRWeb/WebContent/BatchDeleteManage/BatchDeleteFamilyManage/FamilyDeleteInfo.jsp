<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%
	/* 页面说明: 示例详情页面 */
	String PG_TITLE = "家族成员详情";

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
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr.HIS_BATCHDELETEFAMILY");
	ASObjectModel doTemp = new ASObjectModel(boManager);	
	doTemp.setJboWhere(jboWhere.length()>0?jboWhere:"");
	
	doTemp.setDefaultValue("cccurDate", DateX.format(new java.util.Date()));
	doTemp.setVisible("*", false);
	doTemp.setVisible("Cifcustomerid,Managercerttype,Managercertid,Memberrelatype,Membercerttype,Membercertid,updateDate,FinanceID", true);
	doTemp.setRequired("Cifcustomerid,Managercerttype,Managercertid,Memberrelatype,Membercerttype,Membercertid,updateDate,FinanceID",true);
	
	doTemp.setDDDWCodeTable("Memberrelatype", "1,配偶,2,父母,3,子女,4,其他血亲,5,其他姻亲");
	doTemp.setDDDWJbo("Managercerttype,Membercerttype", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9047'");
	doTemp.setEditStyle("updateDate", "Date");
	doTemp.setEditStyle("Managercerttype,Membercerttype,Memberrelatype", "Select");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	// 设置是否只读 1:只读 0:可写
	if(sNode.equals("UnDelete")){
		dwTemp.ReadOnly = "0";
	}
	else{
		dwTemp.ReadOnly = "1";
	}
	
	dwTemp.genHTMLObjectWindow(args.length()>0?args:"%");
	 
	String sButtons[][] = {
		{sNode.equals("UnDelete")?"true":"false","","Button","保存","保存所有修改","saveRecord()","","","",""},
		{sNode.equals("UnDelete")?"true":"false","","Button","保存并返回","保存并返回列表","saveAndGoBack()","","","",""},
		{"true","","Button","返回","返回列表页面","goBack()","","","",""}
	};
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function saveRecord(sPostEvents){
		if (!ValidityCheck()) return;
		as_save("myiframe0",sPostEvents);
	}
	
	function saveAndGoBack(){
		saveRecord("goBack()");
	}
	
	function ValidityCheck(){
		//主要关系人身份证号码校验
	    var sMANAGERCERTTYPE=getItemValue(0,0,"MANAGERCERTTYPE");
		var sMANAGERCERTID=getItemValue(0,0,"MANAGERCERTID");
		if(sMANAGERCERTTYPE=="0"&&(!CheckLicense(sMANAGERCERTID))){
			alert(getBusinessMessage('156')); 
		return false;
		}
		
		//家族成员身份证号码校验
		var sMEMBERCERTTYPE=getItemValue(0,0,"MEMBERCERTTYPE");
		var sMEMBERCERTID=getItemValue(0,0,"MEMBERCERTID");
		if(sMEMBERCERTTYPE=="0"&&(!CheckLicense(sMEMBERCERTID))){
			alert(getBusinessMessage('156')); 
			return false;
		}
		return true;
	}
	
	function goBack(){
		var sNode="<%=sNode%>";
		if(sNode=='UnDelete'){
			AsControl.OpenView("/BatchDeleteManage/BatchDeleteFamilyManage/FamilyDeleteList.jsp","node=UnDelete","right");
		}else if(sNode=='Deleted'){
			AsControl.OpenView("/BatchDeleteManage/BatchDeleteFamilyManage/FamilyDeleteList.jsp","node=Deleted","right");
		}else if(sNode=='Result'){
			AsControl.OpenView("/BatchDeleteManage/BatchDeleteFamilyManage/FamilyDeleteList.jsp","node=Result","right");
		}
	}


	function initRow(){
		if (getRowCount(0)==0){//如当前无记录，则新增一条
			setItemValue(0,0,"OccurDate","<%=DateX.format(new java.util.Date())%>");
			setItemValue(0,0,"SessionID","0000000000");
			setItemValue(0,0,"IncrementFlag","1");
			setItemValue(0,0,"RecordFlag","40");
		}
    }
	
	initRow();
	
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
