<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBeginMD.jsp"%><%
	/*
		Content: --�ͻ����񱨱����
		Input Param:
	                 --CustomerID���ͻ���
	                 --Term �����������²������ݣ�
	                      --ReportCount ����������
	                      --AccountMonth1�����������
	                      --Scope������Χ
	                      --EntityCount���ͻ���
	 */
    //���ҳ�����,�ͻ����롢Term������������������������¡�����Χ���ͻ�����
	String sCustomerID = CurPage.getParameter("CustomerID");
	String sTerm       = CurPage.getParameter("Term");
	sTerm = sTerm.replace('@','&');
%>
<html>
<head>
	<title>ָ�����</title>
</head>
<body class="ListPage" leftmargin="0" topmargin="0" style="overflow: auto;overflow-x:visible;overflow-y:visible" onload="" oncontextmenu="return false">
<table align='center' cellspacing=0 cellpadding=0 border=0 width=100% height="100%">
  <tr> 
       <td class='tabcontent' align='center' valign='top'>  
			<table cellspacing=0 cellpadding=4 border=0 width='100%' height='100%'>
				<tr> 
				<td valign="top" id="TabBodyTable" class="TabBodyTable">
					<iframe name="DeskTopInfo" src="" width=100% height=100% frameborder=0 hspace=0 vspace=0 marginwidth=0 marginheight=0 ></iframe>
				</td>
				</tr>
			</table> 
      </td>
  </tr>
</table>
</body>
</html>
<script type="text/javascript">
	OpenPage("/CustomerManage/FinanceAnalyse/ItemDetail.jsp?CustomerID=<%=sCustomerID%><%=sTerm%>","DeskTopInfo");
</script>
<%@ include file="/IncludeEnd.jsp"%>