<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List00;Describe=注释区;]~*/%>
	<%
	/*
		Author: hywang
		Tester:
		Content: 机构管理列表
		Input Param:
		Output param:
		History Log: 
            
	 */
	%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List01;Describe=定义页面属性;]~*/%>
	<%
	String PG_TITLE = "机构管理列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List02;Describe=定义变量，获取参数;]~*/%>
<%

	//定义变量
	//获取组件参数
	int iLevel  = 0;
	String sOrgID = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("OrgID"));
	if(sOrgID == null) sOrgID = "";
	String sUserID = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("UserID"));
	if(sUserID == null) sUserID = "";
	String sSortNo = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("SortNo"));
	if(sSortNo == null) sSortNo = "";
	
	String sSortNoLength = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("SortNoLength"));
	if(sSortNoLength == null) sSortNoLength = "";
	
	String[] sSortLevel = sSortNoLength.split("@");
	
	for(int i=0;i<sSortLevel.length;i++){
		if(sSortLevel[i].equals(""+sSortNo.length())){
			iLevel = i;
			break;
		}
	}
	
	//获取页面参数
	
%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List03;Describe=定义数据对象;]~*/%>
<%	
	String sHeaders[][] = {
		                  {"OrgID","机构代码"},
		                  {"OrgName","机构名称"},
			              {"BankID","银行编号"},
			              {"Status","状态"},
			              {"SortNo","机构排序号"}
	                       };

	String sSql = " select OrgID,OrgName,BankID,Status,SortNo from ORG_INFO where  SortNO like '"+sSortNo+"%' ";
	if(iLevel<sSortLevel.length-1)
		sSql = sSql + " and  length(SortNo)="+sSortLevel[iLevel+1]+" order by OrgID";
	else 
		sSql = sSql + " and  length(SortNo)="+sSortLevel[iLevel]+1+" order by OrgID";

	ASDataObject doTemp = new ASDataObject(sSql);
	doTemp.setHeader(sHeaders);	
	doTemp.UpdateTable="ORG_INFO";
	doTemp.setKey("OrgID",true);
	doTemp.setVisible("SortNo",false);
	
	//设置对应关系
	doTemp.setDDDWSql("Status","select ItemNo,ItemName from CODE_LIBRARY where CodeNo='IsInUse'");
    ASDataWindow dwTemp = new ASDataWindow(CurPage,doTemp,Sqlca);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
    dwTemp.setPageSize(200);

	//生成HTMLDataWindow
	Vector vTemp = dwTemp.genHTMLDataWindow("");
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));
	
%>

<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List04;Describe=定义按钮;]~*/%>
	<%
	//依次为：
	String sButtons[][] = {
		{"true","","Button","关联机构设置","设置机构","relativeRole()",sResourcesPath},
		{"true","","Button","非关联机构设置","设置机构","noRelativeRole()",sResourcesPath},
		{"true","","Button","取消授权","取消授权","deleteRole()",sResourcesPath}
	};
	%> 
<%/*~END~*/%>


<%/*~BEGIN~不可编辑区~[Editable=false;CodeAreaID=List05;Describe=主体页面;]~*/%>
	<%@include file="/Resources/CodeParts/List05.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=List06;Describe=自定义函数;]~*/%>
	<script language=javascript>
	//---------------------定义按钮事件------------------------------------
	/*~[Describe=设置该用户的管辖机构及其下属机构;InputParam=无;OutPutParam=无;]~*/
	function relativeRole()
    {
        sOrgID=getItemValue(0,getRow(),"OrgID");
        sSortNo=getItemValue(0,getRow(),"SortNo");
        sBankID=getItemValue(0,getRow(),"BankID");
        if(typeof(sOrgID)=="undefined" ||sOrgID.length==0)
        { 
            alert(getHtmlMessage('1'));//请选择一条信息！
        }else
        {
            if(confirm("是否关联下级机构?")){
               	var sResult = "insert_relative";
          		popComp("SaveOperOrg","/SystemManage/RightManage/SaveOperOrg.jsp","UserID=<%=sUserID%>&OrgID="+sOrgID+"&BankID="+sBankID+"&SortNo="+sSortNo+"&Result="+sResult,"");
          		alert("设置管辖机构成功！");
            }
        }    
    }
	/*~[Describe=设置该用户的管辖机构不包括其下属机构;InputParam=无;OutPutParam=无;]~*/
	function noRelativeRole()
    {
        sOrgID=getItemValue(0,getRow(),"OrgID");
        sSortNo=getItemValue(0,getRow(),"SortNo");
        sBankID=getItemValue(0,getRow(),"BankID");
        
        if(typeof(sOrgID)=="undefined" ||sOrgID.length==0)
        { 
            alert(getHtmlMessage('1'));//请选择一条信息！
        }else
        {
            if(confirm("只设置本机构，不涉及到其下级机构?")){
            	var sResult = "insert_no_relative";
          		popComp("SaveOperOrg","/SystemManage/RightManage/SaveOperOrg.jsp","UserID=<%=sUserID%>&OrgID="+sOrgID+"&BankID="+sBankID+"&SortNo="+sSortNo+"&Result="+sResult,"");
          		alert("设置管辖机构成功！");
            }
        }    
    }
	/*~[Describe=删除该用户的管辖机构;InputParam=无;OutPutParam=无;]~*/
	function deleteRole()
    {
        sOrgID=getItemValue(0,getRow(),"OrgID");
        sSortNo=getItemValue(0,getRow(),"SortNo");
        
        if(typeof(sOrgID)=="undefined" ||sOrgID.length==0)
        { 
            alert(getHtmlMessage('1'));//请选择一条信息！
        }else
        {
        	if(confirm("是否是否删除该用户置管辖机构？")){
            	var sResult = "delete";
          	  	popComp("SaveOperOrg","/SystemManage/RightManage/SaveOperOrg.jsp","UserID=<%=sUserID%>&OrgID="+sOrgID+"&SortNo="+sSortNo+"&Result="+sResult,"");
          	 	alert("删除管辖机构成功！");
            }
        }    
    }

	</script>
<%/*~END~*/%>

<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=List07;Describe=页面装载时，进行初始化;]~*/%>
<script language=javascript>	
	AsOne.AsInit();
	init();
	my_load(2,0,'myiframe0');
</script>	
<%/*~END~*/%>

<%@ include file="/IncludeEnd.jsp"%>
