<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<%
	String sCustomerID = CurPage.getParameter("CustomerID");
	if(sCustomerID==null) sCustomerID = "";
	System.out.println();
 	// ������0.�Ƿ���ʾ, 1.���⣬2.URL��3��������, 4. Strip�߶�(Ĭ��600px)��5. �Ƿ��йرհ�ť(Ĭ����) 6. �Ƿ񻺴�(Ĭ����)
	String sTabStrip[][] = {
		//("CustomerInfoDetail","/DataMaintain/CustomerMaintain/CustomerStrip.jsp","CustomerID="+sCustomerID,"");
		{"true", "У�������Ϣ", "/DataMaintain/CustomerMaintain/Table01.jsp", "CustomerID="+sCustomerID, "100"},
		{"true", "�ͻ���Ϣά��", "/DataMaintain/CustomerMaintain/CustomerInfoDetail.jsp","CustomerID="+sCustomerID, "500"},
	};
 	
	// ������0.�Ƿ���ʾ, 1.Ȩ��, 2.����, 3.��ť����, 4.˵������, 5.�¼�, 6.��ݼ�, 7.��Դ·��, 8.��Դ·������, 9.ͼ��, 10.���
	String sButtons[][] = {
		{"true","","Button","�޸����","�޸����","aaa()","","","","btn_icon_edit"},
 	};
 	CurPage.setAttribute("BeforeTabStripHtml", Button.getHtmlText(sButtons, CurUser, CurPage, CurConfig));
%>
<!-- <div style="z-index:9999;position:absolute;right:0;top:0;background:#fff;border:1px solid #aaa;font-size:12px;">
  	<pre>
  	
	ͨ�����鶨������Strip���ҳ��ʾ��
	1. ����sTabStrip��ά���飺
	// ������0.�Ƿ���ʾ, 1.���⣬2.URL��3��������, 4. Strip�߶�(Ĭ��600px)��5. �Ƿ��йرհ�ť(Ĭ����) 6. �Ƿ񻺴�(Ĭ����)
	String sTabStrip[][] = {
		{"true", "����List", "/FrameCase/widget/dw/ExampleList.jsp", "", "500"},
		{"true", "����Info", "/FrameCase/widget/dw/ExampleInfo.jsp","ExampleId=2012081700000001", "500"},
	};
	2. include �ļ� /Resources/CodeParts/Strip01.jsp ��  /Resources/CodeParts/Tab01.jsp
	
	3. ���尴ť��λ����
	// ������0.�Ƿ���ʾ, 1.Ȩ��, 2.����, 3.��ť����, 4.˵������, 5.�¼�, 6.��ݼ�, 7.��Դ·��, 8.��Դ·������, 9.ͼ��, 10.���	
	String sButtons[][] = {
		{"true","","Button","��ť1","��ť1","aaa()","","","","btn_icon_edit"},
		{"true","","Button","��ť2","��ť2","bbb()","","","","btn_icon_help"},
	};
	4. �����ɵİ�ťHTML�������CurPage����BeforeTabStripHtml
	CurPage.setAttribute("BeforeTabStripHtml", Button.getHtmlText(sButtons, request));
	
</pre>
	<a style="position:absolute;top:5px;left:5px;" href="javascript:void(0);" onclick="$(this).parent().slideUp();">X</a>
</div> -->
<%@include file="/Resources/CodeParts/Strip01.jsp"%>
<script type="text/javascript">
	function aaa(){
		alert(1);
	}
	
	function bbb(){
		alert(2);
	}
</script>
<%@ include file="/IncludeEnd.jsp"%>