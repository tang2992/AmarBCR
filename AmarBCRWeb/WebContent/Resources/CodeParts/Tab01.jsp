<%String _sView = "tab";%>
<%@ include file="/Resources/CodeParts/TabStrip01.jsp"%>
<script type="text/javascript"><%try{
if("true".equals(CurPage.getAttribute("TabNowrap"))){%>$(".tabs_button >ul").width(3000);<%}
if(CurPage.getAttribute("AfterTabHtml") != null){%>
	$('<%=CurPage.getAttribute("AfterTabHtml").replace("'", "\\'")%>').appendTo('#divine_handle_'+tabCompent.getID());
<%}}catch(Exception e){}%>
 
function addTabItem(sTitle, sUrl, sParas, bOpen){
	addTabStripItem(sTitle, sUrl, sParas, bOpen);
}
/**
 * �ر�Tab��ǩǰ���÷���
 * @returns {Boolean} false tab��ǩ���ر�
 */
function closeTab(sItemName, sFrameName){
	//alert([sItemName, sFrameName]); // ��ǩ���ơ���ǩ��Ӧҳ�������
	//alert(frames[sFrameName]); // ȡ��ǩ��window����
	//alert($("body", frames[sFrameName].document).html()); // ������ǩҳ������ࡢ����

	/*
	// ��һ��ҳ�浽��ǩҳ��ȥ������false�Է�ֹ�رձ�ǩ
	AsControl.OpenView("/AppMain/Blank.jsp", "", sFrameName);
	return false;
	*/
	
	return true;
}

$(function(){
	tabCompent.setCloseCallback(closeTab);
	$(window).resize(function(){
		$(".tabs_content").height($("#window1").height()-$(".tabs_button").height());
	}).resize();
});
</script>