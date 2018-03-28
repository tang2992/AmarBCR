<%@page import="com.amarsoft.dict.als.object.Item"%>
<%@page import="com.amarsoft.dict.als.manage.CodeManager"%>
<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBeginMD.jsp"%><%
	/*
		Describe: ѡ�����;
	 */
	String sCaption  = CurPage.getParameter("Caption");				//ѡ������
	String sDefaultValue  = CurPage.getParameter("DefaultValue");				//ѡ������
	String sCodeNo  = CurPage.getParameter("CodeNo");					//�����еĴ����н���ƥ��Ĵ���
	String sItemNoExp  = CurPage.getParameter("ItemNoExpr");				//ƥ����ʽ����10*
	
	if(sCaption == null) sCaption = "����ѡ��";
	if(sDefaultValue == null) sDefaultValue = "";
	if(sCodeNo == null) throw new Exception("����Codeδ����");
	if(sItemNoExp == null) sItemNoExp = "";
	
	//ȡ���������
	Item[] codeDef = CodeManager.getItems(sCodeNo);
	if(codeDef == null) throw new Exception("δ�ҵ�����"+sCodeNo);
	
	//��������
	Vector list = new Vector();
	for(int i=0;i<codeDef.length;i++){
		String[] option = new String[2];
		Item vpItem = codeDef[i];
		String sTmp = (String)vpItem.getItemNo();	//ȡ��ItemNo��ֵ������ƥ��
		if(!sItemNoExp.equals("")){
			if(sTmp.matches(sItemNoExp)){
				option[0] = sTmp;
				option[1] = (String)vpItem.getItemName();
				list.add(option);
			}
		}else{
			option[0] = (String)vpItem.getItemNo();
			option[1] = (String)vpItem.getItemName();
			list.add(option);
		}
	}
%>
<html>
<head> 
<title><%=sCaption%></title>
<script type="text/javascript">
	function returnSelected(){
		top.returnValue=document.getElementById("ValueField").value;
		top.close();
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
      <td nowarp align="right" class="black9pt" bgcolor="#DCDCDC" >��ѡ��<%=sCaption%></td>
      <td nowarp bgcolor="#DCDCDC" > 
        <select id="ValueField">
					<option value="">&nbsp;</option>
					<% 
					for(int i=0;i<list.size();i++){
						String[] option = (String[])list.get(i);
						//����Ĭ��ֵ
						if(sDefaultValue.equals(option[0])){
							out.println("<option value='"+option[0]+"' selected>"+option[1]+"</option>");
						}else{
							out.println("<option value='"+option[0]+"'>"+option[1]+"</option>");
						}
					} 
					%>
        </select>
      </td>
    </tr>
    <tr>
      <td nowarp align="right" class="black9pt" bgcolor="#DCDCDC" height="25" >&nbsp;</td>
      <td nowarp bgcolor="#DCDCDC" height="25">
      	<%=new Button("ȷ��","ȷ��","returnSelected()","","btn_icon_submit").getHtmlText()%>
      	<%=new Button("ȡ��","ȡ��","self.returnValue='_CANCEL_';self.close()","","btn_icon_close").getHtmlText()%>
      </td>
    </tr>
  </table>
</body>
</html>
<%@ include file="/IncludeEnd.jsp"%>