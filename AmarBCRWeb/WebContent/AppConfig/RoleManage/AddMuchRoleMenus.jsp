<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBeginMD.jsp"%>
<script type="text/javascript">
	var availableRoleNameList = new Array;
	var availableRoleIDList = new Array;
	var selectedRoleNameList = new Array;
	var selectedRoleIDList = new Array;
<%
	String queryStr = " SELECT RoleID,RoleName FROM AWE_ROLE_INFO WHERE length(RoleID)>1 and RoleStatus = '1' order by SortNo";
	ASResultSet rs = Sqlca.getASResultSet(new SqlObject(queryStr));
	int num = 0;
	while(rs.next()){
		String roleID = rs.getString("RoleID");
		String roleName = rs.getString("RoleName");
		String displayName = roleID +"   "+roleName;
		out.println("availableRoleNameList[" + num + "] = '" + displayName + "';\r");
		out.println("availableRoleIDList[" + num + "] = '" + roleID + "';\r");
		num++;
	}
	rs.getStatement().close();
%>
</script>
<head>
	<title>���˵���ɫ��Ȩ</title>
</head>
<body bgcolor="#E4E4E4" scroll="no">
<form name="chooseform">
<table align="center" width="100%">
	<tr>
		<td width='50%'>
			<table width='100%' border='1' cellpadding='0' cellspacing='5' bgcolor='#DDDDDD'>
				<tr>
					<td colspan="2"><span>ѡȡҪ���õĽ�ɫ</span></td>
				</tr>
				<tr>
					<td colspan="2" bgcolor='#DDDDDD'><span class='dialog-label'>�����õĽ�ɫ�б�</span></td>
				</tr>
				<tr>
					<td colspan="2" align='center'>
						<select name='role_available' onchange='selectionChanged(document.forms["chooseform"].elements["role_available"],document.forms["chooseform"].elements["role_chosen"]);' size='12' style='width:100%;' multiple> 
						</select>
					</td>
				</tr>
				<tr>
					<td align='center' valign='middle' bordercolor='#DDDDDD'>
						<%=new Button("��","����","moveSelected(document.forms['chooseform'].elements['role_available'],document.forms['chooseform'].elements['role_chosen']);updateHiddenChooserField(document.forms['chooseform'].elements['role_chosen'],document.forms['chooseform'].elements['report']);","","").getHtmlText()%>
						<%=new Button("��","�Ƴ�","moveSelected(document.forms['chooseform'].elements['role_chosen'],document.forms['chooseform'].elements['role_available']);updateHiddenChooserField(document.forms['chooseform'].elements['role_chosen'],document.forms['chooseform'].elements['report']);","","").getHtmlText()%>
					</td>
				</tr>
				<tr>
					<td colspan="2" bgcolor='#DDDDDD'><span class='dialog-label'>�����õĽ�ɫ�б�</span></td>
				</tr>
				<tr>
					<td colspan="2" align='center'>
						<select name='role_chosen' onchange='selectionChanged(document.forms["chooseform"].elements["role_chosen"],document.forms["chooseform"].elements["role_available"]);' size='12' style='width:100%;' multiple>
						</select>
						<input type='hidden' name='report' value=''>
					</td>
				</tr>
			</table>
		</td>
		<td width='50%'>
			<table width='100%' border='1' cellpadding='0' cellspacing='0' bgcolor='#DDDDDD'>
				<tr>
					<td colspan="1"><span>ѡȡҪ���õĲ˵�</span></td>
				</tr>
				<tr>
					<td id="myleft" colspan='3' align=center width=100%>
						<div style="positition:absolute;align:left;height:510px;overflow-y: hide;">
							<iframe name="left" src="<%=sWebRootPath%>/Blank.jsp" width=100% height=100% frameborder=0 scrolling=no ></iframe>
						</div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
		<table>
			<tr>
				<td>
					<span>ѡȡ���÷�ʽ��</span>
				</td>
				<td>
					<select name="configtype">
						<option selected value='1' >��������</option>
						<option value='2' >��������</option>
					</select>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td align="center" colspan="2">
			<%=new Button("&nbsp;��&nbsp;��&nbsp;","�ָ�","doDefault()","","").getHtmlText()%>
			<%=new Button("&nbsp;ȷ&nbsp;��&nbsp;","ȷ��","doConfig()","","").getHtmlText()%>
			<%=new Button("&nbsp;ȡ&nbsp;��&nbsp;","ȡ��","top.returnValue='_none_';top.close();","","").getHtmlText()%>
		</td>
	</tr>
