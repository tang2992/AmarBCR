<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List00;Describe=ע����;]~*/%>
	<%
	/*
		Author:   hywang
		Tester:
		Content: �û���ɫ�б�
		Input Param:
                  
		Output param:
		                
		History Log: 
            
	 */
	%>
<%/*~END~*/%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List01;Describe=����ҳ������;]~*/%>
	<%
	String PG_TITLE = "�û���ɫ�б�"; // ��������ڱ��� <title> PG_TITLE </title>  
	%>
<%/*~END~*/%>

<%!

	String setTitle(String sRoleID){
		String sName = "";
		if(sRoleID.substring(0,2).equals("01")&&sRoleID.substring(sRoleID.length()-1).equals("0")){
			sName = "����ά����ɫ";
		}
		if(sRoleID.substring(0,2).equals("04")&&sRoleID.substring(sRoleID.length()-1).equals("0")){
			sName = "�ļ������ɫ";
		}
		if(sRoleID.substring(0,2).equals("07")&&sRoleID.substring(sRoleID.length()-1).equals("0")){
			sName = "ϵͳ�����ɫ";
		}
		if(sRoleID.substring(0,3).equals("090")&&sRoleID.substring(sRoleID.length()-1).equals("0")){
			sName = "���鴦���ɫ";
		}
		if(sRoleID.substring(0,2).equals("10")&&sRoleID.substring(sRoleID.length()-1).equals("0")){
			sName = "��������";
		}
		return sName;
}


%>

<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List02;Describe=�����������ȡ����;]~*/%>
<%

	//�������
	String sSortNo; //������
	String sUserID = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("UserID"));
	if (sUserID == null) sUserID = "";
	String sRightStringToUpdate = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("RightStringToUpdate"));
    if (sRightStringToUpdate == null) sRightStringToUpdate = "";
  
%>
<%/*~END~*/%>


