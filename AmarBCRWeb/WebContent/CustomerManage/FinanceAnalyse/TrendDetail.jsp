<%@page import="com.amarsoft.biz.finance.*,java.text.DecimalFormat" %>
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBeginMD.jsp"%><%
	/*
		Content: --���Ʒ���
		Input Param:
			                 --CustomerID���ͻ���
			                 --ReportCount ������������
			                 --EntityCount ���ͻ���
			                 --ReportNo:�����
	 */
	String PG_TITLE = "���Ʒ���"; // ��������ڱ��� <title> PG_TITLE </title>

    //�������
	String sAccountMonths = "";//--�������� 
	String sScopes = "" ;  //--����Χ
	String sMonthsScopes = "";//�������¼ӿھ�
	int iSubTitleSpan = 0;//--������
	int iTitleSpan = 0;//--������
	String sReportName = "";//--��������
	String sCustomerName = "";//--�ͻ�����
	String sSql="";//--���sql���
	double dTemp;//--�����������
	double dTempIndustry ;//--�����ҵ����
    String sTemp="";//--��ŵ��ַ�������
    String sTempsIndustry="";//--��ŵ��ַ�����ҵ����
    String sTrueFlag="FALSE";//--��־�ж�
    String sTempValues="";//--��ʾ�ַ���ֵ
    String sTempNames="";//--��ʾ����
    String aMonth[]=null;//--�������·ݵ�����
    String aScope[]=null;//--�����ŷ�Χ������
 
    //���ҳ������������������ͻ������ͻ����롢������롢��������
 	String sReportCount = CurPage.getParameter("ReportCount");
	String sEntityCount = CurPage.getParameter("EntityCount");
	String sCustomerID  = CurPage.getParameter("CustomerID");
	String sReportNo    = CurPage.getParameter("ReportNo");
	String sAnalyseType = CurPage.getParameter("AnalyseType");

	iSubTitleSpan = Integer.parseInt(sEntityCount) + 1;
	iTitleSpan    = iSubTitleSpan * Integer.parseInt(sReportCount) + 1;
	
	sSql = "select ReportName from FINANCE_CATALOG where ReportNo = '" + sReportNo + "'";
	ASResultSet rsTemp = Sqlca.getResultSet(sSql);
	if(rsTemp.next())
		sReportName = rsTemp.getString("ReportName");
	rsTemp.getStatement().close();

	sSql = "select CustomerName from CUSTOMER_INFO where CustomerID = '" + sCustomerID + "'";
	rsTemp = Sqlca.getResultSet(sSql);
	if(rsTemp.next())
		sCustomerName = rsTemp.getString(1);
	rsTemp.getStatement().close();

	//ʱ������(����
	//���贫������˳�����еģ�CurPage:AccountMonth1=2001/12,AccountMonth2=2002/12,AccountMonth3=2003/12
	//�����ݽ�������ʾ���ǵ���,��ǰһ��(2003/12)��ǰ����(2002/12)��ǰ����(2001/12)
	//��ͼ�ν�������ʾ����˳�򣬼�2001/12,2002/12,2003/12
	//aMonth�ŵ��ǵ���,�������ݽ���, 2003/12 2002/21 2001/12
	
	aMonth = new String[Integer.parseInt(sReportCount)+1];
	aScope = new String[Integer.parseInt(sReportCount)+1];
	for(int i=Integer.parseInt(sReportCount); i>=1; i--){
		aMonth[Integer.parseInt(sReportCount)-i+1] = CurPage.getParameter("AccountMonth" + i);
		aScope[Integer.parseInt(sReportCount)-i+1] = CurPage.getParameter("Scope" + i);
	}
	//��һ������"3"��ʾ�ṹ����,�ڶ���������ʾ������ʽ
	ReportAnalyse reportAnalyse = new ReportAnalyse("3",sAnalyseType,sCustomerID,sReportNo,sReportCount,aMonth,aScope,Sqlca);//@jlwu
%>
<head>
	<title>���Ʒ���</title>
