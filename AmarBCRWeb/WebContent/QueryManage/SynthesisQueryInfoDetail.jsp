<%@ page contentType="text/html; charset=GBK"
    import= "com.amarsoft.app.datax.ecr.common.Tools,java.util.*" %>
<%@ include file="/IncludeBegin.jsp"%>
<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=List00;Describe=注释区;]~*/%>
	<%
	/*
		Author: hywang
		Tester:
		Content:综合查询详情页面
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
	int size=50;
	String sCustomerID = "";
	//获取参数
	String sLOANCARDNO = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("LoanCardNo"));
	if(sLOANCARDNO == null) sLOANCARDNO = "";

%>
<%/*~END~*/%>
<%
	//获取所有的相关的公共信息：包括客户ID,客户名称,贷款卡编码
	sSql=" select CUSTOMERID,CHINANAME,LOANCARDNO from ECR_CUSTOMERINFO  where LoanCardNo='"+sLOANCARDNO+"'";
	rs = Sqlca.getASResultSet(sSql);
%>
<%@include file="/Resources/CodeParts/Table03.jsp"%>
<%
	rs.getStatement().close();
%>
<%	
	String occurDate = "";
	Calendar cal = Calendar.getInstance();
	cal.setTime(new java.util.Date());
	occurDate=Tools.getCurrentDay("1");
	if(cal.get(Calendar.HOUR_OF_DAY)<22)  //22点之前取昨天，22点之后取当天
		occurDate=Tools.getLastDay("1");

	String[][] sTableName = {
			{"ECR_CUSTOMERINFO","借款人概况信息",""},
			{"ECR_LOANCONTRACT","借款人贷款合同信息","AVAILABSTATUS='1'"},
			{"ECR_FACTORING","借款人保理信息","BALANCE>0"},//保理业务状态：正常,逾期,所以不能有此字段,用余额进行判断
			{"ECR_DISCOUNT","借款人票据贴现信息","BILLSTATUS<>'2'"},//正常,结清,转贴现
			{"ECR_FINAINFO","借款人贸易融资信息","AVAILABSTATUS='1'"},//正常,结清
			{"ECR_CREDITLETTER","借款人信用证信息","CREDITSTATUS='1'"},//正常和注销
			{"ECR_GUARANTEEBILL","借款人保函业务信息","GUARANTEESTATUS='1'"},//正常和解除
			{"ECR_ACCEPTANCE","借款人承兑汇票信息","DRAFTSTATUS<>'3'"},//正常,未用退出,结清
			{"ECR_CUSTOMERCREDIT","借款人公开授信信息","(CreditLogOutCause is null and CreditEndDate > '"+occurDate+"') or CreditLogOutDate > '"+occurDate+"'"},
			{"ECR_FLOORFUND","借款人垫款信息","FLOORBALANCE>0"},
			{"ECR_ASSURECONT","保证合同业务信息","AVAILABSTATUS='1'"},
			{"ECR_GUARANTYCONT","抵押合同业务信息","AVAILABSTATUS='1'"},
			{"ECR_IMPAWNCONT","质押合同业务信息","AVAILABSTATUS='1'"}
		};

		sSql = "select 0, 1 from " +  sTableName[0][0] +" where LoanCardNo='"+sLOANCARDNO+"'";
		String  sLoanCardNoName = "LoanCardNo";
		for(int k=1;k<sTableName.length;k++){
			sLoanCardNoName = "LoanCardNo";
			if(k==sTableName.length-3)	sLoanCardNoName = "ALOANCARDNO";
			if(k==sTableName.length-2) sLoanCardNoName = "GLOANCARDNO";
			if(k==sTableName.length-1)	 sLoanCardNoName = "ILOANCARDNO";
			sSql = sSql + " union " + "select "+k+", count(*) from " + sTableName[k][0] +" where " +  sLoanCardNoName + "='" +sLOANCARDNO+"' and "  + sTableName[k][2];
		}
		rs = Sqlca.getASResultSet(sSql);
		
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
		
		sSql = "SELECT CUSTOMERID FROM ECR_CUSTOMERINFO WHERE LoanCardNo='"+sLOANCARDNO+"' ";
		rs = Sqlca.getASResultSet(sSql);
		if(rs.next()){
			sCustomerID = rs.getString(1);
		}
		rs.getStatement().close();
		
		String sCustomerCompName = "CustomerRelativeList";
		String sCustomerCompPath = "/DataMaintain/CustomerMaintain/CustomerRelativeList.jsp";
		String sBusinessCompName = "SynthesisRelativeQueryList";
		String sBusinessCompPath = "/QueryManage/SynthesisRelativeQueryList.jsp";
		String[][] sStrips = new String[sTableName.length][7];
		
		sLoanCardNoName = "LoanCardNo";
		
		for(int t=0;t<sTableName.length;t++){
			if(sShow[t].equals("true")){
				sStrips[t][0]= "true";
				sStrips[t][1]= sTableName[t][1]+"(共有" + iShow[t] + "条)";
				if(iShow[t]>20)
					iShow[t]  = 22;
				sStrips[t][2]= String.valueOf(size+iShow[t]*23);
				if(t==0){
					sStrips[t][3]= sCustomerCompName;
					sStrips[t][4]= sCustomerCompPath;
					sStrips[t][5]= "MetaTableName="+sTableName[0][0]+"&DBTableName="+sTableName[0][0]+"&CustomerID="+sCustomerID+"&TableFlag=ECR&IsQuery=true";
				}else{
					sLoanCardNoName = "LoanCardNo";
					if(t==sTableName.length-3)	sLoanCardNoName = "ALOANCARDNO";
					if(t==sTableName.length-2) sLoanCardNoName = "GLOANCARDNO";
					if(t==sTableName.length-1)	 sLoanCardNoName = "ILOANCARDNO";
					sStrips[t][3]= sBusinessCompName;
					sStrips[t][4]= sBusinessCompPath;
					sStrips[t][5]= "MetaTableName="+sTableName[t][0]+"&DBTableName="+sTableName[t][0]+"&Param="+sLoanCardNoName+"='"+sLOANCARDNO+"'@"+sTableName[t][2]+"&TableFlag=ECR";
				}
				sStrips[t][6]="";
				
			}
		}
