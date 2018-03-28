<%
/* 
 * Author: jhli 
 * Content: 最高担保额担保解除
 * Input Param:
 *			
 * Output param:
 *
 * History Log:  
 *
 */
%>
<%@ page contentType="text/html; charset=GBK"
    import="com.amarsoft.app.datax.ecr.common.*,java.text.SimpleDateFormat,com.amarsoft.are.ARE"%>
<%@ include file="/IncludeBeginMD.jsp"%>
<%@page import="java.util.Date"%>
<html>
<head> 
<title></title>
</head>
<body>
<%
	String sSql = "",sBusinessType = "";
	String sReturn = "",sGuarantyType = "";
	ASResultSet rs = null;
	String	sMetaTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("MetaTableName")); //操纵的表 
	if(sMetaTableName == null) sMetaTableName = "";	
	String	sDBTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBTableName"));  //进入系统入口表
	if(sDBTableName == null) sDBTableName = "";	
	String	sOccurDate = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("OccurDate"));  //担保合同发生日期
	if(sOccurDate == null) sOccurDate = "";
	String  sOccurDate1 = Tools.getLastDay("1");    //获得当前天的前一天
	String	sKeyName =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyName"));  //获取主键名称
	if(sKeyName == null) sKeyName = "";	
	String	sDBKeyName =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBKeyName")); //获取主业务名称
	if(sDBKeyName == null) sDBKeyName = "";	
	String	sDBKeyValue =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBKeyValue")); //获取主业务值
	if(sDBKeyValue == null) sDBKeyValue = "";	
	String sKeyValue = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyValue"));  //获取主键值
	if(sKeyValue == null) sKeyValue = "";
	String  sMetaTableNameHis = StringFunction.replace(sMetaTableName,"ECR","HIS");
	String  sDBTableNameHis = StringFunction.replace(sDBTableName,"ECR","HIS");
	
	//获取当前时间
	Date date = new Date();
	SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	String sCurrentDate = df.format(date);
	
	//获取主业务类型
	if("ECR_LOANCONTRACT".equals(sDBTableName)){
		sBusinessType="1";
	}else if("ECR_FACTORING".equals(sDBTableName)){
		sBusinessType="2";
	}else if("ECR_FINAINFO".equals(sDBTableName)){
		sBusinessType="3";
	}else if("ECR_CREDITLETTER".equals(sDBTableName)){
		sBusinessType="4";
	}else if("ECR_GUARANTEEBILL".equals(sDBTableName)){
		sBusinessType="5";
	}else{
		sBusinessType="6";
	}
	
	//获取担保类型
	if("ECR_ASSURECONT".equals(sMetaTableName)){
		sGuarantyType="1";
	}else if("ECR_GUARANTYCONT".equals(sMetaTableName)){
		sGuarantyType="2";
	}else{
		sGuarantyType="3";
	}
		
	//对主键名和键值进行对应,设置where子句
	String keyNames[]=sKeyName.split("@");
	String keyValues[]=sKeyValue.split("@");
	String sWhereClause4 = " where 1=1   ";//用于迁移一条ECR_担保到HIS_担保中
	String sWhereClause3 = " where 1=1   ";//用于更新ECR_担保表中所有最高额担保
	String sWhereClause2 = " where 1=1   ";//用于检索HIS_担保表
	String sWhereClause1 = " where 1=1   ";//用于检索his_RelieveGuaranty
	//keyNames[0]主业务合同号
	//keyNames[1]担保合同号
	//keyNames[2]抵质押顺序号或者为保证贷款卡号
	for(int i=0;i<keyNames.length&&i<keyValues.length;i++){
		if(i==0){//主业务数据项名及数值
			sWhereClause4 = sWhereClause4 + " and " +  keyNames[i] + " ='" + keyValues[i] +"'";	
			sWhereClause2 = sWhereClause2 +"and SessionID='0000000000' and "+keyNames[i]+" like 'QBZHT┄%' ";
			sWhereClause1 = sWhereClause1 +"and RelieveType='G' and GuarantyType ='"+sGuarantyType+"' and ContractNo='"
				+keyValues[i]+"' and occurdate='"+sOccurDate+"' ";
		}else if(i==1){//主担保合同数据项名及数值
			sWhereClause4 = sWhereClause4 + " and " +  keyNames[i] + " ='" + keyValues[i] +"'";	
			sWhereClause3 = sWhereClause3 + " and " +  keyNames[i] + " ='" + keyValues[i] +"'";	
			sWhereClause2 = sWhereClause2 +" and "+keyNames[i]+"='"+keyValues[i]+"' ";
			sWhereClause1 = sWhereClause1 +" and GuarantyContNo='"+keyValues[i]+"'";
		}else if((!"ECR_ASSURECONT".equals(sMetaTableName))&&i>1){//抵质押物数据项名及数值
			sWhereClause4 = sWhereClause4 + " and " +  keyNames[i] + " ='" + keyValues[i] +"'";	
			sWhereClause3 = sWhereClause3 + " and " +  keyNames[i] + " ='" + keyValues[i] +"'";	
			sWhereClause2 = sWhereClause2 +" and "+keyNames[i]+"='"+keyValues[i]+"' ";
			sWhereClause1 = sWhereClause1 +" and GuarantySerialNo='"+keyValues[i]+"'";
		}
	}
	
	//I、先查询是否已经发生最高额担保解除
	boolean iShow = false;
	//查看担保是否为保证，保证和抵质押分开处理 ， status 为 "1"时是正常解除，为"2"时是已撤销
	sSql = "select status from his_RelieveGuaranty "+sWhereClause1;
	ARE.getLog().info(sSql);
		rs = Sqlca.getASResultSet(sSql);
		if(rs.next()){
		if("1".equals(rs.getString(1))){  
			iShow =true;
			sReturn = "Failture";   // 已做过最高额担保解除
		}
	}
	rs.close();
	rs=null;
	
	if(!iShow){
		//II、查询担保历史表中是否存在未上报记录
		sSql = "select SessionID from "+sMetaTableNameHis+" "+sWhereClause2;
		ARE.getLog().info(sSql); 
		rs = Sqlca.getASResultSet(sSql);
		if(rs.next()){
			iShow =true;
			sReturn = "Return"; // 存在待上报记录
		}
		rs.close();
		rs = null;
		
		if(!iShow){
			//III、更新数据
			ARE.getLog().info("***************更新数据开始******************");
			try{
				Sqlca.getConnection().setAutoCommit(false);
				// 第一步：从要更新的ECR表中查出要更新的数据，并存入到担保解除表中
				sSql = "select Occurdate,AVAILABSTATUS,INCREMENTFLAG,SESSIONID,ContractNo from "+sMetaTableName+" "+sWhereClause3+""; 
				ARE.getLog().info(sSql);
				rs = Sqlca.getASResultSet(sSql);			
				while(rs.next()){
					sSql = "insert into his_RelieveGuaranty(RelieveType,OccurDate,ContractNo,BusinessType,GuarantyType," +
							"Status,GuarantyContNo,GuarantySerialNo,OldOccurDate,AvailabStatus,IncrementFlag,SessionID," +
							"updateDate,insertDate) values('G','"+sOccurDate1+"','"
							+rs.getString(5)+"','"+sBusinessType+"','"+sGuarantyType+"','1','"
							+keyValues[1]+"','"+keyValues[2]+"','"+rs.getString(1)+"','"+rs.getString(2)+"','"
							+rs.getString(3)+"','"+rs.getString(4)+"','','"+sCurrentDate+"')";
					ARE.getLog().info(sSql);
					Sqlca.executeSQL(sSql);	 
				}
				rs.close();
				rs = null;
				
				//第二步： 更新担保合同
				sSql = "update "+sMetaTableName+" set  OccurDate ='"+sOccurDate1+"'"+","+" INCREMENTFLAG='8' , " +
						"AVAILABSTATUS='2' , SESSIONID='0000000000' "+sWhereClause3; 
				ARE.getLog().info(sSql);
				Sqlca.executeSQL(sSql);
				
				ARE.getLog().info("***************数据迁移******************");
				
				// 第三步：在历史表中插入更新的担保合同
				sSql = "insert into "+sMetaTableNameHis+" select * from "+sMetaTableName+""+sWhereClause4+"";
				ARE.getLog().info(sSql);
				Sqlca.executeSQL(sSql);
				
				// 第四步：在更改历史表中的信息
				sSql = "update "+sMetaTableNameHis+" set ContractNo='QBZHT┄"+keyValues[0]+"' ,INCREMENTFLAG='2' "+sWhereClause4+"";
				ARE.getLog().info(sSql);
				Sqlca.executeSQL(sSql);
				
				Sqlca.getConnection().commit();
				ARE.getLog().info("***************最高额担保合同担保解除结束******************");
				sReturn = "Success";
			}catch(Exception e){
				Sqlca.getConnection().rollback();
				ARE.getLog().error("最高担保额解除失败!  "+sSql,e);
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