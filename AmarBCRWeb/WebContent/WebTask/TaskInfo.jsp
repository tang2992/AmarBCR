<%
	String sPageHead = "";
	String sPageHeadPlacement = "";

if(PG_TITLE.indexOf("@")>=0){
	sPageHead = StringFunction.getSeparate(PG_TITLE,"@",1);
	sPageHeadPlacement = StringFunction.getSeparate(PG_TITLE,"@",2);
}

%>
<html>
<head></head>
<body class=pagebackground>

<% if(task!=null){
%>
	<p>	
	<%=new Button("����...","���е�ǰ�ĵ�Ԫ","runTarget()","","").getHtmlText()%>
	<p>
	<TABLE id=dataTable borderColor=#999999  width=80% cellspacing="0" borderColorDark=#efefef cellPadding=0 align=left bgColor=#e4e4e4 border=1>
<%	
	for(int j=0;j<task.getTargetCount();j++){
		Target target = (Target)task.getTargets()[j];
%>

	<TR style="PADDING-RIGHT: 2px; PADDING-LEFT: 2px" bgColor=#9fbef4 height=20>
	<TD class=GDTdHeader  noWrap align=left  width=15%>����&nbsp;&nbsp;</TD>
	<TD style="PADDING-RIGHT: 4px; PADDING-LEFT: 4px; FONT-SIZE: 9pt; CURSOR: hand; COLOR: gray; valign: top; align: absmiddle"  align=left  bgColor=#f5f5f5><%=target.getName()%></TD>
	</TR>
	<TR style="PADDING-RIGHT: 2px; PADDING-LEFT: 2px" bgColor=#9fbef4 height=20>
	<TD class=GDTdHeader  noWrap align=left width=15% >����&nbsp;&nbsp;</TD>
	<TD style="PADDING-RIGHT: 4px; PADDING-LEFT: 4px; FONT-SIZE: 9pt; CURSOR: hand; COLOR: gray; valign: top; align: absmiddle"  align=left  bgColor=#f5f5f5><%=target.getDescribe()%></TD>
	</TR>
	<% 
		//�������ִ�е�Ԫ
		ExecuteUnit[] units = target.getUnits();
		if(units.length>1){
			for(int i=0;i<units.length;i++){
	%>
			<TR style="PADDING-RIGHT: 2px; PADDING-LEFT: 2px" bgColor=#9fbef4 height=20>
			<TD class=GDTdHeader  noWrap align=left  width=15%>ִ�е�Ԫ[<%=i+1 %>]&nbsp;&nbsp;</TD>
			<TD style="PADDING-RIGHT: 4px; PADDING-LEFT: 4px; FONT-SIZE: 9pt; CURSOR: hand; COLOR: gray; valign: top; align: absmiddle"  align=left bgColor=#f5f5f5><%=((ExecuteUnit)units[i]).getDescribe()%></TD>
			</TR>
	<% 
			}
		}
	%>
	
	<%}
	%>
	<TR></TR>
	</TABLE>
	
	<%
	}else{%>
			<TABLE id=dataTable width="100%"  borderColor=#9fbef4  cellspacing=0 borderColorDark=#ffffff cellPadding=0 align=left  border=0>
			<TR><TD class=ListDWArea>	
			<TR height=20>
			<TD style="PADDING-RIGHT: 4px; PADDING-LEFT: 4px; FONT-SIZE: 12pt; CURSOR: hand; COLOR: balck; valign: middle; align: absmiddle" >��Ч�ĵ�Ԫ���壡</TD>
			</TR>
			</TD></TR>
			</TABLE>
	<% }%>
	
	<%/*~BEGIN~���ɱ༭��~[Editable=false;CodeAreaID=List05;Describe=����ҳ��;]~*/%>
	<%
	String sWhere=" where 1=1 ";
	if("transferTaskFile".equals(sTaskName)){
		sWhere=" where TASKCODE ='BCRDataTransfer'";
	}else if("reportTaskFile".equals(sTaskName)){
		sWhere=" where TASKCODE ='BCRDataReport'";
	}else if("prepareTaskFile".equals(sTaskName)){
		sWhere=" where TASKCODE ='BCRDataPrepare'";
	}else if("initTaskFile".equals(sTaskName)){
		sWhere=" where TASKCODE='BCRDataInit'";
	}else if("validateTaskFile".equals(sTaskName)){
		sWhere=" where TASKCODE='BCRDataValidate'";
	}else if("changeTaskFile".equals(sTaskName)){
		sWhere=" where TASKCODE='BCRDataChange'";
	}else if("batchdelTaskFile".equals(sTaskName)){
		sWhere=" where TASKCODE='BCRDataBatchdel'";
	}else if("feedbackTaskFile".equals(sTaskName)){
		sWhere=" where TASKCODE='BackMessageProcess'";
	}
	String sql = "select TARGETCODE,RUNDESC,BEGINDATE,ENDDATE,SUCCESSFLAG from BATCH_CTRL "+sWhere+" order by ENDDATE desc" ;	
	ASResultSet rs = Sqlca.getASResultSet(new SqlObject(sql));
	int i= 0;
%>

	<div id="div_process" style="overflow-y: auto; width:100%; height:50%;clear:both;padding-top:20px;">
	<table border="1" width="80%" align="left" cellspacing="0" cellpadding="4" style="border-collapse: collapse;" bgcolor="#FFFFFF" >
	 <tr>
	  <td bgcolor="#99B0CE" style="font-size:12px;color:red" height=24 colspan=8>����ִ�н���... </td>
	 </tr>
	 <tr>
	  		<td>����Ԫ</td><td>״̬</td><td>��ʼִ��ʱ��</td><td>����ʱ��</td>
	 </tr>
	 <%while(rs.next()) {%>
	 <tr>
		<td><%=rs.getString("RUNDESC") %></td>
		<%if(rs.getString("SUCCESSFLAG").equals("SUCCESSFUL")){ %>
		<td>ִ�гɹ�</td>
		<%}else if(rs.getString("SUCCESSFLAG").equals("FAILED")){ %>
		<td style="color:red">ִ��ʧ��</td>
		<%} else{%>
		<td>ִ�гɹ����о���</td>
		<%} %>

		
		<td><%=rs.getString("BEGINDATE") %></td>
		<td><%=rs.getString("ENDDATE") %></td>
	 </tr>
	 <%
	 		i++;
	 		if(i==30) break;
	 	} 
	 	rs.close();
	 %>
	   <tr>
	  <td style="font-size:12px;line-height:200%">&nbsp;</td>
	 </tr>
	</table>
	</div> 
<%/*~END~*/%>
</body>
</html>

