<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%@
 page import="com.amarsoft.app.awe.framecase.formatdoc.template01.ActionForD000100" %><%@
 page import="com.amarsoft.are.jbo.*" %><%
	//��ȡjbo��list
	String[] headers = {"�ĵ����ͱ��","�ĵ���������","�ĵ�����","����"};
 	ASObjectModel doTemp = new ASObjectModel(headers);
	doTemp.setBusinessProcess("com.amarsoft.app.awe.framecase.formatdoc.template01.ActionForD000100");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.MultiSelect = true;
	dwTemp.forceSerialJBO=true;
	dwTemp.Style="1";      //����ΪGrid���
	dwTemp.genHTMLObjectWindow(ActionForD000100.getSelectedDatas(CurPage.getParameter("DataSerialNo"), request));
	
	String sButtons[][] = {
		{"true","","Button","ȷ��","ȷ��","as_extendAction(0,'afterSave()','removeList')","","","",""},
	};
%><%@ include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
 function afterSave(){
	var selrows = getSelRows(0);
	var parentWindow = window.dialogArguments;
	var table = parentWindow.document.getElementById("listtest");
	var tbody;
	if(table.childNodes[0].tagName=='TBODY'){
		tbody = table.childNodes[0];
	}
	else{//����firefox
		tbody = table.childNodes[1];
	}
	//�Ƚ�tr�����������
	var trArray = new Array();
	for(var i=0;i<tbody.childNodes.length;i++){
		//alert(tbody.childNodes[i].tagName);
		if(tbody.childNodes[i].tagName.toUpperCase() == 'TR'){
			trArray[trArray.length] = tbody.childNodes[i];
		}
	}
	//����trɾ������.��Ҫ�ų�ǰ����
	for(var i=selrows.length-1;i>=0;i--){
		var deleteRowIndex = selrows[i] + 2;
		tbody.removeChild(trArray[deleteRowIndex]);
	}
	top.close();
 }
 </script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>