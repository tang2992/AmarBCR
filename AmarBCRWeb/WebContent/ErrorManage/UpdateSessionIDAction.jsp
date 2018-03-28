<%
/* 
 *
 * Content:   更改HIS表的SessionID
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
<title>查询担保信息对应的主业务信息</title>
</head>
<body>
<% 
	String sSql = "";
	String sReturn = "";

	String sTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("TableName")); 
	if(sTableName==null) sTableName="";
	String sWhere = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("Where"));
	if(sWhere==null) sWhere="";
	String sAction = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("Action"));
	if(sAction==null) sAction="";
	String sTraceNumber = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("TraceNumber"));
	if(sTraceNumber==null) sTraceNumber="";
	
	//对于不能执行重新上报和暂不上报的记录直接从FEEDBACK表里删除
	if(sTraceNumber!=null && !sTraceNumber.equals("") && sTableName.equals("")){
		Sqlca.executeSQL("delete from ecr_feedback where tracenumber='"+sTraceNumber+"'");
	}else{
		if(sAction.equals("2"))//重新上报
		{
			sSql = "Update "+sTableName+" Set SessionID='1111111111' where 1=1 "+sWhere;
		}else if(sAction.equals("3"))//暂不上报
		{
			sSql = "Update "+sTableName+" Set SessionID='6666666666' where 1=1 "+sWhere;
		}else if(sAction.equals("4"))//反馈补报
		{
			sSql = "Update "+sTableName+" Set SessionID='1111111111',ModFlag='1',TraceNumber='99999999999999999999' "+sWhere;
		}
		try
		{
				if(sAction.equals("2")||sAction.equals("3")||sAction.equals("4"))
				{
					Sqlca.executeSQL(sSql);
				}
				//对于确认修改完成并重新上报或者不重报的记录,从反馈表中删除,保证该记录的后续变化能正常上报
				if(sAction.equals("2")||sAction.equals("3"))
				{
					Sqlca.executeSQL("delete from ecr_feedback where tracenumber='"+sTraceNumber+"'");
				}
				sReturn = "Success";
		}
		catch(Exception e)
		{	
			sReturn = "Failure";
			throw e;
		}
		finally
		{
		}
	}
%>
</body>
</html>
<script language=javascript>
	top.returnValue="<%=sReturn%>";
	top.close();
</script>
<%@ include file="/IncludeEnd.jsp"%>