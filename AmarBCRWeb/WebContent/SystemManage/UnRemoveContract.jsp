<%
/* 
 * Author: jhli
 * Content: 撤销主业务担保解除
 * Input Param:
 *			
 * Output param:
 *
 * History Log:  
 *
 */
%>
<%@ page contentType="text/html; charset=GBK"
    import="com.amarsoft.app.datax.ecr.common.*,java.text.SimpleDateFormat,com.amarsoft.are.log.Log"%>
<%@ include file="/IncludeBeginMD.jsp"%>

<%@page import="java.util.Date"%><html>
<head> 
<title></title>
</head>
<body>
<%!
public void removeContract(Transaction Sqlca,String sOccurDate,String sDBKeyValue,String sGuarantyType,String sBusinessType)throws Exception{
	Log logger=ARE.getLog();//使用ARE日志
	
	//1、获取解除前担保备份记录
	String sSql = "select OldOccurDate,AvailabStatus,IncrementFlag,GuarantyContNo,GuarantySerialNo from his_RelieveGuaranty "
		+"where RelieveType='B' and GuarantyType='"+sGuarantyType+"' and Occurdate = '"
		+sOccurDate+"' and ContractNo='"+sDBKeyValue+"' and Status='1' and BusinessType='"+sBusinessType+"'";
	
	logger.info(sSql);
	ASResultSet rs = Sqlca.getASResultSet(sSql);
	String sUpdateSql = "";
	
	if(sGuarantyType.equals("1")){//保证
		sUpdateSql = "update ECR_ASSURECONT set Occurdate = ?, AvailabStatus = ?,INCREMENTFLAG = ? where Occurdate = '"
			+sOccurDate+"' and ContractNo='"+sDBKeyValue+"' and AssureContNo= ? and BusinessType='"+sBusinessType+"'";
	}else if(sGuarantyType.equals("2")){//抵押
		sUpdateSql = "update ECR_GUARANTYCONT set Occurdate = ?, AvailabStatus = ?,INCREMENTFLAG = ? where Occurdate = '"
			+sOccurDate+"' and ContractNo='"+sDBKeyValue+"' and GuarantyContNo= ? and GuarantySerialNo= ? and BusinessType='"+sBusinessType+"'";
	}else{//质押
		sUpdateSql = "update ECR_IMPAWNCONT set Occurdate = ?, AvailabStatus = ?,INCREMENTFLAG = ? where Occurdate = '"
			+sOccurDate+"' and ContractNo='"+sDBKeyValue+"' and ImpawnContNo= ? and ImpawSerialNo= ? and BusinessType='"+sBusinessType+"'";
	}
	//2、更新担保ECR_表状态
	PreparedStatement PS_UpdateSql = Sqlca.getConnection().prepareStatement(sUpdateSql);
	while(rs.next()){
		PS_UpdateSql.setString(1,rs.getString(1));
		PS_UpdateSql.setString(2,rs.getString(2));
		PS_UpdateSql.setString(3,rs.getString(3));
		PS_UpdateSql.setString(4,rs.getString(4));
		if(!sGuarantyType.equals("1")){
			PS_UpdateSql.setString(5,rs.getString(5));
		}
		PS_UpdateSql.addBatch();
	}
	PS_UpdateSql.executeBatch();
	PS_UpdateSql.clearBatch();
	rs.close();
	PS_UpdateSql.close();
	PS_UpdateSql = null;
	
	//3、更新his_RelieveGuaranty状态
	//获取当前时间
	Date date = new Date();
	SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	String sCurrentDate = df.format(date);
	sSql = "update his_RelieveGuaranty set Status= '2',updateDate='"+sCurrentDate+"' where RelieveType='B' "
		+"and GuarantyType='"+sGuarantyType+"' and Occurdate = '"+sOccurDate+"' and ContractNo='"+sDBKeyValue+"' and BusinessType='"+sBusinessType+"'";
	logger.info(sSql);
	Sqlca.executeSQL(sSql);
}
%>
<% 
	String sSql = "",sUpdateSql = "",sBusinessType = "";
	Log logger=ARE.getLog();//使用ARE日志
	String sReturn = "";
	String	sTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("TableName"));
	if(sTableName == null) sTableName = "";	
	String	sOccurDate =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("OccurDate"));
	if(sOccurDate == null) sOccurDate = "";
	String	sDBKeyName =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBKeyName"));
	if(sDBKeyName == null) sDBKeyName = "";	
	String	sDBKeyValue =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBKeyValue"));
	if(sDBKeyValue == null) sDBKeyValue = "";	
	String  sTableNameHis = StringFunction.replace(sTableName,"ECR","HIS");
	
	if("ECR_LOANCONTRACT".equalsIgnoreCase(sTableName)){
		sBusinessType="1";
	}else if("ECR_FACTORING".equalsIgnoreCase(sTableName)){
		sBusinessType="2";
	}else if("ECR_FINAINFO".equalsIgnoreCase(sTableName)){
		sBusinessType="3";
	}else if("ECR_CREDITLETTER".equalsIgnoreCase(sTableName)){
		sBusinessType="4";
	}else if("ECR_GUARANTEEBILL".equalsIgnoreCase(sTableName)){
		sBusinessType="5";
	}else{
		sBusinessType="6";
	}

	//I、查询主业务历史表中是否存在可撤销状态，若存在则执行撤销担保解除，否则返回提示信息
	boolean iShow = false;
	sSql = "select status from his_RelieveBusiness where RelieveType='B' "+
	" and ContractNo = '"+sDBKeyValue+"' and occurdate='"+sOccurDate+"' and businesstype='"+sBusinessType+"'" ;
	logger.info(sSql);
	ASResultSet rs = Sqlca.getASResultSet(sSql);
	if(rs.next()){
		if("2".equals(rs.getString(1))) {//存在已经撤销的状态
			iShow = true;
			sReturn = "Failture2";
		}else{//存在可供撤销的状态
			iShow = false;
		}
	}else {//不存在任何记录
		iShow = true;
		sReturn = "Failture1";
	}
	rs.close();
	rs=null;
 
	if(!iShow){
		//II、查询主业务历史表中是否存在未上报记录，存在则继续撤销，否则返回提示信息
		sSql = "select SessionID from "+sTableNameHis+" where SessionID='0000000000' and "+sDBKeyName+"='"+sDBKeyValue+"'";
		logger.info(sSql);
		rs = Sqlca.getASResultSet(sSql);
		if(rs.next())
			iShow =false;
		else{
			iShow =true;
			sReturn = "Return";
		}
		rs.close();
        rs=null;	  
        	    
		if(!iShow){
			//III、若1-2步骤均通过则进行撤销担保解除操作
			logger.info("***************撤销数据开始******************");
			//1、删除主业务历史表
			try{
			Sqlca.getConnection().setAutoCommit(false); 
			sSql = "delete from "+sTableNameHis+" where "+sDBKeyName+"='"+sDBKeyValue+"' and SessionID='0000000000'";
			logger.info(sSql);
			Sqlca.executeSQL(sSql);
		
			//2、恢复主业务ECR表数据
			PreparedStatement PS_UpdateSql = null;
			sSql = "select OldOccurDate,IncrementFlag,SessionID,GuarantyFlag from his_RelieveBusiness "
			+"where RelieveType='B' and Occurdate = '"+sOccurDate+"' and ContractNo='"+sDBKeyValue+"' and status='1' and businesstype='"+sBusinessType+"'" ;
			logger.info(sSql);
			rs = Sqlca.getASResultSet(sSql);

			if(rs.next()){
				sUpdateSql = "update "+sTableName+" set OccurDate = '"+rs.getString(1)+"' ,IncrementFlag = '"
				+rs.getString(2)+"' ,SessionID = '"+rs.getString(3)+"', GuarantyFlag = '"+rs.getString(4)+"' "
				+"where  "+sDBKeyName+"='"+sDBKeyValue+"'";
				logger.info(sUpdateSql);
				Sqlca.executeSQL(sUpdateSql);
			}
			rs.close();
			rs=null;
	
			//3、遍历恢复担保信息
	        for(int i=1 ;i<=3;i++)
	        	removeContract( Sqlca, sOccurDate, sDBKeyValue, String.valueOf(i),sBusinessType);
			
	        //4、更新主业务担保解除表
	        //获取当前时间
			Date date = new Date();
			SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			sSql = "update his_RelieveBusiness set Status= '2',updateDate='"+df.format(date)+"' where "
				+"RelieveType='B' and Occurdate = '"+sOccurDate+"' and ContractNo='"+sDBKeyValue+"' and Status='1' and businesstype='"+sBusinessType+"'" ;
			logger.info(sSql);
			Sqlca.executeSQL(sSql);
			logger.info("***************主业务合同撤销担保解除结束******************");
		    sReturn = "Success";
		    Sqlca.getConnection().commit();
			}catch(Exception e){
				Sqlca.getConnection().rollback();
				ARE.getLog().error("担保撤销失败!"+sSql,e);
				sReturn="False";
			}finally{
				Sqlca.getConnection().setAutoCommit(true);
			}
        }
	}
%>

</body>
</html>
<script language=javascript>
    self.returnValue="<%=sReturn%>";
	self.close();
</script>
<%@ include file="/IncludeEnd.jsp"%>