</table>
</form>
</body>
<script type="text/javascript">
	function cloneOption(option){
		var out = new Option(option.text,option.value);
		out.selected = option.selected;
		out.defaultSelected = option.defaultSelected;
		return out;
	}
	
	function moveSelected(from,to){
		newTo = new Array();
		for(var i=0; i<to.options.length; i++){
			newTo[newTo.length] = cloneOption(to.options[i]);
			newTo[newTo.length-1].selected = false;
		}
		
		for(i=0; i<from.options.length; i++){
			if (from.options[i].selected){
				newTo[newTo.length] = cloneOption(from.options[i]);
				from.options[i] = null;
				i--;
			}
		}
		to.options.length = 0;
		for(i=0; i<newTo.length; i++){
			to.options[to.options.length] = newTo[i];
		}
		selectionChanged(to,from);
	}
   
	function updateHiddenChooserField(chosen,hidden){
		hidden.value='';
		var opts = chosen.options;
		for(var i=0; i<opts.length; i++){
			hidden.value = hidden.value + opts[i].value+'\n';
		}
	}
   
	function selectionChanged(selectedElement,unselectedElement){
		for(var i=0; i<unselectedElement.options.length; i++){
			unselectedElement.options[i].selected=false;
		}
		form = selectedElement.form;
	}
   
	function doConfig(){
		var configType = chooseform.configtype.value; //���÷�ʽ
		var configTypeName = "��������";
		if(configType !="1") configTypeName = "��������";
		
   		if(chooseform.role_chosen.length == 0){
   			alert("��ѡ��Ҫ���õĽ�ɫ��");
   			return;
   		}
   		
   		var vReturn = "";
   		for(var i=0; i<chooseform.role_chosen.length;i++ ){
   			var vTemp = chooseform.role_chosen.options[i].value;
               vReturn += vTemp+"@";
   		}
   		
   		var nodes = getCheckedTVItems(); //��ͼ��ʶ�Ľڵ�
   		if(nodes.length == 0){
   			alert("��ѡ��Ҫ���õĲ˵���");
   			return;
   		}
   		
   		var vReturn1 = "";
   		for(var i=0;i<nodes.length;i++){
   			vReturn1 += nodes[i].id + "@";
   		}
   		
		if(confirm("��ȷ���ԡ�"+configTypeName+"����ʽ����ѡ�Ľ�ɫ��Ȩ���˵���")){
    		var sReturn = RunJavaMethodTrans("com.amarsoft.app.awe.config.role.action.AddMuchRoleMenusAction","addMuchRoleMenus","ConfigType="+configType+",RoleIDs="+vReturn+",MenuIDs="+vReturn1);
			if(sReturn =="SUCCEEDED"){
				alert("�������������˵��ɹ���");
			}else{
				alert("�������������˵�ʧ�ܣ�");
			}
			top.close();
	    }
	}
	
	function doDefault(){
		chooseform.role_available.options.length = 0;
		chooseform.role_chosen.options.length = 0;
		var j = 0;
		for(var i = 0; i < availableRoleIDList.length; i++){
			eval("chooseform.role_available.options[" + j + "] = new Option(availableRoleNameList[" + i + "], availableRoleIDList[" + i + "])");
			j++;
		}
		
		j = 0;
	}
	
	function startMenu(){
	<%
		HTMLTreeView tviTemp = new HTMLTreeView("��ɫ��Ȩ�˵�","right");
		tviTemp.MultiSelect = true;
		tviTemp.initWithSql("MenuID","MenuName","MenuID","","from AWE_MENU_INFO where IsInUse='1'",Sqlca);
		out.println(tviTemp.generateHTMLTreeView());
	%>
	}
	
	startMenu();
	expandNode('root');
	doDefault();
</script>
<%@ include file="/IncludeEnd.jsp"%>