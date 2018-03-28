<%@page import="com.amarsoft.awe.res.model.SkinItem"%>
<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBeginMDAJAX.jsp"%><%
	String sReloadType = CurPage.getParameter("ReloadType");
	if("FixSkins".equals(sReloadType)){
		if(SkinItem.initFixSkins(session.getServletContext())){
			out.print("SUCCESS");
		}
		return;
	}
	String skinPath = CurPage.getParameter("Path");
	String sResult = ASUserHelp.changeSkinPath(CurUser.getUserID(), skinPath, Sqlca);
	if(StringX.isSpace(sResult)) CurUser.getSkin().setPath(skinPath);
	out.print(sResult);
%><%@ include file="/IncludeEndAJAX.jsp"%>