<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content:�༰�����б�
	 */
	String PG_TITLE = "�༰�����б�"; // ��������ڱ��� <title> PG_TITLE </title>
    //����������	
	String sClassName =  CurPage.getParameter("ClassName");
    if (sClassName == null) sClassName = "";
	
    ASObjectModel doTemp = new ASObjectModel("ClassMethodList");
	if(sClassName!=null && !sClassName.equals("")){
		doTemp.appendJboWhere(" And ClassName='"+sClassName+"'");
	}
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {
		{(sClassName.equals("")?"false":"true"),"","Button","����","����һ����¼","newRecord()","","","",""},
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		{"true","","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		sReturn=popComp("ClassMethodInfo","/Common/Configurator/ClassManage/ClassMethodInfo.jsp","","");
		reloadSelf();
	}
	
	function viewAndEdit(){
       var sClassName = getItemValue(0,getRow(),"ClassName");
       var sMethodName = getItemValue(0,getRow(),"MethodName");
       if(typeof(sClassName)=="undefined" || sClassName.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
    	popComp("ClassMethodInfo","/Common/Configurator/ClassManage/ClassMethodInfo.jsp","ClassName="+sClassName+"&MethodName="+sMethodName,"");
		reloadSelf();
	}
    
	function saveRecord(){
		as_save("myiframe0","");
	}

	function deleteRecord(){
		var sClassName = getItemValue(0,getRow(),"ClassName");
       if(typeof(sClassName)=="undefined" || sClassName.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
		if(confirm(getHtmlMessage('2'))){ //�������ɾ������Ϣ��
			as_delete("myiframe0");
		}
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>