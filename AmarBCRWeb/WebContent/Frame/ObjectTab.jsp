<%@page import="com.amarsoft.dict.als.object.ObjectTypeRela"%>
<%@page import="com.amarsoft.awe.res.AppBizObject"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<link rel="stylesheet" href="<%=sWebRootPath%>/Frame/page/resources/css/tabs.css">
<link rel="stylesheet" type="text/css" href="<%=sWebRootPath%><%=sSkinPath%>/css/tabs.css">
<script type='text/javascript' src='<%=sWebRootPath%>/Frame/resources/js/tabstrip-1.0.js'></script>
<%
	/*
		ҳ��˵��: tabҳ�鿴������Ϣ
	 */
	//�������
	String sTitle = "";
	//���ҳ������� ObjectNo�������� ��ObjectType����������
	String sObjectNo =  CurPage.getParameter("ObjectNo");
	String sObjectType =  CurPage.getParameter("ObjectType");	
	String sViewID =  CurPage.getParameter("ViewID");
	if (sObjectNo == null) sObjectNo = "";
	if (sObjectType == null) sObjectType = "";
	if (sViewID == null) sViewID = "001";
%>
<script type="text/javascript">
	$(document).ready(function(){
		var tabCompent = new TabStrip("T001","<%=sObjectType%>","tab","#tabdiv");
		tabCompent.setSelectedItem("0");
		tabCompent.setIsDialogTitle(true);		//�Ƿ���ʾ�Ի������
		<%
		if(StringX.isEmpty(sObjectType) || StringX.isEmpty(sObjectNo)){
			throw new Exception("δ���ObjectType��ObjectNo����ֵ");
		}else{
			ArrayList<ObjectTypeRela> relaList = AppBizObject.getObjectRelaList(Sqlca,sObjectType,sObjectNo,sViewID);
			//���ݶ��������� tab
			for(int i=0;i<relaList.size();i++){ 
				if(relaList.get(i). getObjectType()!= null&&relaList.get(i). getDisplayName() != null&&relaList.get(i). getViewExpr() != null){
					out.println("tabCompent.addDataItem('"+i+"',\""+relaList.get(i). getDisplayName()+"\",\""+relaList.get(i). getViewExpr() +"\",true,false);");
				}
			}
		}
		%>
		tabCompent.initTab();
	});
</script>
<html>
<head>
<title><%=sTitle%></title>
</head> 
<body leftmargin="0" topmargin="0" class="pagebackground" style="margin:0;padding:0;">
<div id="tabdiv" style="border:0px solid #F00;z-index:-1;width:100%;height:100%;padding:0,0.5%">&nbsp;</div>
</body>
</html>
<%@ include file="/IncludeEnd.jsp"%>