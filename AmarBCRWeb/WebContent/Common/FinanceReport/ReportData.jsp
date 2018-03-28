<%@page import="com.amarsoft.dict.als.manage.NameManager"%>
<%@page import="com.amarsoft.dict.als.manage.CodeManager"%>
<%@page import="com.amarsoft.biz.finance.*" %>
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<link rel="stylesheet" href="<%=sWebRootPath%>/Common/FinanceReport/resources/css/financereport.css">
<script type="text/javascript" src="<%=sWebRootPath%>/Common/FinanceReport/resources/js/financecheck.js"></script>
<%@ include file="/Resources/CodeParts/progressSet.jsp"%>
<% 
	/*
		Describe: ��ʾ�Ͳ���ָ��������ˮ�ŵĲ��񱨱�
		Input Param:
			ReportNo�� ָ��������ˮ��
			Operation: ��������
		HistoryLog: sxjiang  2010/07/22  ͳһ���񱨱�λ��Ԫ��ǧԪ����Ԫ���뾫�ȣ�С�����λ�����Ĺ淶  ȥ��DataConvert.toMoney����
	 */
	//�������
	int i = 0,iColCount = 0,iHalfRowCount = 0;
	String sAlertStirng = "",sCustomerName = "";
	String sCreditColumn1Value = "",sCreditColumn2Value = "",sDebitColumn1Value = "",sDebitColumn2Value = "";
	String[] sTitle = null;
	Report rReport = null;
	double dDiff1 = 0.00,dDiff2 = 0.00;
	String sStyle = "";
	boolean isEditable=true;
	SqlObject so = null;
	String sNewSql = "";	
		
	//����������
	String sReportNo = CurPage.getParameter("ReportNo");
	String sRole = CurPage.getParameter("Role");
	String sCustomerID =  CurPage.getParameter("CustomerID");
	String sRecordNo =  CurPage.getParameter("RecordNo");
	String sEditable =  CurPage.getParameter("Editable");
	if("false".equals(sEditable))isEditable=false;
	String sOperation = CurPage.getParameter("Operation");
		
	//����ֵת��Ϊ���ַ���
	if(sReportNo == null) sReportNo = "";
	if(sRole == null) sRole = "";
	if(sCustomerID == null) sCustomerID = "";	
	if(sRecordNo == null) sRecordNo = "";
	if(sOperation == null) sOperation="";
	
	rReport = new Report(sReportNo,Sqlca);
	ASResultSet rsTemp;
	
	//��ÿͻ�����
	sCustomerName = NameManager.getCustManageName(rReport.ObjectNo);
	String sReportUnitName = CodeManager.getItemName("ReportUnit", rReport.ReportUnit);
	if(sReportUnitName == null) sReportUnitName = "Ԫ";
	
	String sReportName = "";
	rsTemp = Sqlca.getResultSet(new SqlObject("select ReportName from REPORT_RECORD where ReportNo = :ReportNo").setParameter("ReportNo",sReportNo));
	if(rsTemp.next()) sReportName = rsTemp.getString(1);
	rsTemp.getStatement().close();
	
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	if(sReportUnitName.equals("Ԫ")){
		nf.setMinimumFractionDigits(2);
		nf.setMaximumFractionDigits(2);
	}else if(sReportUnitName.equals("ǧԪ")){
		nf.setMinimumFractionDigits(4);
		nf.setMaximumFractionDigits(4);
	}else{
		nf.setMinimumFractionDigits(5);
		nf.setMaximumFractionDigits(5);
	}

	if(sOperation.equals("delete")){
		rReport.delete();
		%> 
		<script type="text/javascript">
			alert("����ɾ���ɹ�");
			window.close();
		</script>
		<%
	}else if( sOperation.equals("save")){
		rReport.updateRows(request);
		rReport.save();	
		sNewSql = "Update CUSTOMER_FSRECORD set OrgID=:OrgID,UserID=:UserID,UpdateDate=:UpdateDate where RecordNo=:RecordNo";
		so = new SqlObject(sNewSql);
		so.setParameter("OrgID",CurOrg.getOrgID());
		so.setParameter("UserID",CurUser.getUserID());
		so.setParameter("UpdateDate",StringFunction.getToday());
		so.setParameter("RecordNo",sRecordNo);
		Sqlca.executeSQL(so);
		sAlertStirng = "������ɹ�";
		%>
		<script type="text/javascript">
			alert("<%=sAlertStirng%>");
		</script>
		<%	
	}else if(sOperation.equals("calc")){
		rReport.updateRows(request);
		rReport.calculate();
		//�ж��Ƿ�Ϊ�ʲ���ծ��
		if(rReport.getReportRowBySubject("804")==null||rReport.getReportRowBySubject("807")==null){
			sNewSql = "Update CUSTOMER_FSRECORD set OrgID=:OrgID,UserID=:UserID,UpdateDate=:UpdateDate where RecordNo=:RecordNo";
			so = new SqlObject(sNewSql);
			so.setParameter("OrgID",CurOrg.getOrgID());
			so.setParameter("UserID",CurUser.getUserID());
			so.setParameter("UpdateDate",StringFunction.getToday());
			so.setParameter("RecordNo",sRecordNo);
    		Sqlca.executeSQL(so);
    		sAlertStirng = "�������ɹ�";
		}else{
			//ȡ�����ʲ�
			sCreditColumn1Value = rReport.getReportRowBySubject("804").ColDisplay[0]; //�ڳ���
			sCreditColumn2Value = rReport.getReportRowBySubject("804").ColDisplay[1]; //��ĩ��
			//ȡ���ܸ�ծ
			sDebitColumn1Value = rReport.getReportRowBySubject("809").ColDisplay[0]; //�ڳ���
			sDebitColumn2Value = rReport.getReportRowBySubject("809").ColDisplay[1]; //��ĩ��

			//�ڳ����Ƚ�
			dDiff1 = Double.parseDouble(sCreditColumn1Value) - Double.parseDouble(sDebitColumn1Value);
			//��ĩ���Ƚ�
			dDiff2 = Double.parseDouble(sCreditColumn2Value) - Double.parseDouble(sDebitColumn2Value);
			if(Math.abs(dDiff1) > 0.00001 ){
			   	sAlertStirng = sAlertStirng+"���ֵ����ծ���ʲ�С"+DataConvert.toMoney(dDiff1);
			}
			if(Math.abs(dDiff2) > 0.00001 ){
			   	sAlertStirng = "  "+sAlertStirng+"    ��ĩֵ����ծ���ʲ�С"+DataConvert.toMoney(dDiff2);
			}
			if(sAlertStirng==null||sAlertStirng.equals("")){
				sAlertStirng = "����ƽ�⣡";
			}else{
				sAlertStirng = "����ƽ��!  "+sAlertStirng;
			}
		}
		%>
		<script type="text/javascript">
			alert("<%=sAlertStirng%>");
		</script>
		<%
	}
	
	// ��ñ�����ʾ��ʽ
	if(rReport.DisplayMethod.equals("1")) iColCount = 4; // ����
	else if (rReport.DisplayMethod.equals("2"))  iColCount = 8; // ˫��
	else iColCount = 3;  // ����
	
	sTitle = new String[iColCount];
	
	//��ñ�ͷ
	StringTokenizer st = new StringTokenizer(rReport.HeaderMethod,"&");
	while (st.hasMoreTokens()){
		sTitle[i++] = st.nextToken("&");	
	}
	%>
