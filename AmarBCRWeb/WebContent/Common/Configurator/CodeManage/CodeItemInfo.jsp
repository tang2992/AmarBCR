<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		Content: ���������
	 */
	//�������
	String sDiaLogTitle = "";
	String sCodeNo =  CurPage.getParameter("CodeNo"); //������
	String sItemNo =  CurPage.getParameter("ItemNo"); //��Ŀ���
	String sCodeName =  CurPage.getParameter("CodeName");
	//����ֵת��Ϊ���ַ���
	if(sCodeNo == null) sCodeNo = "";
	if(sItemNo == null) sItemNo = "";
	if(sCodeName == null) sCodeName = "";
	
	if(sCodeNo.equals("")){
		sDiaLogTitle = "�� ������������� ��";
	}else{
		if(sItemNo==null || sItemNo.equals("")){
			sItemNo="";
			sDiaLogTitle = "��"+sCodeName+"�����룺��"+sCodeNo+"����������";
		}else{
			sDiaLogTitle = "��"+sCodeName+"�����룺��"+sCodeNo+"���鿴�޸�����";
		}
	}

	ASObjectModel doTemp = new ASObjectModel("CodeItemInfo");
	if(!sCodeNo.equals("")){
		doTemp.setVisible("CodeNo",false); 
	}else{
		doTemp.setRequired("CodeNo",true);
	} 
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage ,doTemp,request);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(sCodeNo+","+sItemNo);
	
	String sButtons[][] = {
		{"true","","Button","����","�����޸�","saveRecord()","","","",""},
		{"true","","Button","���沢����","���������","saveAndNew()","","","",""}			
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function saveRecord(sPostEvents){
		setItemValue(0,0,"CodeNo","<%=sCodeNo%>");
		as_save("myiframe0",sPostEvents);
	}
	
	function saveAndNew(){
		saveRecord("newRecord()");
	}
   
	function newRecord(){
        OpenComp("CodeItemInfo","/Common/Configurator/CodeManage/CodeItemInfo.jsp","CodeNo=<%=sCodeNo%>&CodeName=<%=sCodeName%>","_self");
	}
	setDialogTitle("<%=sDiaLogTitle%>");
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>