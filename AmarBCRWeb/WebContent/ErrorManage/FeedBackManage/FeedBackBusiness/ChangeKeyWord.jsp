<%@ include file="/IncludeBegin.jsp"%>
<%
	String sSQL = "",sReturnValue="true";
	ASResultSet rs= null;	
	//���ø���������
	String sNEWName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("NEWName"));
	if(sNEWName == null) sNEWName = "";
	//���ø�������ֵ
	String NEWValue = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("NEWValue"));
	if(NEWValue == null) NEWValue = "";
	//���ò�ѯ�����ݿ�
	String sDBTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBTableName"));
	if(sDBTableName == null) sDBTableName = "";
	//����ԭ����������
	String sKeyName =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyName"));
	if(sKeyName == null) sKeyName = "";
	//����ԭ��������ֵ
	String sKeyValue =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyValue"));
	if(sKeyValue == null) sKeyValue = "";
	
	String[] sName = sKeyName.split("@");
	String[] sValue = sKeyValue.split("@");
	String newWhereClause = " where 1=1 ";
	String oldWhereClause = " where 1=1 ";
	
	//��ԭ����ֵ���и���
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
	//�ж��Ƿ���������ͻ
	sSQL = "SELECT COUNT(*) FROM " + sDBTableName + newWhereClause;
	//System.out.println("*************"+sSQL);
	rs = Sqlca.getASResultSet(sSQL);
	
	if(rs.next()){
		if(rs.getInt(1)>0){
			sReturnValue = "false";
		}else{
			if(sKeyName.indexOf("RETURNTIMES")>0){
				//�ڻ�����Ϣ���޸ķ����������2������������ĵ������ǻ�����������ĵ������Ƿ�������
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
			//�洢��session��
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