<body leftmargin="0" topmargin="0" bgcolor="#FFFFFF" <%=sStyle%>>
<table id="amarhidden" cellpadding="0" cellspacing="0" border="0" width="100%" height="100%">
  <tr>
  <td valign="top" >
  <table>
	  <tr> 
	    <td width="1" height="17">&nbsp; </td>
	    <td align="left" width="500" height="17" bgcolor="#FFFFFF"> 
	     <%=sCustomerName+" >> "+rReport.ReportDate+" >> "+((rReport.ReportScope.equals("01"))?"�ϲ�":(rReport.ReportScope.equals("02")?"����":"����"))+" >> "+rReport.ReportName+"   ��λ:"+sReportUnitName+"  >>  "+rReport.ModelType%>&nbsp;</td>
	    <td align="center"> 
	        <%	if(sRole.equals("has") && isEditable){%>
	          	<%-- <%=new Button("��&nbsp;��","������񱨱�����","importReport()","","").getHtmlText()%>
				<%=new Button("��&nbsp;��","��ղ��񱨱�","clearReport()","","").getHtmlText()%> --%>
	          	<%=new Button("��&nbsp;��","������񱨱�","saveReport()","","").getHtmlText()%>
			  	<%=new Button("��&nbsp;��","������񱨱�","calcReport()","","").getHtmlText()%>
			<%	}%>
			  <%//=new Button("ת�������ӱ��","ת�������ӱ��","spreadsheetTransfer(formatContent());","","").getHtmlText()%>
  			  <%=new Button("ת�������ӱ��","ת�������ӱ��","AsControl.ExportFinanceReport('"+rReport.ReportNo+"')","","").getHtmlText()%>
			  <%-- <%=new Button("ɾ��","ɾ��","deleteReport()","","").getHtmlText()%>
			  <%=new Button("�ر�","�ر�","closeSelf()","","").getHtmlText()%> --%>
	    </td>
	    <td align="center" colspan="2" height="17" width="1">&nbsp; </td>
	  </tr>
  <tr> 
    <td width="1"></td>
    <td align="left" colspan="4" valign="top"> 
        <!-- ������ʾ -->
        <form name="report" Method="post" action="" >
	   	  <input type=hidden name="Operation" value="">
	   	  <input type=hidden name="CompClientID" value='<%=SpecialTools.amarsoft2Real(sCompClientID)%>'>
          <table border=1 cellpadding=0 cellspacing=0 align="center" class="thistable">
        	<!-- ��ʾ��ͷ --> 
            <tr align="center" bgcolor="#CCCCCC"> 
			<%	for(i=0;i<iColCount;i++){ %>
				 	<td class="thistd" nowrap><%=sTitle[i]%></td>
			<%	} %>
			</tr>
