<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		Content: ���ݶ���Ŀ¼����
	 */
	String PG_TITLE = "���ݶ���Ŀ¼����"; // ��������ڱ��� <title> PG_TITLE </title>
	
	//����������	
	String sDoNo =  CurPage.getParameter("DoNo");
	if(sDoNo==null) sDoNo="";

	ASDataObject doTemp = new ASDataObject("DataObjectInfo",Sqlca);
	
	if (sDoNo.equals("") || sDoNo.equals("null")) {
 	  	doTemp.setRequired("DONO",true);
		doTemp.setReadOnly("DONO",false);
	}else{
		doTemp.setRequired("DONO",false);
		doTemp.setReadOnly("DONO",true);
	}
			
	ASDataWindow dwTemp = new ASDataWindow(CurPage,doTemp,Sqlca);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	//����HTMLDataWindow
	Vector vTemp = dwTemp.genHTMLDataWindow(sDoNo);
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));
	
	String sButtons[][] = {
		{"true","","Button","����","�����޸�","saveRecord()","","","",""}
	};
%><%@include file="/Resources/CodeParts/List05.jsp"%>
<script type="text/javascript">
	function saveRecord(){
	    var sDoNo = getItemValue(0,getRow(),"DONO");
	    as_save("myiframe0","openDOView('"+sDoNo+"')");
	}
	
	function openDOView(sDoNo){
		parent.AsControl.OpenView("/Frame/ObjectViewer.jsp","ObjectType=DataObject&ObjectNo="+sDoNo+"&ViewID=001","_self");
	}
    
	function initRow(){
		if (getRowCount(0)==0){
			as_add("myiframe0");
			bIsInsert = true;
		}
	}

	$(document).ready(function(){
		AsOne.AsInit();
		init();
		my_load(2,0,'myiframe0');
		initRow();
	});
</script>	
<%@ include file="/IncludeEnd.jsp"%>