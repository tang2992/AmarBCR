<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<body style="overflow: hidden; height: 100%; width: 100%;">
<table height="100%" width="100%">
<tr height="1"><td>
<pre>
ǰ���������̶���������������鶨�尴ť�Ĳ�������һ��
new Button(String text, String tips, String action, String shortcutKey, String iconCls, String style).getHtmlText();
</pre>
</td></tr>
<tr height="100%"><td valign="top">
<input type="button" value="input" onclick="alert('input')" />
<button onclick="alert('button')">button</button>
<%=new Button("norm", "", "alert('norm')", "", "btn_icon_information", "").getHtmlText()%>
<%=new Button("sys", "", "alert('sys')", "", "btn_icon_information", "sys").getHtmlText()%>
<%=new Button("high", "", "alert('high')", "", "btn_icon_information", "high").getHtmlText()%>
<%=new Button("high2", "", "alert('high2')", "", "btn_icon_information", "high2").getHtmlText()%>
<%Button b = new Button("unable", "", "alert('���ܴ������¼������ǽ������')", "", "btn_icon_information", "unable");%>
<%=b.getHtmlText()%>
<hr>
<%=new Button("����", "����һ����¼", "test()", "", "btn_icon_add").getHtmlText()%>
<%=new Button("����","�鿴/�޸�����","test()","", "btn_icon_detail").getHtmlText()%>
<%=new Button("����","����","test()","","btn_icon_save").getHtmlText()%>
<%=new Button("ɾ��","ɾ����ѡ�еļ�¼","test()","", "btn_icon_delete").getHtmlText()%>
<%=new Button("�ر�","�ر�","test()","","btn_icon_close").getHtmlText()%>
<%=new Button("�ύ","�ύ","test()","","btn_icon_submit").getHtmlText()%>
<%=new Button("�༭","�༭","test()","","btn_icon_edit").getHtmlText()%>
<%=new Button("ˢ��","ˢ��","test()","","btn_icon_refresh").getHtmlText()%>
<%=new Button("��Ϣ","��Ϣ","test()","","btn_icon_information").getHtmlText()%>
<%=new Button("����","����","test()","","btn_icon_help").getHtmlText()%>
<%=new Button("�˳�","�˳�","test()","","btn_icon_exit").getHtmlText()%>
<%=new Button("����","����","test()","","btn_icon_check").getHtmlText()%>
<%=new Button("�ϼ�ͷ","�ϼ�ͷ","test()","","btn_icon_up").getHtmlText()%>
<%=new Button("�¼�ͷ","�¼�ͷ","test()","","btn_icon_down").getHtmlText()%>
<%=new Button("���ͷ","���ͷ","test()","","btn_icon_left").getHtmlText()%>
<%=new Button("�Ҽ�ͷ","�Ҽ�ͷ","test()","","btn_icon_right").getHtmlText()%>
<hr>
<%=new Button("������ť","","AsButton.unable('"+b.getButtonID()+"')").getHtmlText()%>
<span style="font-size:12px;">AsButton.unable(sBtnId);</span>
<br>
<%=new Button("���������ť","","AsButton.able('"+b.getButtonID()+"')").getHtmlText()%>
<span style="font-size:12px;">AsButton.able(sBtnId);</span>
</td></tr>
<tr><td>
<table><tr>
<td><%=new Button("�Ҽ�ͷ","�Ҽ�ͷ","test()","","btn_icon_right").getHtmlText()%></td>
<td><%=new Button("�Ҽ�ͷ","�Ҽ�ͷ","test()","","btn_icon_right").getHtmlText()%></td>
<td><%=new Button("�Ҽ�ͷ","�Ҽ�ͷ","test()","","btn_icon_right").getHtmlText()%></td>
<td><%=new Button("�Ҽ�ͷ","�Ҽ�ͷ","test()","","btn_icon_right").getHtmlText()%></td>
</tr></table>
</td></tr>
</table>
</body>
<script type="text/javascript">
	function test(){
		alert("�����ť");
	}
</script>
<%@ include file="/IncludeEnd.jsp"%>