<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>

<% 
	//定义变量
	ASResultSet rs = null;
	String sSql="";
	String sCustomerID="";
	int size=75;
	boolean flag = false;
	String sTempWhere = " (SORTNO <='07' or  (SORTNO >='43' and SORTNO<='47')  )";
	//获取参数
	//该页面是客户信息的公共页面
	//根据客户ID来显示客户所有的相关信息
	sCustomerID = CurPage.getParameter("CustomerID");
	if(sCustomerID==null) sCustomerID = "";
	String sFirstValue = sCustomerID;
	String sQueryType = CurComp.getParameter("QueryType");
	if(sQueryType == null) sQueryType = "";
	//在只能查询的模块中隐藏保存按钮
	String sIsQuery = CurComp.getParameter("Query");
	if(sIsQuery == null) sIsQuery = "";
%>
	<%
	 String PG_TITLE = "客户信息维护"; // 浏览器窗口标题 <title> PG_TITLE </title>
	 String PG_CONTENT_TITLE = "&nbsp;&nbsp;客户基本情况&nbsp;&nbsp;"; //默认的内容区标题
	 String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	 String PG_LEFT_WIDTH = "200";//默认的treeview宽度
	%>
<%	
	//客户信息表
	String[][] sTableName = {
			{"ECR_ORGANINFO","借款人概况信息"},//ECR_CUSTOMER已经弃用，客户信息暂时改为从ECR_ORGANINFO里面取
			{"ECR_FINANCEBS","借款人资产负债表"},
			{"ECR_FINANCEPS","借款人利润及利润分配表"},
			{"ECR_FINANCECF","借款人现金流量表"},
			{"ECR_FINANCEBS_2007","2007版资产负债表"},
			{"ECR_FINANCEPS_2007","2007版利润及利润分配表"},
			{"ECR_FINANCECF_2007","2007版现金流量表"},
			{"ECR_FINANCEBS_IN","事业单位资产负债表"},
			{"ECR_FINANCECF_IN","事业单位收入支出表"},
			{"ECR_CUSTOMERLAW","借款人涉讼信息"},
			{"ECR_CUSTOMERFACT","借款人大事记"}		
		};
	//对于所有的客户相关的信息进行查询
	sSql = "select 0, count(*) from " + sTableName[0][0] +" where LSCustomerID='"+sCustomerID+"'";
	
	for(int i=1;i<sTableName.length;i++){
		sSql = sSql + " union all " + "select "+i+", count(*) from " + sTableName[i][0] +" where CustomerID='"+sCustomerID+"'";
	}
	rs = Sqlca.getASResultSet(new SqlObject(sSql));
	int[] iShow = new int[sTableName.length];
	String[] sShow = new String[sTableName.length];
	//对于是否显示进行初始化
	for(int i=0;i<sShow.length;i++){
		sShow[i] = "false";
		iShow[i] = 0;
	}
	boolean bShowAll = false;
	//根据查询结果对是否显示进行设置
	while(rs.next()){
		int l  = rs.getInt(2);
		if(l>0){
			sShow[rs.getInt(1)]="true";
			iShow[rs.getInt(1)] = l;
			if(bShowAll==false)
				bShowAll = true;
		}
	}
	rs.getStatement().close();
	
	 //设置显示的组件和组件路径
	String sCompName = "CustomerRelativeList";
	String sCompPath = "/DataMaintain/CustomerMaintain/CustomerRelativeList.jsp";


	String sStrips[][] = new String[sTableName.length][9];
	for(int t=0;t<sTableName.length;t++){
			sStrips[t][0]= sShow[t];
			sStrips[t][1]= sTableName[t][1]+"(共有" + iShow[t] + "条)";
			if(iShow[t]>20){
				iShow[t] = 22;
			}
			sStrips[t][2]= String.valueOf(size+ iShow[t]*23);
			sStrips[t][3]= sCompName;//组件
			sStrips[t][4]= sCompPath;//组件路径
			sStrips[t][5]= "sTableName="+sTableName[t][0]+"&CustomerID="+sCustomerID+"&TableFlag=ECR"+"&IsQuery="+sIsQuery;
			sStrips[t][6]="";
	}
	
	if(bShowAll==false){
		sStrips = new String[1][7];
		sStrips[0][0]= "false";
		sStrips[0][1]= "";
		sStrips[0][2]= "";
		sStrips[0][3]= "";
		sStrips[0][4]= "";
		sStrips[0][5]= "";
		sStrips[0][6]= "";
	}  
	
%>

<%
	//获取所有的相关的公共信息：包括客户ID,客户名称,贷款卡编码
	sSql=" select LSCUSTOMERID,GETRORGANNAME(CIFCUSTOMERID) as CHINANAME,LOANCARDNO from ECR_ORGANINFO  where LSCustomerID='"+sCustomerID+"'";
	rs = Sqlca.getASResultSet(new SqlObject(sSql));
	String sShowButton = "false";
%>
<div id="view_top" style="overflow:auto;"><%@include file="/Resources/CodeParts/Table01.jsp"%></div>
<%
	rs.getStatement().close();
%>
	<%
	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"客户基本情况","right");
	tviTemp.TriggerClickEvent=true; //是否选中时自动触发TreeViewOnClick()函数

	int iTreeNode=1;
	for(int i=1;i<sTableName.length;i++){
		tviTemp.insertPage("root",sStrips[i][1],"","",iTreeNode++);
	}
	
	%>

<%
	if(sQueryType.equals("ERROR")&&sShowButton.equals("true")){
	%>
		<div style="width:100px; overflow: hidden;padding_left:25px;"><%=new Button("修改完毕","修改完成,删除对应的错误信息","amendRecord()","","").getHtmlText() %></div>
	<%
	} 
	String sButtons[][] = {
			
		};
%> 
	<div id="view_bottom"><%@include file="/Resources/CodeParts/View04.jsp"%></div>

	<script type="text/javascript"> 

	function TreeViewOnClick()
	{
		//如果tviTemp.TriggerClickEvent=true，则在单击时，触发本函数
		var sCurItemname = getCurTVItem().name;
		<%  for(int i=1;i<sTableName.length;i++){
			if(i==0){%>
				if(sCurItemname=="<%=sStrips[i][1]%>"){
					AsControl.OpenView("/DataMaintain/CustomerMaintain/CustomerRelativeInfo.jsp","<%=sStrips[i][5]%>&Type=Info","right");
				}
				<%				
			}else{
		%>
		if(sCurItemname=="<%=sStrips[i][1]%>"){
			AsControl.OpenView("/DataMaintain/CustomerMaintain/CustomerRelativeList.jsp","<%=sStrips[i][5]%>","right");
		}
		<%
		}
		}
		%>
	     setTitle(getCurTVItem().name);
	}
	
	/*~[Describe=生成treeview;InputParam=无;OutPutParam=无;]~*/
	function startMenu() 
	{
		<%=tviTemp.generateHTMLTreeView()%>
	}

		function amendRecord() {
			if(confirm("确认已修改完成,并删除对应的校验错误信息?")){
				var sReturnValue = popComp("DeleteValidteErr","/ErrorManage/ValidateErrorManage/DeleteValidteErr.jsp","","");
				if(typeof(sReturnValue)!="undefined" && sReturnValue=="ok") {
					alert("设置成功,已删除相应的校验错误信息!");
					top.close();
				}
			}
		}
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

	<script type="text/javascript">
	startMenu();
	expandNode('root');
	selectItem(1);
	selectItemByName("借款人资产负债表");
	</script>

<%@ include file="/IncludeEnd.jsp"%>
