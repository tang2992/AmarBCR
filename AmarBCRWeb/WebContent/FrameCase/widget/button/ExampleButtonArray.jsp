<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%><%
	String sButtons[][] = {
		{"true","","Button","����","����һ����¼","test()","","","",""},//btn_icon_add
		{"true","All","Button","����","�鿴/�޸�����","test()","","","",""},//btn_icon_detail
		{"true","","Button","����","�����޸�","test()","","","",""},//btn_icon_save
		{"true","","Button","ɾ��","ɾ����ѡ�еļ�¼","test()","","","",""},//btn_icon_delete
		{"true","All","Button","�ر�","�ر�","test()","","","","btn_icon_close"},
		{"true","All","Button","�ύ","�ύ","test()","","","","btn_icon_submit"},
		{"true","All","Button","�༭","�༭","test()","","","","btn_icon_edit"},
		{"true","All","Button","ˢ��","ˢ��","test()","","","","btn_icon_refresh"},
		{"true","All","Button","��Ϣ","��Ϣ","test()","","","","btn_icon_information"},
		{"true","All","Button","����","����","test()","","","","btn_icon_help"},
		{"true","All","Button","�˳�","�˳�","test()","","","","btn_icon_exit"},
		{"true","All","Button","����","����","test()","","","","btn_icon_check"},
		{"true","All","Button","�ϼ�ͷ","�ϼ�ͷ","test()","","","","btn_icon_up"},
		{"true","All","Button","�¼�ͷ","�¼�ͷ","test()","","","","btn_icon_down"},
		{"true","All","Button","���ͷ","���ͷ","test()","","","","btn_icon_left"},
		{"true","All","Button","�Ҽ�ͷ","�Ҽ�ͷ","test()","","","","btn_icon_right"}
	};
%>
<div>
  	<pre>
  	
  	��ť���鶨�壬����Ϊ:
	0.�Ƿ���ʾ "true"/"false"
	1.Ȩ�����ͣ�����������ɾ���ͱ���������ť��Ϊ���⣬����������Ϊ'All'
	2.���ͣ�Ĭ��ΪButton (��ѡButton/ButtonWithNoAction/HyperLinkText/TreeviewItem/PlainText/Blank)
	3.��ť����
	4.��ʾ����
	5.������
	6.shortcutKey ��ݼ�
	7.href ��Դ·��
	8.parm ��Դ·������
	9.iconCls ͼ�� CSS���� (�ο� button.css)
	
  	String sButtons[][] = {
		{"true","","Button","����","����һ����¼","newRecord()","","","",""},
		{"true","","Button","����","����","saveRecord()","","","",""},
		{"true","","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","",""},
		{"true","All","Button","�ر�","�ر�","close()","","","","btn_icon_close"}
	}
	</pre>
</div>
<%@ include file="/Frame/resources/include/ui/include_buttonset_dw.jspf"%>
<hr>
<%=new Button("����[����]��ť","","AsButton.unable('����')").getHtmlText()%>
<span style="font-size:12px;">AsButton.unable('����');</span>
<br>
<%=new Button("�������[����]��ť","","AsButton.able('����')").getHtmlText()%>
<span style="font-size:12px;">AsButton.able('����');</span>
<script type="text/javascript">
	function test(){
		alert('�����ť');
	}
</script>
<%@ include file="/IncludeEnd.jsp"%>