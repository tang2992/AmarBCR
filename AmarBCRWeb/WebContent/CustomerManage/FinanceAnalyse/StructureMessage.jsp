<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBeginMD.jsp"%><%
	/*
		Content: --�������֮�ṹ����
		Input Param:
	                 --CustomerID���ͻ���
	 */
   //���ҳ��������ͻ�����
	String sCustomerID = CurPage.getParameter("CustomerID");
%>
<html>
<head> 
<title>��������</title>
</head>
<body bgcolor="#FAF4DE">
<table width="75%" align="center" height="255">
	<tr>
		<td height="1">&nbsp;</td>
	</tr>
  <tr align="center">
    <td width="97%"> 
      <form name="SelectReport">
      <table>
   <tr>
   <td align="right">
		�����������
	</td>
	<td colspan="3">
		<select multiple name="reportList">
			<%=HTMLControls.generateDropDownSelect(Sqlca,"select AccountMonth || '@' || Scope,AccountMonth || ' ' || getItemName('ReportScope',Scope) from FINANCE_DESC where CustomerID = '" + sCustomerID + "' order by AccountMonth desc",1,2,"")%>
		</select>
	</td>
	</tr>
	</table>
      </form>
    </td>
  </tr>
  <tr align="center">
    <td width="97%">&nbsp; 
      <input type="button" style="width:50px"  name="ok" value="ȷ��" onclick="javascipt:newReport()">
      &nbsp;&nbsp; 
      <input type="button" style="width:50px"  name="Cancel" value="ȡ��" onclick="javascript:self.returnValue='_none_';self.close()">
    </td>
  </tr>
</table>
</body>
</html>
<script type="text/javascript">
	function newReport(){
		var iLength  = document.forms["SelectReport"].reportList.length;
		var iCount = 1;
		var vTemp="", vTemp1="", vTemp2="", vReturn = "";
		if(iLength < 3){
			for(var i=0;i<=iLength-1;i++){
				vTemp = document.forms["SelectReport"].reportList.item(i).value.split("@");
				vTemp1 = vTemp[0];
				vTemp2 = vTemp[1];
				vReturn += "&AccountMonth" + iCount + "=" + vTemp1 + "&Scope" + iCount + "=" + vTemp2;
				iCount++;
				if(iCount > 3)
					break;
			}
			while(iCount <= 3){
				vReturn += "&AccountMonth" + iCount + "=" + vTemp1 + "&Scope" + iCount + "=" + vTemp2;
				iCount++;
			}
		}else{
			for(i=0;i<=iLength-1;i++){
				if(document.forms["SelectReport"].reportList.item(i).selected){
					vTemp = document.forms["SelectReport"].reportList.item(i).value.split("@");
					vTemp1 = vTemp[0];
					vTemp2 = vTemp[1];
					vReturn += "&AccountMonth" + iCount + "=" + vTemp1 + "&Scope" + iCount + "=" + vTemp2;
					iCount++;
				}
			}
			if(iCount <= 3){
				alert(getMessageText("ALS70177"));//��ѡ���������ڱ���
				return;
			}
		}
		
		self.returnValue = vReturn;
		self.close();
	}
</script>
<%@ include file="/IncludeEnd.jsp"%>