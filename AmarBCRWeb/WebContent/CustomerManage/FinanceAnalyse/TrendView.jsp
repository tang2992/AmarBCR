<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBeginMD.jsp"%>
<link rel="stylesheet" href="<%=sWebRootPath%>/Frame/page/resources/css/tabs.css">
<link rel="stylesheet" type="text/css" href="<%=sWebRootPath%><%=sSkinPath%>/css/tabs.css">
<script type='text/javascript' src='<%=sWebRootPath%>/Frame/resources/js/tabstrip-1.0.js'></script>
<%
	/*
		Content: �ͻ����񱨱����
		Input Param:
	                 CustomerID���ͻ���
	                 Term �����������²������ݣ�
	                      ReportCount ����������
	                      AccountMonth1�����������
	                      Scope������Χ
	 */
    //���ҳ�����
	String sCustomerID = CurPage.getParameter("CustomerID");
	String sTerm = CurPage.getParameter("Term");
	sTerm = sTerm.replace('@','&');
%>
<html>
<head>
	<title>���Ʒ���</title>
</head>
<body leftmargin="0" topmargin="0" class="pagebackground" style="margin:0;padding:0;";>
<div id="tabdiv" style="border:0px solid #F00;z-index:-1;width:100%;height:100%;padding:0,0.5%">&nbsp;</div>
</body>
</html>

<script type="text/javascript">
	$(document).ready(function(){
		parent.document.title="���Ʒ���";
		$("#TitleDiv").hide();
		var tabCompent = new TabStrip("TrendTab","TrendInfo","tab","#tabdiv");
		tabCompent.setSelectedItem("0");
		tabCompent.setIsCache(false);
		<%
			String sFinanceBelong = "";
			ASResultSet rs = Sqlca.getASResultSet("select FinanceBelong from ENT_INFO where CustomerID= '" + sCustomerID + "'");
			if(rs.next()) sFinanceBelong = rs.getString(1);	
			rs.getStatement().close();
			
			String sReportNo = "", sReportName = "";
			int iCount = 0;
			String sSql = "select ReportNo,ReportName from FINANCE_CATALOG where FINANCE_CATALOG.BelongIndustry ='" + sFinanceBelong + "'"+" order by ReportNo";
			rs = Sqlca.getASResultSet(sSql);
			while(rs.next()) {
				sReportNo = rs.getString(1);
				sReportName = rs.getString(2);
				if("����˵��".equals(sReportName) || "�ͻ��ʲ��븺ծ��ϸ".equals(sReportName)) continue;
				String script = "OpenComp('TrendDetail','/CustomerManage/FinanceAnalyse/TrendDetail.jsp','CustomerID="+sCustomerID+"&ReportNo="+sReportNo+""+sTerm+"')";
				out.println("tabCompent.addDataItem('"+iCount+"',\""+sReportName+"\", \""+script+"\",true,false);");
				iCount++;
			}
			rs.getStatement().close();
		%>
		tabCompent.initTab();
	});
</script>
<%@ include file="/IncludeEnd.jsp"%>