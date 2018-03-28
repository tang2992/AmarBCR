<%
/* 
 * Author: jhli 
 * Content:  撤销最高担保额解除
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
<%@page import="java.util.Date"%><html>
<head> 
<title></title>
</head>
<body>
<%
	String sSql = "",sBusinessType = "";
	String sReturn = "",sGuarantyType = "";
	ASResultSet rs = null;
	String	sMetaTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("MetaTableName")); //担保合同表 
	if(sMetaTableName == null) sMetaTableName = "";	
	String	sDBTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBTableName")); //进入系统入口表
	if(sDBTableName == null) sDBTableName = "";	
	String	sOccurDate = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("OccurDate")); //担保合同发生日期
	if(sOccurDate == null) sOccurDate = "";
	String  sOccurDate1 = Tools.getLastDay("1");   //获得当前天的前一天
	String	sKeyName =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyName")); //获取主键名称
	if(sKeyName == null) sKeyName = "";	
	String	sDBKeyName =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBKeyName"));  //获取主业务名称
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
	
	//对主键名和键值进行对应,设置where子句
	String keyNames[]=sKeyName.split("@");
	String keyValues[]=sKeyValue.split("@");
	String sWhereClause4 = " where 1=1   ";//用于更新每条ECR_担保表
	String sWhereClause3 = " where 1=1   ";//用于从his_RelieveGuaranty中获取所有欲更新的担保记录
	String sWhereClause2 = " where 1=1   ";//用于检索HIS_担保表
	String sWhereClause1 = " where 1=1   ";//用于检索his_RelieveGuaranty
	
	//获取担保类型
	if("ECR_ASSURECONT".equals(sMetaTableName)){
		sGuarantyType="1";
	}else if("ECR_GUARANTYCONT".equals(sMetaTableName)){
		sGuarantyType="2";
	}else{
		sGuarantyType="3";
	}
	//keyNames[0]主业务合同号
	//keyNames[1]担保合同号
	//keyNames[2]抵质押顺序号或者为保证贷款卡号
	for(int i=0;i<keyNames.length&&i<keyValues.length;i++){
		if(i==0){//主业务数据项名及数值
			sWhereClause3 = sWhereClause3 + " and RelieveType='G' and Occurdate = '"+sOccurDate+"' and status='1'";
			sWhereClause2 = sWhereClause2 +"and SessionID='0000000000' and "+keyNames[i]+" like 'QBZHT┄%' ";
			sWhereClause1 = sWhereClause1 +"and RelieveType='G' and GuarantyType ='"+sGuarantyType+"' and ContractNo='"
				+keyValues[i]+"' and occurdate='"+sOccurDate+"' ";
		}else if(i==1){//主担保合同数据项名及数值
			sWhereClause4 = sWhereClause4 + " and " +  keyNames[i] + " ='" + keyValues[i] +"'";	
			sWhereClause3 = sWhereClause3 + " and GuarantyContNo ='" + keyValues[i] +"'";	
			sWhereClause2 = sWhereClause2 +" and "+keyNames[i]+"='"+keyValues[i]+"' ";
			sWhereClause1 = sWhereClause1 +" and GuarantyContNo='"+keyValues[i]+"'";
		}else if((!"ECR_ASSURECONT".equals(sMetaTableName))&&i>1){//抵质押物数据项名及数值
			sWhereClause4 = sWhereClause4 + " and " +  keyNames[i] + " ='" + keyValues[i] +"'";	
			sWhereClause3 = sWhereClause3 + " and GuarantySerialNo ='" + keyValues[i] +"'";	
			sWhereClause2 = sWhereClause2 +" and "+keyNames[i]+"='"+keyValues[i]+"' ";
			sWhereClause1 = sWhereClause1 +" and GuarantySerialNo='"+keyValues[i]+"'";
		}
	}
	
	//先查询是否当天已经发生撤销
	boolean iShow = false;
	//I、查看担保是否为保证，保证和抵质押分开处理，status 为 "1"时是正常解除， 为"2"时是已撤销
	sSql = "select status from his_RelieveGuaranty "+sWhereClause1;
	ARE.getLog().info(sSql);
	rs = Sqlca.getASResultSet(sSql);
	if(rs.next()){
		if("2".equals(rs.getString(1))){
			iShow =true; 
			sReturn = "Failture1"; //当天已经做过撤销操作
		}else{
			iShow =false; 	  //做为可撤销的标志
		}			
	}else{
		iShow =true;
		sReturn = "Failture2"; //当前 天没有做过解除操作
	}
	rs.close();
	rs = null;
	
	if(!iShow){
		//II、查询历史表中是否存在未上报记录
		iShow = true;
		sSql = "select SessionID from "+sMetaTableNameHis+" "+sWhereClause2;
		ARE.getLog().info(sSql);
		rs = Sqlca.getASResultSet(sSql);
		if(rs.next()){
			iShow = false;
			sReturn = "Return";
		}
		if(rs!=null) rs.close();
		if(!iShow){
			//III、恢复数据
			ARE.getLog().info("***************更新数据开始******************");
			try{
				Sqlca.getConnection().setAutoCommit(false);
				//第一步：删除历史表中解除时插的记录
				sSql = "delete from "+sMetaTableNameHis+" "+sWhereClause2;
				ARE.getLog().info(sSql);
				Sqlca.executeSQL(sSql);
				//第二步： 从备份表中查出历史信息
				sSql = "select OldOccurdate,AVAILABSTATUS,INCREMENTFLAG,SESSIONID,ContractNo " +
						"from his_RelieveGuaranty "+sWhereClause3; 
				ARE.getLog().info(sSql);
				rs = Sqlca.getASResultSet(sSql);			
				while(rs.next()){
				//第三步： 更新ECR表使其恢复到原来状态
					String sSql2 = "update "+sMetaTableName+" set OccurDate= '"+rs.getString(1)+"' , AVAILABSTATUS = '"
					+rs.getString(2)+"' , INCREMENTFLAG = '"+rs.getString(3)+"' ,SESSIONID = '"
					+rs.getString(4)+"' "+sWhereClause4+" and Occurdate = '"+sOccurDate+"' and "
					+keyNames[0]+"= '"+rs.getString(5)+"' ";
					ARE.getLog().info(sSql2);
					Sqlca.executeSQL(sSql2);
				} 
				rs.close();
				rs = null;
				//第四步： 更新备份表中担保合同表
				sSql = "update his_RelieveGuaranty set updateDate ='"+sCurrentDate+"',status='2' " +sWhereClause3;
				ARE.getLog().info(sSql);
				Sqlca.executeSQL(sSql);
				Sqlca.getConnection().commit();
				ARE.getLog().info("***************最高额担保合同担保解除结束******************");
				sReturn = "Success";
			}catch(Exception e){
				Sqlca.getConnection().rollback();
				ARE.getLog().error("最高担保额解除失败! "+sSql,e);
				throw e;
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