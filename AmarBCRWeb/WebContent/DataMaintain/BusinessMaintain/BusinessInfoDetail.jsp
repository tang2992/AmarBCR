<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
 <% 
	//定义变量
	ASResultSet rs = null;
	String sSql="",sGetDueBill="";
	int size=70;
	String sTempWhere = "";
	String sCustomerID = null;
	
	String sTableName = CurPage.getParameter("sTableName");
	if(sTableName == null) sTableName = "";
	String sKeyName =  CurPage.getParameter("KeyName");
	if(sKeyName == null) sKeyName = "";
	String sKeyValue = CurPage.getParameter("KeyValue");
	if(sKeyValue == null) sKeyValue = "";
	//校验错误修改隐藏按钮
	String sQueryType = CurComp.getParameter("QueryType");
	if(sQueryType == null) sQueryType = "";
	//在查询时隐藏保存按钮
	String sIsQuery = CurComp.getParameter("sIsQuery");
	if(sIsQuery == null) sIsQuery = "";

	// 担保，抵押，质押时增加传入担保表的主键  add by jhli
	String sKeyName1 =  CurPage.getParameter("KeyName1");
	if(sKeyName1 == null) sKeyName1 = "";
	String sKeyValue1 =  CurPage.getParameter("KeyValue1");
	if(sKeyValue1 == null) sKeyValue1 = "";
	
	String[]  stName =  sKeyName.split("@");
	String[]  stValue = sKeyValue.split("@");
	
	String sWhereClause = " where 1=1 ";
	String sFirstValue = "";
	for(int i=0;i<stName.length;i++){
		if(i==0)
			sFirstValue = stValue[i];
		sWhereClause = sWhereClause + " and " + stName[i] + "='" + stValue[i] +"'";
	}
	String[][] TableName = null;
%>

<%
	//在CODE_LIBRARY中recordtype对应存储了相关的业务和客户信息,包括对应的业务和客户名称,以及对应的表,和对应的主键信息
	sSql = "SELECT ITEMNAME,ITEMDESCRIBE,ITEMATTRIBUTE,RELATIVECODE  FROM CODE_LIBRARY WHERE CODENO='recordtype'";
	//对于不同的业务关联的表是不同的
	//对于贷款业务来说,需要查询的表包括,合同表,借据表,还款表,展期表,保证表,抵押表,质押表
	if(sTableName.equals("ECR_LOANCONTRACT")){
		sSql = sSql + " and  ITEMNO IN ('8','9','10','11','22','23','24')";
		sTempWhere = " SORTNO IN ('08','09','10','11','22','23','24')";
	}else if(sTableName.equals("ECR_FINAINFO")){
	//对于贸易融资业务来说,需要查询的表包括,合同表,借据表,还款表,展期表,保证表,抵押表,质押表
		sSql = sSql + " and  ITEMNO IN ('14','15','16','17','22','23','24')";
		sTempWhere = " SORTNO IN ('14','15','16','17','22','23','24')";
	}else if(sTableName.equals("ECR_ASSETSDISPOSE")||sTableName.equals("ECR_INTERESTDUE")||sTableName.equals("ECR_FLOORFUND")||sTableName.equals("ECR_DISCOUNT")||sTableName.equals("ECR_CUSTOMERCREDIT")){
		//对于不良信贷资产处置,欠息,垫款,票据贴现,都是只有主表,没有其他的相关表
		sSql = sSql + " and  ITEMDESCRIBE='" + sTableName +"'";
		if(sTableName.equals("ECR_INTERESTDUE"))
			sTempWhere = " ITEMDESCRIBE='" + sTableName +"' AND ITEMNO ='26' ";
		else
			sTempWhere = " ITEMDESCRIBE='" + sTableName +"'";
	}else{
		//对于剩下的四种业务:包括保理,承兑汇票,保函,信用证
		//这五种业务都是有担保信息的：保证,抵押,质押
		sSql = sSql + " and (ITEMNO IN ('22','23','24') or ITEMDESCRIBE='" + sTableName +"')";
		sTempWhere = " (SORTNO IN ('22','23','24') or ITEMDESCRIBE='" + sTableName +"')";
	}
	String countSql= "select count(*) from "+sSql.substring(sSql.indexOf("FROM")+4);
	ASResultSet rs1 = Sqlca.getASResultSet(new SqlObject(countSql));
	while(rs1.next()){
		TableName = new String[rs1.getInt(1)][6];
	}
	rs1.getStatement().close();

	sSql = sSql + " ORDER BY  SORTNO ";
	rs = Sqlca.getASResultSet(new SqlObject(sSql));
	int k = 0;
	String sRelative = null;
	//对于查询到的内容,包括表名,表描述,表的主键名,表的主键值,主表和其他关联表的相关键名,主表和其他关联表的相关键值
	//通过查询进行填充
	//对于表的主键值的说明,是通过list页面传递过来的过来的参数KeyValue来设置的,取第一个参数的值
	//对于这样的设置,是由于在metadata.xml中配置的特殊性来决定的,第一个参数就是主键
	//对于有多个主键的情况,业务发生日期和上报期次是排列的主页编号的后面,所以获取的第一个参数的值就是主业务编号的值

	while(rs.next()){	
		   TableName[k][0]  = rs.getString(2);//表名
		/* 	if(sTableName.equals(sTableName)){
			TableName[k][0]  = rs.getString(2);//表名
		}else{
			TableName[k][0]  = StringFunction.replace(rs.getString(2),"ECR","HIS");//表名
		} */
		//对于欠息的表,为了与反馈的主业务编号进行兼容,设置主键为贷款卡编码
		//所以需要对主键进行修正为CUSTOMERID
		TableName[k][1]  = rs.getString(1);//表描述
		TableName[k][2]  = rs.getString(3);//表主键
		TableName[k][3]  = sKeyValue.split("@")[0];//表主键值(对于还款和展期是需要进行修正的)
	
		sRelative = rs.getString(4);
		if(sRelative!=null){
		//如果是担保信息时,必须是相关的业务类型,当合同编号相同,而业务种类不同时
			TableName[k][4]  = "BUSINESSTYPE";//担保表表的业务种类
			if(TableName[0][0].equals("ECR_LOANCONTRACT")){
			TableName[k][5]  = "1";}//业务种类键值
		  if (TableName[0][0].equals("ECR_FINAINFO")){
			TableName[k][5]  = "4";}
			if (TableName[0][0].equals("ECR_ACCEPTANCE")){
			TableName[k][5]  = "7";}
			if (TableName[0][0].equals("ECR_GUARANTEEBILL")){
			TableName[k][5]  = "6";}
			if (TableName[0][0].equals("ECR_CREDITLETTER")){
			TableName[k][5]  = "5";}
			if (TableName[0][0].equals("ECR_FACTORING")){
			TableName[k][5]  = "2";}
		}
		k++;
	}

	//对于主业务和主业务项下进行查询
	//如果没有相关的信息,则不进行显示,否则进行显示
	rs.getStatement().close();
