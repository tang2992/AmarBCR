<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List00;Describe=ע����;]~*/%>
	<%
	/*
		Author:   cwzhan 2004-12-28
		Tester:
		Content: Ȩ���б�
		Input Param:
                  
		Output param:
		                
		History Log: 
            
	 */
	%>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List01;Describe=����ҳ������;]~*/%>
	<%
	String PG_TITLE = "Ȩ���б�"; // ��������ڱ��� <title> PG_TITLE </title>  
	%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List02;Describe=�����������ȡ����;]~*/%>
<%

	//�������
	String sSqldel = "";
	String sPara = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("Para"));
    String sRightStringToUpdate = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("RightStringToUpdate"));
    if (sPara == null) sPara = "@";
    String sParas[] = sPara.split("@");//����ţ����ͣ��û�����ɫ�������Ͷ�Ӧ��ţ��û��š���ɫ�ţ�
    String sRelativeTable="";   //Ȩ�޹�����
    String sKey=""; //��Ӧ�����������
    String sInsertSql="";  //Insert���
    String sSelectSql="";
    
    sRelativeTable="ROLE_RIGHT";
    sKey="RoleID";
    sSelectSql="select RightID from ROLE_RIGHT where RoleID='"+sParas[1]+"'";
 %>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List03;Describe=�������ݶ���;]~*/%>
<%	
    StringTokenizer st =null;
    ASResultSet rs1 = null;
	String sParastr = "",sSplit1="",sSplit2 = "",sSqlStr = "";
	int iCount = 0;
	//������ҳ���ύʱ��ִ�б�����
	if(sRightStringToUpdate!=null && !sRightStringToUpdate.equals("")){
		st = new StringTokenizer(sRightStringToUpdate,"@");		
		SqlcaRepository.executeSQL(" delete from "+sRelativeTable+" where "+sKey+"='"+sParas[1]+"'");
        while (st.hasMoreTokens())
		{
			sParastr = st.nextToken(); 
			sSplit1 = StringFunction.getSeparate(sParastr,":",1);
			sSplit2 = StringFunction.getSeparate(sParastr,":",2);
            if(sSplit2!=null && sSplit2.equals("true")){
              		sSqlStr = 	"select count(RightId) from ROLE_RIGHT where RightId = '"+sSplit1+"' " + " and RoleId = '"+sParas[1]+"' ";
                    rs1 = Sqlca.getASResultSet(sSqlStr);
                    if(rs1.next())
                    	iCount = rs1.getInt(1);
                    if(iCount == 0)
                    {
	                    sInsertSql=" insert into ROLE_RIGHT(RoleID,RightId,InputUser,InputOrg,InputTime) values('"+sParas[1]+"','"+sSplit1+"' ,'"+CurUser.getUserID()+"','"+CurUser.getOrgID()+"','"+StringFunction.getToday()+" "+StringFunction.getNow()+"')";
	                    SqlcaRepository.executeSQL(sInsertSql);
	                }
                
            }
		}
		%>
		<script>alert("����ɹ�");</script>
		<%
	}    
    String sSql = "";
    ASResultSet rs=null;
    String sCompOrderNo = "";//��������
    String sRightIDString="";

    //ȡ��������
	sSql = "select OrderNo from REG_COMP_DEF where CompID='"+sParas[0]+"'";
	rs = SqlcaRepository.getASResultSet(sSql);
	if(rs.next()) sCompOrderNo = rs.getString("OrderNo");
	rs.getStatement().close();
    
    //ȡ����ǰ�û������е�Ȩ��
	rs = SqlcaRepository.getASResultSet(sSelectSql);
	while(rs.next()){
		sRightIDString = sRightIDString + rs.getString(1)+"@";
	}
	rs.getStatement().close();
        
    sSql = "select RightID,RightName,getItemName('IsInUse',RightStatus) as RightStatus from RIGHT_INFO WHERE RightID in (select RightID from REG_COMP_DEF where OrderNo like'"+sCompOrderNo+"%') or RightID in (select RightID from REG_FUNCTION_DEF where CompID in ((select CompID from REG_COMP_DEF where OrderNo like'"+sCompOrderNo+"%')))  ORDER BY RightID ";
    sSqldel = " and RightID in (select RightID from REG_COMP_DEF where OrderNo like'"+sCompOrderNo+"%') or RightID in (select RightID from REG_FUNCTION_DEF where CompID in ((select CompID from REG_COMP_DEF where OrderNo like'"+sCompOrderNo+"%')))" ;
%>

<%/*~END~*/%>

<body leftmargin="0" topmargin="0" onload="" class="ListPage">
<table border="0" width="100%" height="100%" cellspacing="0" cellpadding="0" >
<tr height=1>
    <%
        rs=Sqlca.getASResultSet("select RoleName from AWE_ROLE_INFO where RoleID='"+sParas[1]+"'");
        if (rs.next())
        {
             out.println("<td>��ɫ&nbsp;&nbsp;<font color=#6666cc>"+rs.getString(1)+"("+sParas[1]+")</font>&nbsp;&nbsp;���е�Ȩ��</td>");
        }
        rs.getStatement().close();
    %>
