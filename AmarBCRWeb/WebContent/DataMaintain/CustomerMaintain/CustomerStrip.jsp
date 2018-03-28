<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<%
	String sCustomerID = CurPage.getParameter("CustomerID");
	if(sCustomerID==null) sCustomerID = "";
	System.out.println();
 	// 参数：0.是否显示, 1.标题，2.URL，3，参数串, 4. Strip高度(默认600px)，5. 是否有关闭按钮(默认无) 6. 是否缓存(默认是)
	String sTabStrip[][] = {
		//("CustomerInfoDetail","/DataMaintain/CustomerMaintain/CustomerStrip.jsp","CustomerID="+sCustomerID,"");
		{"true", "校验错误信息", "/DataMaintain/CustomerMaintain/Table01.jsp", "CustomerID="+sCustomerID, "100"},
		{"true", "客户信息维护", "/DataMaintain/CustomerMaintain/CustomerInfoDetail.jsp","CustomerID="+sCustomerID, "500"},
	};
 	
	// 参数：0.是否显示, 1.权限, 2.类型, 3.按钮文字, 4.说明文字, 5.事件, 6.快捷键, 7.资源路径, 8.资源路径参数, 9.图标, 10.风格
	String sButtons[][] = {
		{"true","","Button","修改完成","修改完成","aaa()","","","","btn_icon_edit"},
 	};
 	CurPage.setAttribute("BeforeTabStripHtml", Button.getHtmlText(sButtons, CurUser, CurPage, CurConfig));
%>
<!-- <div style="z-index:9999;position:absolute;right:0;top:0;background:#fff;border:1px solid #aaa;font-size:12px;">
  	<pre>
  	
	通过数组定义生成Strip框架页面示例
	1. 定义sTabStrip二维数组：
	// 参数：0.是否显示, 1.标题，2.URL，3，参数串, 4. Strip高度(默认600px)，5. 是否有关闭按钮(默认无) 6. 是否缓存(默认是)
	String sTabStrip[][] = {
		{"true", "典型List", "/FrameCase/widget/dw/ExampleList.jsp", "", "500"},
		{"true", "典型Info", "/FrameCase/widget/dw/ExampleInfo.jsp","ExampleId=2012081700000001", "500"},
	};
	2. include 文件 /Resources/CodeParts/Strip01.jsp 或  /Resources/CodeParts/Tab01.jsp
	
	3. 定义按钮二位数组
	// 参数：0.是否显示, 1.权限, 2.类型, 3.按钮文字, 4.说明文字, 5.事件, 6.快捷键, 7.资源路径, 8.资源路径参数, 9.图标, 10.风格	
	String sButtons[][] = {
		{"true","","Button","按钮1","按钮1","aaa()","","","","btn_icon_edit"},
		{"true","","Button","按钮2","按钮2","bbb()","","","","btn_icon_help"},
	};
	4. 将生成的按钮HTML代码放入CurPage属性BeforeTabStripHtml
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