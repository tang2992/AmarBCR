<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List00;Describe=注释区;]~*/%>
	<%
	/*
		Author: hywang
		Tester:
		Content: 业务数据详情页面
		Input Param:CustomerID
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>
<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List02;Describe=定义变量，获取参数;]~*/%>
<% 
	//定义变量
	ASResultSet rs = null;
	String sSql="",sGetDueBill="";
	int size=100;
	//获取参数
	//本页面对与所有的业务是统一的显示页面,显示的方式是strip效果
	//参数主要有四个：MetaTableName(xml配置name),DBTableName(数据库中要查找的字段),KeyName(要查找的本业务的关键字),KeyValue(要查找的本业务的关键字的值)
	String sMetaTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("MetaTableName"));
	if(sMetaTableName == null) sMetaTableName = "";
	String sDBTableName = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("DBTableName"));
	if(sDBTableName == null) sDBTableName = "";
	String sKeyName =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyName"));
	if(sKeyName == null) sKeyName = "";
	String sKeyValue =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("KeyValue"));
	if(sKeyValue == null) sKeyValue = "";
	
	String[]  stName =  sKeyName.split("@");
	String[]  stValue = sKeyValue.split("@");
	
	String sWhereClause = " where 1=1 ";
	
	for(int i=0;i<stName.length;i++){
		sWhereClause = sWhereClause + " and " + stName[i] + "='" + stValue[i] +"'";
	}
	String[][] sTableName = null;
%>
<%/*~END~*/%>
<%
	//获取所有的相关的公共信息,用来显示本业务所属的客户基本信息,包括客户编号,客户名称,贷款卡编码
	//对于所有的业务表,除了欠息表,其他的都包含客户名称
	sSql=" select CUSTOMERID,GETCUSTOMERNAME(CUSTOMERID),LOANCARDNO from "+  sMetaTableName + sWhereClause;
	rs = Sqlca.getASResultSet(sSql);
%>
<%@include file="/Resources/CodeParts/Table03.jsp"%>
<%
	rs.getStatement().close();
