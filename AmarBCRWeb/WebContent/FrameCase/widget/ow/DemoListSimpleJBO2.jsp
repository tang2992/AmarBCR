<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%@
 page import="com.amarsoft.are.jbo.*" %><%
	//��ȡjbo��list
	ASObjectModel doTemp = new ASObjectModel();
 	String queryStr = "select o.userid,O.USERNAME,o.CERTID,MOBILETEL,EMAIL,UR.ROLEID,UR.GRANTOR from O,jbo.sys.USER_ROLE UR where UR.UserID = O.UserID";
	doTemp.initQuery("jbo.sys.USER_INFO", queryStr);
	/* 
	doTemp.setVisible("*",false); //ȱʡ��ʾȫ�����ԣ���������ȫ������ʾ��
	doTemp.setVisible("userid,USERNAME,CERTID,ROLEID",true);   //������ʾ������
	 */
	doTemp.setColumnFilter("userid",true);
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.setPageSize(15);
	dwTemp.Style="1";      //����ΪGrid���
	dwTemp.ReadOnly = "1";//ֻ��ģʽ
	dwTemp.genHTMLObjectWindow("");
	
	String sButtons[][] = {};
%><%@
include file="/Frame/resources/include/ui/include_list.jspf"%><%@
 include file="/Frame/resources/include/include_end.jspf"%>