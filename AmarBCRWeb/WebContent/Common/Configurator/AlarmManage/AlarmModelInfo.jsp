<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
		/*
		Content:    Ԥ��ģ������
		Input Param:
					ScenarioID: ������ 
					ModelID��    ��ʾģ�ͱ��
	 */
	//����������	
	String sScenarioID = CurPage.getParameter("ScenarioID");
	String sModelID =  CurPage.getParameter("ModelID");
	if(sModelID==null) sModelID="";
	if(sScenarioID==null) sScenarioID="";

	String sSubTypeNo = Sqlca.getString(new SqlObject("select DefaultSubTypeNo from SCENARIO_CATALOG where ScenarioID=:ScenarioID").setParameter("ScenarioID",sScenarioID));
	if(sSubTypeNo == null) sSubTypeNo = null;

	ASObjectModel doTemp = new ASObjectModel("AlarmModelInfo");
	//����Ĭ��ֵ
	doTemp.setDefaultValue("ScenarioID",sScenarioID);
	doTemp.setDefaultValue("SubTypeNo",sSubTypeNo);
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(sScenarioID+","+sModelID);
	
	String sButtons[][] = {
		{"true","","Button","���沢����","�����޸Ĳ�����","saveRecordAndReturn()","","","",""},
		{"true","","Button","���沢����","�����޸Ĳ�������һ����¼","saveRecordAndAdd()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	setDialogTitle("Ԥ��ģ������");
	function saveRecordAndReturn(){
		as_save("myiframe0","top.close();");
	}
    
	function saveRecordAndAdd(){
		as_save("myiframe0","newRecord()");
	}
    
	function newRecord(){
        AsControl.OpenComp("/Common/Configurator/AlarmManage/AlarmModelInfo.jsp","ScenarioID=<%=sScenarioID%>","_self","");
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>