<%
/* 
 *
 * Content:   根据担保合同信息取得对应主业务的金融机构代码和贷款卡编码 
 *
 */
%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBeginMD.jsp"%>
<html>
<head> 
<title></title>
</head>
<body>
<% 
	String sSql = "";
	String sReturn = "";

	String	sTableName = CurPage.getParameter("TableName"); 
	String	sKeyNameMain = CurPage.getParameter("KeyNameMain");
	String	sKeyValueMain =  CurPage.getParameter("KeyValueMain");
	
	sSql = "select LoanCardNo,FinanceID from " + sTableName + " where " + sKeyNameMain + " = '" + sKeyValueMain + "'";
	
	ASResultSet rs = Sqlca.getASResultSet(new SqlObject(sSql));
	if(rs.next()){
	sReturn = rs.getString(1) + "!" + rs.getString(2);
	}
	if(rs!=null) {
		rs.close();
	}
%>
</body>
</html>
<script language=javascript>
	top.returnValue="<%=sReturn%>";
	top.close();
</script>
<%@ include file="/IncludeEnd.jsp"%>