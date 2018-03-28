<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List00;Describe=注释区;]~*/%>
	<%
	/*
		Author: hywang
		Tester:
		Content: 客户数据详情页面
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
	String sSql="";
	String sCustomerID="";
	int size=100;
	boolean flag = false;
	//获取参数
	//该页面是客户信息的公共页面
	//根据客户ID来显示客户所有的相关信息
	sCustomerID = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("CustomerID"));	
	
%>
<%
	//获取所有的相关的公共信息：包括客户ID,客户名称,贷款卡编码
	sSql=" select CUSTOMERID,CHINANAME,LOANCARDNO from ECR_CUSTOMERINFO  where CustomerID='"+sCustomerID+"'";
	rs = Sqlca.getASResultSet(sSql);
%>
<%@include file="/Resources/CodeParts/Table03.jsp"%>
<%
	rs.getStatement().close();
%>
<%/*~END~*/%>

<%	
	//客户信息表
	String[][] sTableName = {
			{"HIS_CUSTOMERINFO","借款人概况信息表"},
			{"HIS_CUSTOMERSTOCK","借款人股票信息表"},
			{"HIS_CUSTCAPIINFO","借款人注册资本信息表"},
			{"HIS_CUSTOMERCAPI","借款人资本构成信息表"},
			{"HIS_CUSTOMERINVEST","借款人对外投资信息表"},
			{"HIS_CUSTOMERKEEPER","借款人高级管理人员信息表"},
			{"HIS_CUSTOMERFAMILY","款人法人代表家族成员企业信息表"},
			{"HIS_CUSTOMERlAW","借款人涉讼信息表"},
			{"HIS_CUSTOMERFACT","借款人大事记"}
		};
	//对于所有的客户相关的信息进行查询
	sSql = "select 0, count(*) from " + sTableName[0][0] +" where CustomerID='"+sCustomerID+"'";
	
	for(int i=1;i<sTableName.length;i++){
		sSql = sSql + " union " + "select "+i+", count(*) from " + sTableName[i][0] +" where CustomerID='"+sCustomerID+"'";
	}
	rs = Sqlca.getASResultSet(sSql);
	int[] iShow = new int[sTableName.length];
	String[] sShow = new String[sTableName.length];
	//对于是否显示进行初始化
	for(int i=0;i<sShow.length;i++){
		sShow[i] = "false";
		iShow[i] = 0;
	}
	//根据查询结果对是否显示进行设置
	while(rs.next()){
		int l  = rs.getInt(2);
		if(l>0){
			sShow[rs.getInt(1)]="true";
			iShow[rs.getInt(1)] = l;
		}
	}
	rs.getStatement().close();
	
	//设置显示的组件和组件路径
	String sCustomerCompName = "FeedBackCustomerList";
	String sCustomerCompPath = "/ErrorManage/FeedBackManage/FeedBackCustomer/FeedBackCustomerList.jsp";

	String sStrips[][] = new String[sTableName.length][9];
	for(int t=0;t<sTableName.length;t++){
			sStrips[t][0]= sShow[t];
			sStrips[t][1]= sTableName[t][1]+"(共有" + iShow[t] + "条)";
			if(iShow[t]>20){
				iShow[t] = 22;
			}
			sStrips[t][2]= String.valueOf(size+ iShow[t]*20);
			sStrips[t][3]= sCustomerCompName;//组件
			sStrips[t][4]= sCustomerCompPath;//组件路径
			sStrips[t][5]= "MetaTableName="+StringFunction.replace(sTableName[t][0],"HIS","ECR")+"&DBTableName="+sTableName[t][0]+"&CustomerID="+sCustomerID+"&TableFlag=HIS&IsShow=true&IsPatch=true";
			sStrips[t][6]="";
	}
%>

<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=List06;Describe=自定义函数;]~*/%>
<script language=javascript>

</script>
<%/*~END~*/%>
<%@include file="/Resources/CodeParts/Strip06.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>
