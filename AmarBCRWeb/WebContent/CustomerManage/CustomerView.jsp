<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		Content: --客户视图主界面
		Input Param:
			  ObjectNo  ：--客户号
	 */
	String PG_TITLE = "客户管理"; //-- 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;详细信息&nbsp;&nbsp;"; //--默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//--默认的内容区文字
	String PG_LEFT_WIDTH = "200";//--默认的treeview宽度

	//定义变量
	String sSql = "";	//--存放sql语句
	String sItemAttribute = "",sItemDescribe = "",sAttribute3 = "";//--客户类型	
	String sCustomerType = "";//--客户类型	
	String sTreeViewTemplet = "";//--存放custmerview页面树图的CodeNo
	ASResultSet rs = null;//--存放结果集
	int iCount = 0;//记录数
	String sBelongGroupID = "";//所属集团客户ID
	//获得组件参数	,客户代码
	String sCustomerID = CurPage.getParameter("ObjectNo");

	//每个客户经理查看各自的客户时，条件都会关联CUSTOMER_INFO和CUSTOMER_BELONG的CustomerID,以及CUSTOMER_BELONG的UserID，具有客户经理角色的人员只能在审批阶段可以查看当前客户的信息，在其他情况下是不可以查看的。
	//非客户经理岗位的人员：从客户所属信息表中查询出本机构及其下属机构具有当前客户的信息查看权或信息维护权的记录数		
	sSql = 	" select Count(*) from CUSTOMER_BELONG  "+
			" where CustomerID = '"+sCustomerID+"' "+
			" and OrgID in (select orgid from ORG_INFO where sortno like '"+CurOrg.getSortNo()+"%') "+
			" and (BelongAttribute1 = '1' or BelongAttribute2 = '1')";	
	rs = Sqlca.getASResultSet(sSql);
	if(rs.next())
		iCount = rs.getInt(1);
	//关闭结果集
	rs.getStatement().close();
	
	//如果用户没有上述相关权限，则给出相应的提示
	if( iCount  <= 0){
%>
		<script type="text/javascript">
			alert( getHtmlMessage("15")); //用户不具备当前客户查看权
		    self.close();			        
		</script>
<%
	}
	
	//取得客户类型
	sSql = "select CustomerType,BelongGroupID from CUSTOMER_INFO where CustomerID = '"+sCustomerID+"' ";
	rs = Sqlca.getASResultSet(sSql);
	if(rs.next()){
		sCustomerType = rs.getString("CustomerType");
		//如果是集团成员，则取得所属集团客户ID add by jgao1 2009-11-03
		sBelongGroupID  = rs.getString("BelongGroupID");
	}
	rs.getStatement().close();
	
	if(sCustomerType == null) sCustomerType = "";
	if(sBelongGroupID == null) sBelongGroupID = "";

	//取得视图模板类型	
	sSql = " select ItemDescribe,ItemAttribute,Attribute2,Attribute3  from CODE_LIBRARY where CodeNo ='CustomerType' and ItemNo = '"+sCustomerType+"' ";
	rs = Sqlca.getASResultSet(sSql);
	if(rs.next()){
		sItemDescribe = DataConvert.toString(rs.getString("ItemDescribe"));		//客户详情树图类型		
	}
	rs.getStatement().close(); 
	
	sTreeViewTemplet = sItemDescribe;		//公司客户详情树图类型
	
	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"客户信息管理","right");
	tviTemp.TriggerClickEvent=true; //是否自动触发选中事件

	//定义树图结构
	String sSqlTreeView = "from CODE_LIBRARY where CodeNo= '"+sTreeViewTemplet+"' and isinuse = '1' ";
	//如果是非集团成员客户，则滤掉所属集团节点 add by jgao1 2009-11-3,针对公司客户类型
	if(sCustomerType.substring(0,2).equals("01") && sBelongGroupID.equals("")){
		sSqlTreeView += " and ItemNo <> '010055'";//大型企业，中小企业010055代表所属集团信息
	}
	tviTemp.initWithSql("SortNo","ItemName","ItemDescribe","","",sSqlTreeView,"Order By SortNo",Sqlca);
	//参数从左至右依次为：
	//ID字段(必须),Name字段(必须),Value字段,Script字段,Picture字段,From子句(必须),OrderBy子句,Sqlca
%><%@include file="/Resources/CodeParts/View04.jsp"%>
<script type="text/javascript"> 
	function openChildComp(sCompID,sURL,sParameterString){
		sParaStringTmp = "";
		sLastChar=sParameterString.substring(sParameterString.length-1);
		if(sLastChar=="&") sParaStringTmp=sParameterString;
		else sParaStringTmp=sParameterString+"&";

		sParaStringTmp += "ToInheritObj=y&OpenerFunctionName="+getCurTVItem().name;
		OpenComp(sCompID,sURL,sParaStringTmp,"right");
	}
	
	//treeview单击选中事件
	function TreeViewOnClick(){
		var sCurItemName = getCurTVItem().name;//--获得树图的节点名称
		var sCurItemDescribe = getCurTVItem().value;//--获得连接下个页面的路径及相关的参数
		sCurItemDescribe = sCurItemDescribe.split("@");
		sCurItemDescribe1=sCurItemDescribe[0];//--获得连接下个页面的路径
		sCurItemDescribe2=sCurItemDescribe[1];//--存放下个页面的的页面名称
		sCurItemDescribe3=sCurItemDescribe[2];//--现在没有
		sCurItemDescribe4=sCurItemDescribe[3];//--现在没有
		sCustomerID = "<%=sCustomerID%>";//--获得客户代码
		if(sCurItemDescribe2 == "Back"){
			top.close();
		}else if(sCurItemDescribe1 != "null" && sCurItemDescribe1 != "root"){
			openChildComp(sCurItemDescribe2,sCurItemDescribe1,"ModelType="+sCurItemDescribe4+"&ObjectNo="+sCustomerID+"&ComponentName="+sCurItemName+"&CustomerID="+sCustomerID+"&ObjectType=Customer&NoteType="+sCurItemDescribe3);
			setTitle(getCurTVItem().name);
		}
	}
	
	function startMenu(){
		<%=tviTemp.generateHTMLTreeView()%>
	}
		
	startMenu();
	expandNode('root');

	var sCustomerType = "<%=sCustomerType%>";
	//如果客户类型为集团客户，则自动点击"010"项目，如果不是集团客户，则自动展开"010"节点 add by cbsu 2009-10-21
	var sGroupType = sCustomerType.substring(0,2);
	if (sGroupType != '02') {
		expandNode('010');
	} else {
	    selectItem('010');
	}
	
	if(sCustomerType != '0120'){
		selectItem('010010');//自动点击树图，目前写死，也可以设置到 code_library中进行设定
	}else{
		selectItem('010005');//中小企业。 自动点击树图，目前写死，也可以设置到 code_library中进行设定
	}
</script>
<%@ include file="/IncludeEnd.jsp"%>