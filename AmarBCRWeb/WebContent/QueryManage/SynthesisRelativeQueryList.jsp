<%@ page contentType="text/html; charset=GBK"
		import="com.amarsoft.ECRDataWindowXml"%>
<%@ include file="/IncludeBegin.jsp"%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List00;Describe=注释区;]~*/%>
	<%
	/*
		Author: hywang
		Tester:
		Content: 业务相关数据列表-查询未结清
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
	String sMetaTableName = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("MetaTableName"));
	if(sMetaTableName == null) sMetaTableName = "";
	String sDBTableName = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("DBTableName"));
	if(sDBTableName == null) sDBTableName = "";
	String sTableFlag = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("TableFlag"));
	if(sTableFlag == null) sTableFlag = "";
	String sParam = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("Param"));
	if(sParam == null) sParam = "";

	String[]  sCondition = sParam.split("@");
	String sWhereClause = " where 1=1 ";
	for(int j=0;j<sCondition.length;j++){
			sWhereClause = sWhereClause + " and " +  sCondition[j] ;	
	}
	//获取页面参数
	
%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List03;Describe=定义数据对象;]~*/%>
<%	
	ECRDataWindowXml ecrDWX = new ECRDataWindowXml(sMetaTableName,sDBTableName,sTableFlag);
	//2.生成源数据SQL语句
	ecrDWX.setWhereSql(sWhereClause);
	ecrDWX.setOrderSql(" ORDER BY Occurdate DESC");
	//3.创建ASDataObject对象
	ASDataObject doTemp =  ecrDWX.generateASDataObject("List");
	
	String[] sKeyName = ecrDWX.getKeyName();
	String sKeyStr =  sKeyName[0];
	for(int i=1;i<sKeyName.length;i++){
		sKeyStr = sKeyStr +"@" + sKeyName[i];
	}
	
	String sCompNameInfo = "BusinessRelativeInfo";
	String sCompPathInfo = "/DataMaintain/BusinessMaintain/BusinessRelativeInfo.jsp";
	String sParamInfo = "MetaTableName="+sMetaTableName+"&DBTableName="+sDBTableName+"&TableFlag="+sTableFlag+"&KeyName="+sKeyStr;
	
	String sStyle = "style= \"cursor:hand\" ondblclick=\"javascript:parent.openBusinessInfo();\"";
	doTemp.appendHTMLStyle("",sStyle);
	 
    ASDataWindow dwTemp = new ASDataWindow(CurPage,doTemp,Sqlca);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(20);
	
	//生成HTMLDataWindow
	Vector vTemp = dwTemp.genHTMLDataWindow("");
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));
	
%>

<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List04;Describe=定义按钮;]~*/%>
	<%
	//依次为：
	String sButtons[][] = {
		};
	%> 
<%/*~END~*/%>


<%/*~BEGIN~不可编辑区~[Editable=false;CodeAreaID=List05;Describe=主体页面;]~*/%>
	<%@include file="/Resources/CodeParts/List05.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=List06;Describe=自定义函数;]~*/%>
	<script language=javascript>
    var sCurCodeNo=""; //记录当前所选择行的代码号
		
	//---------------------定义按钮事件------------------------------------
	
    function openBusinessInfo()
    {
		//双击打开选中的记录
    	var sKeyValue = getItemValue(0,getRow(),"<%=sKeyName[0]%>");
    	<%
    		for(int i=1;i<sKeyName.length;i++){
    	%>
    			sKeyValue = sKeyValue +  "@" + getItemValue(0,getRow(),"<%=sKeyName[i]%>");
    	<%				
    		}
    	%>
    	popComp("<%=sCompNameInfo%>","<%=sCompPathInfo%>","<%=sParamInfo%>&KeyValue="+sKeyValue+"&IsQuery=true","");          
    	reloadSelf();
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
