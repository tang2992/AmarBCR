<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	String sDefaultNode = CurPage.getParameter("DefaultNode"); //Ĭ�ϴ򿪽ڵ�
	if(sDefaultNode == null) sDefaultNode = "10";
	//����Treeview
	HTMLTreeView tviTemp = new OHTMLTreeView(SqlcaRepository,CurComp,sServletURL,"���˵�����","right");
	tviTemp.TriggerClickEvent=true; //�Ƿ��Զ�����ѡ���¼�

	//����������������Ϊ��
	//ID�ֶ�(����),Name�ֶ�(����),Value�ֶ�,Script�ֶ�,Picture�ֶ�,From�Ӿ�(����),OrderBy�Ӿ�,Sqlca
	tviTemp.initWithSql("SortNo","MenuName","MenuID","","","from AWE_MENU_INFO where 1 = 1 ","Order By SortNo",Sqlca);
	String sButtons[][] = {
		{"true","All","Button","����","����һ����¼","newRecord()","","","","btn_icon_add"},
		{"true","All","Button","����","���ø�����¼","changeMenuState('1')","","","",""},
		{"true","All","Button","ͣ��","ͣ�ø�����¼","changeMenuState('2')","","","",""},
		{"true","All","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","","btn_icon_delete"},
		{"true","All","Button","���ý�ɫ","���ÿɼ���ɫ","selectMenuRoles()","","","",""},
		{"false","","Button","ˢ�»���","","reloadCacheAll()","","","",""},
		{"true","","Button","��ѯ","","showTVSearch()","","","",""},
	};
%><%@include file="/Resources/CodeParts/View07.jsp"%>
<script type="text/javascript">
	function startMenu(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		selectItem('<%=sDefaultNode%>');
	}
	<%/*[Describe=������¼;]*/%>
	function newRecord(){
		parent.OpenMenuInfo();
	}

	function changeMenuState(sChange){ // ���� 1��ͣ�� 2
		var sSortNo = getCurTVItem().id; //���ݲ˵������ɣ�����ȡ���ǲ˵������
		var sMenuID = getCurTVItem().value;
		if(!sMenuID){
			alert(getMessageText('AWEW1001'));//��ѡ��һ����Ϣ��
			return ;
		}
		var sAction = "";
		if(sChange == "1") sAction = "����";
		else if(sChange == "2") sAction = "ͣ��";
		else sAction = "����";
		
		if(!confirm("ȷ��"+sAction+"�˵���")) return;

		var sIncludeSubs = "false";
		if(confirm("�Ƿ�ͬʱ"+sAction+"���²˵���", "��", "��")){
			sIncludeSubs = "true";
		}
		var sPara = "MenuID="+sMenuID+",SortNo="+sSortNo+",Flag="+sChange+",IncludeSubs="+sIncludeSubs;
		var sReturn = RunJavaMethodSqlca("com.amarsoft.app.awe.config.menu.action.ChangeMenuState","changeMenuState",sPara);
		if(sReturn != "SUCCEEDED"){
			alert(sAction+"�ò˵���ʧ�ܣ�");
		}else{
		    alert("����Ŀ��"+sAction+"�ɹ���");
		    parent.OpenMenuInfo(sMenuID); // ���´򿪽ڵ�
		}
	}
	
	<%/*[Describe=����ڵ��¼�,�鿴���޸�����;]*/%>
	function TreeViewOnClick(){
		var sMenuID = getCurTVItem().value;
		if(!sMenuID) return;
		return parent.OpenMenuInfo(sMenuID);
	}

	<%/*[Describe=ɾ����¼;]*/%>
	function deleteRecord(){
		var sMenuID = getCurTVItem().value;
		if(!sMenuID){
			alert(getMessageText('AWEW1001'));//��ѡ��һ����Ϣ��
			return ;
		}
		if(confirm("ɾ���ü�¼��ͬʱɾ������ɼ���ɫ�Ĺ�����ϵ��\n��ȷ��ɾ����")){
			var sReturn = RunJavaMethodSqlca("com.amarsoft.app.awe.config.menu.action.DeleteMenuAction","deleteMenuAndRela","MenuID="+sMenuID);
			if(typeof sReturn != "undefined" && sReturn == "SUCCEEDED"){
				parent.OpenMenuTree();
			}
		}
	}
	
	<%/*[Describe=ѡ��˵��ɼ���ɫ;]*/%>
	function selectMenuRoles(){
		var sMenuID = getCurTVItem().value;
		var sMenuName = getCurTVItem().name;
		if(!sMenuID){
			alert(getMessageText('AWEW1001'));//��ѡ��һ����Ϣ��
			return ;
		}else{
			AsControl.PopView("/AppConfig/MenuManage/SelectMenuRoleTree.jsp","MenuID="+sMenuID+"&MenuName="+sMenuName,"dialogWidth=440px;dialogHeight=500px;center:yes;resizable:no;scrollbars:no;status:no;help:no");
        }
    }
	<%/*ˢ�����л���*/%>
	function reloadCacheAll(){
		var sReturn = RunJavaMethod("com.amarsoft.app.awe.common.action.ReloadCacheConfigAction","reloadCacheAll","");
		if(sReturn=="SUCCESS") alert("ˢ�³ɹ���");
		else alert("ˢ��ʧ�ܣ�");
	}
	
	$("body").addClass("tree_show_in_view");
	_Tree_Show_In_View = true;
	startMenu();
</script>
<%@ include file="/IncludeEnd.jsp"%>