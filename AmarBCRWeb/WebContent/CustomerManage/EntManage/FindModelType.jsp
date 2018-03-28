<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBeginMDAJAX.jsp"%><%
	/*
		Content: 取得对应的报表类型
	 */
    //定义变量
	String sReturnValue = "02";//--表示是否为明细附表
	
	//获得页面参数，报表编号
	String sReportNo = CurPage.getParameter("ReportNo");

	//获取财务报表类型
	String sModelno = Sqlca.getString("select MODELNO from REPORT_RECORD  where  ReportNo  ='"+sReportNo+"' ");
	if(sModelno == null) sModelno = "";
	
	String sModelLabbr = Sqlca.getString("select MODELABBR from REPORT_CATALOG  where  ModelNo  ='"+sModelno+"' ");	
	if(sModelLabbr == null) sModelLabbr = "";
	
	if(sModelLabbr.equals("报表说明")){
		sReturnValue ="00";
	}else if(sModelLabbr.equals("客户资产与负债明细")){
		sReturnValue ="01";
	}else{
		sReturnValue = sModelno;
	}

	out.println(sReturnValue);
%><%@ include file="/IncludeEndAJAX.jsp"%>