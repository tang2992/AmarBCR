<%@ include file="/IncludeBegin.jsp"%>
<html>
<head>
<style type="text/css">
.style15{
/* margin: 0px auto; */
/* margin-bottom:10px; */
/* border:2px solid #A5B6C8; */
background-color: #EEF3F7
}
</style>
<%@ include file="/Resources/CodeParts/progressSet.jsp"%>
<body class=pagebackground leftmargin="0" topmargin="0" >
<table align='center' width='99%'  cellspacing="4" cellpadding="0" class='style15'>
<%
	String ErrMsg="";
	ASResultSet rs9 = null;
	String sMySql = "";
	String sGBusinessNo = CurPage.getParameter("GBusinessNo");
	if(sGBusinessNo==null) sGBusinessNo = "";
	String sTempWhere = " (SORTNO <='07' or  (SORTNO >=43 and SORTNO<=47)  )";
%>
<%
	//根据记录类型来获取，表名，表描述，主键值
	sMySql = "SELECT ITEMNAME,ERRMSG FROM CODE_LIBRARY,ECR_ERRHISTORY WHERE CODENO='recordtype' AND ITEMNO = RECORDTYPE ";
	if("".equals(sGBusinessNo)){
		if(sTempWhere.indexOf("ITEMNO ='26'")>0){
			sMySql = sMySql + " AND CUSTOMERID = '" + sGBusinessNo +"' and " + sTempWhere + " ORDER BY SORTNO ";
		}else if(sTempWhere.indexOf("ITEMNO ='71'")>0){
			sMySql = sMySql + " AND CUSTOMERID = '" + sGBusinessNo +"' and " + sTempWhere + " ORDER BY SORTNO ";
		}	
		else{
			sMySql = sMySql + " AND MAINBUSINESSNO = '" + sGBusinessNo +"' and " + sTempWhere + " ORDER BY SORTNO ";
		}
	}else
		sMySql = sMySql +  " AND CUSTOMERID = '" + sGBusinessNo +"' and " + sTempWhere + " ORDER BY SORTNO ";
	rs9 = Sqlca.getASResultSet(new SqlObject(sMySql));
	//输出错误信息和记录类型
	while(rs9.next()){
		out.println("<tr bgcolor='#FFFFFF' valign=center height='25' border='3' bordercolordark=#F8B3D0 bordercolorlight=#000000 > ");
		out.println("<td align='left'><strong><font color=red>"+rs9.getString(1)+":</font><strong>");
		out.println("<strong><font color=red>"+rs9.getString(2)+"</font><strong></td>");
		out.println("</tr>");
	}
	rs9.getStatement().close();
	

%>
</table>
</body>
</html>

<%@ include file="/IncludeEnd.jsp"%>