<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List03;Describe=�������ݶ���;]~*/%>
<%	
	StringTokenizer st =null;
	String sSplitStr = "",sSplit1 = "",sSplit2 = "",sSql="";
	ASResultSet  rs = null;
	if(!sRightStringToUpdate.equals("")){
		st = new StringTokenizer(sRightStringToUpdate,"@");
		//ɾ�����û����иû����Ľ�ɫ
		SqlcaRepository.executeSQL("delete from USER_ROLE where UserID = '"+sUserID+"'");
		 while (st.hasMoreTokens())
			{
				sSplitStr = st.nextToken(); 
				sSplit1 = StringFunction.getSeparate(sSplitStr,":",1);
				sSplit2 = StringFunction.getSeparate(sSplitStr,":",2);
				
				if(sSplit2!=null && sSplit2.equals("true")){
					//�����ɫ��USER_ROLE����
		            SqlcaRepository.executeSQL(" insert into USER_ROLE(UserID,RoleId,Grantor,BeginTime,EndTime,InputUser,InputOrg,InputTime,Status) "
		  		         + " values('"+sUserID+"','"+sSplit1+"' ,'"+CurUser.getUserID()+"','"+StringFunction.getToday()+"','','"+CurUser.getUserID()+"','"+CurUser.getOrgID()+"','"+StringFunction.getToday()+" "+StringFunction.getNow()+"','1')");
				}
			}
		%>
		<script>alert(getHtmlMessage('4'));//��Ϣ����ɹ���</script>
		<%
	}
    
  
    sSql = " select getUserName(UR.UserID),RoleID,getUserName(Grantor), "+
    			  " getItemName('IsInUse',UR.Status),BeginTime,EndTime "+
    			  " from USER_ROLE UR,USER_INFO UI  "+
    			  " where UR.UserID = '"+sUserID + "' and UR.UserID= UI.UserID and UR.Status='1'";
	
	rs=Sqlca.getASResultSet(sSql);
    int iRow = rs.getRowCount();
    if (iRow==0) iRow=1;
    String[][] sUserRoleNodes = new String[iRow][6] ;
    iRow=0;
    while (rs.next())
    {
    	if(rs.getString(1) == null)
    		sUserRoleNodes[iRow][0] = "";
    	else
    		sUserRoleNodes[iRow][0] = rs.getString(1);  
    	if(rs.getString(2) == null)
    		sUserRoleNodes[iRow][1] = "";
    	else
    		sUserRoleNodes[iRow][1] = rs.getString(2);  
    	if(rs.getString(3) == null)
    		sUserRoleNodes[iRow][2] = "";
    	else
    		sUserRoleNodes[iRow][2] = rs.getString(3);  
    	if(rs.getString(4) == null)
    		sUserRoleNodes[iRow][3] = "";
    	else
    		sUserRoleNodes[iRow][3] = rs.getString(4);  
    	if(rs.getString(5) == null)
    		sUserRoleNodes[iRow][4] = "";
    	else
    		sUserRoleNodes[iRow][4] = rs.getString(5);  
    	if(rs.getString(6) == null)
    		sUserRoleNodes[iRow][5] = "";
    	else
    		sUserRoleNodes[iRow][5] = rs.getString(6); 

    	iRow++;
    }
    rs.getStatement().close();
	
    sSql = "select RoleID,RoleName from AWE_ROLE_INFO where RoleStatus='1' and RoleID <> '800' order by RoleID";
  
    rs=Sqlca.getASResultSet(sSql);
    iRow = rs.getRowCount();
    if (iRow==0) iRow=1;
    String[][] sRoleNodes = new String[iRow][8] ;
    iRow=0;
    while (rs.next())
    {
    	sRoleNodes[iRow][0]=rs.getString(1);//roleID
    	sRoleNodes[iRow][1]=rs.getString(2);//roleName
    	sRoleNodes[iRow][2]="";	
    	sRoleNodes[iRow][3]="FALSE";	//�Ƿ��иý�ɫ
    	sRoleNodes[iRow][4]=""; //��Ȩ��
        sRoleNodes[iRow][5]="";
        sRoleNodes[iRow][6]="";
        sRoleNodes[iRow][7]="";
    	iRow++;
    }
    rs.getStatement().close();
    
    
    for(int i=0;i<sRoleNodes.length;i++)
    {
        for(int j=0;j<sUserRoleNodes.length;j++)
        {
        	//�Ƿ��н�ɫ,������û��иý�ɫ��������sRoleNodes[i][3]=true
        	if(sRoleNodes[i][0].equals(sUserRoleNodes[j][1])) 
            {
                sRoleNodes[i][3]="TRUE";
                sRoleNodes[i][4]=sUserRoleNodes[j][2]; //��Ȩ��
                sRoleNodes[i][5]=sUserRoleNodes[j][3];
                sRoleNodes[i][6]=sUserRoleNodes[j][4];
                sRoleNodes[i][7]=sUserRoleNodes[j][5];
            }
        }
        
    }

	
%>

<%/*~END~*/%>

<body leftmargin="0" topmargin="0" onload="" class="ListPage" onLoad="setParent()">
<table border="0" width="100%" height="100%" cellspacing="0" cellpadding="0" >
<tr height=1 align=center>
    <td>�û�&nbsp;&nbsp;<font color=#6666cc>(<%=sUserID%>)</font>&nbsp;&nbsp;���еĽ�ɫ
        
    </td>