</head>
<body class="ReportPage" leftmargin="0" topmargin="0" onload="" style="overflow:auto" oncontextmenu="return false">
<form name="form0">
<table style="border: 0;width: 100%;height: 100%;" cellspacing="0" cellpadding="0" >
	<tr height=1 valign=top id="buttonback" >
		<td>
			<%=new Button("ת�������ӱ��","ת�������ӱ��","excelShow()","","").getHtmlText()%>
		</td>
		<td align=left>
			<table style="width: 100%"><tr><td>
				ѡȡͼ��չ�ַ�ʽ��
				<select id="GraphType">
					<option value=0 >��״ͼ</option>
					<option value=6 >����ͼ</option>
				</select>
			</td></tr></table>
		</td>
		<td align=left>
			<%=new Button("ͼ��չ��","ͼ��չ��","graphShow()","","").getHtmlText()%>
		</td>
	</tr>
	<tr valign="top" >
		<td colspan =3 style='BORDER-bottom: #000000 1px solid;' id="reporttable">
			<script type="text/javascript">
				var aValues = new Array();
				var aNames = new Array();
			</script>
			
			<table border=1 cellpadding=0 cellspacing=0 width="100%" align="center" bgcolor="#F0F0F0">
			<%
				//��ͷ
				String sAccountMonth = "", sScope = "", sUnit = "";
				sAccountMonth = CurPage.getParameter("AccountMonth1");
				sScope = CurPage.getParameter("Scope1");
				//FinanceAnalyse financeReport = new FinanceAnalyse(0, sCustomerID, sAccountMonth, sReportNo, sScope, Sqlca);
				//sUnit = financeReport.FinanceUnit;
			%>
				<tr>
					<td colspan="<%=iTitleSpan%>" align="center"><%=sReportName + "�������Ʒ���(" + ReportAnalyse.getItemName("FinanceTrendAnalyse",sAnalyseType,Sqlca) + ")"%></td>
				</tr>
				<tr>
					<td colspan="<%=Math.floor(iTitleSpan/2)%>" align="left"><%="�ͻ����ƣ�" + sCustomerName%></td>
					<td colspan="<%=iTitleSpan - Math.floor(iTitleSpan/2)%>" align="right"><%="��λ�������Ԫ"%> </td>
				</tr>
				<tr>
					<td rowspan="2" align="center" valign="center" nowrap>��Ŀ����</td>
			<%
				for(int i=Integer.parseInt(sReportCount); i>=1; i--){
					sAccountMonth = CurPage.getParameter("AccountMonth" + i);
					sScope = CurPage.getParameter("Scope" + i);
					if (i!=1){
						if(i!=2) sAccountMonths = sAccountMonths + sAccountMonth + "@";
						else     sAccountMonths = sAccountMonths + sAccountMonth ;
						
						if(i!=2) sScopes = sScopes + sScope + "@";
						else     sScopes = sScopes + sScope ;
						
						//�·ݼӿھ����������ڶ�ھ���չ	
						if(i!=2) sMonthsScopes = sMonthsScopes + sAccountMonth+" "+((sScope.equals("01"))?"�ϲ�":(sScope.equals("02")?"����":"����"))+"@";
						else 	sMonthsScopes = sMonthsScopes + sAccountMonth+" "+((sScope.equals("01"))?"�ϲ�":(sScope.equals("02")?"����":"����"));
					}
			%>
					<td colspan="<%=iSubTitleSpan%>" align="center">
						<%=StringFunction.getSeparate(sAccountMonth,"/",1) + "��" + StringFunction.getSeparate(sAccountMonth,"/",2) + "��  "+((sScope.equals("01"))?"�ϲ�":(sScope.equals("02")?"����":"����"))%>
					</td>
			<%
				}
			%>
				</tr>
				<tr>
			<%
				String sEntityType = "", sEntityID = "", sEntityName = "";
				for(int i=1; i<=Integer.parseInt(sReportCount); i++){
					if(i == Integer.parseInt(sReportCount)){
			%>
					<td align="center" nowrap>���</td>
			<%
					}else{
			%>
					<td align="center" nowrap>�䶯��(%)</td>
			<%
					}

					for(int j=1; j<=Integer.parseInt(sEntityCount); j++){
						sEntityType = CurPage.getParameter("EntityType" + j);
						sEntityID = CurPage.getParameter("EntityID" + j);
						if(sEntityType.equals("Industry"))
							sSql = "select getIndustryName('" + sEntityID + "') from dual";
						else
							sSql = "select CustomerName from CUSTOMER_INFO where CustomerID = '" + sEntityID + "'";
						rsTemp = Sqlca.getResultSet(sSql);
						if(rsTemp.next())
							sEntityName = rsTemp.getString(1);
						rsTemp.getStatement().close();

						if(i == Integer.parseInt(sReportCount)){
			%>
						<td align="center"><%=sEntityName%></td>
			<%
						}else{
			%>
						<td align="center"><%=sEntityName + "(%)"%></td>
			<%
						}
					}
				}

				//����
				String sFinanceItemNo = "", sDisplayName = "", sFormatType = "", sBaseAccountMonth = "", sBaseScope = "";
				sAccountMonth = CurPage.getParameter("AccountMonth" + sReportCount);
				sScope = CurPage.getParameter("Scope" + sReportCount);
				int icount=0;
				if(sReportNo.substring(3,4).equals("9")){
//��ʱδ���� DisplayAttribute		//"1":������,"2":�ٷֱ�,"3":������		
					//sSql = "select FD.FinanceItemNo,FD.DisplayName,FM.DisplayAttribute "+
					//		" from FINANCE_MODEL FM,FINANCE_DATA FD where FM.ReportNo = FD.ReportNo and FM.DisplayNo = FD.DisplayNo and FD.CustomerID = '" + sCustomerID + "' and FD.AccountMonth = '" + sAccountMonth + "' and FD.ReportNo = '" + sReportNo + "' and FD.Scope = '" + sScope + "' and (FM.DeleteFlag <> '1' or FM.DeleteFlag is null) order by FD.DisplayNo";
					sSql = "select FD.FinanceItemNo,FD.DisplayName from FINANCE_DATA FD where  FD.CustomerID = '" + sCustomerID + "' and FD.AccountMonth = '" + sAccountMonth + "' and FD.ModelNo = '" + sReportNo + "' and FD.Scope = '" + sScope + "'  order by FD.DisplayNo";
					rsTemp = Sqlca.getResultSet(sSql);
					while(rsTemp.next()){
						icount++;
						sFinanceItemNo = DataConvert.toString(rsTemp.getString(1));
						sDisplayName = DataConvert.toString(rsTemp.getString(2));
						sTempNames = sDisplayName+"@";

						//sFormatType = DataConvert.toString(rsTemp.getString(3));
						//if(sFormatType == null || sFormatType.equals(""))
							sFormatType = "1";
						
						if(sDisplayName.length() > 0){
						  sTempValues ="";
						  sDisplayName  = StringFunction.replace(sDisplayName," ","&nbsp;");
						if(sFinanceItemNo == null || sFinanceItemNo.equals("")){
			%>
							<tr  bgcolor=<%=(icount%2==0)?"#F6F5FA":"#EDEBF6"%>>
								<td colspan="<%=iTitleSpan%>" align="left" nowrap>
									<input type=checkbox name ="checkbox<%=icount%>"  value=<%=sFinanceItemNo%> >
									<%=sDisplayName%>
								</td>
							</tr>
			<%
						}else{
			%>
							<tr  bgcolor=<%=(icount%2==0)?"#F6F5FA":"#EDEBF6"%>>
								<td align="left" nowrap>
									<input type=checkbox name ="checkbox<%=icount%>"  value=<%=sFinanceItemNo%> >
									<%=sDisplayName%>
								</td>
			<%
							for(int i=Integer.parseInt(sReportCount); i>=1; i--){
								sAccountMonth = CurPage.getParameter("AccountMonth" + i);
								sScope = CurPage.getParameter("Scope" + i);
								sTemp="";
								sTempsIndustry="";
								sTrueFlag="FALSE" ;
								if(i == 1){
			%>
								<td align="right" nowrap>
									&nbsp;<%=ReportAnalyse.applyFormat(ReportAnalyse.convertByUnit(reportAnalyse.reportData[Integer.parseInt(sReportCount)-i].ParaValue.getAttribute(sFinanceItemNo).toString(),"01"),sFormatType)%>
								</td>
			<%
								for(int j=1; j<=Integer.parseInt(sEntityCount); j++){
									sEntityType = CurPage.getParameter("EntityType" + j);
									sEntityID = CurPage.getParameter("EntityID" + j);
									String sValue = "";
									if(sEntityType.equals("Industry")){
										sValue = ReportAnalyse.applyFormat(ReportAnalyse.convertByUnit(ReportAnalyse.getItemValue(0,sEntityID, StringFunction.getSeparate(sAccountMonth,"/",1), "0001", "01", sFinanceItemNo, Sqlca),"01"),sFormatType);
									}else{
										sValue = ReportAnalyse.applyFormat(ReportAnalyse.convertByUnit(ReportAnalyse.getItemValue(0,sEntityID, sAccountMonth, sReportNo, sScope, sFinanceItemNo, Sqlca),"01"),sFormatType);
									}
			%>
									<td align="right" nowrap>
										&nbsp;<%=sValue%>
									</td>
			<%
								}

								}else{
									//���ﲻ�ÿ��Ƕ��ȷ������ǻ��ȷ�������Ϊ���෽���м���䶯��ʱ�Ѿ��������Ƕ��ȷ������ǻ��ȷ���@jlwu
								/*if(sAnalyseType.equals("01"))		//����
								{
									sBaseAccountMonth = CurPage.getParameter("AccountMonth1");
									sBaseScope = CurPage.getParameter("Scope1");
								}
								else		//����
								{
									sBaseAccountMonth = CurPage.getParameter("AccountMonth" + (i - 1));
									sBaseScope = CurPage.getParameter("Scope" + (i - 1));
								}*/
								
								if(sFormatType.equals("2")||sFormatType.equals("3")) //�ٷֱȻ���������
								{
									//sTemp = FinanceAnalyse.getRatio2(FinanceAnalyse.getItemValue(0,sCustomerID, sBaseAccountMonth, sReportNo, sBaseScope, sFinanceItemNo, Sqlca),FinanceAnalyse.getItemValue(0,sCustomerID, sAccountMonth, sReportNo, sScope, sFinanceItemNo, Sqlca));
									if(sAnalyseType.equals("01"))
										sTemp = ReportAnalyse.getRatio2(reportAnalyse.reportData[Integer.parseInt(sReportCount)-1].ParaValue.getAttribute(sFinanceItemNo).toString(),reportAnalyse.reportData[Integer.parseInt(sReportCount)-i].ParaValue.getAttribute(sFinanceItemNo).toString());
									else
										sTemp = ReportAnalyse.getRatio2(reportAnalyse.reportData[Integer.parseInt(sReportCount)-i+1].ParaValue.getAttribute(sFinanceItemNo).toString(),reportAnalyse.reportData[Integer.parseInt(sReportCount)-i].ParaValue.getAttribute(sFinanceItemNo).toString());
								}//@jlwu��sFormatTypeΪ1ʱ���෽�����Ѿ�����Ŀǰ���ַ�����ʽ���Ȼ��߻��ȷ����ı䶯�����Կ���ֱ��ȡ
								else	//������
									//sTemp = FinanceAnalyse.getRatio(FinanceAnalyse.getItemValue(0,sCustomerID, sBaseAccountMonth, sReportNo, sBaseScope, sFinanceItemNo, Sqlca),FinanceAnalyse.getItemValue(0,sCustomerID, sAccountMonth, sReportNo, sScope, sFinanceItemNo, Sqlca));
									sTemp = reportAnalyse.reportData[Integer.parseInt(sReportCount)-i].ChangeRateValue.getAttribute(sFinanceItemNo).toString();
								
			                        		if(sTemp!=null&&!sTemp.equals(""))
					                        {
					                          dTemp=Double.parseDouble(sTemp);
					                        }
					                        else
					                        {
					                          dTemp=Double.parseDouble("0");
					                        }
					            sTempValues = sTempValues + StringFunction.getSeparate(ReportAnalyse.formatPercent1(sTemp),"%",1) + "@";
					             	
					            for(int j=1; j<=Integer.parseInt(sEntityCount); j++){
									sEntityType = CurPage.getParameter("EntityType" + j);
									sEntityID = CurPage.getParameter("EntityID" + j);
									String sValue = "";
									if(sEntityType.equals("Industry")){
										//sTempsIndustry = FinanceAnalyse.getRatio(FinanceAnalyse.getItemValue(0,sEntityID, StringFunction.getSeparate(sBaseAccountMonth,"/",1), "0001", "01", sFinanceItemNo, Sqlca),FinanceAnalyse.getItemValue(0,sEntityID, StringFunction.getSeparate(sAccountMonth,"/",1), "0001", "01", sFinanceItemNo, Sqlca));

										if(sFormatType.equals("2")||sFormatType.equals("3")) //�ٷֱȻ���������
											sTempsIndustry = ReportAnalyse.getRatio2(ReportAnalyse.getItemValue(0,sEntityID, StringFunction.getSeparate(sBaseAccountMonth,"/",1), "0001", "01", sFinanceItemNo, Sqlca),ReportAnalyse.getItemValue(0,sEntityID, StringFunction.getSeparate(sAccountMonth,"/",1), "0001", "01", sFinanceItemNo, Sqlca));
										else	//������
											sTempsIndustry = ReportAnalyse.getRatio(ReportAnalyse.getItemValue(0,sEntityID, StringFunction.getSeparate(sBaseAccountMonth,"/",1), "0001", "01", sFinanceItemNo, Sqlca),ReportAnalyse.getItemValue(0,sEntityID, StringFunction.getSeparate(sAccountMonth,"/",1), "0001", "01", sFinanceItemNo, Sqlca));
									}
									if(sTempsIndustry!=null&&!sTempsIndustry.equals("")){
										dTempIndustry=Double.parseDouble(sTempsIndustry);
										if (dTempIndustry!=0){
											if(((dTemp-dTempIndustry)/dTempIndustry)>0.3||((dTemp-dTempIndustry)/dTempIndustry)<-0.3){
											   sTrueFlag="TRUE";
											   continue;
											}
										}
									}
								 }

								String sShowTemp = "";

								if(sFormatType.equals("3")) //������
								{
									DecimalFormat myFormatter = new DecimalFormat("##0.0");
									if(sTemp == null || sTemp.equals(""))
										sShowTemp = "";
									else
										sShowTemp = myFormatter.format(Double.parseDouble(sTemp));
								}else	//�ٷֱ� ���� ������
									sShowTemp = ReportAnalyse.formatPercent1(sTemp);
			%>
								<td align="right" nowrap>
								   <font color=<%=(dTemp>0.2||dTemp<-0.2)?"red":(sTrueFlag.equals("TRUE"))?"red":"black"%>>	&nbsp;<%=sShowTemp%></font>
								</td>
			<%
								for(int j=1; j<=Integer.parseInt(sEntityCount); j++){
									sEntityType = CurPage.getParameter("EntityType" + j);
									sEntityID = CurPage.getParameter("EntityID" + j);
									String sValue = "";
									if(sEntityType.equals("Industry")){
										//sValue = FinanceAnalyse.formatPercent1(FinanceAnalyse.getRatio(FinanceAnalyse.getItemValue(0,sEntityID, StringFunction.getSeparate(sBaseAccountMonth,"/",1), "0001", "01", sFinanceItemNo, Sqlca),FinanceAnalyse.getItemValue(0,sEntityID, StringFunction.getSeparate(sAccountMonth,"/",1), "0001", "01", sFinanceItemNo, Sqlca)));
										if(sFormatType.equals("2")||sFormatType.equals("3")) //�ٷֱȻ���������
											sValue = ReportAnalyse.formatPercent1(ReportAnalyse.getRatio2(ReportAnalyse.getItemValue(0,sEntityID, StringFunction.getSeparate(sBaseAccountMonth,"/",1), "0001", "01", sFinanceItemNo, Sqlca),ReportAnalyse.getItemValue(0,sEntityID, StringFunction.getSeparate(sAccountMonth,"/",1), "0001", "01", sFinanceItemNo, Sqlca)));
										else	//������
											sValue = ReportAnalyse.formatPercent1(ReportAnalyse.getRatio(ReportAnalyse.getItemValue(0,sEntityID, StringFunction.getSeparate(sBaseAccountMonth,"/",1), "0001", "01", sFinanceItemNo, Sqlca),ReportAnalyse.getItemValue(0,sEntityID, StringFunction.getSeparate(sAccountMonth,"/",1), "0001", "01", sFinanceItemNo, Sqlca)));
									}else{
										//sValue = FinanceAnalyse.formatPercent1(FinanceAnalyse.getRatio(FinanceAnalyse.getItemValue(0,sEntityID, sBaseAccountMonth, sReportNo, sBaseScope, sFinanceItemNo, Sqlca),FinanceAnalyse.getItemValue(0,sEntityID, sAccountMonth, sReportNo, sBaseScope, sFinanceItemNo, Sqlca)));
										if(sFormatType.equals("2")||sFormatType.equals("3")) //�ٷֱȻ���������
											sValue = ReportAnalyse.formatPercent1(ReportAnalyse.getRatio2(ReportAnalyse.getItemValue(0,sEntityID, sBaseAccountMonth, sReportNo, sBaseScope, sFinanceItemNo, Sqlca),ReportAnalyse.getItemValue(0,sEntityID, sAccountMonth, sReportNo, sBaseScope, sFinanceItemNo, Sqlca)));
										else	//������
											sValue = ReportAnalyse.formatPercent1(ReportAnalyse.getRatio(ReportAnalyse.getItemValue(0,sEntityID, sBaseAccountMonth, sReportNo, sBaseScope, sFinanceItemNo, Sqlca),ReportAnalyse.getItemValue(0,sEntityID, sAccountMonth, sReportNo, sBaseScope, sFinanceItemNo, Sqlca)));
									}
			%>
									<td align="right" nowrap>
										&nbsp;<%=sValue%>
									</td>
			<%
								}

								}
							}
			%>
								<script type="text/javascript">
									aValues[<%=icount%>] = "<%=sTempValues%>";
									aNames[<%=icount%>] = "<%=sTempNames%>";
								</script>
							</tr>
			<%
						}

						}
					}
					rsTemp.getStatement().close();
				}else{
					sSql = "select FinanceItemNo,DisplayName from FINANCE_DATA where CustomerID = '" + sCustomerID + "' and AccountMonth = '" + sAccountMonth + "' and ModelNo = '" + sReportNo + "' and Scope = '" + sScope + "' order by DisplayNo";
					rsTemp = Sqlca.getResultSet(sSql);
					int i=0;
					while(rsTemp.next()){
						icount++;
						sFinanceItemNo = DataConvert.toString(rsTemp.getString(1));
						sDisplayName = DataConvert.toString(rsTemp.getString(2));
						sTempNames = sDisplayName+"@";
						if(sFinanceItemNo.length() > 0 && sDisplayName.length() > 0){
						  sTempValues ="";
						  sDisplayName  = StringFunction.replace(sDisplayName," ","&nbsp;");
			%>
						<tr  bgcolor=<%=(icount%2==0)?"#F6F5FA":"#EDEBF6" %> >
							<td align="left" nowrap> 
								<input type=checkbox name ="checkbox<%=icount%>"  value=<%=sFinanceItemNo%> >
								<%=sDisplayName%>
							</td>
			<%
							for(i = Integer.parseInt(sReportCount); i>=1; i--){
								sAccountMonth = CurPage.getParameter("AccountMonth" + i);
								sScope = CurPage.getParameter("Scope" + i);
								
								sTemp="";
								sTempsIndustry="";
								sTrueFlag="FALSE" ;
								if(i == 1){
			%>
								<td align="right" nowrap>
									&nbsp;<%=ReportAnalyse.formatNumber(ReportAnalyse.convertByUnit(reportAnalyse.reportData[Integer.parseInt(sReportCount)-i].ParaValue.getAttribute(sFinanceItemNo).toString(), "01"))%>
								</td>
			<%
								for(int j=1; j<=Integer.parseInt(sEntityCount); j++){
									sEntityType = CurPage.getParameter("EntityType" + j);
									sEntityID = CurPage.getParameter("EntityID" + j);
									String sValue = "";
									if(sEntityType.equals("Industry")){
										sValue = ReportAnalyse.formatNumber(ReportAnalyse.convertByUnit(ReportAnalyse.getItemValue(0,sEntityID, StringFunction.getSeparate(sAccountMonth,"/",1), "0001", "01", sFinanceItemNo, Sqlca), "01"));
									}else{
										sValue = ReportAnalyse.formatNumber(ReportAnalyse.convertByUnit(ReportAnalyse.getItemValue(0,sEntityID, sAccountMonth, sReportNo, sScope, sFinanceItemNo, Sqlca), "01"));
									}
			%>
									<td align="right" nowrap>
										&nbsp;<%=sValue%>
									</td>
			<%
								}

								}else{
									//���෽�����Ѿ������˶��ȷ������ǻ��ȷ��������Ҽ�����˱䶯��
                                /*
								if(sAnalyseType.equals("01"))		//����
								{
									sBaseAccountMonth = CurPage.getParameter("AccountMonth1");
									sBaseScope = CurPage.getParameter("Scope1");
								}
								else		//����
								{
									sBaseAccountMonth = CurPage.getParameter("AccountMonth"+(i - 1));
									sBaseScope = CurPage.getParameter("Scope"+(i - 1));
								}
								sTemp = FinanceAnalyse.getRatio(
									FinanceAnalyse.getItemValue(0,sCustomerID, sBaseAccountMonth, sReportNo, sBaseScope, sFinanceItemNo, Sqlca),
									FinanceAnalyse.getItemValue(0,sCustomerID, sAccountMonth, sReportNo, sScope, sFinanceItemNo, Sqlca));
								*/
								sTemp = reportAnalyse.reportData[Integer.parseInt(sReportCount)-i].ChangeRateValue.getAttribute(sFinanceItemNo).toString();
                        		if(sTemp!=null&&!sTemp.equals("")){
		                          dTemp=Double.parseDouble(sTemp);
								}else{
		                          dTemp=Double.parseDouble("0");
		                        }
					             sTempValues = sTempValues + StringFunction.getSeparate(ReportAnalyse.formatPercent1(sTemp),"%",1) + "@";
					             
					             for(int j=1; j<=Integer.parseInt(sEntityCount); j++){
									sEntityType = CurPage.getParameter("EntityType" + j);
									sEntityID = CurPage.getParameter("EntityID" + j);
									String sValue = "";
									if(sEntityType.equals("Industry")){
										sTempsIndustry = ReportAnalyse.getRatio(
												ReportAnalyse.getItemValue(0,sEntityID, StringFunction.getSeparate(sBaseAccountMonth,"/",1), "0001", "01", sFinanceItemNo, Sqlca),
												ReportAnalyse.getItemValue(0,sEntityID, StringFunction.getSeparate(sAccountMonth,"/",1), "0001", "01", sFinanceItemNo, Sqlca));
									}
									if(sTempsIndustry!=null&&!sTempsIndustry.equals("")){
										dTempIndustry=Double.parseDouble(sTempsIndustry);
										if (dTempIndustry!=0){
											if(((dTemp-dTempIndustry)/dTempIndustry)>0.3||((dTemp-dTempIndustry)/dTempIndustry)<-0.3){
											   sTrueFlag="TRUE";
											   continue;
											}
										}
									}
								 }
			%>
								<td align="right" nowrap>
								    <font color=<%=(dTemp>0.2||dTemp<-0.2)?"red":(sTrueFlag.equals("TRUE"))?"red":"black"%>>	&nbsp;<%=ReportAnalyse.formatPercent1(sTemp)%></font>
								</td>
			<%
								for(int j=1; j<=Integer.parseInt(sEntityCount); j++){
									sEntityType = CurPage.getParameter("EntityType" + j);
									sEntityID = CurPage.getParameter("EntityID" + j);
									String sValue = "";
									if(sEntityType.equals("Industry")){
										sValue = ReportAnalyse.formatPercent1(ReportAnalyse.getRatio(ReportAnalyse.getItemValue(0,sEntityID, StringFunction.getSeparate(sBaseAccountMonth,"/",1), "0001", "01", sFinanceItemNo, Sqlca),ReportAnalyse.getItemValue(0,sEntityID, StringFunction.getSeparate(sAccountMonth,"/",1), "0001", "01", sFinanceItemNo, Sqlca)));
									}else{
										sValue = ReportAnalyse.formatPercent1(ReportAnalyse.getRatio(ReportAnalyse.getItemValue(0,sEntityID, sBaseAccountMonth, sReportNo, sBaseScope, sFinanceItemNo, Sqlca),ReportAnalyse.getItemValue(0,sEntityID, sAccountMonth, sReportNo, sScope, sFinanceItemNo, Sqlca)));
									}
			%>
									<td align="right" nowrap>
										&nbsp;<%=sValue%>
									</td>
			<%
								}

								}
							}
			%>
						<script type="text/javascript">
							aValues[<%=icount%>] = "<%=sTempValues%>";
							aNames[<%=icount%>] = "<%=StringFunction.replace(sTempNames,"\"","��")%>";
						</script>
						</tr>
			<%
						}
					}
					rsTemp.getStatement().close();
				}
			%>
			</table>
		</td>
	</tr>
