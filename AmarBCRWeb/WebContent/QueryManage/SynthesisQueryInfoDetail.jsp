<%@ page contentType="text/html; charset=GBK"
    import= "com.amarsoft.app.datax.ecr.common.Tools,java.util.*" %>
<%@ include file="/IncludeBegin.jsp"%>
<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List00;Describe=ע����;]~*/%>
	<%
	/*
		Author: hywang
		Tester:
		Content:�ۺϲ�ѯ����ҳ��
		Input Param:CustomerID
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>
<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=List02;Describe=�����������ȡ����;]~*/%>
<% 
	//�������
	ASResultSet rs = null;
	String sSql="";
	int size=50;
	String sCustomerID = "";
	//��ȡ����
	String sLOANCARDNO = DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("LoanCardNo"));
	if(sLOANCARDNO == null) sLOANCARDNO = "";

%>
<%/*~END~*/%>
<%
	//��ȡ���е���صĹ�����Ϣ�������ͻ�ID,�ͻ�����,�������
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
	if(cal.get(Calendar.HOUR_OF_DAY)<22)  //22��֮ǰȡ���죬22��֮��ȡ����
		occurDate=Tools.getLastDay("1");

	String[][] sTableName = {
			{"ECR_CUSTOMERINFO","����˸ſ���Ϣ",""},
			{"ECR_LOANCONTRACT","����˴����ͬ��Ϣ","AVAILABSTATUS='1'"},
			{"ECR_FACTORING","����˱�����Ϣ","BALANCE>0"},//����ҵ��״̬������,����,���Բ����д��ֶ�,���������ж�
			{"ECR_DISCOUNT","�����Ʊ��������Ϣ","BILLSTATUS<>'2'"},//����,����,ת����
			{"ECR_FINAINFO","�����ó��������Ϣ","AVAILABSTATUS='1'"},//����,����
			{"ECR_CREDITLETTER","���������֤��Ϣ","CREDITSTATUS='1'"},//������ע��
			{"ECR_GUARANTEEBILL","����˱���ҵ����Ϣ","GUARANTEESTATUS='1'"},//�����ͽ��
			{"ECR_ACCEPTANCE","����˳жһ�Ʊ��Ϣ","DRAFTSTATUS<>'3'"},//����,δ���˳�,����
			{"ECR_CUSTOMERCREDIT","����˹���������Ϣ","(CreditLogOutCause is null and CreditEndDate > '"+occurDate+"') or CreditLogOutDate > '"+occurDate+"'"},
			{"ECR_FLOORFUND","����˵����Ϣ","FLOORBALANCE>0"},
			{"ECR_ASSURECONT","��֤��ͬҵ����Ϣ","AVAILABSTATUS='1'"},
			{"ECR_GUARANTYCONT","��Ѻ��ͬҵ����Ϣ","AVAILABSTATUS='1'"},
			{"ECR_IMPAWNCONT","��Ѻ��ͬҵ����Ϣ","AVAILABSTATUS='1'"}
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
				sStrips[t][1]= sTableName[t][1]+"(����" + iShow[t] + "��)";
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


<%/*~BEGIN~�ɱ༭��~[Editable=false;CodeAreaID=List06;Describe=�Զ��庯��;]~*/%>
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
