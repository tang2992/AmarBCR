<%@page import="com.amarsoft.dict.als.object.Item"%>
<%@page import="com.amarsoft.dict.als.manage.CodeManager"%>
<%@page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBeginMDAJAX.jsp"%><%
	/*
	  author:syang 2009/10/20
		Content: 工作台上WorkTips工作提示Ajax展示总调度页面
		Input Param:
			Type:加载类型（点击鼠标，展开时Type ="1"）
	 */
	String sType = CurPage.getParameter("Type");
	String sItemNo = CurPage.getParameter("ItemNo");
	if(sType == null) sType = "0";
	if(sItemNo == null) throw new Exception("请传入编号");
	
	//取出代码对象
	Item[] codeDef = CodeManager.getItems("PlantformTask");
	String sURLName = "";
	for(int i=0;i<codeDef.length;i++){
		Item vpItem = codeDef[i];
		String sCurItemNo = vpItem.getItemNo();
		if(sItemNo.equals(sCurItemNo)){	//遍历，与传入的进行比较
			sURLName = vpItem.getItemAttribute();
			break;
		}
	}
	//调用页面URL不能为空
	if(sURLName == null || sURLName.length() == 0){
		throw new Exception("代码表[PlantformTask]，ItemNo["+sItemNo+"],没有配置ItemAttribute字段的值");
	}
	response.sendRedirect(SpecialTools.amarsoft2Real(sWebRootPath+sURLName+"?Flag="+sType+"&CompClientID="+sCompClientID));
%><%@ include file="/IncludeEndAJAX.jsp"%>