%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=false;CodeAreaID=List06;Describe=自定义函数;]~*/%>
<script language=javascript>
	function showHISContent(iStrip){
		<%
		for(int i=0;i<sStrips.length;i++){
			sLoanCardNoName = "LoanCardNo";
			if(i==sTableName.length-3)	sLoanCardNoName = "ALOANCARDNO";
			if(i==sTableName.length-2) sLoanCardNoName = "GLOANCARDNO";
			if(i==sTableName.length-1)	 sLoanCardNoName = "ILOANCARDNO";
		%>
			if(iStrip==<%=i%>){
				if(iStrip==0)
					popComp("<%=sCustomerCompName%>","<%=sCustomerCompPath%>","MetaTableName=<%=sTableName[0][0]%>&DBTableName=<%=StringFunction.replace(sTableName[0][0],"ECR","HIS")%>&CustomerID=<%=sCustomerID%>&TableFlag=HIS","");
				else
				    popComp("<%=sBusinessCompName%>","<%=sBusinessCompPath%>","MetaTableName=<%=sTableName[i][0]%>&DBTableName=<%=StringFunction.replace(sTableName[i][0],"ECR","HIS")%>&Param=<%=sLoanCardNoName%>='<%=sLOANCARDNO%>'@<%=sTableName[i][2]%>&TableFlag=HIS","");     
			}
			<%
		}
		%>
	}
</script>
<%/*~END~*/%>
<%@include file="/Resources/CodeParts/Strip05.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>
