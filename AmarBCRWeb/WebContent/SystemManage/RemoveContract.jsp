<%
/* 
 * Author: jhli
 * Content: ��ҵ�񵣱����
 * Input Param:
 *			
 * Output param:
 *
 * History Log:  
 *
 */
%>
<%@page contentType="text/html; charset=GBK"
    import="com.amarsoft.app.datax.ecr.common.*,java.text.SimpleDateFormat,com.amarsoft.are.log.Log"%>
<%@include file="/IncludeBeginMD.jsp"%>

<%@page import="java.util.Date"%><html>
<head> 
<title></title>
</head>
<body>

<%!
public void fillMessage(Transaction Sqlca,String sOccurDate1,
		String sContractNo,String sBusinessType,String sCurrentDate,int guarantyType)throws Exception{
	String sSql1="";
	String sSql2="";
	if(guarantyType==1){
		sSql1 = "select AssureContNo,Aloancardno,Occurdate,AvailabStatus,INCREMENTFLAG from ECR_ASSURECONT "
					+"where AvailabStatus='1' and ContractNo='"+sContractNo+"' and businesstype='"+sBusinessType+"'" ;
		sSql2 = "update ECR_ASSURECONT set Occurdate ='"+sOccurDate1+"', AvailabStatus='2',INCREMENTFLAG='8' "
		+" where AvailabStatus='1' and ContractNo='"+sContractNo+"' and businesstype='"+sBusinessType+"'" ;
	}else if(guarantyType==2){
		sSql1 = "select GuarantyContNo,GuarantySerialNo,Occurdate,AvailabStatus,INCREMENTFLAG "
		+"from ECR_GUARANTYCONT where AvailabStatus='1' and ContractNo='"+sContractNo+"' and businesstype='"+sBusinessType+"'" ;
		sSql2 = "update ECR_GUARANTYCONT set occurdate ='"+sOccurDate1+"', AvailabStatus='2',INCREMENTFLAG='8'  "
		+"where AvailabStatus='1' and ContractNo='"+sContractNo+"' and businesstype='"+sBusinessType+"'" ;
	}else{
		sSql1 = "select ImpawnContNo,ImpawSerialNo,Occurdate,AvailabStatus,INCREMENTFLAG "
		+"from ECR_IMPAWNCONT where AvailabStatus='1' and ContractNo='"+sContractNo+"' and businesstype='"+sBusinessType+"'" ;
        sSql2 = "update ECR_IMPAWNCONT set occurdate ='"+sOccurDate1+"', AvailabStatus='2',INCREMENTFLAG='8' "
		+" where AvailabStatus='1' and ContractNo='"+sContractNo+"' and businesstype='"+sBusinessType+"'" ;
	}

	Log logger=ARE.getLog();//ʹ��ARE��־
	logger.info(sSql1);
	//1����ȡ���޸ĵ�����Ϣ
	ASResultSet rs = Sqlca.getASResultSet(new SqlObject(sSql1));
	String sInsertSql = "";
	
	//2�����ݱ�Ҫ������Ϣ��his_RelieveGuaranty��
	while(rs.next()){
		String guarantySerialNo="";
		if(guarantyType==1){
			guarantySerialNo=rs.getString(1);
		}else{
			guarantySerialNo=rs.getString(2);
		}
		sInsertSql = "insert into his_RelieveGuaranty(RelieveType,OccurDate,ContractNo,BusinessType,GuarantyType,Status,"
			+"GuarantyContNo,GuarantySerialNo,OldOccurDate,AvailabStatus,IncrementFlag,SessionID,updateDate,insertDate)"
			+"values('B','"+sOccurDate1+"','"+sContractNo+"','"+sBusinessType+"','"+guarantyType
			+"','1','"+rs.getString(1)+"','"+guarantySerialNo+"','"+rs.getString(3)+"','"
			+rs.getString(4)+"','"+rs.getString(5)+"',null,null,'"+sCurrentDate+"')";
		Sqlca.executeSQL(sInsertSql);
	}
	rs.close();
	rs=null;
	
	//3�����µ�����Ϣ
	logger.info(sSql2);
	Sqlca.executeSQL(new SqlObject(sSql2)); 
}%>