<%
     	String sRowAttribute,sStyle1,sStyle2,sReadOnly1,sReadOnly2,sNameC,sNameC2,sName1,sName2,sName3,sName4;
     	String sCol1Value,sCol2Value;
     	String rowNameL = null;//�����е�ʱ��ֻʹ��rowNameL
		String rowNameR = null;
     	
	// ���ɱ�����ÿ���ֶε�����
	if (rReport.DisplayMethod.equals("1") || rReport.DisplayMethod.equals("3")){
		// ����/������ʾ
		for(i=0;i<rReport.ReportRows.length;i++){ 
		      sRowAttribute = DataConvert.toString(rReport.ReportRows[i].RowAttribute);
		      sStyle1 = StringFunction.getProfileString(sRowAttribute,"style");
		      sReadOnly1 = StringFunction.getProfileString(sRowAttribute,"readonly");
		      sReadOnly1= sReadOnly1.trim().equals("true")?"readonly":"";
		      	      
		      sNameC = "R" + String.valueOf(i+1) + "CC";
		      sName1 = "R" + String.valueOf(i+1) + "C1";
		      sName2 = "R" + String.valueOf(i+1) + "C2";
		      rowNameL = StringFunction.replace(rReport.ReportRows[i].RowName," ","&nbsp;");
		      rowNameL = rowNameL == null ? "" : rowNameL;
		      if( rReport.DisplayMethod.equals("1")){
		      %> 
		            <tr align="center">
		              <td class="thistd"  width=216 style="<%=sStyle1%>" align=left > 
		              	<%=StringFunction.replace(rReport.ReportRows[i].RowName," ","&nbsp;")%>
		                <input class="thisinput" style="<%=sStyle1%>" type=hidden readonly size="36" value='<%=rReport.ReportRows[i].RowName%>' title='<%=DataConvert.toString(rReport.ReportRows[i].RowName)%>' name=<%=sNameC%> >
		              </td>
		              <td class="thistd" > 
		                <input class="thisinput" style="<%=sStyle1%>;width:100px" type=text readonly size="4" value='<%=i+1%>' name="text2">
		              </td>
		              <td class="thistd"> 
		                <input class="thisinputnumber" style="<%=sStyle1%>" type=text size="18" onkeydown="gridValueChange()" onblur="javascript:amarMoneyControl('<%=sName1%>');unsetHighLight(this,'<%=sReportName %>','<%=sReportUnitName %>');" <%=sReadOnly1%> onfocus="setHighLight(this);this.select();" onkeyup="moveFocus('<%=sName1%>')" name=<%=sName1%> value='<%=nf.format(Double.parseDouble(rReport.ReportRows[i].ColDisplay[0]))%>'>
		              </td>
		              <td class="thistd"> 
		                <input class="thisinputnumber" style="<%=sStyle1%>" type=text size="18" onkeydown="gridValueChange()" onblur="javascript:amarMoneyControl('<%=sName2%>');unsetHighLight(this,'<%=sReportName %>','<%=sReportUnitName %>');" <%=sReadOnly1%> onfocus="setHighLight(this);this.select();" onkeyup="moveFocus('<%=sName2%>')" name=<%=sName2%> value='<%=nf.format(Double.parseDouble(rReport.ReportRows[i].ColDisplay[1]))%>'>
		              </td>
		            </tr>
		      <%
		      } 
		      if( rReport.DisplayMethod.equals("3")){
		      %> 
		            <tr align="center">
		              <td class="thistd" width=288 style="<%=sStyle1%>" align=left > 
						<%=rowNameL%>
						<input class="thisinput" style="<%=sStyle1%>" type=hidden readonly size="48" value='<%=rReport.ReportRows[i].RowName%>' name=<%=sNameC%> >
		              </td>
		              <td class="thistd" > 
		                <input class="thisinput" style="<%=sStyle1%>;width=80px" type=text readonly size="4"  value='<%=i+1%>' name="text2">
		              </td>
		              <td class="thistd"> 
		              	<% if(sReportName.indexOf("ָ���") > -1){%>
		                	<input class="thisinputnumber" style="<%=sStyle1%>" type=text size="18" onkeydown="gridValueChange()" onblur="javascript:amarMoneyControl('<%=sName2%>');unsetHighLight(this,'<%=sReportName %>','<%=sReportUnitName %>');" <%=sReadOnly1%> onfocus="setHighLight(this);this.select();" onkeyup="moveFocus('<%=sName2%>')" name=<%=sName2%> value='<%=DataConvert.toMoney(Double.parseDouble(rReport.ReportRows[i].ColDisplay[1]))%>'>
		              	<%}else{ %>
		              		<input class="thisinputnumber" style="<%=sStyle1%>" type=text size="18" onkeydown="gridValueChange()" onblur="javascript:amarMoneyControl('<%=sName2%>');unsetHighLight(this,'<%=sReportName %>','<%=sReportUnitName %>');" <%=sReadOnly1%> onfocus="setHighLight(this);this.select();" onkeyup="moveFocus('<%=sName2%>')" name=<%=sName2%> value='<%=nf.format(Double.parseDouble(rReport.ReportRows[i].ColDisplay[1]))%>'>
		              	<%} %>
		              </td>
		            </tr>
		      <%
		      }
		}
	}else{ // ˫����ʾ
		iHalfRowCount = rReport.ReportRows.length/2;
		for(i=0;i<iHalfRowCount;i++){ 
		      sRowAttribute = DataConvert.toString(rReport.ReportRows[i].RowAttribute);
		      sStyle1 = StringFunction.getProfileString(sRowAttribute,"style");
		      if (sStyle1.equals("")) sStyle1 = "thisinput";
		      
		      sReadOnly1 = StringFunction.getProfileString(sRowAttribute,"readonly");
		      sReadOnly1 = sReadOnly1.trim().equals("true")?"readonly":"";
		      
		      sRowAttribute = DataConvert.toString(rReport.ReportRows[i+iHalfRowCount].RowAttribute);
		      sStyle2 = StringFunction.getProfileString(sRowAttribute,"style");
		      if (sStyle2.equals("")) sStyle2 = "thisinput";
		      
		      sReadOnly2 = StringFunction.getProfileString(sRowAttribute,"readonly");
		      sReadOnly2 = sReadOnly2.trim().equals("true")?"readonly":"";
		      
		      sNameC = "R" + String.valueOf(i+1) + "CC";
		      sName1 = "R" + String.valueOf(i+1) + "C1";
		      sName2 = "R" + String.valueOf(i+1) + "C2";
		      sNameC2 = "R" + String.valueOf(i+1+iHalfRowCount) + "CC";
		      sName3 = "R" + String.valueOf(i+1+iHalfRowCount) + "C1";
		      sName4 = "R" + String.valueOf(i+1+iHalfRowCount) + "C2";
		      rowNameL = StringFunction.replace(rReport.ReportRows[i].RowName," ","&nbsp;");
		      rowNameR = StringFunction.replace(rReport.ReportRows[i+iHalfRowCount].RowName," ","&nbsp;");
		      rowNameL = rowNameL == null ? "" : rowNameL;
		      rowNameR = rowNameR == null ? "" : rowNameR;
		    %> 
	            <tr align="center">
	              <td class="thistd"  width=216 style="<%=sStyle1%>" align=left > 
	              	<%=rowNameL%>
	                <input class="thisinput" style="<%=sStyle1%>" type=hidden readonly size="36"  value='<%=DataConvert.toString(rReport.ReportRows[i].RowName)%>' title='<%=DataConvert.toString(rReport.ReportRows[i].RowName)%>' name=<%=sNameC%> >
	              </td>
	              <td class="thistd" > 
	                <input class="thisinput" style="<%=sStyle1%>" type=text readonly size="4"  value='<%=i+1%>' name="text2">
	              </td>
	              <td class="thistd"> 
	                <input class="thisinputnumber" style="<%=sStyle1%>" type=text size="16" onkeydown="gridValueChange()" onblur="javascript:amarMoneyControl('<%=sName2%>');unsetHighLight(this,'<%=sReportName %>','<%=sReportUnitName %>');" <%=sReadOnly1%> onfocus="setHighLight(this);this.select();" onkeyup="moveFocus('<%=sName2%>')" name=<%=sName2%> value='<%=nf.format(Double.parseDouble(rReport.ReportRows[i].ColDisplay[1]))%>'>
	              </td>
	              <td class="thistd"> 
	                <input class="thisinputnumber" style="<%=sStyle1%>" type=text size="16" onkeydown="gridValueChange()" onblur="javascript:amarMoneyControl('<%=sName1%>');unsetHighLight(this,'<%=sReportName %>','<%=sReportUnitName %>');" <%=sReadOnly1%> onfocus="setHighLight(this);this.select();" onkeyup="moveFocus('<%=sName1%>')" name=<%=sName1%> value='<%=nf.format(Double.parseDouble(rReport.ReportRows[i].ColDisplay[0]))%>'>
	              </td>
	              
	              <td class="thistd"  width=216 style="<%=sStyle2%>" align=left > 
	              	<%=rowNameR%>
	                <input class="thisinput" style="<%=sStyle2%>" type=hidden readonly size="34" value='<%=DataConvert.toString(rReport.ReportRows[i+iHalfRowCount].RowName)%>' title='<%=DataConvert.toString(rReport.ReportRows[i+iHalfRowCount].RowName)%>' name=<%=sNameC2%> >
	              </td>
	              <td class="thistd"> 
	                <input class="thisinput" style="<%=sStyle2%>" type=text readonly size="4"  value='<%=i+1+iHalfRowCount%>' name="text2">
	              </td>
	               <td class="thistd"> 
	                <input class="thisinputnumber" style="<%=sStyle2%>" type=text size="16" onkeydown="gridValueChange()" <%=sReadOnly2%> onblur="javascript:amarMoneyControl('<%=sName4%>');unsetHighLight(this,'<%=sReportName %>','<%=sReportUnitName %>');" onfocus="setHighLight(this);this.select();" onkeyup="moveFocus('<%=sName4%>')"name=<%=sName4%> value='<%=nf.format(Double.parseDouble(rReport.ReportRows[i+iHalfRowCount].ColDisplay[1]))%>'>
	              </td>
	              <td class="thistd"> 
	                <input class="thisinputnumber" style="<%=sStyle2%>" type=text size="16" onkeydown="gridValueChange()" <%=sReadOnly2%> onblur="javascript:amarMoneyControl('<%=sName3%>');unsetHighLight(this,'<%=sReportName %>','<%=sReportUnitName %>');" onfocus="setHighLight(this);this.select();" onkeyup="moveFocus('<%=sName3%>')" name=<%=sName3%> value='<%=nf.format(Double.parseDouble(rReport.ReportRows[i+iHalfRowCount].ColDisplay[0]))%>'>
	              </td>
	            </tr>
	            <%
	        }
	}
	%>
      		</table>
        </form>
    </td>
  </tr>
  <tr> 
    <td width="1" height="17">&nbsp; </td>
    <td align="left" width="450" height="17" bgcolor="#FFFFFF"> 
     <%=rReport.ReportNo+" >> ���񱨱� >> "+rReport.ReportDate+" >> "+rReport.ReportName%>&nbsp;</td>
    <td align="center"> 
        <%	if(sRole.equals("has") && isEditable){%>
          	<%-- <%=new Button("��&nbsp;��","������񱨱�����","importReport()","","").getHtmlText()%>
			<%=new Button("��&nbsp;��","��ղ��񱨱�","clearReport()","","").getHtmlText()%> --%>
          	<%=new Button("��&nbsp;��","������񱨱�","saveReport()","","").getHtmlText()%>
		  	<%=new Button("��&nbsp;��","������񱨱�","calcReport()","","").getHtmlText()%>
		<%	}%>
		  <%=new Button("ת�������ӱ��","ת�������ӱ��","spreadsheetTransfer(formatContent());","","").getHtmlText()%>
		  <%-- <%=new Button("ɾ��","ɾ��","deleteReport()","","").getHtmlText()%>
		  <%=new Button("�ر�","�ر�","closeSelf()","","").getHtmlText()%> --%>
    </td>
    <td align="center" colspan="2" height="17" width="1">&nbsp; </td>
  </tr>
  </table>
  </td>
  </tr>
