<%@ page contentType="text/html; charset=GBK"%><%@
include file="/Frame/resources/include/include_begin_list.jspf"%><%
	String sGroupID = CurPage.getParameter("GroupID");
	String sClassifyID = CurPage.getParameter("ClassifyID");
	String sDisplayType = CurPage.getParameter("DisplayType");
	String sSearch = CurPage.getParameter("Search");
	String sSearchType = CurPage.getParameter("SearchType");
	if(sGroupID == null) sGroupID = "";
	if(sClassifyID == null) sClassifyID = "";
	if(sDisplayType == null) sDisplayType = "";
	if(sSearch == null) sSearch = "";
	if(sSearchType == null) sSearchType = "";

	ASObjectModel doTemp = new ASObjectModel("GroupPageItemList");
	if(!"2".equals(sDisplayType))doTemp.setVisible("Attribute2",false);//�����Strip��չʾ��������߶ȡ�
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";
	dwTemp.ReadOnly = "0";
	dwTemp.setPageSize(20);
	dwTemp.ConvertCode2Title = "1";
	dwTemp.genHTMLObjectWindow(sGroupID);

	String sButtons[][] = {
		{"true", "All", "Button", "��ͨ����", "", "newRecord()", "", "", "", "btn_icon_add"},
		{"true", "All","Button","��������","��ǰҳ������","quikNewRecord()","","","","btn_icon_add"},
		{"true", "All","Button","���ٱ���","���ٱ��浱ǰҳ��","as_save(0)","","","","btn_icon_save"},
		{"true", "All", "Button", "���ٸ���", "", "quickCopy()", "", "", "", ""},
		{"true", "All", "Button", "����", "", "viewRecord()", "", "", "", ""},
		{"true", "All", "Button", "ɾ��", "", "deleteRecord()", "", "", "", ""},
		{"true", "All", "Button", "��ΪĬ����", "", "setDefault()", "", "", "", ""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"
%><script type="text/javascript">
	var sDisplayType = "<%=sDisplayType%>";
	
	function newRecord(){
		var sGroupID = "<%=sGroupID%>";
		AsControl.PopComp("/AppConfig/PageMode/GroupPage/GroupPageItemInfo.jsp", "GroupID="+sGroupID+"&DisplayType="+sDisplayType, "dialogWidth=700px;dialogHeight=500px;resizable=yes;maximize:yes;help:no;status:no;");
		reloadSelf();
	}

	function quikNewRecord(){
		as_add(0);
		setItemValue(0, getRow(), "GroupID", "<%=sGroupID%>");
	}

	function quickCopy(){
		var sGroupID = "<%=sGroupID%>";
		var sItemNo = getItemValue(0,getRow(),"ItemNo");
		var returnValue = RunJavaMethod("com.amarsoft.app.awe.config.grouppage.action.GroupPageCatalogAction","quickCopyItems","GroupID="+sGroupID+",ItemNo="+sItemNo);
		if(returnValue == 'SUCCESS')alert('���Ƴɹ���');
		else alert('�Բ��𣬸���ʧ�ܣ�');
		reloadSelf();
	}
	
	function viewRecord(){
		var sGroupID = "<%=sGroupID%>";
		var sItemNo = getItemValue(0,getRow(),"ItemNo");
		if(typeof sGroupID == "undefined" || sGroupID.length == 0 || typeof sItemNo == "undefined" || sItemNo.length == 0){
			alert(getMessageText('AWEW1001'));
			return;
		}
		AsControl.PopComp("/AppConfig/PageMode/GroupPage/GroupPageItemInfo.jsp", "GroupID="+sGroupID+"&ItemNo="+sItemNo+"&DisplayType="+sDisplayType, "dialogWidth=700px;dialogHeight=500px;resizable=yes;maximize:yes;help:no;status:no;");
		reloadSelf();
	}
	
	function deleteRecord(){
		if(!confirm(getMessageText('AWEW1002'))) return;
		as_delete(0);
	}
	
	function setDefault(){
		var sGroupID = "<%=sGroupID%>";
		var sClassifyID = "<%=sClassifyID%>";
		var sItemNo = getItemValue(0,getRow(),"ItemNo");
		var sSearch = "<%=sSearch%>";
		var sSearchType = "<%=sSearchType%>";
		if(typeof sGroupID == "undefined" || sGroupID.length == 0 || typeof sItemNo == "undefined" || sItemNo.length == 0){
			alert(getMessageText('AWEW1001'));
			return;
		}

		sReturnValue = RunJavaMethodTrans("com.amarsoft.app.awe.config.grouppage.action.GroupPageItemAction","setDefault","GroupID="+sGroupID+",ItemNo="+sItemNo);
		if("SUCCESS" != sReturnValue) alert("�Բ�������Ĭ����ʧ�ܣ�");
		else OpenPage("/AppConfig/PageMode/GroupPage/GroupPageCatalogList.jsp?ClassifyID="+sClassifyID+"&Search="+sSearch+"&SearchType="+sSearchType,parent.Layout.getRegionName('rightup'));
	}
</script>
<%@include file="/Frame/resources/include/include_end.jspf"%>