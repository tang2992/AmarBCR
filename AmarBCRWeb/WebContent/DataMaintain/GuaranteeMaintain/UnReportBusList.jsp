<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
 <%
	/*
		ҳ��˵��: ʾ���б�ҳ��
	 */
	String PG_TITLE = "�����ϱ������б�ҳ��";
	//���ҳ�����
	
	ASObjectModel doTemp = new ASObjectModel("UnReportBusList");
	String jboWhere = doTemp.getJboWhere();
	doTemp.setJboWhere(jboWhere);
	
    doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(13);

	//����HTMLDataWindow
	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {
			{"true","","Button","����","����","my_add()","","","",""},
			{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
			{"true","","Button","ɾ��","ɾ��","deleteRecord()","","","",""},
			{"true","","Button","��������","��������","batchImport()","","","",""}
	};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">

	function my_add(){
		OpenPage("/DataMaintain/GuaranteeMaintain/UnReportBusInfo.jsp","_self","");
	}


	function viewAndEdit(){
		var sMainBusinessNo = getItemValue(0,getRow(),"MAINBUSINESSNO");
		if (typeof(sMainBusinessNo)=="undefined" || sMainBusinessNo.length==0){
			alert("��ѡ��һ����¼��");
			return;
		}
		//OpenPage("/AppConfig/OrgUserManage/UserInfo.jsp?UserID="+sUserID,"_self","");
     	OpenPage("/DataMaintain/GuaranteeMaintain/UnReportBusInfo.jsp?MainBusinessNo="+sMainBusinessNo,"_self","");  
		reloadSelf();
	}
	/*~[Describe=ɾ����¼;InputParam=��;OutPutParam=��;]~*/
	function deleteRecord()
	{
		var sMainBusinessNo = getItemValue(0,getRow(),"MAINBUSINESSNO");
		
		if (typeof(sMainBusinessNo)=="undefined" || sMainBusinessNo.length==0)
		{
			alert("��ѡ��һ����¼��");
			return;
		}
		
		if(confirm("�������ɾ������Ϣ��")) 
		{
			as_delete('myiframe0');
		}
		reloadSelf();
	}
	/*~[Describe=�������뻹��ƻ�;InputParam=��;OutPutParam=��;]~*/
	function batchImport(){
		var pageURL = "/AppConfig/FileImport/FileSelector.jsp";
	    var parameter = "clazz=jbo.imports.excel.BCR_UNREPORTBUSINESSNO"; //����ģ��
	    var dialogStyle = "dialogWidth=650px;dialogHeight=350px;resizable=1;scrollbars=0;status:y;maximize:0;help:0;";
	    var sReturn = AsControl.PopComp(pageURL, parameter, dialogStyle);
		reloadSelf();
	}
	
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>
