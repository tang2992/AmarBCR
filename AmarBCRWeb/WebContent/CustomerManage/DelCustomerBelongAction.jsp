<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBeginMD.jsp"%><%
	/*
		Content: ɾ���û�������ϵ
		Input Param:
			CustomerID���ͻ����					
		Output param:
			ReturnValue:����ֵ
				ExistApply:����δ�ս������
				ExistApprove:����δ�ս�������������
				ExistContract:����δ�ս�ĺ�ͬ
		History Log: 
				syang 2009/10/14 ��ɾ���û�������ϵ��
				��Ҫɾ���Ĳ�һ���ǵ�ǰ�û��Ĺ�ϵ��
				��ˣ�֧���ⲿ�����û�ID,���û�д����û�ID,��Ĭ��ʹ�õ�ǰ�û���Ϊ��Ϊԭ���ļ���
	 */
	//�������
	String sSql = "",sReturnValue = "";		
	int iCount = 0;
	ASResultSet rs = null;
	
	//��ȡҳ��������ͻ����
	String sCustomerID   = CurPage.getParameter("CustomerID");
	String sUserID   = CurPage.getParameter("UserID");
	//����ֵת��Ϊ���ַ���
	if(sCustomerID == null) sCustomerID = "";
	if(sUserID == null || sUserID.length() == 0) sUserID = CurUser.getUserID();	//���û�д����û�����Ĭ��ʹ�õ�ǰ�û�

	//����δ�ս�����ҵ����
	/* sSql = " select count(SerialNo) from BUSINESS_APPLY "+
		   " where CustomerID = '"+sCustomerID+"' and PigeonholeDate is null and OperateUserID = '"+sUserID+"' " ;
	rs = Sqlca.getASResultSet(sSql);
	if(rs.next()) iCount = rs.getInt(1);
	rs.getStatement().close(); 		
	if (iCount == 0){	//����ҵ��ȫ���ս�
		//����δ�ս������������ҵ����
		sSql = " select count(*) from BUSINESS_APPROVE "+
			   " where CustomerID = '"+sCustomerID+"' and PigeonholeDate is null and OperateUserID = '"+sUserID+"' " ;
		rs = Sqlca.getASResultSet(sSql);
		if(rs.next()) iCount = rs.getInt(1);
		rs.getStatement().close();
		if(iCount == 0){	//�����������ҵ��ȫ���ս�
			//����δ�ս��ͬҵ����
			sSql = " select count(*) from BUSINESS_CONTRACT "+
				   " where CustomerID = '"+sCustomerID+"' and FinishDate is null and ManageUserID = '"+sUserID+"' " ;
			rs = Sqlca.getASResultSet(sSql);
			if(rs.next()) iCount = rs.getInt(1);
			rs.getStatement().close();
			if (iCount == 0){	//��ͬҵ��ȫ���ս� */
				//����ɾ��������Ϣ
				Sqlca.executeSQL("Delete from  CUSTOMER_BELONG where CustomerID='"+sCustomerID+"'"+" and UserID='"+sUserID+"'");					
				sReturnValue = "DelSuccess";//�ÿͻ�������Ϣ��ɾ����		
/* 			}else{
				sReturnValue = "ExistContract";//�ÿͻ�������ͬҵ��δ�սᣬ����ɾ����
			}
		}else{
			sReturnValue = "ExistApprove";//�ÿͻ����������������δ�սᣬ����ɾ����
		}
	}else{
		sReturnValue = "ExistApply";//�ÿͻ���������ҵ��δ�սᣬ����ɾ����
	} */
%>
<script type="text/javascript">
	self.returnValue = "<%=sReturnValue%>";
	self.close();
</script>
<%@ include file="/IncludeEnd.jsp"%>