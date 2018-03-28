<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<%
	//参数：0.是否显示, 1.标题，2.URL，3，参数串, 4. Strip高度(默认600px)，5. 是否有关闭按钮(默认无) 6. 是否缓存(默认是)
	String sTabStrip[][] = {
		{"true", "List", "/FrameCase/widget/dw/ExampleList.jsp", ""},
		{"true", "Info", "/FrameCase/widget/dw/ExampleInfo.jsp", "ExampleId=2013012300000001", "", "true"},
		{"true", "Frame_1", "/FrameCase/Layout/ExampleFrame.jsp", ""},
		{"true", "Frame_2", "/FrameCase/Layout/ExampleFrame.jsp", ""},
		{"true", "Tab", "/FrameCase/Layout/ExampleTab03.jsp", ""},
		{"true", "Blank", "/Blank.jsp", ""},
	};

	//参数：0.是否显示, 1.权限, 2.类型, 3.按钮文字, 4.说明文字, 5.事件, 6.快捷键, 7.资源路径, 8.资源路径参数, 9.图标, 10.风格
	String sButtons[][] = {
		{"true","","Button","按钮1", "", "alert('你点到我啦！')", "", "", "", "btn_icon_edit"},
		{"true","","Button","按钮2", "", "alert('第二个按钮')", "", "", "", "btn_icon_help"},
	};
	CurPage.setAttribute("BeforeTabStripHtml", Button.getHtmlText(sButtons, CurUser, CurPage, CurConfig));
	
	CurPage.setAttribute("AfterTabHtml", "<a href='javascript:void(0)' onclick='newTab();return false;' style='font-size:12px;'>新增</a>");
%>
<div style="z-index:9999;position:absolute;right:0;bottom:0;background:#fff;border:1px solid #aaa;font-size:12px;">
  	<pre>
  	
  	通过数组定义生成Tab框架页面示例
	1. 定义tab二维数组：
	参数：0.是否显示, 1.标题，2.URL，3，参数串
	示例: String sTabStrip[][] = {
		{"true", "演示页面标题", "/FrameCase/widget/dw/ExampleInfo.jsp", "ExampleId=2013012300000001"},
		};
	2. include 文件 /Resources/CodeParts/Tab01.jsp
	</pre>
	<a style="position:absolute;top:5px;left:5px;" href="javascript:void(0);" onclick="$(this).parent().slideUp();">X</a>
</div>
<%@ include file="/Resources/CodeParts/Tab01.jsp"%>
<script type="text/javascript">
var n = 0;
function newTab(){
	addTabStripItem('新增窗口'+(++n), '/AppMain/Blank.jsp', '');
}
function closeTab(sName, sFrameName){
	if(!frames[sFrameName]) return true;
	if($("body", frames[sFrameName].document).html()){
		return confirm("页面已经加载，是否关闭？");
	}else{
		return true;
	}
}
</script>
<%@ include file="/IncludeEnd.jsp"%>