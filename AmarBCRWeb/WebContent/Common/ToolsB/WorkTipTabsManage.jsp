<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBeginMDAJAX.jsp"%><%
	/*
	Content: ����̨�û��Զ���TAB�����ݿ⽻���Ž�ҳ�棬����ֱ��ʹ��RunMethodʱ���������ݻ�������
	*/
	String operate  = CurPage.getParameter("Operate");
	String userid  = CurPage.getParameter("UserID");
	String tabid = CurPage.getParameter("TabID");
	String tabname = CurPage.getParameter("TabName");
	String script = CurPage.getParameter("Script");
	String cache = CurPage.getParameter("Cache");
	String close = CurPage.getParameter("Close");
	
	com.amarsoft.app.util.WorkTipTabsManage wttm = new com.amarsoft.app.util.WorkTipTabsManage();
	wttm.setAttribute("Operate",operate);
	wttm.setAttribute("UserID",userid);
	wttm.setAttribute("TabID",tabid);
	wttm.setAttribute("TabName",tabname);
	wttm.setAttribute("Script",script);
	wttm.setAttribute("Cache",cache);
	wttm.setAttribute("Close",close);
	out.println(wttm.run(Sqlca));
%><%@ include file="/IncludeEndAJAX.jsp"%>