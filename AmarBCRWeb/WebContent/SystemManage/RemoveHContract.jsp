<%
/* 
 * Author: jhli 
 * Content: ��ߵ���������
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
	String	sMetaTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("MetaTableName")); //���ݵı� 
	if(sMetaTableName == null) sMetaTableName = "";	
	String	sDBTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBTableName"));  //����ϵͳ��ڱ�
	if(sDBTableName == null) sDBTableName = "";	
	String	sOccurDate = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("OccurDate"));  //������ͬ��������
	if(sOccurDate == null) sOccurDate = "";
	String  sOccurDate1 = Tools.getLastDay("1");    //��õ�ǰ���ǰһ��
	String	sKeyName =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyName"));  //��ȡ��������
	if(sKeyName == null) sKeyName = "";	
	String	sDBKeyName =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBKeyName")); //��ȡ��ҵ������
	if(sDBKeyName == null) sDBKeyName = "";	
	String	sDBKeyValue =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBKeyValue")); //��ȡ��ҵ��ֵ
	if(sDBKeyValue == null) sDBKeyValue = "";	
	String sKeyValue = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyValue"));  //��ȡ����ֵ
	if(sKeyValue == null) sKeyValue = "";
	String  sMetaTableNameHis = StringFunction.replace(sMetaTableName,"ECR","HIS");
	String  sDBTableNameHis = StringFunction.replace(sDBTableName,"ECR","HIS");
	
	//��ȡ��ǰʱ��
	Date date = new Date();
	SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	String sCurrentDate = df.format(date);
	
	//��ȡ��ҵ������
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
	
	//��ȡ��������
	if("ECR_ASSURECONT".equals(sMetaTableName)){
		sGuarantyType="1";
	}else if("ECR_GUARANTYCONT".equals(sMetaTableName)){
		sGuarantyType="2";
	}else{
		sGuarantyType="3";
	}
		
	//���������ͼ�ֵ���ж�Ӧ,����where�Ӿ�
	String keyNames[]=sKeyName.split("@");
	String keyValues[]=sKeyValue.split("@");
	String sWhereClause4 = " where 1=1   ";//����Ǩ��һ��ECR_������HIS_������
	String sWhereClause3 = " where 1=1   ";//���ڸ���ECR_��������������߶��
	String sWhereClause2 = " where 1=1   ";//���ڼ���HIS_������
	String sWhereClause1 = " where 1=1   ";//���ڼ���his_RelieveGuaranty
	//keyNames[0]��ҵ���ͬ��
	//keyNames[1]������ͬ��
	//keyNames[2]����Ѻ˳��Ż���Ϊ��֤�����
	for(int i=0;i<keyNames.length&&i<keyValues.length;i++){
		if(i==0){//��ҵ��������������ֵ
			sWhereClause4 = sWhereClause4 + " and " +  keyNames[i] + " ='" + keyValues[i] +"'";	
			sWhereClause2 = sWhereClause2 +"and SessionID='0000000000' and "+keyNames[i]+" like 'QBZHT��%' ";
			sWhereClause1 = sWhereClause1 +"and RelieveType='G' and GuarantyType ='"+sGuarantyType+"' and ContractNo='"
				+keyValues[i]+"' and occurdate='"+sOccurDate+"' ";
		}else if(i==1){//��������ͬ������������ֵ
			sWhereClause4 = sWhereClause4 + " and " +  keyNames[i] + " ='" + keyValues[i] +"'";	
			sWhereClause3 = sWhereClause3 + " and " +  keyNames[i] + " ='" + keyValues[i] +"'";	
			sWhereClause2 = sWhereClause2 +" and "+keyNames[i]+"='"+keyValues[i]+"' ";
			sWhereClause1 = sWhereClause1 +" and GuarantyContNo='"+keyValues[i]+"'";
		}else if((!"ECR_ASSURECONT".equals(sMetaTableName))&&i>1){//����Ѻ��������������ֵ
			sWhereClause4 = sWhereClause4 + " and " +  keyNames[i] + " ='" + keyValues[i] +"'";	
			sWhereClause3 = sWhereClause3 + " and " +  keyNames[i] + " ='" + keyValues[i] +"'";	
			sWhereClause2 = sWhereClause2 +" and "+keyNames[i]+"='"+keyValues[i]+"' ";
			sWhereClause1 = sWhereClause1 +" and GuarantySerialNo='"+keyValues[i]+"'";
		}
	}
	
	//I���Ȳ�ѯ�Ƿ��Ѿ�������߶�����
	boolean iShow = false;
	//�鿴�����Ƿ�Ϊ��֤����֤�͵���Ѻ�ֿ����� �� status Ϊ "1"ʱ�����������Ϊ"2"ʱ���ѳ���
	sSql = "select status from his_RelieveGuaranty "+sWhereClause1;
	ARE.getLog().info(sSql);
		rs = Sqlca.getASResultSet(sSql);
		if(rs.next()){
		if("1".equals(rs.getString(1))){  
			iShow =true;
			sReturn = "Failture";   // ��������߶�����
		}
	}
	rs.close();
	rs=null;
	
	if(!iShow){
		//II����ѯ������ʷ�����Ƿ����δ�ϱ���¼
		sSql = "select SessionID from "+sMetaTableNameHis+" "+sWhereClause2;
		ARE.getLog().info(sSql); 
		rs = Sqlca.getASResultSet(sSql);
		if(rs.next()){
			iShow =true;
			sReturn = "Return"; // ���ڴ��ϱ���¼
		}
		rs.close();
		rs = null;
		
		if(!iShow){
			//III����������
			ARE.getLog().info("***************�������ݿ�ʼ******************");
			try{
				Sqlca.getConnection().setAutoCommit(false);
				// ��һ������Ҫ���µ�ECR���в��Ҫ���µ����ݣ������뵽�����������
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
				
				//�ڶ����� ���µ�����ͬ
				sSql = "update "+sMetaTableName+" set  OccurDate ='"+sOccurDate1+"'"+","+" INCREMENTFLAG='8' , " +
						"AVAILABSTATUS='2' , SESSIONID='0000000000' "+sWhereClause3; 
				ARE.getLog().info(sSql);
				Sqlca.executeSQL(sSql);
				
				ARE.getLog().info("***************����Ǩ��******************");
				
				// ������������ʷ���в�����µĵ�����ͬ
				sSql = "insert into "+sMetaTableNameHis+" select * from "+sMetaTableName+""+sWhereClause4+"";
				ARE.getLog().info(sSql);
				Sqlca.executeSQL(sSql);
				
				// ���Ĳ����ڸ�����ʷ���е���Ϣ
				sSql = "update "+sMetaTableNameHis+" set ContractNo='QBZHT��"+keyValues[0]+"' ,INCREMENTFLAG='2' "+sWhereClause4+"";
				ARE.getLog().info(sSql);
				Sqlca.executeSQL(sSql);
				
				Sqlca.getConnection().commit();
				ARE.getLog().info("***************��߶����ͬ�����������******************");
				sReturn = "Success";
			}catch(Exception e){
				Sqlca.getConnection().rollback();
				ARE.getLog().error("��ߵ�������ʧ��!  "+sSql,e);
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