<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content: Ԥ��ģ���б�
	 */
 	sASWizardHtml = "<div><font size=\"2pt\" color=\"#930055\">Ԥ��ģ���б�</font></div>";
    //���ҳ�����	
	String sScenarioID =  CurPage.getParameter("ScenarioID");
	if (sScenarioID == null) sScenarioID = "";

	ASObjectModel doTemp = new ASObjectModel("AlarmModelList");
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
    dwTemp.setPageSize(200);
    dwTemp.genHTMLObjectWindow(sScenarioID);

	String sButtons[][] = {
		{"true","","Button","����","����һ����¼","newRecord()","","","",""},
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		{"true","","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		popComp("AlarmModelInfo","/Common/Configurator/AlarmManage/AlarmModelInfo.jsp","ScenarioID=<%=sScenarioID%>","");
		reloadSelf();
	}
	
	function viewAndEdit(){
		var sModelID = getItemValue(0,getRow(),"ModelID");
       	if(typeof(sModelID)=="undefined" || sModelID.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
        	return ;
		}
       	popComp("AlarmModelInfo","/Common/Configurator/AlarmManage/AlarmModelInfo.jsp","ScenarioID=<%=sScenarioID%>&ModelID="+sModelID,"");
		reloadSelf();
	}

	function deleteRecord(){
		var sModelID = getItemValue(0,getRow(),"ModelID");
		if(typeof(sModelID)=="undefined" || sModelID.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
        	return ;
		}
		if(confirm(getHtmlMessage('45'))){
			as_delete("myiframe0");
		}
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>