<html>
<head>
<style type="text/css">
.style15{
margin: 0px auto;
margin-bottom:10px;
border:2px solid #A5B6C8;
background-color: #EEF3F7
}
</style>
<%@ include file="/Resources/CodeParts/progressSet.jsp"%>
<body class=pagebackground leftmargin="0" topmargin="0" >
<table align='center' width='98%'  cellspacing="4" cellpadding="0" class='style15'>
<%
	
		if(rs.next()){
			out.println("<tr bgcolor='#FFFFFf' valign=center height='25' border='3' bordercolordark=#F8B3D0 bordercolorlight=#000000 >");
			out.println("<td align='left'><strong><font color='#92B0DD'>客户编号:"+rs.getString(1)+"</font><strong></td>");
			out.println("<td align='left'><strong><font color='#92B0DD'>客户名称："+rs.getString(2)+"</font><strong></td>");
			out.println("<td align='left'><strong><font color='#92B0DD'>贷款卡编码："+rs.getString(3)+"</font><strong></td>");
			out.println("</tr>");
		}
%>
</table>
</body>
</html>
