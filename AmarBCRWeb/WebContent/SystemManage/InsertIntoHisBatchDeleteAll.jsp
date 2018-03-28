<%
/* 
 *
 * Content:   更新HIS表的SessionID
 * Input Param:
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
<title></title>
</head>
<body>
<% 
	String sSql = "";
	String sReturn = "";

	String sLoanCardNo = CurPage.getParameter("LoanCardNo");
	String sBusinessType =  CurPage.getParameter("BusinessType");
	String sTableName =  CurPage.getParameter("TableName");
	String sContractNo = "";
	String  sOccurDate = StringFunction.getToday();
	
	if(sBusinessType.equals("01")){sContractNo="LContractNo";}
		else if(sBusinessType.equals("02")){sContractNo="FactoringNo";}
		else if(sBusinessType.equals("03")){sContractNo="BillNo";}
		else if(sBusinessType.equals("04")){sContractNo="FContractNo";}
		else if(sBusinessType.equals("05")){sContractNo="CreditLetterNo";}
		else if(sBusinessType.equals("06")){sContractNo="GuaranteeBillNo";}
		else if(sBusinessType.equals("07")){sContractNo="AcceptNo";}
		else if(sBusinessType.equals("08")){sContractNo="CContractNo";}
		else if(sBusinessType.equals("09")){sContractNo="FloorFundNo";}
		else if(sBusinessType.equals("10")){sContractNo="LoanCardNo";}
	
	sSql = "select "+sContractNo+",OccurDate,FinanceID,SessionID from "+sTableName + " where LoanCardNo='"+sLoanCardNo+"'";
	ASResultSet rs = Sqlca.getASResultSet(new SqlObject(sSql));
	List list = new ArrayList();
	
	while(rs.next()){
			String contractno = rs.getString(sContractNo);
			String financeid = rs.getString("FinanceID");
			String occurdate = rs.getString("OccurDate");
			String sessionid = rs.getString("SessionID");
			String record = contractno + "," + occurdate + "," + financeid + "," + sessionid;
			list.add(record);
	}
	rs.close();
	
	Iterator it = list.iterator();
	String sSql1 = "";
	String sSql2 = "";
	while(it.hasNext()){
		String[] record = ((String)it.next()).split(",");
		//删除已有的HIS_BATCHDELETE
		sSql1 = "delete from HIS_BATCHDELETE where SessionID='"+record[3]+"' and ContractNo='"+record[0]
			+"' and BusinessType='"+sBusinessType+"' and LoanCardNo='"+sLoanCardNo+"' and OccurDate='"+sOccurDate+"'";
		try 
		{
			Sqlca.executeSQL(new SqlObject(sSql1));
		}
		catch(Exception e)
		{	
			System.out.println(e.toString()+" "+e.getMessage());
			throw e;
		}
	}
	
	Iterator it2 = list.iterator();
	while(it2.hasNext()){
		String[] record = ((String)it2.next()).split(",");
		sSql2 = "insert into HIS_BATCHDELETE (Occurdate,ContractNo,BusinessType,Loancardno,FinanceID,SessionID,RecordFlag,incrementflag)"+
         " values('"+sOccurDate+"','"+record[0]+"','"+sBusinessType+"','"+sLoanCardNo+"','"+record[2]+"','"+record[3]+"','40','1')";
		try 
		{
	  		Sqlca.executeSQL(new SqlObject(sSql2));
		}
		catch(Exception e)
		{	
			System.out.println(e.toString()+" "+e.getMessage());
			throw e;
		}
	}
	
  	sReturn = "Success";
%>
</body>
</html>
<script language=javascript>
	top.returnValue="<%=sReturn%>";
	top.close();
</script>
<%@ include file="/IncludeEnd.jsp"%>