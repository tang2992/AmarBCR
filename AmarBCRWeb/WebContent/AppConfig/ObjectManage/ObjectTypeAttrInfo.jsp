<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Content:    ����������������
	 */
	//����������	
	String sObjectType =  CurPage.getParameter("ObjectType");
	String sAttributeID =  CurPage.getParameter("AttributeID");
	if(sObjectType==null) sObjectType="";
	if(sAttributeID==null) sAttributeID="";

	ASObjectModel doTemp = new ASObjectModel("ObjTypeAttributeInfo");
	doTemp.setDefaultValue("ObjectType",sObjectType);
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(sObjectType+","+sAttributeID);
	
	String sButtons[][] = {
		{"true","","Button","���沢����","�����޸Ĳ�����","saveRecordAndReturn()","","","",""},
		{"true","","Button","���沢����","�����޸Ĳ�������һ����¼","saveRecordAndAdd()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	setDialogTitle("����������������");
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