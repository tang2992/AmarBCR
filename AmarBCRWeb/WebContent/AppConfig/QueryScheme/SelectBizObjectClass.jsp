<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%@
 page import="com.amarsoft.are.jbo.*" %><%
 	String DefaultNode =  CurPage.getParameter("DefaultNode");
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView("JBO��","right");
	tviTemp.TriggerClickEvent = true;
	//������ͼ�ṹ
	JBOFactory f = JBOFactory.getFactory();
	String[] pkgNames=f.getPackages();
 	for(int i = 0;i<pkgNames.length;i++){
		if(pkgNames[i].contains("jbo.ui") || pkgNames[i].contains("jbo.oti")) continue; //�޳�UI���ֵ�jbo����

		String pkgLabel = f.getPackage(pkgNames[i]).getLabel();
		tviTemp.insertFolder(pkgNames[i], "root", pkgLabel, pkgNames[i], "", i); //package�ڵ�
		
		String[] classes=f.getClasses(pkgNames[i]);
	 	//�洢class��label������
	 	for(int j=0;j<classes.length;j++){
	 		BizObjectClass clazz = f.getClass(classes[j]);
	 		String clsName = clazz.getName();
	 		String clsLabel = clazz.getLabel();
	 		tviTemp.insertPage(classes[j], pkgNames[i], clsLabel+"["+classes[j]+"]", clsLabel, "", j); //class�ڵ�
	 	}
	}
 	String sButtons[][] = {
 		{"true","","Button","ѡ��","����ѡ����","doConfig()","","","",""},
 		{"true","","Button","��ѯ","","showTVSearch()","","","",""}
 	};
%><%@include file="/Resources/CodeParts/View07.jsp"%>
<script type="text/javascript">
	setDialogTitle("ѡ��JBO������");
	function doConfig(){
		var sCurItemID = getCurTVItem().id;
		var sCurItemValue = getCurTVItem().value;
		var sCurItemType = getCurTVItem().type;
		if(sCurItemType == 'page'){
			top.returnValue = sCurItemID+"@"+sCurItemValue;
			top.close();
		}else{
			return;
		}
	}
	function TreeViewOnClick(){}
	function TreeViewOnDBLClick(){
		doConfig();
	}
	<%/*~[Describe=����treeview;]~*/%>
	function initTreeView(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		var DefaultNode = "<%=DefaultNode%>";
		if( DefaultNode!= null){
			selectItemByName(DefaultNode); //Ĭ�ϴ򿪽ڵ�
		}
	}
	initTreeView();
</script>
<%@ include file="/IncludeEnd.jsp"%>