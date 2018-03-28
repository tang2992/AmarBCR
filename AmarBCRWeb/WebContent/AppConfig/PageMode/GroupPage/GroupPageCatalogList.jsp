<%@ page contentType="text/html; charset=GBK"%><%@
include file="/Frame/resources/include/include_begin_list.jspf"%><%
	String sSearch = CurPage.getParameter("Search");
	String sSearchType = CurPage.getParameter("SearchType");
	String sClassifyID = CurPage.getParameter("ClassifyID");
	String sGroupID = CurPage.getParameter("GroupID");
	if(sGroupID == null) sGroupID = "";
	if(sSearch == null) sSearch = "";

	ASObjectModel doTemp = new ASObjectModel("GroupPageCatalogList");
	if("SortNo".equals(sSearchType)){
		doTemp.setJboWhere("ClassifyID in (SELECT AGC.ClassifyID FROM jbo.awe.AWE_GROUP_CLASSIFY AGC WHERE AGC.SortNo like '"+sSearch+"%')");
	}
	else if("GroupID".equals(sSearchType)){
		doTemp.setJboWhere("GroupID like '%"+sSearch+"%'");
	}
	else{
		doTemp.setJboWhere("1=2");
	}
	if(!"".equals(sGroupID)) {
		doTemp.setJboWhere("GroupID = :GroupID");
		sSearch = sGroupID;
	}
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";
	dwTemp.ReadOnly = "0";//�༭ģʽ
	dwTemp.setPageSize(20);
	dwTemp.ConvertCode2Title = "1";
	dwTemp.genHTMLObjectWindow(sSearch);

	String sButtons[][] = {
		{String.valueOf("SortNo".equals(sSearchType)), "All", "Button", "��ͨ����", "���������Ի���", "newRecord()", "", "", "", "btn_icon_add"},
		{String.valueOf("SortNo".equals(sSearchType)), "All","Button","��������","��ǰҳ������","afterAdd()","","","","btn_icon_add"},
		{String.valueOf("SortNo".equals(sSearchType)||!"".equals(sGroupID)), "All","Button","���ٱ���","���ٱ��浱ǰҳ��","as_save(0)","","","","btn_icon_save"},
		{String.valueOf("SortNo".equals(sSearchType)), "All","Button","���ٸ���","���ٸ��Ƶ�ǰ��¼","quickCopy()","","","",""},
		{"true", "", "Button", "����", "", "viewRecord()", "", "", "", ""},
		{"true", "All", "Button", "ɾ��", "", "deleteRecord()", "", "", "", ""},
		{"true", "All", "Button", "���/Ԥ��", "", "preview()", "", "", "", ""},
		{"true", "All", "Button", "���ɴ���", "", "generateCode()", "", "", "", ""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"
%><script type="text/javascript">
	var sRegionName = parent.Layout.getRegionName('south');
	var sClassifyID = "<%=sClassifyID%>";
	var sOldGroupID = "";
	function mySelectRow(){
		var sGroupID = getItemValue(0, getRow(), "GroupID");
		if(typeof sGroupID == "undefined" || sGroupID.length == 0) return;
		if(sGroupID!=sOldGroupID){
			sOldGroupID = sGroupID;
			var sDisplayType = getItemValue(0,getRow(),"DisplayType");
			var sClassifyID = "<%=sClassifyID%>";
			var sSearch = "<%=sSearch%>";
			var sSearchType = "<%=sSearchType%>";			
			AsControl.OpenPage("/AppConfig/PageMode/GroupPage/GroupPageItemList.jsp", "GroupID="+sGroupID+"&ClassifyID="+sClassifyID+"&DisplayType="+sDisplayType+"&Search="+sSearch+"&SearchType="+sSearchType, "rightdown");
		}
	}
	function afterAdd(){
		as_add(0);
		//��������ʱ�����Ĭ��ֵ
		setItemValue(0,getRow(),"ClassifyID",sClassifyID);
		setItemValue(0,getRow(),"DisplayType","1");
		setItemValue(0,getRow(),"IsInUse","1");
		setItemValue(0,getRow(),"Attribute1","2");
	}
	function quickCopy(){
		var sGroupID = getItemValue(0,getRow(),"GroupID");
		var returnValue = RunJavaMethodTrans("com.amarsoft.app.awe.config.grouppage.action.GroupPageCatalogAction","quickCopyCatalog","GroupID="+sGroupID);
		if(returnValue == 'SUCCESS')alert('���Ƴɹ���');
		else alert('�Բ��𣬸���ʧ�ܣ�');
		reloadSelf();
	}
	function newRecord(){
		AsControl.PopComp("/AppConfig/PageMode/GroupPage/GroupPageCatalogInfo.jsp", "ClassifyID=<%=sClassifyID%>", "dialogWidth=600px;dialogHeight=370px;resizable=yes;maximize:yes;help:no;status:no;");
		reloadSelf();
	}
	function viewRecord(){
		var sGroupID = getItemValue(0, getRow(), "GroupID");
		if(typeof sGroupID == "undefined" || sGroupID.length == 0){
			alert(getMessageText('AWEW1001'));
			return;
		}
		AsControl.PopComp("/AppConfig/PageMode/GroupPage/GroupPageCatalogInfo.jsp", "GroupID="+sGroupID, "dialogWidth=600px;dialogHeight=370px;resizable=yes;maximize:yes;help:no;status:no;");
		reloadSelf();
	}
	function deleteRecord(){
		if(!confirm(getMessageText('AWEW1002'))) return;
		as_delete(0);
	}
	function preview(){
		var sGroupID = getItemValue(0, getRow(), "GroupID");
		var sDisplayType = getItemValue(0,getRow(), "DisplayType");
		AsControl.OpenComp("/AppConfig/PageMode/GroupPage/GroupPagePreview.jsp", "GroupID="+sGroupID+"&DisplayType="+sDisplayType, "_blank");
	}
	function generateCode(){
		var sGroupID = getItemValue(0, getRow(), "GroupID");
		PopPage("/AppConfig/PageMode/GroupPage/GenerateCode4GroupPage.jsp?GroupID="+sGroupID,"","dialogWidth=660px;dialogHeight=470px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;");
	}
	mySelectRow();
</script>
<%@include file="/Frame/resources/include/include_end.jspf"%>