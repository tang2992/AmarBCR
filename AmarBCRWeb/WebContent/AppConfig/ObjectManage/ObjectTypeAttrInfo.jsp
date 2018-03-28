<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Content:    对象类型属性详情
	 */
	//获得组件参数	
	String sObjectType =  CurPage.getParameter("ObjectType");
	String sAttributeID =  CurPage.getParameter("AttributeID");
	if(sObjectType==null) sObjectType="";
	if(sAttributeID==null) sAttributeID="";

	ASObjectModel doTemp = new ASObjectModel("ObjTypeAttributeInfo");
	doTemp.setDefaultValue("ObjectType",sObjectType);
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	dwTemp.genHTMLObjectWindow(sObjectType+","+sAttributeID);
	
	String sButtons[][] = {
		{"true","","Button","保存并返回","保存修改并返回","saveRecordAndReturn()","","","",""},
		{"true","","Button","保存并新增","保存修改并新增另一条记录","saveRecordAndAdd()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	setDialogTitle("对象类型属性详情");
	var sOldAttributeID = getItemValue(0, 0, "AttributeID");
	function saveRecord(sPostEvents){
	    if(!validateAttributeID()) return false;
		as_save("myiframe0",sPostEvents);	
	}
	function saveRecordAndReturn(){
		saveRecord("top.close();");      
	}
    
	function saveRecordAndAdd(){
		saveRecord("newRecord()");
	}
    
	function newRecord(){
		sObjectType = getItemValue(0,getRow(),"ObjectType");
		AsControl.OpenComp("/AppConfig/ObjectManage/ObjectTypeAttrInfo.jsp","ObjectType="+sObjectType,"_self");
	}
	
	function validateAttributeID(){
		var sAttributeID = getItemValue(0, 0, "AttributeID");
		if(sAttributeID != sOldAttributeID){
			var sResult = RunJavaMethodSqlca("com.amarsoft.app.configurator.object.AttributeAction", "validateAttributeID", "ObjectType="+getItemValue(0, 0, "ObjectType")+",AttributeID="+sAttributeID+",OldAttributeID="+sOldAttributeID);
			if(sResult != "SUCCESS"){
				alert(sResult);
				return false;
			}
		}
		return true;
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>