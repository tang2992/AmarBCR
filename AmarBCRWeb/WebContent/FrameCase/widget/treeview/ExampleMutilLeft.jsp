<%@ page contentType="text/html; charset=GBK"%>
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
<%@ include file="/Frame/page/jspf/include/jsp_frame_lrud.jspf"%>
<style>
	.updown #Border {
		border-top-width: 0;
		background: #e1e1e1;
	}
</style>
<script type="text/javascript">
	parent.setTitle("������ͼ", true);
	parent.setTitle("����");
	changeLayout(false, ($("body").height()-300)/300);
	AsControl.OpenView("/FrameCase/widget/treeview/ExampleImage.jsp", "", Layout.getRegionName("SecondFrame"));
	parent.Layout.initRegionName("left", self.name, Layout.getRegionName("FirstFrame"));
	parent.Layout.initRegionName("ImageFrame", self.name, Layout.getRegionName("SecondFrame"));
	var left = frames[Layout.getRegionName("FirstFrame")];
	
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
		AsControl.OpenView(sURL,sParaStringTmp,"right");
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
		parent.setTitle(getCurTVItem().name);
	}
	
	function initTreeView(){
		_Tree_Show_In_View = true;
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		selectItemByName("������Ϣ");
	}
</script>
<%@ include file="/IncludeEnd.jsp"%>