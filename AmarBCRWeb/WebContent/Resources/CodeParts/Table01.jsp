<%@page import="com.amarsoft.app.datax.ecr.validate.ValidateHelp"%>
<%@page import="com.amarsoft.awe.util.SqlObject"%>
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
	String ErrMsg="";
	ASResultSet rs9 = null;
	String sMySql = "";
%>
<%

	if(sQueryType.equals("ERROR")){
		//根据记录类型来获取，表名，表描述，主键值
		sMySql = "SELECT ITEMNAME,ERRMSG,ERRTABLENAME,ERRTABLEKEY FROM CODE_LIBRARY,BCR_ERRHISTORY WHERE CODENO='recordtype' ";
		if(sGBusinessNo==null){
			if(sTempWhere.indexOf("ITEMNO ='26'")>0){
				sMySql = sMySql + " AND CUSTOMERID = '" + sFirstValue +"' and " + sTempWhere + " ORDER BY SORTNO ";
			}else if(sTempWhere.indexOf("ITEMNO ='71'")>0){
				sMySql = sMySql + " AND CUSTOMERID = '" + sFirstValue +"' and " + sTempWhere + " ORDER BY SORTNO ";
			}	
			else{
				sMySql = sMySql + " AND MAINBUSINESSNO = '" + sFirstValue +"' and " + sTempWhere + " ORDER BY SORTNO ";
			}
		}else
			sMySql = sMySql +  " AND MAINBUSINESSNO = '" + sFirstValue +"' and " + sTempWhere + " group by ITEMNAME,ERRMSG,ERRTABLENAME,ERRTABLEKEY ORDER BY ITEMNAME ";
		rs9 = Sqlca.getASResultSet(new SqlObject(sMySql));
		//输出错误信息和记录类型
		while(rs9.next()){
			out.println("<tr bgcolor='#FFFFFF' valign=center height='25' border='3' bordercolordark=#F8B3D0 bordercolorlight=#000000 > ");
			out.println("<td align='left'><strong><font color=red>"+rs9.getString(1)+":</font><strong>");
			out.println("<strong><font color=red>"+rs9.getString(2)+"</font><strong>");
			if(rs9.getString(4)!=null){
				out.println("<strong><font color=blue>  "+ValidateHelp.getKeyLabels(rs9.getString(3),rs9.getString(4))+"</font><strong>");	
			}
			out.println("</td></tr>");
			if(sShowButton.equals("false"))
				sShowButton = "true";
		}
		rs9.getStatement().close();
		
	}else{
		if(rs.next()){
			out.println("<tr bgcolor='#FFFFFf' valign=center height='25' border='3' bordercolordark=#F8B3D0 bordercolorlight=#000000 >");
			out.println("<td align='left'><strong><font color='#92B0DD'>担保业务编号:"+rs.getString(1)+"</font><strong></td>");
			out.println("<td align='left'><strong><font color='#92B0DD'>担保合同号码："+rs.getString(2)+"</font><strong></td>");
			out.println("</tr>");
		}
	
	}
%>
</table>
</body>
</html>
