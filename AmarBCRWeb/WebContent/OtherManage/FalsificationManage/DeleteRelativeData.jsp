<%@ page contentType="text/html; charset=GBK" 
		import="com.amarsoft.are.util.StringFunction"%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List03;Describe=�������ݶ���;]~*/%>
<%	
	//out.println("<br/><b><font color='blue' size='2'>����ɾ���������,���Ե�...</font></b>");
	//��ȡ����
	String sSerialNo = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("SerialNo"));
	if(sSerialNo == null) sSerialNo = "";
	String sCustomerID = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("CustomerID"));
	if(sCustomerID == null) sCustomerID = "";
	String sLoanCardNo = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("LoanCardNo"));
	if(sLoanCardNo == null) sLoanCardNo = "";
	String sErrLoanCardNo = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("ErrLoanCardNo"));
	if(sErrLoanCardNo == null) sErrLoanCardNo = "";

	String sSql="";
	ASResultSet rs = null;
	String incrementflag = "1";
	String sessionid = "0000000000";
	String recordflag = "40";
	String occurdate = StringFunction.getToday();
	String loancardno = sErrLoanCardNo;
	//ɾ��ҵ������
	String dateTable[][] = {
		{"ECR_LOANCONTRACT","HIS_LOANCONTRACT","LCONTRACTNO","01"},//�����ͬ��Ϣ��
		{"ECR_FACTORING","HIS_FACTORING","FACTORINGNO","02"},//����ҵ����Ϣ��
		{"ECR_DISCOUNT","HIS_DISCOUNT","BILLNO","03"},// Ʊ��������Ϣ��
		{"ECR_FINAINFO","HIS_FINAINFO","FCONTRACTNO","04"},//����Э����Ϣ��
		{"ECR_CREDITLETTER","HIS_CREDITLETTER","CREDITLETTERNO","05"},//5.5 ����֤ҵ����Ϣ��
		{"ECR_GUARANTEEBILL","HIS_GUARANTEEBILL","GUARANTEEBILLNO","06"},//5.6 ����ҵ����Ϣ�� 
		{"ECR_ACCEPTANCE","HIS_ACCEPTANCE","ACCEPTNO","07"},//
		{"ECR_CUSTOMERCREDIT","HIS_CUSTOMERCREDIT","CCONTRACTNO","08"},//5.8 ����������Ϣ��
		{"ECR_FLOORFUND","HIS_FLOORFUND","FLOORFUNDNO","09"},//5.10 �����Ϣ��
		{"ECR_INTERESTDUE","HIS_INTERESTDUE","LOANCARDNO","10"}//5.11 ǷϢ��Ϣ��
	};
	
	//��ѯ��ʷ���������ϱ�������,�Ͷ�Ӧ�ĵ�ǰ������Ϣ
	List list = new ArrayList();
	for(int i = 0; i < 10; i++){
		/*
		//ԭECR��HISͬʱ��
		sSql = "select "+dateTable[i][2]+" as contractno,'"+dateTable[i][3]+"' as businesstype,financeid"
				+" from "+dateTable[i][0]+" where CustomerID='"+sCustomerID+"' and LoanCardNo='"+sErrLoanCardNo+"' "
				+"union select "+dateTable[i][2]+" as contractno,'"+dateTable[i][3]+"' as businesstype,financeid"
				+" from "+dateTable[i][1]+" where CustomerID='"+sCustomerID+"' and LoanCardNo='"+sErrLoanCardNo+"' ";
		*/
		sSql = "select distinct "+dateTable[i][2]+" as contractno,'"+dateTable[i][3]+"' as businesstype,financeid"
				+" from "+dateTable[i][0]+" where CustomerID='"+sCustomerID+"' and LoanCardNo='"+sErrLoanCardNo+"' ";
		System.out.println("Sql:"+sSql);
		rs = Sqlca.getASResultSet(sSql);
		while(rs.next()){
			String contractno = rs.getString("contractno");
			String businesstype = rs.getString("businesstype");
			String financeid = rs.getString("financeid");
			
			String record = contractno + "," + businesstype + "," + financeid;
			list.add(record);
		}
		if(rs!=null) rs.close();
	}
	Iterator it = list.iterator();
	String sSql1 = "";
	String sSql2 = "";
	String sReturnValue = "false";
	//��ʼ����
	boolean bOld = Sqlca.getAutoCommit(); 
	try 
	{	
		if(!bOld) Sqlca.commit();
				
		while(it.hasNext()){
			String[] record = ((String)it.next()).split(",");
			//ɾ�����е�HIS_BATCHDELETE
			sSql1 = "delete from his_batchdelete where sessionid='"+sessionid+"' and contractno='"+record[0]
				+"' and businesstype='"+record[1]+"' and loancardno='"+loancardno+"' and occurdate='"+occurdate+"'";
			Sqlca.executeSQL(sSql1);
			//System.out.println("****"+sSql1);
		}
		Iterator it2 = list.iterator();
		while(it2.hasNext()){
			String[] record = ((String)it2.next()).split(",");
			sSql2 = "insert into his_batchdelete(occurdate,contractno,businesstype,loancardno,financeid,incrementflag,sessionid,recordflag)"+
	         " values('"+occurdate+"','"+record[0]+"','"+record[1]+"','"+loancardno+"','"+record[2]+"','"+incrementflag+"','"+sessionid+"','"+recordflag+"')";
			//System.out.println("****"+sSql2);
			Sqlca.executeSQL(sSql2);
		}
		String OrganDelete="delete from HIS_BATCHDELETEORGAN where CIFCUSTOMERID=:CIFCUSTOMERID and SEGMENTTYPE='B'  and UPDATEDATE=:UPDATEDATE and sessionid=:sessionid";
		SqlObject organSqlObject=new SqlObject(OrganDelete);
		organSqlObject.setParameter("CIFCUSTOMERID", sCustomerID);
		organSqlObject.setParameter("UPDATEDATE", "20120101");
		organSqlObject.setParameter("sessionid", sessionid);
		Sqlca.executeSQL(organSqlObject);
		
		String organInsert="INSERT INTO HIS_BATCHDELETEORGAN (CIFCUSTOMERID,SEGMENTTYPE,UPDATEDATE,OCCURDATE,SESSIONID,FINANCEID,incrementflag,recordflag) VALUES"
				+"(:CIFCUSTOMERID,'B',:UPDATEDATE,:OCCURDATE,:SESSIONID,:FINANCEID,:incrementflag,:recordflag)";
		SqlObject organSqlObject2=new SqlObject(organInsert);
		organSqlObject2.setParameter("CIFCUSTOMERID", sCustomerID);
		organSqlObject2.setParameter("UPDATEDATE","20120101");
		organSqlObject2.setParameter("OCCURDATE", occurdate);
		organSqlObject2.setParameter("SESSIONID", sessionid);
		organSqlObject2.setParameter("FINANCEID", CurOrg.getOrgID());
		organSqlObject2.setParameter("incrementflag", incrementflag);
		organSqlObject2.setParameter("recordflag", recordflag);
		Sqlca.executeSQL(organSqlObject2);
		
		String familyQuery="select  MANAGERCERTID,MANAGERCERTTYPE,MEMBERCERTID,MEMBERCERTTYPE,MEMBERRELATYPE,UPDATEDATE,FINANCEID "
				+" from ECR_ORGANFAMILY where  CIFCustomerID=:sCustomerID  and LoanCardNo=:sErrLoanCardNo ";
		ASResultSet rs2=Sqlca.getASResultSet(new SqlObject(familyQuery).setParameter("sCustomerID", sCustomerID).setParameter("sErrLoanCardNo", sErrLoanCardNo));
		String familyDelete="delete from HIS_BATCHDELETEFAMILY where CIFCUSTOMERID=:CIFCUSTOMERID and SESSIONID=:SESSIONID and OCCURDATE=:OCCURDATE";
		Sqlca.executeSQL(new SqlObject(familyDelete).setParameter("CIFCUSTOMERID", sCustomerID).setParameter("OCCURDATE", occurdate).setParameter("SESSIONID", sessionid));
		while(rs2.next()){
			String familyInsert="INSERT INTO HIS_BATCHDELETEFAMILY (CIFCUSTOMERID,MANAGERCERTTYPE,MANAGERCERTID,MEMBERRELATYPE,MEMBERCERTTYPE,MEMBERCERTID,UPDATEDATE,OCCURDATE,INCREMENTFLAG,RECORDFLAG,SESSIONID,FINANCEID) VALUES"+ 
					"(:CIFCUSTOMERID,:MANAGERCERTTYPE,:MANAGERCERTID,:MEMBERRELATYPE,:MEMBERCERTTYPE,:MEMBERCERTID,:UPDATEDATE,:OCCURDATE,:INCREMENTFLAG,:RECORDFLAG,:SESSIONID,:FINANCEID)";
			SqlObject familyInsertSqlObject=new SqlObject(familyInsert);
			familyInsertSqlObject.setParameter("CIFCUSTOMERID", sCustomerID);
			familyInsertSqlObject.setParameter("MANAGERCERTTYPE", rs2.getString("MANAGERCERTTYPE"));
			familyInsertSqlObject.setParameter("MANAGERCERTID", rs2.getString("MANAGERCERTID"));
			familyInsertSqlObject.setParameter("MEMBERRELATYPE", rs2.getString("MEMBERRELATYPE"));
			familyInsertSqlObject.setParameter("MEMBERCERTTYPE", rs2.getString("MEMBERCERTTYPE"));			
			familyInsertSqlObject.setParameter("MEMBERCERTID", rs2.getString("MEMBERCERTID"));
			familyInsertSqlObject.setParameter("UPDATEDATE", rs2.getString("UPDATEDATE"));
			familyInsertSqlObject.setParameter("OCCURDATE",occurdate);
			familyInsertSqlObject.setParameter("INCREMENTFLAG", incrementflag);
			familyInsertSqlObject.setParameter("RECORDFLAG",recordflag);
			familyInsertSqlObject.setParameter("SESSIONID", sessionid);
			familyInsertSqlObject.setParameter("FINANCEID", rs2.getString("FINANCEID"));
			Sqlca.executeSQL(familyInsertSqlObject);
		}
		
		//���¿ͻ���Ϣ loancardno
		sSql1 = "update ECR_ORGANINFO set LOANCARDNO ='"+sLoanCardNo+"' where CIFCUSTOMERID ='"+sCustomerID+"'";
		sSql2 = "update HIS_ORGANINFO set LOANCARDNO ='"+sLoanCardNo+"' where CIFCUSTOMERID ='"+sCustomerID+"'";
	  	Sqlca.executeSQL(sSql1);	
		Sqlca.executeSQL(sSql2);
				
	    String	sNow	= StringFunction.getToday()+" "+StringFunction.getNow();
		//���øô�����Ϣ״̬Ϊ1���Ѵ���
		sSql1 = "update FALSIFICATION set Flag ='1' ,UpdateUser='"+CurUser.getUserID()+"' ,UpdateOrg='"+CurUser.getOrgID()+"' , UpdateTime='"+sNow+"' where SerialNo ='"+sSerialNo+"'";
		Sqlca.executeSQL(sSql1);	
		
		//�����ύ�ɹ�
		Sqlca.commit();
		//����ֵ
		sReturnValue = "success";
	} catch(Exception e){
		Sqlca.rollback();
		throw new Exception("������ʧ�ܣ�"+e.getMessage());
	}			
%>
<%/*~END~*/%>
<script type="text/javascript">
	top.returnValue =  "<%=sReturnValue%>";
	top.close();
</script>

<%@ include file="/IncludeEnd.jsp"%>