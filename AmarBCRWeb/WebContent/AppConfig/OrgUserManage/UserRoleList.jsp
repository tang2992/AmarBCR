<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%>
<link rel="stylesheet" href="<%=sWebRootPath%>/AppConfig/OrgUserManage/resources/css/roletable.css"><%
	/*
		页面说明: 用户角色列表
	 */
	String PG_TITLE = "用户角色列表";
	//获得页面参数
	String sUserID = CurPage.getParameter("UserID");
	if (sUserID == null) sUserID = "";

	/**
	 * @Action:	 取出所有的角色，并判断该用户是否有该角色，并判断该角色是否为叶子结点
	 */	
	String sSql = " select getUserName(UserID),RoleID,getUserName(Grantor), "+
					" getItemName('IsInUse',Status),BeginTime,EndTime "+
					" from USER_ROLE "+
					" where UserID = :UserID";
	String[][] sUserRoleNodes = Sqlca.getStringMatrix(new SqlObject(sSql).setParameter("UserID",sUserID));
	for(int i=0;i<sUserRoleNodes.length;i++){
		for(int j=0;j<sUserRoleNodes[i].length;j++){
			if(sUserRoleNodes[i][j]==null) sUserRoleNodes[i][j]="";
		}
	}
    //实例化用户对象
	ASUser o_User = ASUser.getUser(sUserID,Sqlca);		
	//获取机构级别
	String sOrgLevel = Sqlca.getString(new SqlObject("select OrgLevel from ORG_INFO where OrgID = :OrgID").setParameter("OrgID",o_User.getOrgID()));
	if(sOrgLevel == null) sOrgLevel = "";
	
    sSql = "select RoleID,RoleName from ROLE_INFO where 1=1 ";
    if(sOrgLevel.equals("0")) //机构级别OrgLevel(0：总行；3：分行；6：支行；9：网点)
    	 sSql += " and (RoleID like '0%' "+	        		
        		 " or RoleID like '8%') "+
        		 " and RoleStatus = '1' ";
    if(sOrgLevel.equals("3")) //机构级别OrgLevel(0：总行；3：分行；6：支行；9：网点)
    	 sSql += " and (RoleID like '2%' "+	        		
        		 " or RoleID like '8%') "+
        		 " and RoleStatus = '1' ";
    if(sOrgLevel.equals("6")) //机构级别OrgLevel(0：总行；3：分行；6：支行；9：网点)
        sSql += " and (RoleID like '4%' "+
        		" or RoleID like '8%') "+
        		" and RoleStatus = '1' ";
     sSql += " order by RoleID ";
     String[][] asRoleNodes = Sqlca.getStringMatrix(sSql);
     String[][] sRoleNodes = new String[asRoleNodes.length][8];
     for(int i=0;i<sRoleNodes.length;i++){
   		 sRoleNodes[i][0]=asRoleNodes[i][0];
   		 sRoleNodes[i][1]=asRoleNodes[i][1];
   		 sRoleNodes[i][2]="TRUE";
   		 sRoleNodes[i][3]="FALSE";
	   	 sRoleNodes[i][4]=""; //授权人
         sRoleNodes[i][5]="";
         sRoleNodes[i][6]="";
         sRoleNodes[i][7]="";
     }
     
    for(int i=0;i<sRoleNodes.length;i++){
    	//Is The Node Leaf?
    	for(int j=0;j<sRoleNodes.length;j++){
        	if(i==j) continue;
        	if(sRoleNodes[j][0].startsWith(sRoleNodes[i][0])) sRoleNodes[i][2]="FALSE";
        }
        
        //Has The Node Role?
        for(int j=0;j<sUserRoleNodes.length;j++){
        	if(sRoleNodes[i][0].equals(sUserRoleNodes[j][1])){
                sRoleNodes[i][3]="TRUE";
                sRoleNodes[i][4]=sUserRoleNodes[j][2]; //授权人
                sRoleNodes[i][5]=sUserRoleNodes[j][3];
                sRoleNodes[i][6]=sUserRoleNodes[j][4];
                sRoleNodes[i][7]=sUserRoleNodes[j][5];
            }
        }
    }
%>
<body leftmargin="0" topmargin="0" onload="" class="ListPage" >
<table style="border: 0;width: 100%;height: 100%" cellspacing="0" cellpadding="0" >
<tr height=1 align=center>
    <td>用户&nbsp;&nbsp;<font color=#6666cc>(<%=sUserID%>)</font>&nbsp;&nbsp;具有的角色
    </td>
</tr>
<tr height=1 valign=top >
    <td>
		<%=new Button("保存","保存权限定义信息","saveRightConf()","","").getHtmlText()%>
		<%=new Button("全选","全选","selectAll()","","").getHtmlText()%>
		<%=new Button("全不选","全不选","selectNone()","","").getHtmlText()%>
		<%=new Button("反选","反选","selectInverse()","","").getHtmlText()%>
		<%=new Button("恢复","恢复","restore()","","").getHtmlText()%>
    </td>
