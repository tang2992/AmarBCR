<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	//��ò���	
	String sScenarioID =  CurPage.getParameter("ScenarioID");
	if (sScenarioID == null) sScenarioID = "";
    
	ASObjectModel doTemp = new ASObjectModel("AlarmGroupList");
	doTemp.setDefaultValue("ScenarioID", sScenarioID);
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(sScenarioID);
    
	String sButtons[][] = {
		{"true", "All","Button","��������","��ǰҳ������","afterAdd()","","","","btn_icon_add"},
		{"true", "All","Button","����","���ٱ��浱ǰҳ��","saveRecord()","","","","btn_icon_save"},
		{"true","All","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","","btn_icon_delete"},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function afterAdd(){
		as_add("myiframe0");
		AsControl.OpenPage("/AppMain/Blank.jsp", "TextToShow=�뱣���б��¼", "rightdown");
		//��������ʱ�����Ĭ��ֵ
		setItemValue(0,getRow(),"ScenarioID","<%=sScenarioID%>");
	}
	
	function saveRecord(){
		as_save("myiframe0");
	}

	function deleteRecord(){
		var sScenarioID = "<%=sScenarioID%>";
		var sGroupID = getItemValue(0,getRow(),"GroupID");
        if(typeof(sGroupID)=="undefined" || sGroupID.length==0) {
			alert("ɾ����¼�ķ���Ų���Ϊ�գ�");
        	return ;
		}
		
        if(confirm(getHtmlMessage('45'))){
        	var sReturnMessage = RunJavaMethodTrans("com.amarsoft.app.alarm.action.AlarmConfigAction","delGroupItems","ScenarioID="+sScenarioID+",GroupID="+sGroupID);
    		if(sReturnMessage == "FAILED"){
    			alert("ɾ�������¼����ʧ�ܣ�");
    			return;
    		}else{
				as_delete("myiframe0");
    		}
		}
	}
	
	function mySelectRow(){
		var sScenarioID = "<%=sScenarioID%>";
		var sGroupID = getItemValue(0,getRow(),"GroupID");
		var sSortNo = getItemValue(0,getRow(),"SortNo");
		var sGroupName = getItemValue(0,getRow(),"GroupName");
        if(sGroupID && sSortNo && sGroupName){
			AsControl.OpenComp("/Common/Configurator/AlarmManage/AlarmGroupConfig.jsp", "ScenarioID="+sScenarioID+"&GroupID="+sGroupID, "rightdown");
		}
	}

    setDialogTitle("ģ�ͷ�������");
    mySelectRow();
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>