<%
/* 
 * Author: jhli 
 * Content:  ������ߵ�������
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
	String	sMetaTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("MetaTableName")); //������ͬ�� 
	if(sMetaTableName == null) sMetaTableName = "";	
	String	sDBTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBTableName")); //����ϵͳ��ڱ�
	if(sDBTableName == null) sDBTableName = "";	
	String	sOccurDate = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("OccurDate")); //������ͬ��������
	if(sOccurDate == null) sOccurDate = "";
	String  sOccurDate1 = Tools.getLastDay("1");   //��õ�ǰ���ǰһ��
	String	sKeyName =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyName")); //��ȡ��������
	if(sKeyName == null) sKeyName = "";	
	String	sDBKeyName =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBKeyName"));  //��ȡ��ҵ������
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
	
	//���������ͼ�ֵ���ж�Ӧ,����where�Ӿ�
	String keyNames[]=sKeyName.split("@");
	String keyValues[]=sKeyValue.split("@");
	String sWhereClause4 = " where 1=1   ";//���ڸ���ÿ��ECR_������
	String sWhereClause3 = " where 1=1   ";//���ڴ�his_RelieveGuaranty�л�ȡ���������µĵ�����¼
	String sWhereClause2 = " where 1=1   ";//���ڼ���HIS_������
	String sWhereClause1 = " where 1=1   ";//���ڼ���his_RelieveGuaranty
	
	//��ȡ��������
	if("ECR_ASSURECONT".equals(sMetaTableName)){
		sGuarantyType="1";
	}else if("ECR_GUARANTYCONT".equals(sMetaTableName)){
		sGuarantyType="2";
	}else{
		sGuarantyType="3";
	}
	//keyNames[0]��ҵ���ͬ��
	//keyNames[1]������ͬ��
	//keyNames[2]����Ѻ˳��Ż���Ϊ��֤�����
	for(int i=0;i<keyNames.length&&i<keyValues.length;i++){
		if(i==0){//��ҵ��������������ֵ
			sWhereClause3 = sWhereClause3 + " and RelieveType='G' and Occurdate = '"+sOccurDate+"' and status='1'";
			sWhereClause2 = sWhereClause2 +"and SessionID='0000000000' and "+keyNames[i]+" like 'QBZHT��%' ";
			sWhereClause1 = sWhereClause1 +"and RelieveType='G' and GuarantyType ='"+sGuarantyType+"' and ContractNo='"
				+keyValues[i]+"' and occurdate='"+sOccurDate+"' ";
		}else if(i==1){//��������ͬ������������ֵ
			sWhereClause4 = sWhereClause4 + " and " +  keyNames[i] + " ='" + keyValues[i] +"'";	
			sWhereClause3 = sWhereClause3 + " and GuarantyContNo ='" + keyValues[i] +"'";	
			sWhereClause2 = sWhereClause2 +" and "+keyNames[i]+"='"+keyValues[i]+"' ";
			sWhereClause1 = sWhereClause1 +" and GuarantyContNo='"+keyValues[i]+"'";
		}else if((!"ECR_ASSURECONT".equals(sMetaTableName))&&i>1){//����Ѻ��������������ֵ
			sWhereClause4 = sWhereClause4 + " and " +  keyNames[i] + " ='" + keyValues[i] +"'";	
			sWhereClause3 = sWhereClause3 + " and GuarantySerialNo ='" + keyValues[i] +"'";	
			sWhereClause2 = sWhereClause2 +" and "+keyNames[i]+"='"+keyValues[i]+"' ";
			sWhereClause1 = sWhereClause1 +" and GuarantySerialNo='"+keyValues[i]+"'";
		}
	}
	
	//�Ȳ�ѯ�Ƿ����Ѿ���������
	boolean iShow = false;
	//I���鿴�����Ƿ�Ϊ��֤����֤�͵���Ѻ�ֿ�����status Ϊ "1"ʱ����������� Ϊ"2"ʱ���ѳ���
	sSql = "select status from his_RelieveGuaranty "+sWhereClause1;
	ARE.getLog().info(sSql);
	rs = Sqlca.getASResultSet(sSql);
	if(rs.next()){
		if("2".equals(rs.getString(1))){
			iShow =true; 
			sReturn = "Failture1"; //�����Ѿ�������������
		}else{
			iShow =false; 	  //��Ϊ�ɳ����ı�־
		}			
	}else{
		iShow =true;
		sReturn = "Failture2"; //��ǰ ��û�������������
	}
	rs.close();
	rs = null;
	
	if(!iShow){
		//II����ѯ��ʷ�����Ƿ����δ�ϱ���¼
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
			//III���ָ�����
			ARE.getLog().info("***************�������ݿ�ʼ******************");
			try{
				Sqlca.getConnection().setAutoCommit(false);
				//��һ����ɾ����ʷ���н��ʱ��ļ�¼
				sSql = "delete from "+sMetaTableNameHis+" "+sWhereClause2;
				ARE.getLog().info(sSql);
				Sqlca.executeSQL(sSql);
				//�ڶ����� �ӱ��ݱ��в����ʷ��Ϣ
				sSql = "select OldOccurdate,AVAILABSTATUS,INCREMENTFLAG,SESSIONID,ContractNo " +
						"from his_RelieveGuaranty "+sWhereClause3; 
				ARE.getLog().info(sSql);
				rs = Sqlca.getASResultSet(sSql);			
				while(rs.next()){
				//�������� ����ECR��ʹ��ָ���ԭ��״̬
					String sSql2 = "update "+sMetaTableName+" set OccurDate= '"+rs.getString(1)+"' , AVAILABSTATUS = '"
					+rs.getString(2)+"' , INCREMENTFLAG = '"+rs.getString(3)+"' ,SESSIONID = '"
					+rs.getString(4)+"' "+sWhereClause4+" and Occurdate = '"+sOccurDate+"' and "
					+keyNames[0]+"= '"+rs.getString(5)+"' ";
					ARE.getLog().info(sSql2);
					Sqlca.executeSQL(sSql2);
				} 
				rs.close();
				rs = null;
				//���Ĳ��� ���±��ݱ��е�����ͬ��
				sSql = "update his_RelieveGuaranty set updateDate ='"+sCurrentDate+"',status='2' " +sWhereClause3;
				ARE.getLog().info(sSql);
				Sqlca.executeSQL(sSql);
				Sqlca.getConnection().commit();
				ARE.getLog().info("***************��߶����ͬ�����������******************");
				sReturn = "Success";
			}catch(Exception e){
				Sqlca.getConnection().rollback();
				ARE.getLog().error("��ߵ�������ʧ��! "+sSql,e);
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