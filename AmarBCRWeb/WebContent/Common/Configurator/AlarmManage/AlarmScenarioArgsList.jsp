<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content: Ԥ�������б�
		Input Param:
                  ScenarioID��	����ID
	 */
    //���ҳ�����	
	String sScenarioID =  CurPage.getParameter("ScenarioID");
	if (sScenarioID == null) sScenarioID = "";

	ASObjectModel doTemp = new ASObjectModel("AlarmScenarioArgsList");
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
    dwTemp.setPageSize(30);
    dwTemp.genHTMLObjectWindow(sScenarioID);
	
	String sButtons[][] = {
		{"true","","Button","����","����һ����¼","newRecord()","","","",""},
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		{"true","","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	setDialogTitle("Ԥ�������б�");
	function newRecord(){
		AsControl.PopComp("/Common/Configurator/AlarmManage/AlarmScenarioArgsInfo.jsp","ScenarioID=<%=sScenarioID%>","dialogWidth=750px;dialogHeight=650px;status:no;center:yes;help:no;minimize:yes;maximize:no;border:thin;statusbar:no");
		reloadSelf();
	}
	
	function viewAndEdit(){
		var sScenarioID = getItemValue(0,getRow(),"ScenarioID");
		var sAlarmArgID = getItemValue(0,getRow(),"AlarmArgID");
       	if(typeof(sAlarmArgID)=="undefined" || sAlarmArgID.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
       	AsControl.PopComp("/Common/Configurator/AlarmManage/AlarmScenarioArgsInfo.jsp","ScenarioID="+sScenarioID+"&AlarmArgID="+sAlarmArgID,"dialogWidth=750px;dialogHeight=650px;status:no;center:yes;help:no;minimize:yes;maximize:no;border:thin;statusbar:no");
		reloadSelf();
	}

	function deleteRecord(){
		var sAlarmArgID = getItemValue(0,getRow(),"AlarmArgID");
       	if(typeof(sAlarmArgID)=="undefined" || sAlarmArgID.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
		if(confirm(getHtmlMessage('2'))){
			as_delete("myiframe0");
		}
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>