</table>
</form>
</body>

<script>
/*~[Describe=����excel;InputParam=��;OutPutParam=��;]~*/
function excelShow(){
	var mystr = document.getElementById('reporttable').innerHTML;
	spreadsheetTransfer(mystr.replace(/type=checkbox/g,"type=hidden"));
}
/*~[Describe=����ͼ��;InputParam=��;OutPutParam=��;]~*/
function graphShow(){
	var sChecked = "",iChecked = 0,sItemNames="",sItemValues="";
	var cForms = document.forms["form0"];
	//ѭ��ȡ������ѡ�еĸ�ѡ�򣬷�������valueֵ��ɵķ��ش�
	for(var k=0;k<cForms.elements.length;k++){
		if (cForms.elements[k].checked){
			sChecked += cForms.elements[k].value+"@";
			sItemNames  += aNames[parseInt(cForms.elements[k].name.substr(8,cForms.elements[k].name.length-1),10)];
			sItemValues += aValues[parseInt(cForms.elements[k].name.substr(8,cForms.elements[k].name.length-1),10)];
			iChecked ++ ;
		}
	}
	
	if(iChecked==0){
		alert(getMessageText('ALS70174'));//����Ҫѡһ��ָ�����ͼ��չ�֣�
		return;
	}

	if(iChecked>6){
		alert(getMessageText('ALS70175'));//һ�ε�ѡ������6����Ŀ,��ȥ��һЩ��Ŀ�ٽ���ͼ��չ�֣�
		return;
	}

	sChecked = sChecked.substr(0,sChecked.length-1);
	sItemNames = sItemNames.substr(0,sItemNames.length-1);
	sItemValues = sItemValues.substr(0,sItemValues.length-1);
	sGraphType = document.getElementById("GraphType").value;
	sScreenWidth = screen.availWidth-40;
	sScreenHeight = screen.availHeight-40;
    PopPage("/CustomerManage/FinanceAnalyse/ShowGraph.jsp?GraphType="+sGraphType+"&MonthsScopes=<%=sMonthsScopes%>&ItemNames="+sItemNames+"&ItemValues="+sItemValues+"&ScreenWidth="+sScreenWidth+"&ScreenHeight="+sScreenHeight+"&rand="+randomNumber(),"_blank",sDefaultDialogStyle);
}
</script>
<%@ include file="/IncludeEnd.jsp"%>