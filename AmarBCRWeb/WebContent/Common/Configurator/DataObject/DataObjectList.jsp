<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		Content: ���ݶ���Ŀ¼�б�
	 */
	String PG_TITLE = "���ݶ���Ŀ¼�б�"; // ��������ڱ��� <title> PG_TITLE </title>
	
	//����������	
	String sDoNo =  CurPage.getParameter("DoNo");
	String sDoName =  CurPage.getParameter("DoName");
	if(sDoNo==null) sDoNo="";
	if(sDoName==null) sDoName="";
    
	ASDataObject doTemp = new ASDataObject("DataObjectList",Sqlca);
	ASDataWindow dwTemp = new ASDataWindow(CurPage,doTemp,Sqlca);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(20);

	//��������¼�
	dwTemp.setEvent("BeforeDelete","!Configurator.DelDOLibrary(#DoNo)");
	
	//����HTMLDataWindow
	Vector vTemp = dwTemp.genHTMLDataWindow("");
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));
	
	String sButtons[][] = {
		{"true","","Button","����","����һ����¼","newRecord()","","","",""},
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		{"true","","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","",""},
	};
%><%@include file="/Resources/CodeParts/List05.jsp"%>
<script type="text/javascript">
	function newRecord(){
		AsControl.PopView("/Common/Configurator/DataObject/DataObjectView.jsp","");
		reloadSelf();
	}
	
	function viewAndEdit(){
       	var sDoNo = getItemValue(0,getRow(),"DoNo");
       	if(typeof(sDoNo)=="undefined" || sDoNo.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
		openObject("DataObject",sDoNo,"001");
	}
    
	function deleteRecord(){
		var sDoNo = getItemValue(0,getRow(),"DoNo");
		if(typeof(sDoNo)=="undefined" || sDoNo.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
		
		if(confirm(getHtmlMessage('45'))){
			as_del("myiframe0");
			as_save("myiframe0");  //�������ɾ������Ҫ���ô����
		}
	}
	
	AsOne.AsInit();
	init();
	my_load(2,0,'myiframe0');
<%	if(!doTemp.haveReceivedFilterCriteria()) {%>
		//showFilterArea();
<%	}%>
</script>	
<%@ include file="/IncludeEnd.jsp"%>