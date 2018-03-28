<%@page import="com.amarsoft.are.jbo.*"%>
<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBegin.jsp"%><%
 	String bizObjClass =  CurPage.getParameter("BizObjClass");
 	if(bizObjClass == null) bizObjClass="";
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView("JBO��","right");
	tviTemp.TriggerClickEvent=false;
 	tviTemp.MultiSelect = true;
	BizObjectClass bc = JBOFactory.getBizObjectClass(bizObjClass);
	//TODO ��ȡ������Ĺ������󣬰���class��alias��relation������
	String[] relatedObjects = new String[]{"jbo.xquery.ENT_INFO","jbo.xquery.CUSTOMER_RELATIVE"};
 	for(int i = 0;i<relatedObjects.length;i++){
 		BizObjectClass clazz = JBOFactory.getBizObjectClass(relatedObjects[i]);
 		String clsName = clazz.getName();
 		String clsLabel = clazz.getLabel();
 		//TODO ������Ϊʾ����ʱ���壬���������
 		String nodeJSONValue = relatedObjects[i]+"@"+clsName+"@";
 		if(relatedObjects[i].equals("jbo.xquery.ENT_INFO")) nodeJSONValue += "O.CustomerID=ENT_INFO.CustomerID";
 		else if(relatedObjects[i].equals("jbo.xquery.CUSTOMER_RELATIVE")) nodeJSONValue += "O.CustomerID=CUSTOMER_RELATIVE.CustomerID";
 		
 		tviTemp.insertPage(clsName, "root", clsLabel, nodeJSONValue, "", i); //class�ڵ�
	}
 	
 	String sButtons[][] = {
 		{"true","","Button","ѡ��","����ѡ����","doConfig()","","","",""},
 	};
%><%@include file="/Resources/CodeParts/View07.jsp"%>
<script type="text/javascript">
	setDialogTitle("ѡ��JBO��������");
	function doConfig(){
		var nodes = getCheckedTVItems(); //��������ڵ�
   		if(nodes == null || nodes.length == 0){
   			alert("��ѡ���������ڵ㣡");
   			return;
   		}
		
   		var relatedClasses = new Array();
   		var relatedClassName="";
   		for(var i=0;i<nodes.length;i++){
			if(nodes[i].type != "page") continue;
			relatedClasses.push(nodes[i].value);
			relatedClassName += ","+nodes[i].name;
   		}
   		top.returnValue = JSON.stringify(relatedClasses)+"@@"+relatedClassName.substring(1);
		top.close();
	}
	<%/*~[Describe=����treeview;]~*/%>
	function initTreeView(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandAll();
	}
	initTreeView();
</script>
<%@ include file="/IncludeEnd.jsp"%>