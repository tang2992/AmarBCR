<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content: ������б�
	 */
	String sCodeNo = CurPage.getParameter("CodeNo"); //������
	String sCodeName = CurPage.getParameter("CodeName");
	if(sCodeNo==null) sCodeNo="";
	if(sCodeName==null) sCodeName="";
	String sDiaLogTitle = "��"+sCodeName+"�����룺��"+sCodeNo+"������";

	ASObjectModel doTemp = new ASObjectModel("CodeItemList");
	if(sCodeNo!=null && !sCodeNo.equals("")){
		doTemp.appendJboWhere(" And CodeNo='"+sCodeNo+"'");
	}
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage ,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(50);
	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {
		{(sCodeNo.equals("")?"false":"true"),"","Button","����","����һ����¼","newRecord()","","","",""},
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},		
		{"true","","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		popComp("CodeItemInfo","/Common/Configurator/CodeManage/CodeItemInfo.jsp","CodeNo=<%=sCodeNo%>&CodeName=<%=sCodeName%>","");
		reloadSelf();
	}
	
	function viewAndEdit(){
		var sCodeNo = getItemValue(0,getRow(),"CodeNo");
		var sItemNo = getItemValue(0,getRow(),"ItemNo");
		if(typeof(sCodeNo)=="undefined" || sCodeNo.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
        
       	popComp("CodeItemInfo","/Common/Configurator/CodeManage/CodeItemInfo.jsp","CodeName=<%=sCodeName%>&CodeNo="+sCodeNo+"&ItemNo="+sItemNo,"");
		reloadSelf();
	}
	
	function deleteRecord(){
		var sCodeNo = getItemValue(0,getRow(),"CodeNo");
       	if(typeof(sCodeNo)=="undefined" || sCodeNo.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
		if(confirm(getHtmlMessage('2'))){
			as_delete("myiframe0");
		}
	}
	
	if(typeof("<%=sCodeNo%>")=="undefined" || "<%=sCodeNo%>".length==0){
	}else{
     	setDialogTitle("<%=sDiaLogTitle%>");
    }
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>