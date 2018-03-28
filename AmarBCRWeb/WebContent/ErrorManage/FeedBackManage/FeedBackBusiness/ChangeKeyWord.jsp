<%@ include file="/IncludeBegin.jsp"%>
<%
	String sSQL = "",sReturnValue="true";
	ASResultSet rs= null;	
	//设置更新主键名
	String sNEWName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("NEWName"));
	if(sNEWName == null) sNEWName = "";
	//设置更新主键值
	String NEWValue = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("NEWValue"));
	if(NEWValue == null) NEWValue = "";
	//设置查询的数据库
	String sDBTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBTableName"));
	if(sDBTableName == null) sDBTableName = "";
	//设置原所有主键名
	String sKeyName =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyName"));
	if(sKeyName == null) sKeyName = "";
	//设置原所有主键值
	String sKeyValue =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyValue"));
	if(sKeyValue == null) sKeyValue = "";
	
	String[] sName = sKeyName.split("@");
	String[] sValue = sKeyValue.split("@");
	String newWhereClause = " where 1=1 ";
	String oldWhereClause = " where 1=1 ";
	
	//对原主键值进行更新
	for(int i=0;i<sName.length;i++){	
		if(sNEWName.equals(sName[i])) {
			if(sName[i].equalsIgnoreCase("RETURNTIMES")||sName[i].equalsIgnoreCase("EXTENSIONTIMES")) 
			{
				newWhereClause = newWhereClause + " and " +  sName[i] + "=" +  NEWValue;
				oldWhereClause = oldWhereClause +  " and " + sName[i] + "=" + sValue[i] ;
			}else{
				newWhereClause = newWhereClause +  " and " + sName[i] + "='" + NEWValue +"'";
				oldWhereClause = oldWhereClause +  " and " + sName[i] + "='" + sValue[i] +"'";
			}
		}else {
			if(sName[i].equalsIgnoreCase("RETURNTIMES")||sName[i].equalsIgnoreCase("EXTENSIONTIMES")) 
			{
				newWhereClause = newWhereClause + " and " +  sName[i] + "=" +  sValue[i];
				oldWhereClause = oldWhereClause +  " and " + sName[i] + "=" + sValue[i];
			}else{
				newWhereClause = newWhereClause +  " and " + sName[i] + "='" + sValue[i] +"'";
			    oldWhereClause = oldWhereClause +  " and " + sName[i] + "='" + sValue[i] +"'";
			}
		}
	}
	//判断是否发生主键冲突
	sSQL = "SELECT COUNT(*) FROM " + sDBTableName + newWhereClause;
	//System.out.println("*************"+sSQL);
	rs = Sqlca.getASResultSet(sSQL);
	
	if(rs.next()){
		if(rs.getInt(1)>0){
			sReturnValue = "false";
		}else{
			if(sKeyName.indexOf("RETURNTIMES")>0){
				//在还款信息中修改发生日期需分2种情况处理：更改的主键是还款次数，更改的主键是发生日期
				if(sNEWName.equals("OCCURDATE")){
					//sWhereClause = StringFunction.replace(sWhereClause," and " + sNEWName + "='" + NEWValue +"'","");
					sSQL = "update " + sDBTableName + " set " + sNEWName + "='"+NEWValue+"'" + oldWhereClause;
				}else{
					//sWhereClause = StringFunction.replace(sWhereClause," and " + sNEWName + "=" +  NEWValue,"");
					sSQL = "update " + sDBTableName + " set " + sNEWName + "=" + NEWValue + oldWhereClause;
				}
			}
			else{
				//sWhereClause = StringFunction.replace(sWhereClause," and " + sNEWName + "='" + NEWValue +"'","");
				sSQL = "update " + sDBTableName + " set " + sNEWName + "='"+NEWValue+"'" + oldWhereClause;
			}
			SqlcaRepository.executeSQL(sSQL);
			//SqlcaRepository.conn.commit();
			//存储到session中
			session.setAttribute(sNEWName,NEWValue);
		}
	}
	rs.getStatement().close();
%>
<script type="text/javascript">
	top.returnValue = "<%=sReturnValue%>";
	top.close();
</script>
<%@ include file="/IncludeEnd.jsp"%>