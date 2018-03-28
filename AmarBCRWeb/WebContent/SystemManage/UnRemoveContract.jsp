<%
/* 
 * Author: jhli
 * Content: ������ҵ�񵣱����
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
	Log logger=ARE.getLog();//ʹ��ARE��־
	
	//1����ȡ���ǰ�������ݼ�¼
	String sSql = "select OldOccurDate,AvailabStatus,IncrementFlag,GuarantyContNo,GuarantySerialNo from his_RelieveGuaranty "
		+"where RelieveType='B' and GuarantyType='"+sGuarantyType+"' and Occurdate = '"
		+sOccurDate+"' and ContractNo='"+sDBKeyValue+"' and Status='1' and BusinessType='"+sBusinessType+"'";
	
	logger.info(sSql);
	ASResultSet rs = Sqlca.getASResultSet(sSql);
	String sUpdateSql = "";
	
	if(sGuarantyType.equals("1")){//��֤
		sUpdateSql = "update ECR_ASSURECONT set Occurdate = ?, AvailabStatus = ?,INCREMENTFLAG = ? where Occurdate = '"
			+sOccurDate+"' and ContractNo='"+sDBKeyValue+"' and AssureContNo= ? and BusinessType='"+sBusinessType+"'";
	}else if(sGuarantyType.equals("2")){//��Ѻ
		sUpdateSql = "update ECR_GUARANTYCONT set Occurdate = ?, AvailabStatus = ?,INCREMENTFLAG = ? where Occurdate = '"
			+sOccurDate+"' and ContractNo='"+sDBKeyValue+"' and GuarantyContNo= ? and GuarantySerialNo= ? and BusinessType='"+sBusinessType+"'";
	}else{//��Ѻ
		sUpdateSql = "update ECR_IMPAWNCONT set Occurdate = ?, AvailabStatus = ?,INCREMENTFLAG = ? where Occurdate = '"
			+sOccurDate+"' and ContractNo='"+sDBKeyValue+"' and ImpawnContNo= ? and ImpawSerialNo= ? and BusinessType='"+sBusinessType+"'";
	}
	//2�����µ���ECR_��״̬
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
	
	//3������his_RelieveGuaranty״̬
	//��ȡ��ǰʱ��
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
	Log logger=ARE.getLog();//ʹ��ARE��־
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

	//I����ѯ��ҵ����ʷ�����Ƿ���ڿɳ���״̬����������ִ�г���������������򷵻���ʾ��Ϣ
	boolean iShow = false;
	sSql = "select status from his_RelieveBusiness where RelieveType='B' "+
	" and ContractNo = '"+sDBKeyValue+"' and occurdate='"+sOccurDate+"' and businesstype='"+sBusinessType+"'" ;
	logger.info(sSql);
	ASResultSet rs = Sqlca.getASResultSet(sSql);
	if(rs.next()){
		if("2".equals(rs.getString(1))) {//�����Ѿ�������״̬
			iShow = true;
			sReturn = "Failture2";
		}else{//���ڿɹ�������״̬
			iShow = false;
		}
	}else {//�������κμ�¼
		iShow = true;
		sReturn = "Failture1";
	}
	rs.close();
	rs=null;
 
	if(!iShow){
		//II����ѯ��ҵ����ʷ�����Ƿ����δ�ϱ���¼��������������������򷵻���ʾ��Ϣ
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
			//III����1-2�����ͨ������г��������������
			logger.info("***************�������ݿ�ʼ******************");
			//1��ɾ����ҵ����ʷ��
			try{
			Sqlca.getConnection().setAutoCommit(false); 
			sSql = "delete from "+sTableNameHis+" where "+sDBKeyName+"='"+sDBKeyValue+"' and SessionID='0000000000'";
			logger.info(sSql);
			Sqlca.executeSQL(sSql);
		
			//2���ָ���ҵ��ECR������
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
	
			//3�������ָ�������Ϣ
	        for(int i=1 ;i<=3;i++)
	        	removeContract( Sqlca, sOccurDate, sDBKeyValue, String.valueOf(i),sBusinessType);
			
	        //4��������ҵ�񵣱������
	        //��ȡ��ǰʱ��
			Date date = new Date();
			SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			sSql = "update his_RelieveBusiness set Status= '2',updateDate='"+df.format(date)+"' where "
				+"RelieveType='B' and Occurdate = '"+sOccurDate+"' and ContractNo='"+sDBKeyValue+"' and Status='1' and businesstype='"+sBusinessType+"'" ;
			logger.info(sSql);
			Sqlca.executeSQL(sSql);
			logger.info("***************��ҵ���ͬ���������������******************");
		    sReturn = "Success";
		    Sqlca.getConnection().commit();
			}catch(Exception e){
				Sqlca.getConnection().rollback();
				ARE.getLog().error("��������ʧ��!"+sSql,e);
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