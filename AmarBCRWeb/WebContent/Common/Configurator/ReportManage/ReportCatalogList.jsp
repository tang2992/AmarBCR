<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content: ����ģ��Ŀ¼�б�
	 */
	ASObjectModel doTemp = new ASObjectModel("ReportCatalogList");
	doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(200);
	dwTemp.genHTMLObjectWindow("");
	
	String sButtons[][] = {
		{"true","","Button","����","����һ����¼","newRecord()","","","",""},
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		{"true","","Button","ģ���б�","�鿴/�޸�ģ���б�","viewAndEdit2()","","","",""},
		{"true","","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		sReturn=popComp("ReportCatalogInfo","/Common/Configurator/ReportManage/ReportCatalogInfo.jsp","","");
		reloadSelf(); 
		//�������ݺ�ˢ���б�
		if (typeof(sReturn)!='undefined' && sReturn.length!=0){
			sReturnValues = sReturn.split("@");
			if (sReturnValues[0].length !=0 && sReturnValues[1]=="Y"){
				OpenPage("/Common/Configurator/ReportManage/ReportCatalogList.jsp","_self",""); 
			}
		}     
	}
	
	/*~[Describe=�鿴���޸�����;InputParam=��;OutPutParam=��;]~*/
	function viewAndEdit(){
		var sModelNo = getItemValue(0,getRow(),"MODELNO");
		if(typeof(sModelNo)=="undefined" || sModelNo.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
		//openObject("ReportCatalogView",sModelNo,"001");
		popComp("ReportCatalogView","/Common/Configurator/ReportManage/ReportCatalogView.jsp","ObjectNo="+sModelNo+"&ItemID=0010","");
	}
    
	/*~[Describe=�鿴���޸�ģ���б�;InputParam=��;OutPutParam=��;]~*/
	function viewAndEdit2(){
		var sModelNo = getItemValue(0,getRow(),"MODELNO");
		if(typeof(sModelNo)=="undefined" || sModelNo.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
		//popComp("ReportModelList","/Common/Configurator/ReportManage/ReportModelList.jsp","ModelNo="+sModelNo,"");
		popComp("ReportCatalogView","/Common/Configurator/ReportManage/ReportCatalogView.jsp","ObjectNo="+sModelNo+"&ItemID=0020","");
	}

	function deleteRecord(){
		var sModelNo = getItemValue(0,getRow(),"MODELNO");
		if(typeof(sModelNo)=="undefined" || sModelNo.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
		if(confirm("��ͬʱɾ���ñ���Ļ�����Ϣ��ģ����Ϣ���Ƿ������")){
			as_delete("myiframe0");
		}
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>