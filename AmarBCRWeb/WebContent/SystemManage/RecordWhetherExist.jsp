<%
/* 
 *
 * Content:   
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
	
	String sTableName = DataConvert.toRealString(iPostChange,(String)request.getParameter("TableName"));
	String sKeyName = DataConvert.toRealString(iPostChange,(String)request.getParameter("KeyName"));
	String sKeyValue =  DataConvert.toRealString(iPostChange,(String)request.getParameter("KeyValue"));
	
	String[] stName =  sKeyName.split("@");
	String[] stValue = sKeyValue.split("@");
	String sWhereClause = " where 1=1 ";
	
	for(int i=0;i<stName.length;i++){
		sWhereClause = sWhereClause + " and " + stName[i] + "='" + stValue[i] +"'";
	}
	
	//先查询是否在表里已经存在该记录
	sSql = "select 1 from " + sTableName + sWhereClause;
	ASResultSet rs = Sqlca.getASResultSet(sSql);
	
	if(!rs.next()){
	//返回结果
		sReturn = "UnExist";
	}else{
		sReturn = "Exist";
	}
	if(rs!=null) {
		rs.close();
	}
%>
</body>
</html>
<script language=javascript>
	self.returnValue="<%=sReturn%>";
	self.close();
</script>
<%@ include file="/IncludeEnd.jsp"%>