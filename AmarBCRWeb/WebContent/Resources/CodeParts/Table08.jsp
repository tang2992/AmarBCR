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
		//���ݼ�¼��������ȡ��������������������ֵ
		if("71".equals(sRECORDTYPE)||"72".equals(sRECORDTYPE)){//��������Ϣ�ͼ�ͥ��Ա��Ϣ�ķ���������Ϣһ��չʾ
			sMySql=" select CODE.ITEMNAME,FEED.ERRMSG from ECR_FEEDBACK FEED,CODE_LIBRARY CODE "
					+ " WHERE CODE.ITEMNO = FEED.RECORDTYPE AND CODE.CODENO='recordtype'  AND MAINBUSINESSNO='" +sMAINBUSINESSNO+"' AND FEED.RECORDTYPE in('71','72') ";
		}else{
			sMySql=" select CODE.ITEMNAME,FEED.ERRMSG from ECR_FEEDBACK FEED,CODE_LIBRARY CODE "
					+ " WHERE CODE.ITEMNO = FEED.RECORDTYPE AND CODE.CODENO='recordtype'  AND MAINBUSINESSNO='" +sMAINBUSINESSNO+"' AND FEED.RECORDTYPE='"+sRECORDTYPE+"' ";
		}	

		rs9 = Sqlca.getASResultSet(new SqlObject(sMySql));
		//���������Ϣ�ͼ�¼����
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
