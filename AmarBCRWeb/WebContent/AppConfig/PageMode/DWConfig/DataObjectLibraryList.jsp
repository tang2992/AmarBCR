<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	String PG_TITLE = "��ʾģ�����Ϣ"; // ��������ڱ��� <title> PG_TITLE </title>
	String sDONO = CurPage.getParameter("DONO");
	if(sDONO == null) sDONO = "";
	
	ASObjectModel doTemp = new ASObjectModel("DataObjectLibraryList");
	doTemp.setLockCount(2); //��������
	doTemp.setDDDWJbo("DOCKID", "jbo.awe.DATAOBJECT_GROUP,DockID,DockName,DONO='"+sDONO+"' order by SortNo");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow(sDONO);

	String sButtons[][] = {
		{"true", "All","Button","��������","��ǰҳ������","afterAdd()","","","","btn_icon_add"},
		{"true", "All","Button","���ٱ���","���ٱ��浱ǰҳ��","afterSave()","","","","btn_icon_save"},
		{"true", "All","Button","���ٸ���","���ٸ��Ƶ�ǰ��¼","quickCopy()","","","",""},
		{"true", "All", "Button", "ɾ��", "", "deleteRecord()", "", "", "", ""},
		{"true", "All", "Button", "������Ϣ����", "������Ϣ����", "setGroup()", "", "", "", "btn_icon_edit"},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	var sDONO = "<%=sDONO%>";
	function afterSave(){
		as_save("myiframe0");
	}
	//��������
	function afterAdd(){
		as_add("myiframe0");
		//��������ʱ�����Ĭ��ֵ
		setItemValue(0,getRow(),"DONO",sDONO);
	}
	function quickCopy(){
		var sColIndex = getItemValue(0,getRow(),"COLINDEX");
		var returnValue = RunJavaMethodTrans("com.amarsoft.app.awe.config.dw.action.DataObjectLibListAction","quickCopyLib","DONO="+sDONO+",ColIndex="+sColIndex);
		if(returnValue == 'SUCCESS'){
			alert('���Ƴɹ���');
			reloadSelf();
		}else alert('�Բ��𣬸���ʧ�ܣ�');
	}
	//����ɾ��
	function deleteRecord(){
		var sColIndex = getItemValue(0,getRow(),"COLINDEX");
		if (typeof(sColIndex)=="undefined" || sColIndex.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return;
		}
		if(confirm(getHtmlMessage("2"))){ //�������ɾ������Ϣ��
			as_delete("myiframe0");
		}
	}

	function setGroup(){
		AsControl.PopView("/AppConfig/PageMode/DWConfig/DataObjectGroupList.jsp","DONo="+sDONO);
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>