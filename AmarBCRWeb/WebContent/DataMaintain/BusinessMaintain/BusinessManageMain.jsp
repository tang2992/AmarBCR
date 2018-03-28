<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

	<%
	String PG_TITLE = "业务信息维护"; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;业务信息维护&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "180";//默认的treeview宽度
	%>

	<%
	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"业务信息维护","right");
	tviTemp.toRegister = false; //设置是否需要将所有的节点注册为功能点及权限点
	tviTemp.TriggerClickEvent=true; //是否选中时自动触发TreeViewOnClick()函数

	//定义树图结构
	//String sFolder1=tviTemp.insertFolder("root","业务信息维护","",0);
	tviTemp.insertPage("root","贷款业务","ECR_LOANCONTRACT","",1);
	tviTemp.insertPage("root","保理业务","ECR_FACTORING","",2);
	tviTemp.insertPage("root","票据贴现","ECR_DISCOUNT","",3);
	tviTemp.insertPage("root","贸易融资","ECR_FINAINFO","",4);
	tviTemp.insertPage("root","信用证","ECR_CREDITLETTER","",5);
	tviTemp.insertPage("root","保函业务","ECR_GUARANTEEBILL","",6);
	tviTemp.insertPage("root","承兑汇票","ECR_ACCEPTANCE","",7);
	tviTemp.insertPage("root","公开授信","ECR_CUSTOMERCREDIT","",8);
	tviTemp.insertPage("root","垫款信息","ECR_FLOORFUND","",9);
	tviTemp.insertPage("root","欠息信息","ECR_INTERESTDUE","",10);
	tviTemp.insertPage("root","保证信息","ECR_ASSURECONT","",21);
	tviTemp.insertPage("root","抵押信息","ECR_GUARANTYCONT","",22);
	tviTemp.insertPage("root","质押信息","ECR_IMPAWNCONT","",23);
	tviTemp.insertPage("root","不良信贷资产处置信息","ECR_ASSETSDISPOSE","",51);
	%>

	<%@include file="/Resources/CodeParts/Main04.jsp"%>

	<script language=javascript> 
	
	/*~[Describe=treeview单击选中事件;InputParam=无;OutPutParam=无;]~*/

	function TreeViewOnClick()
	{
		//如果tviTemp.TriggerClickEvent=true，则在单击时，触发本函数

		var sCurItemname = getCurTVItem().name;
		var sTableName = getCurTVItem().value;
		if(typeof(sTableName)!="undefined"&&sTableName.length!=0&&sCurItemname!="业务信息维护"){
			OpenComp("BusinessManageList","/DataMaintain/BusinessMaintain/BusinessManageList.jsp","TableName="+sTableName,"right");
		}else{
			return;							
		}
		setTitle(getCurTVItem().name);
	}
	
	/*~[Describe=生成treeview;InputParam=无;OutPutParam=无;]~*/
	function startMenu() 
	{
		<%=tviTemp.generateHTMLTreeView()%>
	}
	</script> 

	<script language="javascript">
	startMenu();
	expandNode('root');	
	selectItem("1");
	</script>

<%@ include file="/IncludeEnd.jsp"%>