</tr>
<tr height=1 valign=top >
    <td>
    	<table>
	    	<tr>
	    		<td>
	                	<%=ASWebInterface.generateControl(SqlcaRepository,CurComp,sServletURL,"","Button","����","����Ȩ�޶�����Ϣ","javascript:saveRightConf()",sResourcesPath)%>
	    		</td>
	    		<td>
	                	<%=ASWebInterface.generateControl(SqlcaRepository,CurComp,sServletURL,"","Button","ȫѡ","ȫѡ","javascript:selectAll()",sResourcesPath)%>
	    		</td>
	    		<td>
	                	<%=ASWebInterface.generateControl(SqlcaRepository,CurComp,sServletURL,"","Button","ȫ��ѡ","ȫ��ѡ","javascript:selectNone()",sResourcesPath)%>
	    		</td>
	    		<td>
	                	<%=ASWebInterface.generateControl(SqlcaRepository,CurComp,sServletURL,"","Button","��ѡ","��ѡ","javascript:selectInverse()",sResourcesPath)%>
	    		</td>
	    		<td>
	                	<%=ASWebInterface.generateControl(SqlcaRepository,CurComp,sServletURL,"","Button","�ָ�","�ָ�","javascript:restore()",sResourcesPath)%>
	    		</td>
    		</tr>
    	</table>
    </td>
</tr>
<tr>
    <td valign="top" >
	<div style="position:absolute;width:100%;height:100%;overflow:auto">
	<table border="0"  cellspacing="1" cellpadding="4" style="{border:  dash 1px;overflow:scroll;}" >
		<tr height=1 valign=top class="RoleTitle">
		    <td width=3% align=center>&nbsp;</td>
		    <td width=10%>Ȩ��ID</td>
		    <td width=20%>Ȩ������</td>
		    <td width=10%>״̬</td>
		</tr>
		<form method=post name=RightConfig>
			<INPUT TYPE="hidden" NAME="RightStringToUpdate">
			<INPUT TYPE="hidden" NAME="Para" value="<%=sPara%>">
			<INPUT TYPE="hidden" NAME="DeleteString" value="<%=sSqldel%>">
		</form>
		<form name=CheckBoxes>
        <%
        int countLeaf=0;
		rs=Sqlca.getASResultSet(sSql);		
        while (rs.next()) 
        {
            ++countLeaf;            
            if(sRightIDString.indexOf(rs.getString("RightID"))>=0)  //�Ƿ���Ȩ��
            {%>
                <tr height=1 valign=top class="RoleLeafCheck">
                    <td align=center>
                        <INPUT ID="checkbox<%=countLeaf%>" TYPE="checkbox" NAME="<%=rs.getString("RightID")%>" checked>
                    </td>
                    <td><%=rs.getString(1)%></td>
                    <td><%=rs.getString(2)%></td>
                    <td><%=rs.getString(3)%></td>
                </tr>
            <%}else
            {
            %>
                <tr height=1 valign=top class="RoleLeafUncheck">
                    <td align=center>
                        <INPUT ID="checkbox<%=countLeaf%>" TYPE="checkbox" NAME="<%=rs.getString("RightID")%>">
                    </td>
                    <td><%=rs.getString(1)%></td>
                    <td><%=rs.getString(2)%></td>
                    <td><%=rs.getString(3)%></td>
                </tr>
            <%
            }
            %>
		    
		<%
		}
		rs.getStatement().close();
		%>
		</form>
	</table>
	</div>
    </td>
</tr>
</table>
</body>
</html>

<script>
	//��ҳ�����Լ����Լ������ύ�����ԣ���ִ��function�Ժ��ύ������ҳ�棬����ִ��
	function saveRightConf(){
		var iControls = <%=countLeaf%>;
		if(!confirm("ȷ��Ҫ����Խ�ɫ���޸���")){
			return;
		}
		var sRightStringToUpdate = "";
		var iTmp = 1;
		for(iTmp=1;iTmp<=iControls;iTmp++){
			sRightStringToUpdate = sRightStringToUpdate + document.all("checkbox"+iTmp).name + ":" + document.all("checkbox"+iTmp).checked+"@";
		}
		document.all("RightStringToUpdate").value=sRightStringToUpdate;
		document.forms("RightConfig").submit();
	}

	function selectAll(){
		var iControls = <%=countLeaf%>;
		var iTmp = 1;
		for(iTmp=1;iTmp<=iControls;iTmp++){
			document.all("checkbox"+iTmp).checked=true;
		}

	}
	function selectNone(){
		var iControls = <%=countLeaf%>;
		var iTmp = 1;
		for(iTmp=1;iTmp<=iControls;iTmp++){
			document.all("checkbox"+iTmp).checked=false;
		}

	}
	function selectInverse(){
		var iControls = <%=countLeaf%>;
		var iTmp = 1;
		for(iTmp=1;iTmp<=iControls;iTmp++){
			document.all("checkbox"+iTmp).checked=!document.all("checkbox"+iTmp).checked;
		}

	}
	function restore(){
		document.forms("CheckBoxes").reset();

	}
	
</script>

<%@ include file="/IncludeEnd.jsp"%>
