<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBeginMD.jsp"%><%
	/*
		Describe: ѡ��ͻ�����;
		History Log: 
		        syang 2009/10/12 �������б����ų���ǰ�ͻ��Լ�����Ŀͻ����͡���ͻ�1����Ϊ"��˾�ͻ�"���������б��в�����ʾ"��˾�ͻ�"
	 */
	String sCustomerID  = CurPage.getParameter("CustomerID");
	String sType  = CurPage.getParameter("Type");
	if(sCustomerID == null) sCustomerID = "";
	if(sType == null) sType = "";
	String message = "";		//��ʾ��Ϣ
	if(sType.equals("01"))
		message = "ѡ��ͻ���ģ��";
	else
		message = "ѡ��ͻ����ͣ�";
	
	String sSqla = " select CustomerType from CUSTOMER_INFO where CustomerID='"+sCustomerID+"'"; 
	String sCustomerTypea = Sqlca.getString(sSqla);
	if(sCustomerTypea==null) sCustomerTypea="";
	
	String sSql = "";
	
	if(sCustomerTypea.length()>=2 && sCustomerTypea.substring(0,2).equals("01"))
		sSql = " select ItemNo,ItemName from CODE_LIBRARY "+
			   " where CodeNo = 'CustomerType' "+
			   " and ItemNo like '01%' "+
			   " and length(ItemNo) > 2 "+
			   " and IsInUse = '1' "+
			   " and ItemNo <>'"+sCustomerTypea+"' "+
			   " order by SortNo";
	else if(sCustomerTypea.length()>=2 && sCustomerTypea.substring(0,2).equals("03"))
		sSql = " select ItemNo,ItemName from CODE_LIBRARY "+
			   " where CodeNo = 'CustomerType' "+
			   " and ItemNo like '03%' "+
			   " and length(ItemNo) > 2 "+
			   " and IsInUse = '1' "+
			   " and ItemNo <>'"+sCustomerTypea+"' "+
			   " order by SortNo";
%>
<html>
<head> 
<title>��ѡ��</title>
<script type="text/javascript">
function newOrgNatureInfo(){
	self.returnValue=document.getElementById("CustomerType").value;
	self.close();
}
</script>
<style>
.black9pt {  font-size: 9pt; color: #000000; text-decoration: none}
</style>
</head>
<body bgcolor="#DCDCDC">
<br>
  <table align="center" width="260" border='1' cellspacing='0' bordercolor='#999999' bordercolordark='#FFFFFF'>
    <tr> 
      <td nowarp align="right" class="black9pt" bgcolor="#DCDCDC" ><%=message %></td>
      <td nowarp bgcolor="#DCDCDC" > 
        <select id="CustomerType">
			<%=HTMLControls.generateDropDownSelect(Sqlca,sSql,1,2,"")%> 
        </select>
      </td>
    </tr>
    <tr>
      <td nowarp align="right" class="black9pt" bgcolor="#DCDCDC" height="25" >&nbsp;</td>
      <td nowarp bgcolor="#DCDCDC" height="25">
      	<%=new Button("ȷ��","ȷ��","newOrgNatureInfo()","","btn_icon_submit").getHtmlText()%>
      	<%=new Button("ȡ��","ȡ��","self.returnValue='_CANCEL_';self.close()","","btn_icon_close").getHtmlText()%>
      </td>
    </tr>
  </table>
</body>
</html>
<%@ include file="/IncludeEnd.jsp"%>