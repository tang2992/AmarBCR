<%
/* 
 *
 * Content:   ����HIS���SessionID
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

	String	sContractNo = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("ContractNo")); 
	String  sOccurDate = StringFunction.getToday();
	String	sLoanCardNo =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("LoanCardNo"));
	String	sFinanceID =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("FinanceID"));
	String	sBusinessType =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("BusinessType"));
	
	//�Ȳ�ѯ�Ƿ�������ɾ�������Ѿ����ڸü�¼
	sSql = "select * from HIS_BATCHDELETE where ContractNo='"+sContractNo+"' and OccurDate='"+sOccurDate+"' and LoanCardNo='"+sLoanCardNo+"' and FinanceID='"+sFinanceID+"' and BusinessType='"+sBusinessType+"'";
	ASResultSet rs = Sqlca.getASResultSet(sSql);
	
	if(!rs.next()){
	//û�д��ھͲ���һ���¼�¼
		sSql = "insert into HIS_BATCHDELETE (RecordFlag,ContractNo,OccurDate,LoanCardNo,FinanceID,BusinessType,SessionID,incrementflag) values ('40','"+sContractNo+"','"+StringFunction.getToday()+"','"+sLoanCardNo+"','"+sFinanceID+"','"+sBusinessType+"','0000000000','1')";
		try
		{
			Sqlca.executeSQL(sSql);
			sReturn = "Success";
		}
		catch(Exception e)
		{	
			System.out.println(e.toString()+" "+e.getMessage());
			sReturn = "Failure";
			throw e;
		}
		finally
		{
		}
	}else{
		sReturn = "Exist";
	}
	if(rs!=null) rs.close();
%>
</body>
</html>
<script language=javascript>
	top.returnValue="<%=sReturn%>";
	top.close();
</script>
<%@ include file="/IncludeEnd.jsp"%>