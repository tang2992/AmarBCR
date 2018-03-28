<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBeginMD.jsp"%><%
	/*
		Content: �ͻ���Ϣ¼�����
		Input Param:
			  CustomerType���ͻ�����				
				01����˾�ͻ���
				0110��������ҵ�ͻ���
				0120����С����ҵ�ͻ���
				02�����ſͻ���
				0210��ʵ�弯�ſͻ���
				0220�����⼯�ſͻ���
				03�����˿ͻ�
				0310�����˿ͻ���
				0320�����徭Ӫ����
		Output param:
			 CustomerType���ͻ�����				
				01����˾�ͻ���
				0110��������ҵ�ͻ���
				0120����С����ҵ�ͻ���
				02�����ſͻ���
				0210��ʵ�弯�ſͻ���
				0220�����⼯�ſͻ���
				03�����˿ͻ�
				0310�����˿ͻ���
				0320�����徭Ӫ����
			 CustomerOrgType:�ͻ���������	
					0101��������ҵ��
					0102���Ƿ�����ҵ��
					0103����ҵ��λ��
					0104��������壻
					0105���������أ�
					0106�����ڻ�����
					0199��������			
			CustomerName���ͻ�����
			CertType��֤������
			CertID��֤������
		History Log: zywei 2005/09/10 �ؼ����
		             pwang 2009/10/12 �޸Ŀͻ���������ѡ�����ΪCustomerOrgType��
	 */
	//�������
	String sCustomerOrgType ="";

	//���ҳ�����	���ͻ�����
	String sCustomerType  = CurPage.getParameter("CustomerType");
	if(sCustomerType == null) sCustomerType = "";
%>
<html>
<head> 
<title>������ͻ���Ϣ</title>
<script type="text/javascript">
	function newCustomer(){
		//�ǹ������ſͻ���ȡ��֤�����͡�֤������
		if("<%=sCustomerType.substring(0,2)%>" != '02'){
			sCertType = document.all("CertType").value;
			sCertID = trim(document.all("CertID").value);
			sCertID1 = trim(document.all("CertID1").value);
		}else{
			sCertType = "";
			sCertID = "";
			sCertID1 = "";
		}
		
		var sCustomerName = trim(document.all("CustomerName").value);
		
		//��ȡ�ͻ����ͣ�С�ࣩ
		var sCustomerOrgType = document.all("CustomerType").value;	
		//���ͻ������Ƿ�ѡ��
		if (sCustomerOrgType == ''){
			alert(getMessageText('ALS70147'));//��ѡ��ͻ����ͣ�
			document.all("CustomerType").focus();
			return;
		}
		
		//�ǹ������ſͻ�����֤�����͡�֤������
		if("<%=sCustomerType.substring(0,2)%>" != '02'){
			//���֤�������Ƿ�ѡ��
			if (sCertType == ''){
				alert(getMessageText('ALS70148'));//��ѡ��֤�����ͣ�
				document.all("CertType").focus();
				return;
			}
			//���֤�������Ƿ�����
			if (sCertID == ''){
				alert(getMessageText('ALS70149'));//֤������δ���룡
				document.all("CertID").focus();
				return;
			}
			//���֤�������Ƿ�����һ��
			if (sCertID != sCertID1){
				alert(getMessageText('ALS70152'));//֤���������벻һ�£�
				document.all("CertID1").focus();
				return;
			}
		}
		
		//�ж���֯��������Ϸ���
		if(sCertType =='Ent01'){
			if(!CheckORG(sCertID)){
				alert(getMessageText('ALS70102'));//��֯������������
				document.all("CertID").focus();
				return;
			}
		}
			
		//�ж����֤�Ϸ���,�������֤����Ӧ����15��18λ��
		if(sCertType == 'Ind01' || sCertType =='Ind08'){
			if (!CheckLicense(sCertID)){
				alert(getMessageText('ALS70156'));//���֤��������
				document.all("CertID").focus();
				return;
			}
		}		
		
		//���ͻ������Ƿ�����
		if (sCustomerName == ''){
			alert(getMessageText('ALS70104'));//�ͻ����Ʋ���Ϊ�գ�
			document.all("CustomerName").focus();
			return;
		}
		
		//���ر�����ϸ���Ŀͻ����͡��ͻ����ơ��ͻ�֤�����͡�֤����
		self.returnValue=sCustomerOrgType+"@"+sCustomerName+"@"+sCertType+"@"+sCertID;
		self.close();
	}
