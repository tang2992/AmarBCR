<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content: Ԥ�������б�
	 */
 	sASWizardHtml = "<div><font size=\"2pt\" color=\"#930055\">Ԥ�������б�</font></div>";

 	ASObjectModel doTemp = new ASObjectModel("AlarmScenarioList");
 	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {
		{"true","","Button","����","����һ����¼","newRecord()","","","",""},
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		{"true","","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","",""},
		{"true","","Button","������������","�鿴/�޸ĳ���Ԥ�������","viewAndEditArg()","","","",""},
		{"true","","Button","ģ�ͷ�������","�鿴/�޸ĳ�����ģ�ͷ���","viewAndEditGroup()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		AsControl.PopComp("/Common/Configurator/AlarmManage/AlarmScenarioInfo.jsp","","dialogWidth=600px;dialogHeight=500px;status:no;center:yes;help:no;minimize:yes;maximize:no;border:thin;statusbar:no");//OpenStyle
		reloadSelf();
	}
	
	function viewAndEdit(){
		var sScenarioID = getItemValue(0,getRow(),"ScenarioID");
       	if(typeof(sScenarioID)=="undefined" || sScenarioID.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
	    }
       	AsControl.PopComp("/Common/Configurator/AlarmManage/AlarmScenarioInfo.jsp","ScenarioID="+sScenarioID,"dialogWidth=600px;dialogHeight=500px;status:no;center:yes;help:no;minimize:yes;maximize:no;border:thin;statusbar:no");
		reloadSelf();
	}
    
    /*~[Describe=�鿴���޸�Ԥ������;InputParam=��;OutPutParam=��;]~*/
	function viewAndEditArg(){
      	var sScenarioID = getItemValue(0,getRow(),"ScenarioID");
      	if(typeof(sScenarioID)=="undefined" || sScenarioID.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
          	return ;
		}
      	AsControl.PopComp("/Common/Configurator/AlarmManage/AlarmScenarioArgsList.jsp","ScenarioID="+sScenarioID,"",OpenStyle);
	}

    /*~[Describe=�鿴���޸�ģ�ͷ�������;InputParam=��;OutPutParam=��;]~*/
	function viewAndEditGroup(){
		var sScenarioID = getItemValue(0,getRow(),"ScenarioID");
		if(typeof(sScenarioID)=="undefined" || sScenarioID.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
          	return ;
		}
		AsControl.PopComp("/Common/Configurator/AlarmManage/AlarmGroupFrame.jsp","ScenarioID="+sScenarioID,"",OpenStyle);
    }

	function deleteRecord(){
		var sScenarioID = getItemValue(0,getRow(),"ScenarioID");
      	if(typeof(sScenarioID)=="undefined" || sScenarioID.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
          	return ;
		}
		if(confirm(getHtmlMessage('45'))){
			as_delete("myiframe0");
		}
	}

	function mySelectRow(){
		var sScenarioID = getItemValue(0,getRow(),"ScenarioID");
      	if(typeof(sScenarioID)=="undefined" || sScenarioID.length==0) {
			return;
		}
      	parent.OpenModelList(sScenarioID);
	}
	mySelectRow();
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>