</tr>
<tr height=1 width=100% align="center" >
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
<tr width=100% align="center" >
    <td valign="top" >
    <div style="positition:absolute;width:100%;height:100%;overflow:auto">
	<table border="0"  cellspacing="1" cellpadding="4" style="{border:  dash 1px;}">
		<tr height=1 valign=top class="RoleTitle">
		    <td width=3% align=center>&nbsp;</td>
		    <td width=10%>��ɫID</td>
		    <td width=22%>��ɫ����</td>
			<td width=3% align=center>&nbsp;</td>
			<td width=10%>��ɫID</td>
		    <td width=22%>��ɫ����</td>
		</tr>
		<form method=post name=RightConfig>
			<INPUT TYPE="hidden" NAME="RightStringToUpdate">
			<INPUT TYPE="hidden" NAME="UserID" value="<%=sUserID%>">
		</form>
		<form name=CheckBoxes>
		<%
        int countLeaf=-1,i=0,j=0;
		for(i=0;i<sRoleNodes.length;i++)
        {            
			countLeaf++;
			String sName = "", sGroupName="";
        	if(!(sName=setTitle(sRoleNodes[i][0])).equals("")){
        		sGroupName = sRoleNodes[i][0].substring(0,2);
	        %>
			<tr  valign=center height='20' bgColor = #6382BC>
			<td align=center>
            	<INPUT ID="<%=countLeaf%>" TYPE="checkbox" name="check" onClick="onCheck(<%=j%>,0)">
          	</td>
			<td><%=sName%></td>
			<td></td>
			<% if(sRoleNodes[i][0].substring(0,2).equals("10")||sRoleNodes[i][0].substring(0,2).equals("09")){%>	
			<td></td>
			<td></td>
			<td></td>
			<%}else{ %>
			<td align=center>
            	<INPUT ID="<%=countLeaf%>" TYPE="checkbox" name="check1" onClick="onCheck(<%=j%>,1)">
          	</td>
			<td><%=sName%></td>
			<td></td>
			</tr>
			<%
			}
	       		j++;
        	}
        	int iCount = Integer.valueOf(sRoleNodes[i][0].substring(sRoleNodes[i][0].length()-1)).intValue();
        	if(iCount%2==0){
        		%>
					<tr>
				<%}
            if(sRoleNodes[i][3].equals("TRUE"))  //�Ƿ��н�ɫ
            {    
            %>      	
		        
                    <td align=center>
                        <INPUT ID="checkbox<%=countLeaf%>" TYPE="checkbox" NAME="<%=sRoleNodes[i][0]%>"  onClick="setParent()" checked>
                    </td>
                    <td><%=sRoleNodes[i][0]%></td>
                    <td><%=sRoleNodes[i][1]%></td>
               
		    <%}else
            {                	
            %>
               
                    <td align=center>
                        <INPUT ID="checkbox<%=countLeaf%>" TYPE="checkbox" NAME="<%=sRoleNodes[i][0]%>" onClick="setParent()">
                    </td>
                    <td><%=sRoleNodes[i][0]%></td>
                    <td><%=sRoleNodes[i][1]%></td>
            <%
            
            }
            if((iCount+1)%2==0){
        		%>
					</tr>
			<%}
  		}
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
	function checkAny(start,end,index){
		var flag = true;
		start = parseInt(start);
		end = parseInt(end);
		while(start<end){
			var group = document.all("checkbox"+start).name;
			if(document.all("checkbox"+start).checked==false&&group%2==index){
				flag = false;
			}
			start++;
		}
		if(start==<%=countLeaf%>&&flag == true){
			var group = document.all("checkbox"+start).name;
			if(document.all("checkbox"+start).checked==false&&group%2==index){
				flag = false;
			}
		}
		return flag;
	}

	function setCheckBox(){
		var iControls = <%=countLeaf%>;
		var flag = true;
		var start = 0;
		var end = 0;
		for(iTmp=0;iTmp<document.CheckBoxes.check.length-1;iTmp++){
			start = document.CheckBoxes.check[iTmp].id;
			end = document.CheckBoxes.check[iTmp+1].id;
			flag = checkAny(start,end,0);
			if(flag==true)
				document.CheckBoxes.check[iTmp].checked = true;
			else
				document.CheckBoxes.check[iTmp].checked = false;
		}
		start = document.CheckBoxes.check[document.CheckBoxes.check.length-1].id
		end = iControls;
		flag = checkAny(start,end,0);
		if(flag==true)
			document.CheckBoxes.check[document.CheckBoxes.check.length-1].checked = true;
		else
			document.CheckBoxes.check[document.CheckBoxes.check.length-1].checked = false;
	}
	
	function setCheckBox1(){
		var iControls = <%=countLeaf%>;
		var flag = true;
		var start = 0;
		var end = 0;
		for(iTmp=0;iTmp<document.CheckBoxes.check1.length-1;iTmp++){
			start = document.CheckBoxes.check1[iTmp].id;
			end = document.CheckBoxes.check1[iTmp+1].id;
			flag = checkAny(start,end,1);
			if(flag==true)
				document.CheckBoxes.check1[iTmp].checked = true;
			else
				document.CheckBoxes.check1[iTmp].checked = false;
			flag = true;
		}
		start = document.CheckBoxes.check1[document.CheckBoxes.check1.length-1].id;
		end = document.CheckBoxes.check[document.CheckBoxes.check1.length].id;
		flag = checkAny(start,end,1);
		if(flag==true)
			document.CheckBoxes.check1[document.CheckBoxes.check1.length-1].checked = true;
		else
			document.CheckBoxes.check1[document.CheckBoxes.check1.length-1].checked = false;
	}

	function setParent(){
		var flag = true;
		var iControls = <%=countLeaf%>;
		var iTmp = 0; 
		//checkbox��
		setCheckBox();
		//checkbox1��
		setCheckBox1();
		
	}

	function setCheck1(index){
		var iControls = <%=countLeaf%>;
		var check = document.CheckBoxes.check1[index].checked;
		if(document.CheckBoxes.check1.length>index+1){
			start = parseInt(document.CheckBoxes.check1[index].id);
			end = parseInt(document.CheckBoxes.check1[index+1].id);
			for(iTmp=start;iTmp<end;iTmp++){
				if(iTmp%2==1)
					document.all("checkbox"+iTmp).checked=check;
			}
		}else{
			start = parseInt(document.CheckBoxes.check1[index].id);
			end = parseInt(document.CheckBoxes.check[index+1].id);
			for(iTmp=start;iTmp<end;iTmp++){
					if(iTmp%2==1)
						document.all("checkbox"+iTmp).checked=check;
				}
		}
	}
	
	function setCheck(index){
		var iControls = <%=countLeaf%>;
		var check = document.CheckBoxes.check[index].checked;
		start = parseInt(document.CheckBoxes.check[index].id);
		if(document.CheckBoxes.check.length>index+2){
			end = parseInt(document.CheckBoxes.check[index+1].id);
			for(iTmp=start;iTmp<end;iTmp++){
				if(iTmp%2==0)
					document.all("checkbox"+iTmp).checked=check;
			}
		}
		else{
			if(document.CheckBoxes.check.length>index+1){
				end = parseInt(document.CheckBoxes.check[index+1].id);
				for(iTmp=start;iTmp<end;iTmp++){
						document.all("checkbox"+iTmp).checked=check;
				}
			}else{
				for(iTmp=start;iTmp<=iControls;iTmp++){
						document.all("checkbox"+iTmp).checked=check;
				}
			}
				
		}
	}
	function onCheck(index,flag){
		if(flag==0)
			setCheck(index);
		else
			setCheck1(index);
	}
	
	function saveRightConf(){
		var iControls = <%=countLeaf%>;
		if(!confirm("ȷ��Ҫ����Խ�ɫ���޸���")){
			return;
		}
		var sRightStringToUpdate = "";
		var iTmp = 0;
		for(iTmp=0;iTmp<=iControls;iTmp++){
			sRightStringToUpdate = sRightStringToUpdate +  document.all("checkbox"+iTmp).name + ":" + document.all("checkbox"+iTmp).checked+"@";
		}
		document.all("RightStringToUpdate").value=sRightStringToUpdate;
		document.forms("RightConfig").submit();
	}

	function selectAll(){
		var iControls = <%=countLeaf%>;
		var iTmp = 0;
		for(iTmp=0;iTmp<=iControls;iTmp++){
			document.all("checkbox"+iTmp).checked=true;
		}
		for(iTmp=0;iTmp<document.CheckBoxes.check.length;iTmp++){
			document.CheckBoxes.check[iTmp].checked = true;
		}
		for(iTmp=0;iTmp<document.CheckBoxes.check1.length;iTmp++){
			document.CheckBoxes.check1[iTmp].checked = true;
		}

	}
	function selectNone(){
		var iControls = <%=countLeaf%>;
		var iTmp = 0;
		for(iTmp=0;iTmp<=iControls;iTmp++){
			document.all("checkbox"+iTmp).checked=false;
		}
		for(iTmp=0;iTmp<document.CheckBoxes.check.length;iTmp++){
			document.CheckBoxes.check[iTmp].checked = false;
		}
		for(iTmp=0;iTmp<document.CheckBoxes.check1.length;iTmp++){
			document.CheckBoxes.check1[iTmp].checked = false;
		}

	}
	function selectInverse(){
		var iControls = <%=countLeaf%>;
		var iTmp = 0;
		for(iTmp=0;iTmp<=iControls;iTmp++){
			document.all("checkbox"+iTmp).checked=!document.all("checkbox"+iTmp).checked;
		}
		setParent();
	}
	function restore(){
		document.forms("CheckBoxes").reset();
		setParent();
	}
	
</script>

<%@ include file="/IncludeEnd.jsp"%>
