<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		ҳ��˵��:�ֹ�������ͼʾ��ҳ��
	 */
	String PG_TITLE = "�ֹ�������ͼ"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;�ֹ�������ͼ&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "200";//Ĭ�ϵ�treeview���

	//���ҳ�����
	String sExampleId = CurPage.getParameter("ObjectNo");

	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"�ֹ�������ͼ","right");
	tviTemp.TriggerClickEvent=true; //�Ƿ��Զ�����ѡ���¼�
	//ͨ��insertFolder��insertPage������ͼ
	String sFold1=tviTemp.insertFolder("root","����ʾ��","",1);                             
 	String tmp1=tviTemp.insertFolder(sFold1,"����ʾ���б�","",1);                               
 	tviTemp.insertPage(tmp1,"������Ϣ","",1);
	tviTemp.insertPage(tmp1,"������Ϣ(TAB)","",2);
	tviTemp.insertPage(tmp1,"������","",3);
	tviTemp.insertPage("root","����ʾ���б�2","",2);
	tviTemp.insertPage("root","����ʾ���б�3","",3);
%><%@include file="/Resources/CodeParts/View04.jsp"%>
<script type="text/javascript"> 
	function openChildComp(sURL,sParameterString){
		sParaStringTmp = "";
		sLastChar=sParameterString.substring(sParameterString.length-1);
		if(sLastChar=="&") sParaStringTmp=sParameterString;
		else sParaStringTmp=sParameterString+"&";

		/*
		 * ToInheritObj:�Ƿ񽫶����Ȩ��״̬��ر��������������
		 */
		sParaStringTmp += "ToInheritObj=y";
		AsControl.OpenView(sURL,sParaStringTmp,"right");
	}
	
	//treeview����ѡ���¼�
	function TreeViewOnClick(){
		var sCurItemname = getCurTVItem().name;
		if(sCurItemname=="������Ϣ"){
			openChildComp("/FrameCase/widget/dw/ExampleInfo.jsp","ExampleId=<%=sExampleId%>");
		}else if(sCurItemname=="������Ϣ(TAB)"){
			openChildComp("/FrameCase/Layout/ExampleTab.jsp","ExampleId=<%=sExampleId%>");
			return;
		}else if(sCurItemname=="������"){
			openChildComp("/FrameCase/Layout/ExampleFrame.jsp","ExampleId=<%=sExampleId%>");
			return;
		}else if(sCurItemname=="����ʾ���б�2"){
			openChildComp("/FrameCase/widget/dw/ExampleList.jsp","");
			return;
		}else if(sCurItemname=="����ʾ���б�3"){
			openChildComp("/FrameCase/widget/dw/ExampleList.jsp","");
			return;
		}else{}
		setTitle(getCurTVItem().name);
	}
	
	function initTreeView(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		selectItemByName("������Ϣ");
	}
		
	initTreeView();
</script>
<%@ include file="/IncludeEnd.jsp"%>