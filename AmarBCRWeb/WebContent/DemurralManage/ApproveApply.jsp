<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBeginMD.jsp"%>

<script language="javascript">
<% 
	String	sSerialno = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("Serialno"));
	String	sFlag = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("Flag"));

 %>
<% 
    String sql = "";    
	if(sFlag.equals("2")||sFlag.equals("3")){
		String	sNow = StringFunction.getToday()+" "+StringFunction.getNow();
		sql ="update DEMURRAL set FLAG='"+sFlag+"' , OPERATOR='"+CurUser.getUserID()+"' ,OPERATEORG='"+CurUser.getOrgID()+"' , OPERATETIME='"+sNow+"' where SERIALNO='"+sSerialno+"'";
	}else{
		sql ="update DEMURRAL set FLAG='"+sFlag+"' where SERIALNO='"+sSerialno+"'";
	}
	Sqlca.executeSQL(sql);
%>
</script>
<script language=javascript>
	top.returnValue = "ok";
	top.close();
</script>
<%@ include file="/IncludeEnd.jsp"%>