<% 
	String sSql = "",sInsertSql = "",sBusinessType = "";
	String sReturn = "";
    Log logger=ARE.getLog();//ʹ��ARE��־
	String	sTableName = CurPage.getParameter("TableName"); 
	if(sTableName == null) sTableName = "";
	String	sOccurDate = CurPage.getParameter("OccurDate"); 
	if(sOccurDate == null) sOccurDate = "";
	String sOccurDate1 = Tools.getLastDay("1");
	String	sKeyName =  CurPage.getParameter("KeyName");
	if(sKeyName == null) sKeyName = "";
	String	sContractNo =  CurPage.getParameter("ContractNo");
	if(sContractNo == null) sContractNo = "";
	String	sKeyValue =  CurPage.getParameter("KeyValue");
	if(sKeyValue == null) sKeyValue = "";
	String  sTableNameHis = StringFunction.replace(sTableName,"ECR","HIS");
		//��ȡ��ǰʱ��
	Date date = new Date();
	SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	String sCurrentDate = df.format(date);
	
	//������ҵ������
	if("ECR_LOANCONTRACT".equalsIgnoreCase(sTableName)){
		sBusinessType="1";
	}else if("ECR_FACTORING".equalsIgnoreCase(sTableName)){
		sBusinessType="2";
	}else if("ECR_FINAINFO".equalsIgnoreCase(sTableName)){
		sBusinessType="4";
	}else if("ECR_CREDITLETTER".equalsIgnoreCase(sTableName)){
		sBusinessType="5";
	}else if("ECR_GUARANTEEBILL".equalsIgnoreCase(sTableName)){
		sBusinessType="6";
	}else{
		sBusinessType="7";
	}
	//I����ѯ��ҵ�񵣱������¼���д��ڽ��״̬����ִ�е���������������ִ��
	boolean iShow = false;
	sSql = "select status from his_RelieveBusiness "+
	"where RelieveType='B' and ContractNo = '"+sKeyValue+"' and Occurdate ='"+sOccurDate+"' and STATUS ='1' and businesstype='"+sBusinessType+"'" ;
	logger.info(sSql);
	ASResultSet rs = Sqlca.getASResultSet(sSql);
	if(rs.next()){
		iShow = true;	
		sReturn = "Failture";
	}
	rs.close();
	rs=null;
 
	if(!iShow) {
		//II�������ҵ����ʷ�����Ƿ����δ�ϱ���¼����������ִ�е���������������ִ��
		sSql = "select SessionID from "+sTableNameHis+" where "+sKeyName+"='"+sKeyValue+"' and SessionID='0000000000' ";
		logger.info(sSql);
		rs = Sqlca.getASResultSet(sSql);
		if(rs.next()){
			iShow =true;
			sReturn = "Return";
		}
		rs.close();
		rs=null;
		
		if(!iShow){
			//III����1-2�����ͨ������е������
			logger.info("***************���ºͱ������ݿ�ʼ******************");
			try{
				Sqlca.getConnection().setAutoCommit(false); //��������
				
				//1����ȡ������Ϣ����������ǰ��Ҫ��Ϣ����his_RelieveBusiness��
				sSql = "select Occurdate,INCREMENTFLAG,SESSIONID,GUARANTYFLAG from "+sTableName+" where "+sKeyName+"='"+sKeyValue+"'";
				logger.info(sSql);
				rs = Sqlca.getASResultSet(sSql);
				if(rs.next()){
					sInsertSql = "insert into his_RelieveBusiness(RelieveType,OccurDate,ContractNo,BusinessType,"+
					"Status,OldOccurDate,IncrementFlag,SessionID,GuarantyFlag,updateDate,insertDate) "
					+"values('B','"+sOccurDate1+"','"+sContractNo+"','"+sBusinessType+"','1','"+rs.getString(1)
					+"','"+rs.getString(2)+"','"+rs.getString(3)+"','"+rs.getString(4)+"',null,'"+sCurrentDate+"')";
					logger.info(sInsertSql);
					Sqlca.executeSQL(sInsertSql);
				}
				rs.close();
				rs=null;
				
				//2��������ҵ���ͬ
				sSql = "update "+sTableName+" Set Occurdate ='"+sOccurDate1+"', INCREMENTFLAG='8', "
				 	+"SESSIONID='0000000000', GUARANTYFLAG='2' where "+sKeyName+"='"+sKeyValue+"'";
				logger.info(sSql);
		        Sqlca.executeSQL(sSql);
				
				
				//3���������µ�����Ϣ
				for(int i=1;i<=3;i++)
					fillMessage(Sqlca,sOccurDate1,sContractNo,sBusinessType,sCurrentDate, i);
				
				logger.info("***************���ºͱ������ݽ���******************");
					
				//4��Ǩ����ҵ��HIS��������HIS��ø�ҵ�񣬱�Ҫ״̬
				logger.info("***************����Ǩ�ƿ�ʼ******************");
				sSql = "insert into "+sTableNameHis+" select * from "+sTableName+" where "+sKeyName+"='"+sKeyValue+"'";
				logger.info(sSql);
				Sqlca.executeSQL(sSql);
				
				sSql = "update "+sTableNameHis+" set INCREMENTFLAG='2' where SessionID='0000000000' and "
				+sKeyName+"='"+sKeyValue+"'";
				logger.info(sSql);
				Sqlca.executeSQL(sSql);
				logger.info("***************����Ǩ�ƽ���******************");
				logger.info("***************��ҵ���ͬ�����������******************");
				sReturn = "Success";
				Sqlca.getConnection().commit();
			}catch(Exception e){
				Sqlca.getConnection().rollback();
				ARE.getLog().error("�������ʧ��! "+sSql,e);
				sReturn = "False";
			}finally{
				Sqlca.getConnection().setAutoCommit(true);
			}
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