<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBeginMDAJAX.jsp"%><%
	/*
		Content: 取得对应的报表类型
	 */
    //定义变量
	String sTabelName = "";//--表名
	String sReturnValue = "false";
	String sCustomerID = CurPage.getParameter("CustomerID");

	//根据客户号找到对应的客户类型
	String sSql = "select CustomerType from CUSTOMER_INFO where CustomerID =:CustomerID ";
	String sCustomerType = Sqlca.getString(new SqlObject(sSql).setParameter("CustomerID",sCustomerID));
		
	//根据不同的客户类型到不同的表中取得对应的报表类型
	if(sCustomerType!=null && ("01,02").indexOf(sCustomerType.substring(0,2))>=0)// 公司客户、集团客户
		sTabelName = "ENT_INFO ";
	else if(sCustomerType!=null && ("03,04,05").indexOf(sCustomerType.substring(0,2))>=0)//个人客户、个体工商户、农户
		sTabelName = "IND_INFO ";

	//获取财务报表类型
	sSql = "select FinanceBelong as FSModelClass from "+sTabelName+" where CustomerID =:CustomerID and length(FinanceBelong)>1";
	String sFinanceBelong = Sqlca.getString(new SqlObject(sSql).setParameter("CustomerID",sCustomerID));	
	if(sFinanceBelong == null) sFinanceBelong = "";
	if(!sFinanceBelong.equals("")) sReturnValue = sFinanceBelong;	
	
	out.println(sReturnValue);
%><%@ include file="/IncludeEndAJAX.jsp"%>