%>
<%
	//获取所有的相关的公共信息,用来显示本业务所属的客户基本信息,包括客户编号,客户名称,贷款卡编码
	//对于所有的业务表,除了欠息表,其他的都包含客户名称
	sSql=" select CUSTOMERID,GETRORGANNAME(CUSTOMERID),LOANCARDNO from "+  sTableName + sWhereClause;
	rs = Sqlca.getASResultSet(new SqlObject(sSql));
	String sShowButton = "false";
%>
<div id="view_top" style="overflow:auto;"><%@include file="/Resources/CodeParts/Table01.jsp"%></div>

	<%
	if(sQueryType.equals("ERROR")&&sShowButton.equals("true"))
	{
		
%> 
     <%=new Button("完成修改","完成修改","amendRecord()","","").getHtmlText()%>
<%	}%>
<%
	rs.getStatement().close();
%>

<%	

	sSql = "SELECT 0,COUNT(*) FROM " + TableName[0][0] + sWhereClause; 
	for(int i=1;i<TableName.length;i++){
		//对于还款和展期进行特殊处理(因为还款和展期的主键是：借据编号,而不是合同编号)
		String sTemp = StringFunction.replace(TableName[i][0],"HIS","ECR");
		if(sTemp.equals("ECR_FINARETURN")||sTemp.equals("ECR_FINAEXTENSION")
			||sTemp.equals("ECR_LOANRETURN")||sTemp.equals("ECR_LOANEXTENSION")){
			sSql  = sSql  + " UNION ALL SELECT "+i+",COUNT(*)" +" FROM " +  TableName[i][0] + " WHERE " + TableName[i][2] + " in  (SELECT "+ TableName[i][2] + " FROM " + TableName[1][0] +  sWhereClause+")";
			if(sGetDueBill.equals(""))
				sGetDueBill = "SELECT DISTINCT "+ TableName[i][2] + " FROM " + TableName[1][0] +  sWhereClause;
		}else{
			sSql  = sSql  + " UNION ALL SELECT "+i+",COUNT(*) FROM " +  TableName[i][0] + " WHERE " + TableName[i][2] + "='" +  TableName[i][3] + "'";
			if(sTemp.equals("ECR_IMPAWNCONT")||sTemp.equals("ECR_ASSURECONT")||sTemp.equals("ECR_GUARANTYCONT")){
				sSql = sSql + " and " + TableName[0][4] +"='" + TableName[0][5] + "'";}
		}
	}

	rs = Sqlca.getASResultSet(new SqlObject(sSql));
	boolean bShowAll = false;
	int[] iShow = new int[TableName.length];
	String[] sShow = new String[TableName.length];
	//初始化显示的状态
	for(int i=0;i<sShow.length;i++){
		sShow[i] = "false";
		iShow[i] = 0;
	}
	//根据查询结果进行设置
	while(rs.next()){
		int l  = rs.getInt(2);
			sShow[rs.getInt(1)]="true";
			iShow[rs.getInt(1)] = l;
			if(bShowAll==false)
				bShowAll = true;
	}	
	rs.getStatement().close();
	
	//对一个贷款合同下有多个借据的情况,把所有的借据编号进行组合
	//用"-"对借据进行连接,表示"或"关系
     
	if(!sGetDueBill.equals("")){
		rs = Sqlca.getASResultSet(new SqlObject(sGetDueBill));
		String sDueBill = "";
		while(rs.next()){
			if(sDueBill.equals(""))
				sDueBill = rs.getString(1);
			else
				sDueBill = sDueBill + "-" + rs.getString(1);
		}
		TableName[2][3] = sDueBill;
		TableName[3][3] = sDueBill;
		rs.getStatement().close();
	}

	//设置显示的组件和组件路径
	String sCompName = "BusinessRelativeList";
	String sCompPath = "/DataMaintain/BusinessMaintain/BusinessRelativeList.jsp";
	//对于strip进行设置
		String sStrips[][] = new String[TableName.length][7];
		String sTableFlag = "ECR"; 
		for(int t=0;t<TableName.length;t++){
			if(sShow[t]=="true"){
				sStrips[t][0]= sShow[t];
				sStrips[t][1]= TableName[t][1]+"(共有" + iShow[t] + "条)";
				if(iShow[t]>20){
					iShow[t] = 22;
				}
				sStrips[t][2]= String.valueOf(size+ iShow[t]*23);
				sStrips[t][3]= sCompName;
				sStrips[t][4]= sCompPath;
				if(TableName[t][0].indexOf("HIS")>=0){
					sTableName = StringFunction.replace(TableName[t][0],"HIS","ECR");
					sTableFlag = "HIS";
				}else{
					sTableName = TableName[t][0];
				}
				//参数主要有五个：sTableName传入的是主表名，
				//TableFlag表示：是显示his表,还是ecr表
				//对于其他的三个参数：QueryType,Query,IsPatch(由于该页面是公共的页面,对于不同的页面的按钮是不同的,是用来区别按钮的显示效果的用途)
				sStrips[t][5]= "sTableName="+sTableName+"&sTableName1="+TableName[t][1]+"&KeyName="+TableName[t][2]+"&KeyValue="+TableName[t][3]+"&TableFlag="+sTableFlag+"&IsQuery="+sIsQuery+"&QueryType="+sQueryType+"&IsQuery="+sIsQuery;
				sStrips[t][6]="";
			}
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
	/*
		页面说明:示例对象信息查看页面
	 */
	String PG_TITLE = "业务信息维护"; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;SQL生成树图&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "200";//默认的treeview宽度
	
	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"SQL生成树图","right");
	tviTemp.toRegister = false; //设置是否需要将所有的节点注册为功能点及权限点
	tviTemp.TriggerClickEvent=true; //是否自动触发选中事件

	//定义树图结构
	int iTreeNode=1;
	for(int i=0;i<TableName.length;i++){
		tviTemp.insertPage("root",TableName[i][1]+"(" + iShow[i] + "条)","","",iTreeNode++);
	}
%>	
<div id="view_bottom"><%@include file="/Resources/CodeParts/View04.jsp"%></div>
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
	function TreeViewOnClick(){
		var sCurItemname = getCurTVItem().name;
		
		<%
		for(int i=0;i<TableName.length;i++){
			if(i==0){
				%>
				if(sCurItemname==("<%=TableName[i][1]%>"+"(" + <%=iShow[i]%> + "条)")){
					openChildComp("/DataMaintain/BusinessMaintain/BusinessRelativeInfo.jsp","sTableName=<%=TableName[i][0]%>&TableFlag=ECR&KeyName=<%=TableName[i][2]%>&KeyValue=<%=TableName[i][3]%>&Type=info&IsQuery=<%=sIsQuery%>");
				}
				<%
				
			}else{
		%>
		if(sCurItemname==("<%=TableName[i][1]%>"+"(" +<%= iShow[i]%> + "条)")){
			openChildComp("/DataMaintain/BusinessMaintain/BusinessRelativeList.jsp","<%=sStrips[i][5]%>");
		}
		<%
		}
		}
		%>
		setTitle(getCurTVItem().name);
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
	
	function initTreeView(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		selectItemByName("<%=TableName[0][1]%>"+"(" + <%=iShow[0]%> + "条)");
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
