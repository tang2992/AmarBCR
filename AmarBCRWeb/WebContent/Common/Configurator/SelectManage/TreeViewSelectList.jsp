<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content: ��ѯ����ѡ��
	 */
	ASObjectModel doTemp = new ASObjectModel("TreeViewSelectList");
 	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");
	
	String sButtons[][] = {
		{"true","","Button","����","����һ����¼","newRecord()","","","",""},
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		{"true","","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		OpenPage("/Common/Configurator/SelectManage/TreeViewSelectInfo.jsp","_self","");  
	}
	
	function viewAndEdit(){
		var sSelName = getItemValue(0,getRow(),"SelName");
		if(typeof(sSelName) == "undefined" || sSelName.length == 0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
		OpenPage("/Common/Configurator/SelectManage/TreeViewSelectInfo.jsp?SelName="+sSelName,"_self","");           
	}
    
	function deleteRecord(){
		var sSelName = getItemValue(0,getRow(),"SelName");
		if(typeof(sSelName) == "undefined" || sSelName.length == 0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
		if(confirm(getHtmlMessage('2'))){
			as_delete("myiframe0");
		}
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>