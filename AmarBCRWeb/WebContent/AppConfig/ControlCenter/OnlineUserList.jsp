<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
 	/* �����û��б� */
	String time=DateX.format(new java.util.Date(), "yyyy/MM/dd");

 	ASObjectModel doTemp = new ASObjectModel("OnlineUserList");
 	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����ΪGrid���
	dwTemp.ReadOnly = "1"; //����Ϊֻ��
	dwTemp.genHTMLObjectWindow(time);

	String sButtons[][] = {
		{"true","","Button","�ر�","�ر�","top.close();","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<%@ include file="/Frame/resources/include/include_end.jspf"%>