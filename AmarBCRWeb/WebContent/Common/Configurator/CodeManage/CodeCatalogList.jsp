<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content: ����Ŀ¼�б�
	 */
	//���ҳ�����	
	String sCodeTypeOne =  CurPage.getParameter("CodeTypeOne");
	String sCodeTypeTwo =  CurPage.getParameter("CodeTypeTwo");
	//����ֵת��Ϊ���ַ���	
	if (sCodeTypeOne == null) sCodeTypeOne = ""; 
	if (sCodeTypeTwo == null) sCodeTypeTwo = ""; 

	ASObjectModel doTemp = new ASObjectModel("CodeCatalogList");
 		
	if(sCodeTypeOne!=null && !sCodeTypeOne.equals("")) doTemp.appendJboWhere(" and CodeTypeOne='"+sCodeTypeOne+"'");
	if(sCodeTypeTwo!=null && !sCodeTypeTwo.equals("")) doTemp.appendJboWhere(" and CodeTypeTwo='"+sCodeTypeTwo+"'");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(200);
	dwTemp.genHTMLObjectWindow("");
	
	String sButtons[][] = {
		{"true","","Button","����","����һ����¼","newRecord()","","","",""},
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		{"true","","Button","�����б�","�鿴/�޸Ĵ�������","viewAndEditCode()","","","",""},
		{"true","","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","",""},
		{"false","","Button","����SortNo","����SortNo","GenerateCodeCatalogSortNo()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		sReturn=popComp("CodeCatalogInfo","/Common/Configurator/CodeManage/CodeCatalogInfo.jsp","CodeTypeOne=<%=sCodeTypeOne%>&CodeTypeTwo=<%=sCodeTypeTwo%>","");
		reloadSelf();        
	}
	
	function viewAndEdit(){
       var sCodeNo = getItemValue(0,getRow(),"CodeNo");
       if(typeof(sCodeNo)=="undefined" || sCodeNo.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
  		popComp("CodeCatalogInfo","/Common/Configurator/CodeManage/CodeCatalogInfo.jsp","CodeNo="+sCodeNo,"");
	}
    
    /*~[Describe=�鿴���޸Ĵ�������;InputParam=��;OutPutParam=��;]~*/
	function viewAndEditCode(){
       var sCodeNo = getItemValue(0,getRow(),"CodeNo");
       var sCodeName = getItemValue(0,getRow(),"CodeName");
       if(typeof(sCodeNo)=="undefined" || sCodeNo.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
		popComp("CodeItem","/Common/Configurator/CodeManage/CodeItemList.jsp","CodeNo="+sCodeNo+"&CodeName="+sCodeName,"");  
	}

	function deleteRecord(){
		var sCodeNo = getItemValue(0,getRow(),"CodeNo");
		if(typeof(sCodeNo)=="undefined" || sCodeNo.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
		if(confirm(getHtmlMessage('45'))){
			as_delete("myiframe0");
		}
	}
	
	function GenerateCodeCatalogSortNo(){
		RunMethod("Configurator","GenerateCodeCatalogSortNo","");
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>