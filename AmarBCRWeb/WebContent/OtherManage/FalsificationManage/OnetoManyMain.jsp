<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	String PG_TITLE = "һ���໧";
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;"+PG_TITLE+"&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "1";//Ĭ�ϵ�treeview���

	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"һ���໧","right");
	tviTemp.toRegister = false; //�����Ƿ���Ҫ�����еĽڵ�ע��Ϊ���ܵ㼰Ȩ�޵�
	tviTemp.TriggerClickEvent=true;
 	tviTemp.insertPage("root","һ���໧","",1);
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript"> 
	function TreeViewOnClick(){
		var sCurItemID = getCurTVItem().id;
		var sCurItemname = getCurTVItem().name;
	   if(sCurItemname=='һ���໧'){
		   //AsControl.OpenComp("/Icr/OtherManage/AccountChangeList.jsp","IsReported=0","right");
		   OpenComp("OnetoManyList","/OtherManage/FalsificationManage/OnetoManyList.jsp","","right");
		}else{
			return;
		}
	  setTitle(getCurTVItem().name);
	}
	
	function initTreeView(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		selectItem("1");
	}
		
	initTreeView();
</script>
<%@ include file="/IncludeEnd.jsp"%>