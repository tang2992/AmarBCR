<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		ҳ��˵��: �û���Ϣ����
	 */
	String PG_TITLE = "�û���Ϣ����";
	
	//���ҳ�����	
	String sMainBusinessNo =  CurPage.getParameter("MainBusinessNo");
	if(sMainBusinessNo==null) sMainBusinessNo="";
	System.out.println("sMainBusinessNo================="+sMainBusinessNo);
	//ͨ����ʾģ�����ASDataObject����doTemp
	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.bcr.BCR_UNREPORTBUSINESSNO");
	ASObjectModel doTemp = new ASObjectModel(boManager);
	doTemp.setJboWhere(" MAINBUSINESSNO=:MAINBUSINESSNO ");
	
	doTemp.setRequired("MAINBUSINESSNO",true);
	doTemp.setReadOnly("InputDate", true);
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      // ����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; // �����Ƿ�ֻ�� 1:ֻ�� 0:��д
	
	dwTemp.genHTMLObjectWindow(sMainBusinessNo);

	String sButtons[][] = {
		{"true","","Button","���沢����","���沢����","saveRecord()","","","",""},
		{"true","","Button","����","���ص��б����","doReturn('Y')","","","",""}		
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function saveRecord(){
		as_save("myiframe0","doReturn('Y')");
	}
    
    function doReturn(sIsRefresh){
        OpenPage("/DataMaintain/GuaranteeMaintain/UnReportBusList.jsp","_self","");
	}
	/*~[Describe=ҳ��װ��ʱ����DW���г�ʼ��;InputParam=��;OutPutParam=��;]~*/
	function initRow(){
		if (getRowCount(0)==0){
			setItemValue(0,0,"InputDate","<%=StringFunction.getToday()%>");
			bIsInsert = true;
		}
	}
	initRow();
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>