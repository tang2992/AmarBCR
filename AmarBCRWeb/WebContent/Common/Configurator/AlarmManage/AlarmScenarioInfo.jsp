<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Content:    Ԥ��������Ϣ����
		Input Param:
                    ScenarioID��    Ԥ���������
	 */
	//����������	
	String sScenarioID =  CurPage.getParameter("ScenarioID");
	if(sScenarioID==null) sScenarioID="";

	ASObjectModel doTemp = new ASObjectModel("AlarmScenarioInfo");
	//���Ϊ����ҳ�棬�������޸ĳ������
	if(!sScenarioID.equals("")){
		doTemp.setReadOnly("ScenarioID",true);
	}
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(sScenarioID);
	
	String sButtons[][] = {
		{"true","","Button","����","�����޸�","saveRecord()","","","",""},
		{"true","","Button","����","�رձ�ҳ��","back()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	setDialogTitle("Ԥ��������Ϣ����");
	function saveRecord(){
        as_save("myiframe0","");
	}
	
	function back(){
		top.close();
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>