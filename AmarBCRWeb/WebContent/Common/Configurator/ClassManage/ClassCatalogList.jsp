<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content: �༰����Ŀ¼�б�
	 */
	String PG_TITLE = "�༰����Ŀ¼�б�"; // ��������ڱ��� <title> PG_TITLE </title>
  	//����������	
	String sClassName =  CurPage.getParameter("ClassName");   //����
	if (sClassName == null) sClassName = "";
	
	ASObjectModel doTemp = new ASObjectModel("ClassCatalogList");
	if(sClassName!=null && !sClassName.equals("")){
		doTemp.appendJboWhere(" AND ClassName='"+sClassName+"'");
	}
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(8);
	dwTemp.genHTMLObjectWindow("");
	
	String sButtons[][] = {
		{"true","","Button","����","����һ����¼","newRecord()","","","",""},
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		{"false","","Button","����","�����޸�","saveRecord()","","","",""},
		{"true","","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		AsControl.PopComp("/Common/Configurator/ClassManage/ClassCatalogInfo.jsp","","");
       	reloadSelf();
	}
	
    /*~[Describe=�鿴���޸ĸ����Ӧ����;InputParam=��;OutPutParam=��;]~*/
	function viewAndEdit(){
       	var sClassName = getItemValue(0,getRow(),"ClassName");
       	var sClassDescribe = getItemValue(0,getRow(),"ClassDescribe");
       	if(typeof(sClassName)=="undefined" || sClassName.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
       	AsControl.PopComp("/Common/Configurator/ClassManage/ClassCatalogInfo.jsp","ClassName="+sClassName+"&ClassDescribe="+sClassDescribe,"");
       	reloadSelf();     
	}
    
	function saveRecord(){
		as_save("myiframe0","");
	}

    /*~[Describe=�鿴���޸�����;InputParam=��;OutPutParam=��;]~*/
	function mySelectRow(){
       	var sClassName = getItemValue(0,getRow(),"ClassName");
       	var sClassDescribe = getItemValue(0,getRow(),"ClassDescribe");
		if(typeof(sClassName)=="undefined" || sClassName.length==0) {
		}else{
			AsControl.OpenView("/Common/Configurator/ClassManage/ClassMethodList.jsp","ClassName="+sClassName+"&ClassDescribe="+sClassDescribe,"rightdown","");
		}
	}

	function deleteRecord(){
		var sClassName = getItemValue(0,getRow(),"ClassName");
		if(typeof(sClassName)=="undefined" || sClassName.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
		if(confirm(getHtmlMessage('54'))){
			as_delete("myiframe0");
		}
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>