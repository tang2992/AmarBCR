<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/IncludeBegin.jsp"%>
<%
	//���ҳ�����
	String sExampleId = CurPage.getParameter("ObjectNo");

	//����Treeview
	HTMLTreeView tviTemp = new OHTMLTreeView(SqlcaRepository,CurComp,sServletURL,"������ͼ","right");
	tviTemp.TriggerClickEvent=true; //�Ƿ��Զ�����ѡ���¼�

	//������ͼ�ṹ
	String sSqlTreeView = "from CODE_LIBRARY where CodeNo='ExampleTree' and IsInUse='1' ";
	tviTemp.initWithSql("SortNo","ItemName","ItemName","","",sSqlTreeView,"Order By SortNo",Sqlca);
	//����������������Ϊ��
	//ID�ֶ�(����),Name�ֶ�(����),Value�ֶ�,Script�ֶ�,Picture�ֶ�,From�Ӿ�(����),OrderBy�Ӿ�,Sqlca
	CurPage.setAttribute("HideMinButton", "true");
%>
<html>
	<head>
		<title>Ӱ����ͼ</title>
	</head>
	<body style="margin:0;padding:0;overflow:hidden;height:100%;width:100%;background:none;">
		<iframe width="100%" height="100%" frameborder="0" name="left" allowtransparency></iframe>
	</body>
	<script type="text/javascript">
	function openChildComp(sURL,sParameterString){
		sParaStringTmp = "";
		sLastChar=sParameterString.substring(sParameterString.length-1);
		if(sLastChar=="&") sParaStringTmp=sParameterString;
		else sParaStringTmp=sParameterString+"&";

		/*
		 * ������������
		 * ToInheritObj:�Ƿ񽫶����Ȩ��״̬��ر��������������
		 * OpenerFunctionName:�����Զ�ע�����������REG_FUNCTION_DEF.TargetComp��
		 */
		sParaStringTmp += "ToInheritObj=y&OpenerFunctionName="+getCurTVItem().name;
		AsControl.OpenView(sURL,sParaStringTmp,"RightImage");
	}
	
	//treeview����ѡ���¼�
	function TreeViewOnClick(){
		//var sCurItemID = getCurTVItem().id;
		var sCurItemname = getCurTVItem().name;
		if(sCurItemname=="������Ϣ"){
			openChildComp("/FrameCase/widget/dw/ExampleList.jsp","");
		}else if(sCurItemname=="������Ϣ1"){
			openChildComp("/FrameCase/widget/dw/ExampleList.jsp","");
		}else if(sCurItemname=="������Ϣ2"){
			openChildComp("/FrameCase/widget/dw/ExampleList.jsp","");
		}else if(sCurItemname=="��������Ϣ"){
			openChildComp("/FrameCase/widget/dw/ExampleList.jsp","");
		}else if(sCurItemname=="�������Ϣ"){
			openChildComp("/FrameCase/widget/dw/ExampleList.jsp","");
		}
		//parent.setTitle(getCurTVItem().name);
	}
	
	function initTreeView(){
		_Tree_Show_In_View = true;
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		selectItemByName("������Ϣ");
	}
	</script>
</html>
<%@ include file="/IncludeEnd.jsp"%>