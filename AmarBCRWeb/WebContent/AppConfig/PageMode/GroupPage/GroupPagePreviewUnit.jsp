<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin.jspf"%><%
	String sItemNo = CurPage.getParameter("ItemNo");
	String sHref = CurPage.getParameter("Href");
	String sExist = CurPage.getParameter("Exist");
	String sSuccessFlag = CurPage.getParameter("SuccessFlag");
	String sColor = "black";
	if("false".equals(sExist)){
		sColor = "red";
	}
%>
<script type="text/javascript">
	<%if("true".equals(sSuccessFlag)){%>
		setDialogTitle("��ϲ���óɹ���");
	<%}else{%>
		setDialogTitle("����ҳ��·���������飡");
	<%}%>
</script>
<table border="1" width="100%" bordercolor="#ADC9D8">
	<thead>
		<tr>
			<td><font size="3pt">���</font></td>
			<td><font size="3pt">·��</font></td>
			<td><font size="3pt">�Ƿ����</font></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><font size="3pt"><%=sItemNo%></font></td>
			<td><font size="3pt"><%=sHref%></font></td>
			<td><font size="3pt" color="<%=sColor%>"><%=sExist%></font></td>
		</tr>
	</tbody>
</table>
<%@ include file="/Frame/resources/include/include_end.jspf"%>