<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		页面说明:示例对象信息查看页面
	 */
	String PG_TITLE = "信息维护列表"; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;信息维护列表&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "200";//默认的treeview宽度

	//定义变量
	ASResultSet rs = null;
	String sSql="";
	int size=79;
	String sCustomerID = CurPage.getParameter("CustomerID");
	if(sCustomerID == null) sCustomerID = "";
	//获取参数
	String sLOANCARDNO = CurPage.getParameter("LoanCardNo");
	if(sLOANCARDNO == null) sLOANCARDNO = "";

	//获取所有的相关的公共信息：包括客户ID,客户名称,贷款卡编码
	sSql=" select CIFCUSTOMERID,GETRORGANNAME(CIFCUSTOMERID),LOANCARDNO from ECR_ORGANINFO  where CIFCUSTOMERID='"+sCustomerID+"'";
	rs = Sqlca.getASResultSet(new SqlObject(sSql));
%>
<div id="view_top" style="overflow:auto;">
	<%@include file="/Resources/CodeParts/Table03.jsp"%> 
</div>
<%
	rs.getStatement().close();
%>
<%	
	String[][] sTableName = {
			{"ECR_ORGANINFO","借款人概况信息"},
			{"ECR_LOANCONTRACT","借款人贷款合同信息"},
			{"ECR_FACTORING","借款人保理信息"},
			{"ECR_DISCOUNT","借款人票据贴现信息"},
			{"ECR_FINAINFO","借款人贸易融资信息"},
			{"ECR_CREDITLETTER","借款人信用证信息"},
			{"ECR_GUARANTEEBILL","借款人保函业务信息"},
			{"ECR_ACCEPTANCE","借款人承兑汇票信息"},
			{"ECR_CUSTOMERCREDIT","借款人公开授信信息"},
			{"ECR_FLOORFUND","借款人垫款信息"}
		};

		sSql = "select 0, count(*) from " +  sTableName[0][0] +" where LSCustomerID='"+sCustomerID+"'";
		String  sLoanCardNoName = "LoanCardNo";
		for(int k=1;k<sTableName.length;k++){
			sSql = sSql + " union all " + "select "+k+", count(*) from " + sTableName[k][0] +" where LoanCardNo='" +sLOANCARDNO+"'";
		}
		rs = Sqlca.getASResultSet(new SqlObject(sSql));
		
		int[] iShow = new int[sTableName.length];
		String[] sShow = new String[sTableName.length];
		
		for(int j=0;j<sShow.length;j++){
			sShow[j] = "false";
			iShow[j] = 0;
		}
		while(rs.next()){
			int l  = rs.getInt(2);
			if(l>0){
				sShow[rs.getInt(1)]="true";
				iShow[rs.getInt(1)] = l;
			}
		}
		rs.getStatement().close();
		
		String sCustomerCompName = "OrgnizationBaseInfo";
		String sCustomerCompPath = "/DataMaintain/OrgnizationManage/OrgnizationBaseInfo.jsp";
		String sBusinessCompName = "SynthesisMaintanceRelativeList";
		String sBusinessCompPath = "/DataMaintain/SynthesisMaintance/SynthesisMaintanceRelativeList.jsp";
		String[][] sStrips = new String[sTableName.length][7];
		
		
		for(int t=0;t<sTableName.length;t++){
			//if(sShow[t].equals("true")){
				sStrips[t][0]= "true";
				sStrips[t][1]= sTableName[t][1]+"(共有" + iShow[t] + "条)";
				if(iShow[t]>20){
					iShow[t] = 22;
				}
				sStrips[t][2]= String.valueOf(size+iShow[t]*23);
				if(t==0){
					sStrips[t][3]= sCustomerCompName;
					sStrips[t][4]= sCustomerCompPath;
					sStrips[t][5]= "MetaTableName="+sTableName[0][0]+"&DBTableName="+sTableName[0][0]+"&CustomerID="+sCustomerID+"&TableFlag=ECR";
				}else{
					sStrips[t][3]= sBusinessCompName;
					sStrips[t][4]= sBusinessCompPath;
					sStrips[t][5]= "sTableName="+sTableName[t][0]+"&DBTableName="+sTableName[t][0]+"&KeyName=LoanCardNo&KeyValue="+sLOANCARDNO+"&TableFlag=ECR&SynthesisMaintance=true";
				}
				sStrips[t][6]="";
				
		//	}
		}
		String sButtons[][] = {
		
			};
	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"综合信息","right");
	tviTemp.toRegister = false; //设置是否需要将所有的节点注册为功能点及权限点
	tviTemp.TriggerClickEvent=true; //是否自动触发选中事件

	//定义树图结构
	//定义树图结构
	int iTreeNode=1;
	for(int i=0;i<sTableName.length;i++){
		tviTemp.insertPage("root",sTableName[i][1]+"("+iShow[i]+"条)","","",iTreeNode++);
	}
	
	//参数从左至右依次为：
	//ID字段(必须),Name字段(必须),Value字段,Script字段,Picture字段,From子句(必须),OrderBy子句,Sqlca
%><div id="view_bottom"><%@include file="/Resources/CodeParts/View04.jsp"%></div>
<script type="text/javascript"> 
	function openChildComp(sURL,sParameterString){
		sParaStringTmp = "";
		sLastChar=sParameterString.substring(sParameterString.length-1);
		if(sLastChar=="&") sParaStringTmp=sParameterString;
		else sParaStringTmp=sParameterString+"&";

		/*
		 * 附加两个参数
		 * ToInheritObj:是否将对象的权限状态相关变量复制至子组件
		 * OpenerFunctionName:用于自动注册组件关联（REG_FUNCTION_DEF.TargetComp）
		 */
		sParaStringTmp += "ToInheritObj=y&OpenerFunctionName="+getCurTVItem().name;
		AsControl.OpenView(sURL,sParaStringTmp,"right");
	}
	
	//treeview单击选中事件
	//treeview单击选中事件
	function TreeViewOnClick(){
		var sCurItemname = getCurTVItem().name;
		
		<%
		for(int i=0;i<sTableName.length;i++){
			if(i==0){
				%>
				if(sCurItemname=="<%=sTableName[i][1]%>(<%=iShow[i]%>条)"){
					openChildComp("<%=sStrips[i][4]%>","sTable=ECR_ORGANINFO&sCIFCustomerID=<%=sCustomerID%>&Type=Info&sFlag=syn");
				}
		<%				
			}else if(i>0){
		%>
		if(sCurItemname=="<%=sTableName[i][1]%>(<%=iShow[i]%>条)"){
			openChildComp("<%=sStrips[i][4]%>","<%=sStrips[i][5]%>");
		}
		<%
		}
		}
		%>
		setTitle(getCurTVItem().name);
	}
	
	function initTreeView(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		selectItemByName("<%=sTableName[0][1]%>(<%=iShow[0]%>条)");
	}
		
	initTreeView();
	
	(function(){
		$(window).resize(function(){
			var height = $("body").height();
			var height0 = $("#view_top").height("auto").height();
			if(height0 > height/2)
				$("#view_top").height(height0 = height/2);
			$("#view_bottom").height(height - height0 - 30);
		}).resize();
	})();
</script>
<%@ include file="/IncludeEnd.jsp"%>
