<%@page import="com.amarsoft.are.util.json.*"%>
<%@page import="com.amarsoft.are.jbo.*"%>
<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	String majorClass = CurPage.getParameter("MajorClass"); //������
	String relatedClass = CurPage.getParameter("RelatedClasses"); //�����ַ���
	String selectType = CurPage.getParameter("SelectType"); //ѡ������
	String selectedAttrs = CurPage.getParameter("SelectedAttrs"); //��ѡ��ڵ�
	
	HTMLTreeView tviTemp = new HTMLTreeView("ѡȡJBO��������");
	tviTemp.TriggerClickEvent=false;
	tviTemp.MultiSelect = true;

	Map map = new HashMap();
	map.put(majorClass, "O");
	if(!StringX.isEmpty(relatedClass)){
		//System.out.println("relatedClass=="+relatedClass);
		JSONObject relaArray =  JSONDecoder.decode(relatedClass);
		for(int i=0;i<relaArray.size();i++){
			String je = relaArray.get(i).getValue().toString();
			String jboClass = je.split("\\@")[0];
			String sClassAlias = je.split("\\@")[1];
			map.put(jboClass, sClassAlias);
		}
	}
	
	//�Ӳ����л�ȡjbo�����മ���ô��Զ��ŷָ�
	String sKeys[] = (String[])map.keySet().toArray(new String[0]);
	for(int i=0;i<sKeys.length;i++){
		BizObjectClass bizClass = JBOFactory.getBizObjectClass(sKeys[i]);
		//���������
		String sClassAlias = map.get(sKeys[i]).toString();
		//����jbo class
		tviTemp.insertFolder(sClassAlias, "root", bizClass.getLabel(), bizClass.getAbsoluteName(), "", i);
		
		//���� class attributes
		DataElement[] attrs = bizClass.getAttributes();
		for(int j=0;j<attrs.length;j++){
			String attrName = attrs[j].getName();
			tviTemp.insertPage(sClassAlias+"_"+attrName, sClassAlias, bizClass.getLabel()+"-"+attrs[j].getLabel(), sClassAlias+"."+attrName, "", j);
		}
	}
	String[][] sButtons = {
		{"true", "", "Button", "ȷ��", "ȷ��ѡ��", "doConfig()", "", "", "", ""},
		{"true", "", "Button", "���", "���", "doClear()", "", "", "", ""},
	};
%><%@include file="/Resources/CodeParts/View07.jsp"%>
<script type="text/javascript">
	setDialogTitle("ѡȡJBO�����������");
	function doConfig(){
   		var nodes = getCheckedTVItems(); //������������ͼѡ��Ľڵ�
   		if(nodes == null || nodes.length == 0){
   			alert("��ѡ��������Խڵ㣡");
   			return;
   		}
   		
   		var attrs ="",names="",j=1;
   		var selectType = "<%=selectType%>";
   		if(nodes.length > 5 && (selectType=="Order" || selectType=="Group" || selectType=="Summary")){
   			alert("ѡ������࣡");
   			return;
   		}
		for(var i=0;i<nodes.length;i++){
			if(nodes[i].type != "page") continue;
			//����.����
			attrs += ","+ nodes[i].value;
			names += j+". "+ nodes[i].name+"\r\n";
			j++;
		}
   		top.returnValue = attrs.substring(1)+"@"+names;
		top.close();
	}
	function doClear(){
		top.returnValue = "@";
		top.close();
	}
	function initTreeView(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandAll();
		<%
		String[] attArray = selectedAttrs.split(",");
		for(int i=0;i<attArray.length;i++){
			String nodeid = attArray[i].replace(".", "_");
		%>
			setCheckTVItem("<%=nodeid%>", true);
		<%
		}
		%>
	}
	initTreeView();
</script>
<%@ include file="/IncludeEnd.jsp"%>