</table>
<script type="text/javascript">
	function deleteReport(){
	   	if (confirm("��Ҫɾ���ñ���������")){
			document.report.action="<%=sWebRootPath%>/Common/FinanceReport/ReportData.jsp?ReportNo=<%=sReportNo%>&rand="+randomNumber();
		   	document.report.elements["Operation"].value = "delete";
		   	document.report.submit(); 
	   	}     
	}
   
	function saveReport(){
	   	//������ʾ
	   	amarhidden.style.display = "none";
	   	var sUrl = "<%=sWebRootPath%>/Common/FinanceReport/ReportData.jsp?ReportNo=<%=sReportNo%>&rand="+randomNumber();
		document.report.elements["Operation"].value = "save";
	   	onFromAction(sUrl,'report');   
   	}
   	   
   	function calcReport(){
	   	//������ʾ
	   	amarhidden.style.display = "none";
	   	var sUrl = "<%=sWebRootPath%>/Common/FinanceReport/ReportData.jsp?ReportNo=<%=sReportNo%>&rand="+randomNumber();
		document.report.elements["Operation"].value = "calc";
	   	//�¼����μ�common.js
	   	//onFromAction ��װ��document.formname.action ��Ҫ�ύ���ĵ����������,�������onSubmit(sUrl,sParameter)
	   	onFromAction(sUrl,'report');  
   	}

   	function clearReport(){
    	var iRowCount = <%=rReport.ReportRows.length%>;
    	var vMethod = <%=rReport.DisplayMethod%>;
	   	if(confirm("��ղ��񱨱����ݣ�ȷ�ϣ�")){
			if(vMethod == "1" || vMethod=="2"){
				for(var i=1; i<=iRowCount; i++){
					document.report.elements["R" + i + "C1"].value = "0.00";
					document.report.elements["R" + i + "C2"].value = "0.00";
					}
			}else{
				for(var i=1; i<=iRowCount; i++)
					document.report.elements["R" + i + "C2"].value = "0.00";
			}
		}
	   	//saveReport();
   	}

	function moveFocus(sName){
	   	iRowCount = <%=rReport.ReportRows.length%>;
	   	//ȡ�õ�ǰλ��
	   	iRowPos = sName.indexOf("R");
		iColPos = sName.indexOf("C");
		iRow = parseInt(sName.substring(iRowPos+1,iColPos-iRowPos)); 
		iCol = parseInt(sName.substring(iColPos+1)); 
		sRow = sName.substring(iRowPos,iColPos-iRowPos);
		sCol = sName.substring(iColPos); 	
		
	   	if(event.keyCode==38){ //�����ƶ�
			if(iRow>1){
				iRow--;
			  	sName = "R" + new String(iRow) + sCol;
			  	document.report.elements[sName].focus();
			}
	   	}else if(event.keyCode==40 || event.keyCode==13){ //�����ƶ�
	   		if(iRow<iRowCount){
	   			iRow++;
			  	sName = "R" + new String(iRow) + sCol;
			  	document.report.elements[sName].focus();
			}
	   	}
		if("<%=rReport.DisplayMethod%>" != "3"){ //˫ֵ�������
	   		if(event.keyCode==37 || event.keyCode==39){ 
	   			if(sName.indexOf("C2") > 0){
	       			sName = sName.replace("C2","C1");
	      		}else if(sName.indexOf("C1") > 0){
	       			sName = sName.replace("C1","C2");
	      		}
	   			document.report.elements[sName].focus();
	     	}
		 }
	}
	
	//���뱨��
	function importReport(){
		OpenComp("ReportImport","/Common/FinanceReport/ReportImport.jsp","ReportNo=<%=sReportNo%>&CustomerName=<%=sCustomerName%>&CustomerID=<%=sCustomerID%>&ReportDate=<%=rReport.ReportDate%>&ModelNo=<%=rReport.ModelNo%>","_blank","OpenStyle");
		//reloadSelf();
		//��Ϊ���ø�ҳ��ĺ����Դﵽˢ�µ�Ŀ��
		parent.doTabAction("<%=sReportNo%>");
	}
   
	function closeSelf(){
		if(confirm("ȷ���رձ�������")){
			window.close();
		}
	}

	function amarMoneyControl(sName){
		dMoney = parseFloat(document.report.elements[sName].value.replace(/,/g, ""));
		if(dMoney==0)	return;
		if (dMoney==null || dMoney=="" || typeof(dMoney)=='undefined' || dMoney=="-NaN.Na" || dMoney=="NaN" || isNaN(dMoney)){
			document.report.elements[sName].value = "";
			return "";
		}
	
		var sMoney="",i,sTemp="",itemCount,iLength,digit=3,sign="",s1="",s2="";
		
		if(dMoney>=0){
			dMoney = dMoney + 0.00000005;
			sign = "";
		}else{
			dMoney = Math.abs(dMoney - 0.00000005);
			sign = "-";
		}
		sMoney=dMoney.toString(10);
		var digits = sMoney.indexOf(".");
		if("<%=sReportUnitName%>"=="Ԫ"){
			if(digits >0){ //��С��λ
				s2 = sMoney.substring(sMoney.indexOf(".")+1,sMoney.indexOf(".")+3);//ȡС���������λ����˼
			}else{
				s2 = "00";
			}	
		}else if("<%=sReportUnitName%>"=="ǧԪ"){
			if(digits >0){ //��С��λ
				if(("<%=sReportName%>").indexOf("ָ���") >-1 ){
					s2 = sMoney.substring(sMoney.indexOf(".")+1,sMoney.indexOf(".")+3);
				}else
				s2 = sMoney.substring(sMoney.indexOf(".")+1,sMoney.indexOf(".")+5);
			}else{
				s2 = "0000";
			}		
		}else{
			if(digits >0){ //��С��λ
				if(("<%=sReportName%>").indexOf("ָ���") >-1 ){
					s2 = sMoney.substring(sMoney.indexOf(".")+1,sMoney.indexOf(".")+3);
				}else
				s2 = sMoney.substring(sMoney.indexOf(".")+1,sMoney.indexOf(".")+6);
			}else{
				s2 = "00000";
			}	
		}
		sMoney=parseInt(dMoney,10).toString(10);
		iLength = sMoney.length;
		itemCount = parseInt((iLength-1) / digit,10) ;		
		for (i=0;i<itemCount;i++){
			sTemp = ","+sMoney.substring(iLength-digit*(i+1),iLength-digit*i)+sTemp;
		}		
		sMoney = sign+sMoney.substring(0,iLength-digit*i)+sTemp+"."+s2;	
		document.report.elements[sName].value = sMoney;
		
		return sMoney;		
	}
	
	function formatNull(sNull){
		if(sNull==null || sNull=="")
			return("");//return("&nbsp;");
		else
			return(sNull.replace(/ /g,"&nbsp;"));
	}

	function formatNumber2(sNull){
		if(sNull=="undefined")
			return "";
		else
			return sNull;
	}
		
	function formatContent(){
		var sContentNew = "",i=0;
		var iRowCount = <%=rReport.ReportRows.length%>;
		var iColCount = <%=iColCount%>;
		var sHeader = "<%=sCustomerName%> <%=rReport.ReportDate%> <%=rReport.ReportName%>";

		sContentNew += "<STYLE>";
		sContentNew += ".table {  border: solid; border-width: 0px 0px 1px 1px; border-color: #000000 black #000000 #000000}";
		sContentNew += ".td {  font-size: 9pt;border-color: #000000; border-style: solid; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 0px; border-left-width: 0px}.inputnumber {border-style:none;border-width:thin;border-color:#e9e9e9;text-align:right;}.pt16songud{font-family: '����','����';font-size: 16pt;font-weight:bold;text-decoration: none}.myfont{font-family: '����','����';font-size: 9pt;font-weight:bold;text-decoration: none}"
		sContentNew += "</STYLE>";

		sContentNew += "<table align=center border=1 cellspacing=0 cellpadding=0 bgcolor=#E4E4E4 bordercolor=#999999 bordercolordark=#FFFFFF >";
		sContentNew += "<tr>";
		sContentNew += "    <td colspan="+iColCount+" align=middle >"+sHeader+"</td>";
		sContentNew += "</tr>";
		sContentNew += "<tr>";
<%		for(i=0;i<iColCount;i++) { %>
		sContentNew += "    <td align=left  style='background-color:#CCC8EB;color:black;padding-left:2px;' ><%=sTitle[i]%></td>";
<%		} %>
		sContentNew += "</tr>";
		
<%		if(rReport.DisplayMethod.equals("1")){ %>		
			for(i=1;i<=iRowCount;i++){
				sStyle = " style=\" "+document.forms["report"].elements["R"+i+"CC"].style.cssText+" \" ";
				sContentNew += "<tr>";
				sContentNew += "    <td align=left  "+sStyle+" >"+formatNull(document.forms["report"].elements["R"+i+"CC"].value)+"</td>";
				sContentNew += "    <td align=middle  "+sStyle+" >"+i+"</td>";
				sContentNew += "    <td align=right  "+sStyle+" >"+formatNumber2(document.forms["report"].elements["R"+i+"C1"].value)+"</td>";
				sContentNew += "    <td align=right  "+sStyle+" >"+formatNumber2(document.forms["report"].elements["R"+i+"C2"].value)+"</td>";
				sContentNew += "</tr>";
			}
<%		}else if(rReport.DisplayMethod.equals("3")){ %>
			for(i=1;i<=iRowCount;i++){
				sStyle = " style=\" "+document.forms["report"].elements["R"+i+"CC"].style.cssText+" \" ";
				sContentNew += "<tr>";
				sContentNew += "    <td align=left "+sStyle+" >"+formatNull(document.forms["report"].elements["R"+i+"CC"].value)+"</td>";
				sContentNew += "    <td align=middle  "+sStyle+" >"+i+"</td>";
				sContentNew += "    <td align=right  "+sStyle+" >"+formatNumber2(document.forms["report"].elements["R"+i+"C2"].value)+"</td>";
				sContentNew += "</tr>";
			}		
<%		}else{ %>
			for(i=1;i<=iRowCount/2;i++){
				sStyle =  " style=\" "+document.forms["report"].elements["R"+i+"CC"].style.cssText+" \" ";
				sStyle2 = " style=\" "+document.forms["report"].elements["R"+(i+iRowCount/2)+"CC"].style.cssText+" \" ";
				sContentNew += "<tr>";
				sContentNew += "    <td align=left "+sStyle+" >"+formatNull(document.forms["report"].elements["R"+i+"CC"].value)+"</td>";
				sContentNew += "    <td align=middle "+sStyle+" >"+i+"</td>";
				//λ�õ���
				sContentNew += "    <td align=right "+sStyle+" >"+formatNumber2(document.forms["report"].elements["R"+i+"C2"].value)+"</td>";
				sContentNew += "    <td align=right "+sStyle+" >"+formatNumber2(document.forms["report"].elements["R"+i+"C1"].value)+"</td>";
				sContentNew += "    <td align=left  "+sStyle2+" >"+formatNull(document.forms["report"].elements["R"+(i+iRowCount/2)+"CC"].value)+"</td>";
				sContentNew += "    <td align=middle  "+sStyle2+" >"+(i+iRowCount/2)+"</td>";
				//λ�õ���
				sContentNew += "    <td align=right  "+sStyle2+" >"+formatNumber2(document.forms["report"].elements["R"+(i+iRowCount/2)+"C2"].value)+"</td>";
				sContentNew += "    <td align=right  "+sStyle2+" >"+formatNumber2(document.forms["report"].elements["R"+(i+iRowCount/2)+"C1"].value)+"</td>";
				sContentNew += "</tr>";
			}
<%		} %>
		sContentNew += "</table>";
		//��ֹ���񱨱�������̫С������EXCELʱ�������
		sContentNew += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
						+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
						+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
						+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
						+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
						+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
						+ "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
		return(sContentNew);		
	}

	var dataModified = false; //�����Ƿ��޸Ĺ�
	function gridValueChange(){
		dataModified = true;
	}
</script>
</body>
<%@ include file="/IncludeEnd.jsp"%>