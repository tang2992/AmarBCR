<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%
     String isQuery = CurPage.getParameter("isQuery");
	 if(isQuery == null) isQuery = "1";
	 ASObjectModel doTemp = new ASObjectModel("CONTACT_INFO"); 
	 doTemp.setVisible("*", false);
	 doTemp.setVisible("OrgCode,ContactPerson,ContactPhone,InputDate", true);
	 if("0".equals(isQuery)){
		 doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:doSearch()\"");
	 }else{
	 	 doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	 }
	 
	 ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	 dwTemp.Style = "1";//freeform
	 dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	 dwTemp.genHTMLObjectWindow("%");
	 String sButtons[][] = {
		 {!"0".equals(isQuery)?"true":"false","","Button","����","�鿴��ϵ����Ϣ","viewAndEdit()","","","","",""},
		 {!"0".equals(isQuery)?"true":"false","","Button","ɾ��","ɾ����ϵ����Ϣ","deleteRecord()","","","","",""},
		 {"0".equals(isQuery)?"true":"false","","Button","ȷ��","ȷ��","doSearch()","","","",""},
		 {"0".equals(isQuery)?"true":"false","","Button","ȡ��","ȡ��","javascript:top.close();","","","",""},
	 };
	//sButtonPosition = "south";
%>

<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">

	function deleteRecord(){
		var sOrgCode = getItemValue(0,getRow(),"OrgCode");
		if (typeof(sOrgCode)=="undefined" || sOrgCode.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
		if(confirm("�������ɾ������Ϣ��")){
			as_delete("myiframe0");
		} 
	}
	
	function doSearch(){
		var sOrgCode = getItemValue(0,getRow(),"OrgCode");
		if(typeof(sOrgCode) == "undefined" || sOrgCode.length == 0)
		{
			alert("��ѡ��һ��ҵ����Ϣ!");//��ѡ��һ����Ϣ��
			return;
		}else {
			top.returnValue = sOrgCode;
			top.close();
		}
	}
	
	function viewAndEdit(){
		var sOrgCode = getItemValue(0,getRow(),"OrgCode");
		if (typeof(sOrgCode)=="undefined" || sOrgCode.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
		}else{
			OpenPage("/WebTask/ContactPersons.jsp?OrgCode="+sOrgCode,"_self","");
		}
	}
	
</script>

<%@ include file="/Frame/resources/include/include_end.jspf"%>
