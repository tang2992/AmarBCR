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
<title>��ѯ������Ϣ��Ӧ����ҵ����Ϣ</title>
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
	
	//���ڲ���ִ�������ϱ����ݲ��ϱ��ļ�¼ֱ�Ӵ�FEEDBACK����ɾ��
	if(sTraceNumber!=null && !sTraceNumber.equals("") && sTableName.equals("")){
		Sqlca.executeSQL("delete from ecr_feedback where tracenumber='"+sTraceNumber+"'");
	}else{
		if(sAction.equals("2"))//�����ϱ�
		{
			sSql = "Update "+sTableName+" Set SessionID='1111111111' where 1=1 "+sWhere;
		}else if(sAction.equals("3"))//�ݲ��ϱ�
		{
			sSql = "Update "+sTableName+" Set SessionID='6666666666' where 1=1 "+sWhere;
		}else if(sAction.equals("4"))//��������
		{
			sSql = "Update "+sTableName+" Set SessionID='1111111111',ModFlag='1',TraceNumber='99999999999999999999' "+sWhere;
		}
		try
		{
				if(sAction.equals("2")||sAction.equals("3")||sAction.equals("4"))
				{
					Sqlca.executeSQL(sSql);
				}
				//����ȷ���޸���ɲ������ϱ����߲��ر��ļ�¼,�ӷ�������ɾ��,��֤�ü�¼�ĺ����仯�������ϱ�
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