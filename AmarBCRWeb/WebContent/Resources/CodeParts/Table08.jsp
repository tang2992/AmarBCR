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
		//根据记录类型来获取，表名，表描述，主键值
		if("71".equals(sRECORDTYPE)||"72".equals(sRECORDTYPE)){//将机构信息和家庭成员信息的反馈错误信息一起展示
			sMySql=" select CODE.ITEMNAME,FEED.ERRMSG from ECR_FEEDBACK FEED,CODE_LIBRARY CODE "
					+ " WHERE CODE.ITEMNO = FEED.RECORDTYPE AND CODE.CODENO='recordtype'  AND MAINBUSINESSNO='" +sMAINBUSINESSNO+"' AND FEED.RECORDTYPE in('71','72') ";
		}else{
			sMySql=" select CODE.ITEMNAME,FEED.ERRMSG from ECR_FEEDBACK FEED,CODE_LIBRARY CODE "
					+ " WHERE CODE.ITEMNO = FEED.RECORDTYPE AND CODE.CODENO='recordtype'  AND MAINBUSINESSNO='" +sMAINBUSINESSNO+"' AND FEED.RECORDTYPE='"+sRECORDTYPE+"' ";
		}	

		rs9 = Sqlca.getASResultSet(new SqlObject(sMySql));
		//输出错误信息和记录类型
		while(rs9.next()){
			out.println("<tr bgcolor='#FFFFFF' valign=center height='25' border='3' bordercolordark=#F8B3D0 bordercolorlight=#000000 > ");
			out.println("<td align='left'><strong><font color=red>"+rs9.getString(1)+":</font><strong>");
			out.println("<strong><font color=red>"+rs9.getString(2)+"</font><strong></td>");
			out.println("</tr>");
			if(sShowButton.equals("false"))
				sShowButton = "true";
		}
		rs9.getStatement().close();
%>
</table>
</body>
</html>
