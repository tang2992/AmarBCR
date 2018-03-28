<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<%
	/*
	Content: 用于显示一期所有的财务报表
	*/
	//获得页面参数	
	String sObjectNo =  CurPage.getParameter("CustomerID"); //对象编号 暂时为客户号
	String sObjectType =  CurPage.getParameter("ObjectType");
	String sReportDate =  CurPage.getParameter("ReportDate");
	String sRole =  CurPage.getParameter("Role");
	String sRecordNo =  CurPage.getParameter("RecordNo");
	String sReportScope =  CurPage.getParameter("ReportScope");
	String sEditable =  CurPage.getParameter("Editable");
	
	//将空值转化为空字符串
	if(sObjectNo == null) sObjectNo = "";
	if(sObjectType == null) sObjectType = "";
	if(sReportDate == null) sReportDate = "";
	if(sRole == null) sRole = "";
	if(sRecordNo == null) sRecordNo = "";
	if(sReportScope == null) sReportScope = "";
	if(sEditable == null) sEditable = "";
	
	//取得对应的报表类型
	List<String[]> tabStrip = new ArrayList<String[]>();
	ASResultSet rs = null;
	try{
		rs = Sqlca.getASResultSet(new SqlObject("select ReportNo, ReportName from REPORT_RECORD where ObjectType=:ObjectType and ObjectNo=:ObjectNo and ReportScope=:ReportScope and ReportDate=:ReportDate order by ModelNo")
			.setParameter("ObjectType", sObjectType)
			.setParameter("ObjectNo", sObjectNo)
			.setParameter("ReportScope", sReportScope)
			.setParameter("ReportDate", sReportDate));
		while(rs.next()){
			String sReportNo = rs.getString("ReportNo");
			String sReportName = rs.getString("ReportName");
			String sUrl, sParam;
			if("报表说明".equals(sReportName)){
				sUrl = "/CustomerManage/EntManage/ReportDescribe.jsp";
				sParam = "Role="+sRole+"&CustomerID="+sObjectNo+"&RecordNo="+sRecordNo+"&ReportDate="+sReportDate+"&ReportNo="+sReportNo+"&Editable="+sEditable;
			}else if("客户资产与负债明细".equals(sReportName)){
				sUrl = "/CustomerManage/EntManage/FSdescribeView.jsp";
				sParam = "Role="+sRole+"&CustomerID="+sObjectNo+"&RecordNo="+sRecordNo+"&ReportDate="+sReportDate+"&ReportNo="+sReportNo+"&Editable="+""+sEditable+"";
			}else{
				sUrl = "/Common/FinanceReport/ReportData.jsp";
				sParam = "Role="+sRole+"&CustomerID="+sObjectNo+"&RecordNo="+sRecordNo+"&ReportNo="+sReportNo+"&Editable="+""+sEditable+"";
			}
			tabStrip.add(new String[]{"true", sReportName, sUrl, sParam});
		}
	}finally{
		if(rs != null) rs.close();
	}
	//利用sql语句初始化tab 组
	String sTabStrip[][] = tabStrip.toArray(new String[0][]);
%>
<%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>