%>
<%/*~END~*/%>
<%
	//在CODE_LIBRARY中recordtype对应存储了相关的业务和客户信息,包括对应的业务和客户名称,以及对应的表,和对应的主键信息
	sSql = "SELECT ITEMNAME,ITEMDESCRIBE,ITEMATTRIBUTE,RELATIVECODE FROM CODE_LIBRARY WHERE CODENO='recordtype'";
	//对于不同的业务关联的表是不同的
	//对于贷款业务来说,需要查询的表包括,合同表,借据表,还款表,展期表,保证表,抵押表,质押表
	if(sMetaTableName.equals("ECR_LOANCONTRACT")){
		sSql = sSql + " and  ITEMNO IN ('8','9','10','11','22','23','24')";
	}else if(sMetaTableName.equals("ECR_FINAINFO")){
	//对于贸易融资业务来说,需要查询的表包括,合同表,借据表,还款表,展期表,保证表,抵押表,质押表
		sSql = sSql + " and  ITEMNO IN ('14','15','16','17','22','23','24')";
	}else if(sMetaTableName.equals("ECR_ASSETSDISPOSE")||sMetaTableName.equals("ECR_INTERESTDUE")||sMetaTableName.equals("ECR_FLOORFUND")||sMetaTableName.equals("ECR_DISCOUNT")||sMetaTableName.equals("ECR_CUSTOMERCREDIT")){
		//对于不良信贷资产处置,欠息,垫款,票据贴现,都是只有主表,没有其他的相关表
		sSql = sSql + " and  ITEMDESCRIBE='" + sMetaTableName +"'";
	}else{
		//对于剩下的五种业务:包括保理,承兑汇票,保函,信用证
		//这五种业务都是有担保信息的：保证,抵押,质押
		sSql = sSql + " and (ITEMNO IN ('22','23','24') or ITEMDESCRIBE='" + sMetaTableName +"')";
	}
	sSql = sSql + " ORDER BY  SORTNO ";
	
	rs = Sqlca.getASResultSet(sSql);
	//System.out.println("****"+sSql);
	sTableName = new String[rs.getRowCount()][6];
	int k = 0;
	String sRelative = null;
	//对于查询到的内容,包括表名,表描述,表的主键名,表的主键值,主表和其他关联表的相关键名,主表和其他关联表的相关键值
	//通过查询进行填充
	//对于表的主键值的说明,是通过list页面传递过来的过来的参数KeyValue来设置的,取第一个参数的值
	//对于这样的设置,是由于在metadata.xml中配置的特殊性来决定的,第一个参数就是主键
	//对于有多个主键的情况,业务发生日期和上报期次是排列的主页编号的后面,所以获取的第一个参数的值就是主业务编号的值
	while(rs.next()){
		if(sMetaTableName.equals(sDBTableName)){
			sTableName[k][0]  = rs.getString(2);//表名
		}else{
			sTableName[k][0]  = StringFunction.replace(rs.getString(2),"ECR","HIS");//表名
		}
		//对于欠息的表,为了与反馈的主业务编号进行兼容,设置主键为贷款卡编码
		//所以需要对主键进行修正为CUSTOMERID
		sTableName[k][1]  = rs.getString(1);//表描述
		if(sTableName[k][0].indexOf("INTERESTDUE")>0)
			sTableName[k][2] = "CUSTOMERID";
		else
			sTableName[k][2]  = rs.getString(3);//表主键
		sTableName[k][3]  = sKeyValue.split("@")[0];//表主键值(对于还款和展期是需要进行修正的)
		
		sRelative = rs.getString(4);
		//System.out.println("*******"+sTableName[0][0]);
		if(sRelative!=null){
		//如果是担保信息时,必须是相关的业务类型,当合同编号相同,而业务种类不同时
			sTableName[0][4]  = "BUSINESSTYPE";//担保表表的业务种类
		  if(sTableName[0][0].indexOf("LOANCONTRACT")!=-1){
			sTableName[0][5]  = "1";}//业务种类键值
		  if (sTableName[0][0].indexOf("FINAINFO")!=-1){
			sTableName[0][5]  = "4";}
			if (sTableName[0][0].indexOf("ACCEPTANCE")!=-1){
			sTableName[0][5]  = "7";}
			if (sTableName[0][0].indexOf("GUARANTEEBILL")!=-1){
			sTableName[0][5]  = "6";}
			if (sTableName[0][0].indexOf("CREDITLETTER")!=-1){
			sTableName[0][5]  = "5";}
			if (sTableName[0][0].indexOf("FACTORING")!=-1){
			sTableName[0][5]  = "2";}
			}
		k++;
	}
	rs.getStatement().close();
	//对于主业务和主业务项下进行查询
	//如果没有相关的信息,则不进行显示,否则进行显示
	sSql = "SELECT 0,COUNT(*) FROM " + sTableName[0][0] + sWhereClause; 
	for(int i=1;i<sTableName.length;i++){
		//对于还款和展期进行特殊处理(因为还款和展期的主键是：借据编号,而不是合同编号)
		String sTemp = StringFunction.replace(sTableName[i][0],"HIS","ECR");
		if(sTemp.equals("ECR_FINARETURN")||sTemp.equals("ECR_FINAEXTENSION")
			||sTemp.equals("ECR_LOANRETURN")||sTemp.equals("ECR_LOANEXTENSION")){
			sSql  = sSql  + " UNION SELECT "+i+",COUNT(*)" +" FROM " +  sTableName[i][0] + " WHERE " + sTableName[i][2] + " in  (SELECT "+ sTableName[i][2] + " FROM " + sTableName[1][0] +  sWhereClause+")";
			if(sGetDueBill.equals(""))
				sGetDueBill = "SELECT DISTINCT "+ sTableName[i][2] + " FROM " + sTableName[1][0] +  sWhereClause;
		}else{
			sSql  = sSql  + " UNION SELECT "+i+",COUNT(*) FROM " +  sTableName[i][0] + " WHERE " + sTableName[i][2] + "='" +  sTableName[i][3] + "'";
			if(sTemp.equals("ECR_IMPAWNCONT")||sTemp.equals("ECR_ASSURECONT")||sTemp.equals("ECR_GUARANTYCONT"))
				sSql = sSql + " and " + sTableName[0][4] +"='" + sTableName[0][5] + "'";
		}
	}
	rs = Sqlca.getASResultSet(sSql);
	
	int[] iShow = new int[sTableName.length];
	String[] sShow = new String[sTableName.length];
	//初始化显示的状态
	for(int i=0;i<sShow.length;i++){
		sShow[i] = "false";
		iShow[i] = 0;
	}
	//根据查询结果进行设置
	while(rs.next()){
		int l  = rs.getInt(2);
		if(l>0){
			sShow[rs.getInt(1)]="true";
			iShow[rs.getInt(1)] = l;
		}
	}
	rs.getStatement().close();
	
	//对一个贷款合同下有多个借据的情况,把所有的借据编号进行组合
	//用"-"对借据进行连接,表示"或"关系
	if(!sGetDueBill.equals("")){
		rs = Sqlca.getASResultSet(sGetDueBill);
		String sDueBill = "";
		while(rs.next()){
			if(sDueBill.equals(""))
				sDueBill = rs.getString(1);
			else
				sDueBill = sDueBill + "-" + rs.getString(1);
		}
		sTableName[2][3] = sDueBill;
		sTableName[3][3] = sDueBill;
		rs.getStatement().close();
	}
	
	//设置显示的组件和组件路径
	String sCompName = "FeedBackRelativeList";
	String sCompPath = "/ErrorManage/FeedBackManage/FeedBackBusiness/FeedBackRelativeList.jsp";
	
	//对于strip进行设置
	String sStrips[][] = new String[sTableName.length][7];
	String sTableFlag = "ECR"; 
	for(int t=0;t<sTableName.length;t++){
		sStrips[t][0]= sShow[t];
		sStrips[t][1]= sTableName[t][1]+"(共有" + iShow[t] + "条)";
		if(iShow[t]>20){
			iShow[t] = 22;
		}
		sStrips[t][2]= String.valueOf(size+ iShow[t]*20);
		sStrips[t][3]= sCompName;
		sStrips[t][4]= sCompPath;
	
		sMetaTableName = StringFunction.replace(sTableName[t][0],"HIS","ECR");
		sTableFlag = "HIS";
		
		//参数主要有五个：MetaTableName(xml配置name),DBTableName(数据库中要查找的字段),KeyName(要查找的本业务的关键字),KeyValue(要查找的本业务的关键字的值)
		//TableFlag表示：是显示his表,还是ecr表
		sStrips[t][5]= "MetaTableName="+sMetaTableName+"&DBTableName="+sTableName[t][0]+"&KeyName="+sTableName[t][2]+"&KeyValue="+sTableName[t][3]+"&TableFlag="+sTableFlag+"&IsPatch=true";
		sStrips[t][6]="";
	}
	

	
%>


<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=List06;Describe=自定义函数;]~*/%>
<script language=javascript>
</script>
<%/*~END~*/%>
<%@include file="/Resources/CodeParts/Strip06.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>
