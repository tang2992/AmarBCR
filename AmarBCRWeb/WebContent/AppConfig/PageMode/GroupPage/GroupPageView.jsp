<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
 	String sDefaultNode = CurPage.getParameter("DefaultNode"); //Ĭ�ϴ򿪽ڵ�
	String sClassifyID = CurPage.getParameter("ClassifyID");
	if(sClassifyID == null) sClassifyID = "";
	if(sDefaultNode == null) sDefaultNode = "";
	//widget.setDefaultClickNodeId(sClassifyID);
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"","right");
	tviTemp.TriggerClickEvent=true; //�Ƿ��Զ�����ѡ���¼�

	//������ͼ�ṹ	
	String sSqlTreeView = " from AWE_GROUP_CLASSIFY where IsInUse = '1'";
	//����������������Ϊ��
	//ID�ֶ�(����),Name�ֶ�(����),Value�ֶ�,Script�ֶ�,Picture�ֶ�,From�Ӿ�(����),OrderBy�Ӿ�,Sqlca
	tviTemp.initWithSql("SortNo", "ClassifyName", "ClassifyID","","",sSqlTreeView,"Order By SortNo",Sqlca);
	
	String[][] sButtons = {
		{"true","","Button","����","�������ҳ�����","newTreeGroup()","","","",""},
		{"true","","Button","�༭","�༭���ҳ�����","viewTreeGroup()","","","",""},
		{"true","","Button","ɾ��","ɾ�����ҳ�����","deleteTreeGroup()","","","",""},
		{"true","","Button","��ѯ","","showTVSearch()","","","",""},
	};
%><%@include file="/Resources/CodeParts/View07.jsp"%>
<script type="text/javascript">
	initTreeView();
	function initTreeView(){
		<%=tviTemp.generateHTMLTreeView()%>
		//expandNode('root');
		expandAll();
		selectItem('<%=sDefaultNode%>');
	}
	<%/*�ڵ����¼�*/%>
	function TreeViewOnClick(){
		var sSortNo = getCurTVItem().id;
		var sClassifyID = getCurTVItem().value;
		if(!sClassifyID){
			OpenPage("/AppMain/Blank.jsp?TextToShow=��ѡ�������ͼ�ڵ�!", "frameright");
		}else{
	      	OpenPage("/AppConfig/PageMode/GroupPage/GroupPageFrame.jsp?SearchType=SortNo&Search="+sSortNo+"&ClassifyID="+sClassifyID, "frameright"); 
		}
	}
	<%/*������ͼ���*/%>
	function newTreeGroup(){
		var sReturn = AsControl.PopComp("/AppConfig/PageMode/GroupPage/GroupClassifyInfo.jsp", "",  "dialogWidth=600px;dialogHeight=300px;resizable=yes;maximize:yes;help:no;status:no;");
		if(typeof sReturn == "undefined" || sReturn.length == 0) return;
		var sReturnInfo = sReturn.split("@");
		AsControl.OpenPage("/AppConfig/PageMode/GroupPage/GroupPageView.jsp", "ClassifyID="+sReturnInfo[0]+"&DefaultNode="+sReturnInfo[1], '_self');
	}
	<%/*�༭��ͼ���*/%>
	function viewTreeGroup(){
		var sClassifyID = getCurTVItem().value;
		if(!sClassifyID){
			alert("��ѡ����ͼ���");
			return;
		}
		var sArgs = "ClassifyID=" + sClassifyID;
		if(!hasChild(sClassifyID)){
			sArgs += "&ParentSelectReadOnly=true";
		}
		var sClassifyID = AsControl.PopComp("/AppConfig/PageMode/GroupPage/GroupClassifyInfo.jsp", sArgs,  "dialogWidth=600px;dialogHeight=300px;resizable=yes;maximize:yes;help:no;status:no;");
		if(typeof sClassifyID == "undefined" || sClassifyID.length == 0) return;
		AsControl.OpenPage("/AppConfig/PageMode/GroupPage/GroupPageView.jsp", "ClassifyID="+sClassifyID, "_self");
	}
	<%/*ɾ����ͼ���*/%>
	function deleteTreeGroup(){
		var sClassifyID = getCurTVItem().value;
		if(!sClassifyID){
			alert("��ѡ����ͼ���");
			return;
		}
		if(!hasChild(sClassifyID)){
			alert("�ýڵ��´����ӽڵ㣬���ȴ����ӽڵ㣡");
			return;
		}
		if(!confirm("��ȷ��ɾ�����༰�����µľ�����ͼ��¼��")) return;
		var sReturn = RunJavaMethodTrans("com.amarsoft.app.awe.config.grouppage.action.GroupTreeAction", "deleteTreeNode", "ClassifyID="+sClassifyID);
		if(!sReturn || sReturn != "SUCCESS") return;
		//AsControl.OpenPage("/AppConfig/PageMode/GroupPage/GroupPageView.jsp", "", "_self");
		top.reloadSelf();
	}
</script>
<%@ include file="/IncludeEnd.jsp"%>