</script>
<style>
.black9pt {  font-size: 9pt; color: #000000; text-decoration: none}
</style>
</head>

<body class="pagebackground">
<br>
  <table align="center" width="329" border='1' cellspacing='0' bordercolor='#999999' bordercolordark='#FFFFFF'>
     <%	    
	    if(sCustomerType.substring(0,2).equals("01")){ //��˾�ͻ���Ҫѡ��С��
	 %>
    <tr> 
      <td nowarp align="right" class="black9pt" bgcolor="#DCDCDC" >ѡ���������&nbsp;<font color="#ff0000">*</font>&nbsp;</td>
      <td nowarp bgcolor="#DCDCDC" > 
        <select name="CustomerType">
        	<%=HTMLControls.generateDropDownSelect(Sqlca,"select ItemNo,ItemName from CODE_LIBRARY where CodeNo = 'CustomerOrgType' and ItemNo <> '01' and ItemNo like '01%' and IsInUse = '1' order by SortNo ",1,2,"")%> 
        </select>
      </td>
    </tr> 
     <%
		}else{
	 %>
  	<tr>
	  <td>  
       <input name="CustomerType" value='<%=sCustomerType%>' type=hidden>  
      </td>
    </tr> 	    
	 <%	
		}
		//�ǹ������ſͻ���ѡ��֤������
	    if(!sCustomerType.substring(0,2).equals("02")){
     %>
     <tr> 
      <td nowarp align="right" class="black9pt" bgcolor="#DCDCDC" >ѡ��֤������&nbsp;<font color="#ff0000">*</font>&nbsp;</td>
      <td nowarp bgcolor="#DCDCDC" > 
        <select name="CertType"">
	    <%
	    //ѡ��֤������
	    if(sCustomerType.substring(0,2).equals("01")){ //ѡ��˾�ͻ���֤������
	    %>
			<%=HTMLControls.generateDropDownSelect(Sqlca,"select ItemNo,ItemName from CODE_LIBRARY where CodeNo = 'CertType' and SortNo like 'Ent%' order by SortNo ",1,2,"")%> 
	    <%
		}else if(sCustomerType.substring(0,2).equals("03")){ //ѡ����˿ͻ���֤������
	    %>
			<%=HTMLControls.generateDropDownSelect(Sqlca,"select ItemNo,ItemName from CODE_LIBRARY where CodeNo = 'CertType' and ItemNo like 'Ind%' order by SortNo ",1,2,"")%> 
	    <%
		}
	    %>
        </select>
      </td>
    </tr>
   <tr> 
      <td nowarp align="right" class="black9pt" bgcolor="#DCDCDC" >֤������&nbsp;<font color="#ff0000">*</font>&nbsp;</td>
      <td nowarp bgcolor="#DCDCDC"> 
        <input type='text' name="CertID" value="">
      </td>
    </tr>
   <tr> 
      <td nowarp align="right" class="black9pt" bgcolor="#DCDCDC" >֤������ȷ��&nbsp;<font color="#ff0000">*</font>&nbsp;</td>
      <td nowarp bgcolor="#DCDCDC"> 
        <input type='text' name="CertID1" value="">
      </td>
    </tr>
    <%
    }
    %>
   <tr> 
      <td nowarp align="right" class="black9pt" bgcolor="#DCDCDC"  >�ͻ�����&nbsp;<font color="#ff0000">*</font>&nbsp;</td>
      <td nowarp bgcolor="#DCDCDC"> 
        <input type='text' name="CustomerName" value="" <%=(sCustomerType.equals("04")?"style='width:100px'":"style='width:200px'")%> >
      </td>
    </tr>
    <tr>
      <td nowarp align="right" class="black9pt" bgcolor="#DCDCDC" height="25" >&nbsp;</td>
      <td nowarp bgcolor="#DCDCDC" height="25">
      	<%=new Button("ȷ��","ȷ��","newCustomer()","","btn_icon_submit").getHtmlText()%>
      	<%=new Button("ȡ��","ȡ��","self.returnValue='_CANCEL_';self.close()","","btn_icon_close").getHtmlText()%>
      </td>
    </tr>
  </table>
</body>
</html>
<%@ include file="/IncludeEnd.jsp"%>