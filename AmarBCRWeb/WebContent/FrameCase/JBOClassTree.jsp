<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%@
 page import="com.amarsoft.are.jbo.*" %><%
	String jbopackage = CurPage.getParameter("jbopackage");
 	String DefaultNode =  CurPage.getParameter("DefaultNode");
 	if(jbopackage == null) jbopackage = "";
 	
	String PG_TITLE = "JBO Class��ͼ"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "200";//Ĭ�ϵ�treeview���
	
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"����","right");
	tviTemp.TriggerClickEvent=true; //�Ƿ�ѡ��ʱ�Զ�����TreeViewOnClick()����
	
	//������ͼ�ṹ
	JBOFactory f = JBOFactory.getFactory();
	String[] pkgNames=f.getPackages();
 	for(int i = 0;i<pkgNames.length;i++){
		if(!StringX.isEmpty(jbopackage) && !pkgNames[i].startsWith(jbopackage)) continue;

		String pkgLabel = f.getPackage(pkgNames[i]).getLabel();
		tviTemp.insertFolder(pkgNames[i], "root", pkgLabel, pkgNames[i], "", i); //package�ڵ�
		
		String[] classes=f.getClasses(pkgNames[i]);
	 	//�洢class��label������
	 	for(int j=0;j<classes.length;j++){
	 		BizObjectClass clazz = f.getClass(classes[j]);
	 		String clsLabel = clazz.getLabel();
	 		tviTemp.insertFolder(classes[j], pkgNames[i], clsLabel, classes[j], "", j); //class�ڵ�
	 		
	 		DataElement[] attrs = clazz.getAttributes();
	 		for(int k=0;k<attrs.length;k++){
	 			DataElement element = attrs[k];
	 			tviTemp.insertPage(classes[j], element.getLabel(), element.getName(), "", k); //attribute�ڵ�
	 		}
	 	}
	}
 	
 	String sButtons[][] = {
 		{"true","","Button","��ѯ","","showTVSearch()","","","",""},
	};
%><body style="overflow: hidden;">
	<table style="width: 100%;height: 100%;border: 0;">
		<tr style="height: 30px;">
			<td><%@ include file="/Frame/resources/include/ui/include_buttonset_dw.jspf"%></td>
		</tr>
		<tr> 
  			<td id="myleft" align=center width=100%><iframe name="left" src="" width=100% height=100% frameborder=0 scrolling=no ></iframe></td>
		</tr>
	</table>
</body>
<script type="text/javascript"> 
	<%/*~[Describe=����treeview;]~*/%>
	function initTreeView(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		//����Ĭ�ϴ򿪽ڵ�
		var DefaultNode = "<%=DefaultNode%>";
		if(DefaultNode!= null){
			selectItemByName(DefaultNode);
		}
	}
	initTreeView();
</script>
<%@ include file="/IncludeEnd.jsp"%>