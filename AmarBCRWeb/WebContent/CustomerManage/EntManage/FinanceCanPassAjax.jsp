<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBeginMDAJAX.jsp"%><%
	/*
		Content: 判断对应的报表日期是否存在
	 */
    //定义变量
	String sSql = "",sReturnValue = "pass";
	ASResultSet rs = null;
	//获得页面参数
	//对象编号 暂时为客户号
	String sObjectNo = CurPage.getParameter("CustomerID");
	String sReportDate = CurPage.getParameter("ReportDate");
	String sReportScope = CurPage.getParameter("ReportScope");
	//将空值转化为空字符串
	if(sObjectNo == null) sObjectNo = "";
	if(sReportScope == null) sReportScope = "";
	if(sReportDate == null)	sReportDate = "";
	
	//查询当前新增的财务报表是否重复
	sSql = " select RecordNo from CUSTOMER_FSRECORD "+
			" where CustomerID = :CustomerID and ReportDate = :ReportDate and ReportScope = :ReportScope ";
	rs = Sqlca.getResultSet(new SqlObject(sSql).setParameter("CustomerID",sObjectNo).setParameter("ReportDate",sReportDate).setParameter("ReportScope",sReportScope));
	if(rs.next()){
		sReturnValue = "refuse";
	}
	rs.getStatement().close();
	out.println(sReturnValue);
%><%@ include file="/IncludeEndAJAX.jsp"%>