<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Content:    Ԥ����������
		Input Param:
                    ScenarioID��    �������
                    AlarmArgID��    �������
	 */
	//����������	
	String sScenarioID =  CurPage.getParameter("ScenarioID");
	String sAlarmArgID =  CurPage.getParameter("AlarmArgID");
	if(sScenarioID==null) sScenarioID="";
	if(sAlarmArgID==null) sAlarmArgID="";

	ASObjectModel doTemp = new ASObjectModel("AlarmScenarioArgsInfo");
 	//�����Ϊ����ҳ�棬�������ID�����޸�
	if( sAlarmArgID.length() != 0 ){
		doTemp.setReadOnly("AlarmArgID",true);
	}
	doTemp.setDefaultValue("ScenarioID",sScenarioID);

	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(sScenarioID+","+sAlarmArgID);
	
	String sButtons[][] = {
		{"true","","Button","���沢����","�����޸Ĳ�����","saveRecordAndReturn()","","","",""},
		{"true","","Button","���沢����","�����޸Ĳ�������һ����¼","saveRecordAndAdd()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	setDialogTitle("Ԥ����������");
	function saveRecordAndReturn(){
		as_save("myiframe0","top.close();");
	}
    
	function saveRecordAndAdd(){
		as_save("myiframe0","newRecord()");
	}
    
	function newRecord(){
        var sScenarioID = getItemValue(0,getRow(),"ScenarioID");
        AsControl.OpenComp("/Common/Configurator/AlarmManage/AlarmScenarioArgsInfo.jsp","ScenarioID="+sScenarioID,"_self","");
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>