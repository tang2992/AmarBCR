<%
/* 
 * Author: jhli
 * Content: 主业务担保解除
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

	Log logger=ARE.getLog();//使用ARE日志
	logger.info(sSql1);
	//1、获取与修改担保信息
	ASResultSet rs = Sqlca.getASResultSet(new SqlObject(sSql1));
	String sInsertSql = "";
	
	//2、备份必要担保信息到his_RelieveGuaranty表
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
	
	//3、更新担保信息
	logger.info(sSql2);
	Sqlca.executeSQL(new SqlObject(sSql2)); 
}%>

<% 
	String sSql = "",sInsertSql = "",sBusinessType = "";
	String sReturn = "";
    Log logger=ARE.getLog();//使用ARE日志
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
		//获取当前时间
	Date date = new Date();
	SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	String sCurrentDate = df.format(date);
	
	//设置主业务类型
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
	//I、查询主业务担保解除记录表中存在解除状态，则不执行担保解除，否则继续执行
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
		//II、检查主业务历史表中是否存在未上报记录，若存在则不执行担保解除，否则继续执行
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
			//III、若1-2步骤均通过则进行担保解除
			logger.info("***************更新和备份数据开始******************");
			try{
				Sqlca.getConnection().setAutoCommit(false); //启用事物
				
				//1、获取更新信息，并将更新前必要信息存于his_RelieveBusiness表
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
				
				//2、更新主业务合同
				sSql = "update "+sTableName+" Set Occurdate ='"+sOccurDate1+"', INCREMENTFLAG='8', "
				 	+"SESSIONID='0000000000', GUARANTYFLAG='2' where "+sKeyName+"='"+sKeyValue+"'";
				logger.info(sSql);
		        Sqlca.executeSQL(sSql);
				
				
				//3、遍历更新担保信息
				for(int i=1;i<=3;i++)
					fillMessage(Sqlca,sOccurDate1,sContractNo,sBusinessType,sCurrentDate, i);
				
				logger.info("***************更新和备份数据结束******************");
					
				//4、迁移主业务到HIS表，并更新HIS表该该业务，必要状态
				logger.info("***************数据迁移开始******************");
				sSql = "insert into "+sTableNameHis+" select * from "+sTableName+" where "+sKeyName+"='"+sKeyValue+"'";
				logger.info(sSql);
				Sqlca.executeSQL(sSql);
				
				sSql = "update "+sTableNameHis+" set INCREMENTFLAG='2' where SessionID='0000000000' and "
				+sKeyName+"='"+sKeyValue+"'";
				logger.info(sSql);
				Sqlca.executeSQL(sSql);
				logger.info("***************数据迁移结束******************");
				logger.info("***************主业务合同担保解除结束******************");
				sReturn = "Success";
				Sqlca.getConnection().commit();
			}catch(Exception e){
				Sqlca.getConnection().rollback();
				ARE.getLog().error("担保解除失败! "+sSql,e);
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