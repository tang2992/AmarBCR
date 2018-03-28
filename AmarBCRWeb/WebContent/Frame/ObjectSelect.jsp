<%@page import="com.amarsoft.dict.als.object.ObjectType"%>
<%@page import="com.amarsoft.dict.als.manage.ObjectTypeManager"%>
<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBeginMD.jsp"%><%
	String sObjectType  = CurPage.getParameter("ObjectType");
	String sParaString = CurPage.getParameter("ParaString");
	if(sParaString==null) sParaString="";
	sParaString = StringFunction.replace(sParaString,"~","&");
	sParaString = StringFunction.replace(sParaString,"^","@");
	
	String sSelectionDialogURL = "",sSelectionDialogCompID="";
	
	ObjectType type = ObjectTypeManager.getObjectType(sObjectType);
	String sObjectAttribute = type.getObjectAttribute();
	String sObjectTypeName  = type.getObjectName();
	
	sSelectionDialogURL = StringFunction.getProfileString(sObjectAttribute,"SelectionDialog");
	if(sSelectionDialogURL!=null)	sSelectionDialogURL = sSelectionDialogURL.trim();
	sSelectionDialogCompID = StringFunction.getProfileString(sObjectAttribute,"SelectionDialogCompID");
	if(sSelectionDialogCompID==null || sSelectionDialogCompID.equals(""))
		sSelectionDialogCompID = sObjectType+"SelectionDialog";
%>
<html>
<head> 
<!-- Ϊ��ҳ������,�벻Ҫɾ������ TITLE �еĿո� -->
<title>��ѡ��<%=sObjectTypeName%>
 ���������������������������������� ���������������������������������� ����������������������������������
 ���������������������������������� ���������������������������������� ����������������������������������
</title>
</head>
<body class="pagebackground" style="overflow: auto;overflow-x:visible;overflow-y:visible">
<form  name="buff" align=center>
<table width="100%" border='1' height="98%" cellspacing='0' align=center bordercolor='#999999' bordercolordark='#FFFFFF'>
<%if(sSelectionDialogURL==null || sSelectionDialogURL.equals("")){%>
	<tr> 
		<td id="selectPage" valign=top>
			<p>û�ж������ѡ�񴰿ڡ�����"ҵ�������������"ģ�鶨�� SelectionDialog ���ԡ�</p>
		</td>
	</tr>
<%}else{%>
	<tr> 
		<td id="selectPage">
			<iframe name="ObjectList" width=100% height=100% frameborder=0 scrolling=no src="<%=sWebRootPath%>/Blank.jsp"></iframe>
		</td>
	</tr>
<%}%>
	<tr>
		<td nowarp bgcolor="" height="25" align=center  colspan="2"> 
			<%=new Button("ȷ��", "", "returnSelection()").getHtmlText()%>
			<%=new Button("���", "", "clearAll()").getHtmlText()%>
			<%=new Button("ȡ��", "", "doCancel()").getHtmlText()%>
		</td>
	</tr>
</table>
</form>
</body>
</html>
<script type="text/javascript">
	var sObjectInfo="";
	function returnSelection(){
		if(sObjectInfo==""){
			if(confirm("����δ����ѡ��ȷ��Ҫ������")){
				sObjectInfo="_NONE_";
			}else{
				return;
			}
		}
		top.returnValue=sObjectInfo;
		top.close();
	}

	function clearAll(){
		top.returnValue='_CLEAR_';
		top.close();
	}

	function doCancel(){
		top.returnValue='_CANCEL_';
		top.close();
	}
	
	<%if(sSelectionDialogURL!=null && !sSelectionDialogURL.equals("")){%>
		OpenComp("<%=sSelectionDialogCompID%>","<%=sSelectionDialogURL%>","<%=sParaString%>","ObjectList","");
	<%}%>
</script>
<%@ include file="/IncludeEnd.jsp"%>