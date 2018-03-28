<%
/* Copyright 2001-2005 Amarsoft, Inc. All Rights Reserved.
 * This software is the proprietary information of Amarsoft, Inc.
 * Use is subject to license terms.
 * Author: ZYWei 2003.8.17
 * Tester:
 *
 * Content: 获取流水号
 * Input Param:
 *			表名:	TableName
 *			列名:	ColumnName
 			格式：	SerialNoFormate
 * Output param:
 *		  流水号:	SerialNo
 *
 * History Log:
 *
 */
%>


<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

<html>
<head>
<title>获得序列号</title>

<%
	//页面参数之间的传递一定要用DataConvert.toRealString(iPostChange,只要一个参数)它会自动适应window.open或者window.open
	//获取表名、列名和格式
	String sTableName = CurPage.getParameter("TableName");
	String sColumnName = CurPage.getParameter("ColumnName");
	String sSerialNoFormate = CurPage.getParameter("SerialNoFormate");
	String sPrefix = CurPage.getParameter("Prefix");
	if (sSerialNoFormate == null) sSerialNoFormate="";
	if (sPrefix == null) sPrefix = "";
	String	sSerialNo = ""; //流水号
	if(sSerialNoFormate.equals(""))
	{
		if (sPrefix.equals(""))	sSerialNo = DBKeyHelp.getSerialNo(sTableName,sColumnName,Sqlca);
		else sSerialNo = DBKeyHelp.getSerialNo(sTableName,sColumnName,sPrefix,Sqlca);
	}else{
		sSerialNo = DBKeyHelp.getSerialNo(sTableName,sColumnName,sSerialNoFormate,Sqlca);
	}
%>

<script language=javascript>
    var SerialNo = "<%=sSerialNo%>";
	self.returnValue = "<%=sSerialNo%>";
	self.close();
</script>
<%@ include file="/IncludeEnd.jsp"%>
