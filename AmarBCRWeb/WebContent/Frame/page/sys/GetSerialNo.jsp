<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBeginMDAJAX.jsp"%><%
/*
 * Content: ��ȡ��ˮ��
 * Input Param:
 *			����:	TableName
 *			����:	ColumnName
 			��ʽ��	SerialNoFormate
 * Output param:
 *		  ��ˮ��:	SerialNo
 */
	//��ȡ�����������͸�ʽ
	String	sTableName		 = CurPage.getParameter("TableName");
	String	sColumnName 	 = CurPage.getParameter("ColumnName");
	String	sSerialNoFormate = CurPage.getParameter("SerialNoFormate");
	String sPrefix		 = CurPage.getParameter("Prefix");
	if (sSerialNoFormate == null) sSerialNoFormate="";
	if (sPrefix == null) sPrefix = "";

	String	sSerialNo = ""; //��ˮ��

	if(sSerialNoFormate.equals("")){
		if (sPrefix.equals(""))	sSerialNo = DBKeyHelp.getSerialNo(sTableName,sColumnName,Sqlca);
		else sSerialNo = DBKeyHelp.getSerialNo(sTableName,sColumnName,sPrefix,Sqlca);
	}else{
		sSerialNo = DBKeyHelp.getSerialNo(sTableName,sColumnName,sSerialNoFormate,Sqlca);
	}
	out.print(sSerialNo); 
%><%@ include file="/IncludeEndAJAX.jsp"%>