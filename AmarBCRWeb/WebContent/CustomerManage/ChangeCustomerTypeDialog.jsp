<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBeginMD.jsp"%><%
	/*
		Describe: 选择客户类型;
		History Log: 
		        syang 2009/10/12 从下拉列表中排除当前客户自己本身的客户类型。如客户1本身为"公司客户"，则下拉列表中不再显示"公司客户"
	 */
	String sCustomerID  = CurPage.getParameter("CustomerID");
	String sType  = CurPage.getParameter("Type");
	if(sCustomerID == null) sCustomerID = "";
	if(sType == null) sType = "";
	String message = "";		//显示信息
	if(sType.equals("01"))
		message = "选择客户规模：";
	else
		message = "选择客户类型：";
	
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
<title>请选择</title>
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
      	<%=new Button("确认","确认","newOrgNatureInfo()","","btn_icon_submit").getHtmlText()%>
      	<%=new Button("取消","取消","self.returnValue='_CANCEL_';self.close()","","btn_icon_close").getHtmlText()%>
      </td>
    </tr>
  </table>
</body>
</html>
<%@ include file="/IncludeEnd.jsp"%>