</tr>
<tr style="width: 100%" align="center">
    <td valign="top" >
    <form name=CheckBoxes>
    <div style="positition:absolute;width:100%;height:100%;overflow:auto">
	<table cellspacing="1" cellpadding="4" style="border: dash 1px;">
		<tr height=1 valign=top class="RoleTitle">
		    <td width=3% align=center>&nbsp;</td>
		    <td width=10%>角色ID</td>
		    <td width=20%>角色名称</td>
		    <td width=10%>授权人</td>
		    <td width=10%>状态</td>
		    <td width=10%>开始日</td>
		    <td width=10%>到期日</td>
		</tr>
		<%
        int countLeaf=0;
		for(int i=0;i<sRoleNodes.length;i++){
            if (sRoleNodes[i][2].equals("TRUE")){  //是否为叶
                ++countLeaf;
                if(sRoleNodes[i][3].equals("TRUE")){  //是否有角色
     	%>
			        <tr height=1 valign=top class="RoleLeafCheck">
                        <td align=center><input id="checkbox<%=countLeaf%>" type="checkbox" name="<%=sRoleNodes[i][0]%>" checked></td>
                        <td><%=sRoleNodes[i][0]%></td>
                        <td><%=sRoleNodes[i][1]%></td>
                        <td><%=sRoleNodes[i][4]%></td>
                        <td><%=sRoleNodes[i][5]%></td>
                        <td><%=sRoleNodes[i][6]%></td>
                        <td><%=sRoleNodes[i][7]%></td>
                    </tr>
			    <%}else{%>
                    <tr height=1 valign=top class="RoleLeafUncheck">
                        <td align=center><input id="checkbox<%=countLeaf%>" type="checkbox" name="<%=sRoleNodes[i][0]%>"></td>
                        <td><%=sRoleNodes[i][0]%></td>
                        <td><%=sRoleNodes[i][1]%></td>
                        <td><%=sRoleNodes[i][4]%></td>
                        <td><%=sRoleNodes[i][5]%></td>
                        <td><%=sRoleNodes[i][6]%></td>
                        <td><%=sRoleNodes[i][7]%></td>
                    </tr>
                <%}
		    }else{
		        %>
                <tr height=1 valign=top class="RoleNode">
                    <td>&nbsp;</td>
                    <td><%=sRoleNodes[i][0]%></td>
                    <td><%=sRoleNodes[i][1]%></td>
                    <td><%=sRoleNodes[i][4]%></td>
                    <td><%=sRoleNodes[i][5]%></td>
                    <td><%=sRoleNodes[i][6]%></td>
                    <td><%=sRoleNodes[i][7]%></td>
                </tr>
                <%
		    }
		}
		%>
	</table>
	</div>
	</form>
    </td>
</tr>
</table>
</body>
</html>
<script type="text/javascript">
	function saveRightConf(){
		var iControls = <%=countLeaf%>;
		if(!confirm("确认要保存对角色的修改吗？")){
			return;
		}
		var sRoleIDs = "";
		var iTmp = 1;
		for(iTmp=1;iTmp<=iControls;iTmp++){
			if(document.all["checkbox"+iTmp].checked){
				sRoleIDs = sRoleIDs + document.all["checkbox"+iTmp].name +"@";
			}
		}
		var sReturnMessage = RunJavaMethodSqlca("com.amarsoft.app.awe.config.orguser.action.AddMuchRolesAction","addMuchRoles","UserID=<%=CurUser.getUserID()%>,Action=UPDATE,UsersID=<%=sUserID%>,RolesID="+sRoleIDs);
		alert(sReturnMessage);
		reloadSelf();
	}

	function selectAll(){
		var iControls = <%=countLeaf%>;
		var iTmp = 1;
		for(iTmp=1;iTmp<=iControls;iTmp++){
			document.all["checkbox"+iTmp].checked=true;
		}
	}
	
	function selectNone(){
		var iControls = <%=countLeaf%>;
		var iTmp = 1;
		for(iTmp=1;iTmp<=iControls;iTmp++){
			document.all["checkbox"+iTmp].checked=false;
		}
	}
	
	function selectInverse(){
		var iControls = <%=countLeaf%>;
		var iTmp = 1;
		for(iTmp=1;iTmp<=iControls;iTmp++){
			document.all["checkbox"+iTmp].checked=!document.all["checkbox"+iTmp].checked;
		}
	}
	
	function restore(){
		document.forms["CheckBoxes"].reset();
	}
</script>
<%@ include file="/IncludeEnd.jsp"%>