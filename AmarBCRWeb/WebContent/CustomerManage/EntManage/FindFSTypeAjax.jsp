<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBeginMDAJAX.jsp"%><%
	/*
		Content: ȡ�ö�Ӧ�ı�������
	 */
    //�������
	String sTabelName = "";//--����
	String sReturnValue = "false";
	String sCustomerID = CurPage.getParameter("CustomerID");

	//���ݿͻ����ҵ���Ӧ�Ŀͻ�����
	String sSql = "select CustomerType from CUSTOMER_INFO where CustomerID =:CustomerID ";
	String sCustomerType = Sqlca.getString(new SqlObject(sSql).setParameter("CustomerID",sCustomerID));
		
	//���ݲ�ͬ�Ŀͻ����͵���ͬ�ı���ȡ�ö�Ӧ�ı�������
	if(sCustomerType!=null && ("01,02").indexOf(sCustomerType.substring(0,2))>=0)// ��˾�ͻ������ſͻ�
		sTabelName = "ENT_INFO ";
	else if(sCustomerType!=null && ("03,04,05").indexOf(sCustomerType.substring(0,2))>=0)//���˿ͻ������幤�̻���ũ��
		sTabelName = "IND_INFO ";

	//��ȡ���񱨱�����
	sSql = "select FinanceBelong as FSModelClass from "+sTabelName+" where CustomerID =:CustomerID and length(FinanceBelong)>1";
	String sFinanceBelong = Sqlca.getString(new SqlObject(sSql).setParameter("CustomerID",sCustomerID));	
	if(sFinanceBelong == null) sFinanceBelong = "";
	if(!sFinanceBelong.equals("")) sReturnValue = sFinanceBelong;	
	
	out.println(sReturnValue);
%><%@ include file="/IncludeEndAJAX.jsp"%>