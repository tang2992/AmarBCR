<%
/* 
 *
 * Content:   更改HIS表的SessionID
 * Input Param:MainBusinessNo,LoanCardNo,CustomerID,Flag
 *			
 * Output param:
 *
 * History Log:  
 *
 */
%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBeginMD.jsp"%>
<html>
<head> 
<title>查询担保信息对应的主业务信息</title>
</head>
<body>
<% 
	String sSql = "";
	String sReturn = "";
	String sSessionID = "";

	String sMainBusinessNo = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("MainBusinessNo")); 
	if(sMainBusinessNo==null) sMainBusinessNo="";
	String sLoanCardNo = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("LoanCardNo"));
	if(sLoanCardNo==null) sLoanCardNo="";
	String sCustomerID = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("CustomerID"));
	if(sCustomerID==null) sCustomerID="";
	String sFlag = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("Flag"));
	if(sFlag==null) sFlag="";
	if(sFlag.equals("REREPORT")) sSessionID="1111111111"; 
	else sSessionID = "6666666666";
	
	sSql=" select FEED.TRACENUMBER as TraceNumber,CODE.ItemDescribe as TableName from ECR_FEEDBACK FEED,CODE_LIBRARY CODE "
		+ " WHERE CODE.ITEMNO = FEED.RECORDTYPE AND CODE.CODENO='recordtype' ";
	
	if(sCustomerID.equals(""))
		sSql= sSql  + " AND MAINBUSINESSNO='" +sMainBusinessNo+"' AND LOANCARDNO='"+ sLoanCardNo +"' AND SORTNO > '07' ORDER BY  SORTNO ";	
	else{
		sSql=  sSql  +  " AND CUSTOMERID='" +sCustomerID+"' AND FEED.RECORDTYPE IN ('1','2','3','4','5','6','7','71','72','73','74','75','76','77','78') ORDER BY  SORTNO ";	
	}
	ASResultSet rs = null;
	//System.out.println("*********"+sSql);
	try {
			rs = Sqlca.getASResultSet(sSql);
			while(rs.next()) {
				String sTraceNumber = rs.getString("TraceNumber");
				String sTableName = rs.getString("TableName");
				if(sTableName!=null) sTableName = StringFunction.replace(sTableName,"ECR","HIS");
				sSql = "Update "+sTableName+" Set SessionID='"+sSessionID+"' where TraceNumber='"+sTraceNumber+"'";
				Sqlca.executeSQL(sSql);
				sSql = "delete from ecr_feedback where tracenumber='"+sTraceNumber+"'";
				Sqlca.executeSQL(sSql);
			}
			sReturn = "Success";
		}catch(Exception e)
		{	
			sReturn = "Failure";
			throw e;
		}
		finally
		{
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