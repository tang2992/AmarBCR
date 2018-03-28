<%@page import="com.amarsoft.are.util.json.JSONEncoder"%>
<%@page import="com.amarsoft.awe.util.ObjectTreeManager"%>
<%@page import="com.amarsoft.awe.ui.widget.ObjectTree"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin.jspf"%>
<script type="text/javascript" src="<%=sWebRootPath%>/Frame/resources/js/chart/json2.js"></script>
<script type="text/javascript" src="<%=sWebRootPath%>/Frame/page/js/widget/htmltree.js"></script>
<%
	String sClikItemNo = CurPage.getParameter("ClikItemNo");
	String sSelectItemNos = CurPage.getParameter("SelectItemNo");
	
	String[] aSelectItemNos = null;
	if(sSelectItemNos != null) aSelectItemNos = sSelectItemNos.split(",");
	//System.out.println(aSelectItemNos);

	ObjectTree tree = new ObjectTree("模拟行政区域");
	tree.procureAppendHtml().append("&nbsp;<a href=\"javascript:void(0);\" onclick=\"viewNode(this, event);return false;\" style=\"color:#0f0;\">详情</a>"+
									"&nbsp;<a href=\"javascript:void(0);\" onclick=\"addNode(this, event);return false;\" style=\"color:#00f;\">子增</a>"+
									"&nbsp;<a href=\"javascript:void(0);\" onclick=\"addNode(this, event, true);return false;\" style=\"color:#00f;\">前增</a>"+
									"&nbsp;<a href=\"javascript:void(0);\" onclick=\"addNode(this, event, false);return false;\" style=\"color:#00f;\">后增</a>"+
									"&nbsp;<a href=\"javascript:void(0);\" onclick=\"delNode(this, event);return false;\" style=\"color:#f00;\">删除</a>");
	
	tree.getStorys().addAll(ObjectTreeManager.genTreeNodes(
			Sqlca, new SqlObject("SELECT ItemNo, ItemName, SortNo, ItemName || '(' || ItemNo || ')' as Text FROM CODE_LIBRARY WHERE CodeNo = 'TestObjectTree'"),
			// icon text tips sort
			null, "Text", "ItemName", "SortNo",
			// click
			"ItemNo", sClikItemNo,
			// expand
			"ItemNo", new String[]{"540100","350100"},
			// check
			"ItemNo", aSelectItemNos));
	//System.out.println(JSONEncoder.encode(tree));
	
	TreeStory story = new TreeStory("new", "新增节点", "");
	story.getStorys().add(new TreeStory("", "aaa", ""));
	story.getAttributes().put("ItemNo", "New");
	story.getAttributes().put("ItemName", "新增节点");
%>
<body>
<div style="width:100%;">
<input id="search_input" onkeydown="searchTextKeyDown(event)" style="width:120px;" /><span></span>
<%
out.print(new Button("搜索", "", "searchRecord()").getHtmlText());
out.print(new Button("保存", "", "saveTree()").getHtmlText());
out.print(new Button("打开所有节点", "存在效率问题", "tree.getRoot().expand(true)").getHtmlText());
out.print(new Button("收起所有节点", "", "tree.getRoot().collapse(true)").getHtmlText());
if(aSelectItemNos != null){
	out.print(new Button("全选", "", "tree.getRoot().check()").getHtmlText());
	out.print(new Button("全不选", "", "tree.getRoot().uncheck()").getHtmlText());
	out.print(new Button("获取勾选节点", "", "showChecked()").getHtmlText());
}
%></div>
<div id="test" style="width:600px;height:500px;overflow:auto;cursor:url();"></div>
</body>
<script type="text/javascript">
	// 初始化生成树图，默认打开了根节点
	var tree = new HtmlTree(document.getElementById("test"), <%=JSONEncoder.encode(tree)%>);
	// 在样式文件前放入被叠加样式，优先级比样式文件里的样式低
	tree.nearCss("<style>.htmltree li .mark {background: #0ff;}<style>", true); // IE下放css文件不能叠加原有样式，只能用style
	// 在样式文件后放入被叠加样式，优先级比样式文件里的样式高
	tree.nearCss("<style>.htmltree .new .icon {background-color: #b7dcf4;}</style>");
	
	// 定义操作变量
	var mark = null;
	var searchNodes = null;
	var searchInput = $("#search_input");
	var searchSpan = searchInput.next();
	var searchIndex = 0;
	
	// 定义点击外置事件
	tree.NodeOnClick = function(node, e){
		//alert(JSON.stringify(node.getData()));
		if(mark) mark.unmark("mark");
		node.mark("mark");
		mark = node;
	};
	// 定义双击外置事件
	tree.NodeOnDblclick = function(node){
		node.toggle();
	};
	// 定义勾选外置事件
	tree.NodeOnCheck = function(nodes){
		alert("此次勾选了"+nodes.length+"个节点");
	};
	// 定义去除勾选外置事件
	tree.NodeOnUncheck = function(nodes){
		alert("此次去除了勾选"+nodes.length+"个节点");
	};
	// 定义移动节点外置事件
	tree.NodeOnMove = function(node, parent, index){
		var str = "";
		if(node == parent || node.isHigher(parent)) str = "节点【"+node.getText()+"】为向下级移动\n";
		return confirm("节点【"+node.getText()+"】将移动到节点【"+parent.getText()+"】的第"+index+"的位置上\n"+str+"是否移动？");
	};
	// 定义询问每执行多少次暂停(返回正数)或停止(返回非正数)的事件 funs将要执行的事件数组，efuns已执行的事件数组
	tree.EvalFunsAsk = function(funs, efuns){
		return tree.getEvalFunsAsk()(funs, efuns, 30); // 修改为每10个询问一次
	};
	
	// 按钮详情事件
	function viewNode(btn, e){
		AsLink.stopEvent(e); // 阻止冒泡
		var node = tree.getRoot().getNode(btn);
		alert(node.getText());
	}
	
	// 按钮新增事件 direction=true 前增，direction=false 后增， 其他 子增
	function addNode(btn, e, direction){
		AsLink.stopEvent(e); // 阻止冒泡
		var node = tree.getRoot().getNode(btn);
		node.add(<%=JSONEncoder.encode(story)%>, direction);
	}
	
	// 按钮删除事件
	function delNode(btn, e){
		AsLink.stopEvent(e); // 阻止冒泡
		if(!confirm("确定要删除节点？")) return;
		
		var node = tree.getRoot().getNode(btn);
		var data = node.getData();
		
		var flag = node.getChildren().length==0||confirm("保留子节点？");
		var storys = data["Storys"];
		if(flag) data["Storys"] = new Array();
		
		var sResult = AsControl.RunJavaMethod("com.amarsoft.app.awe.framecase.widget.ExampleHtmlTree", "deleteStory", JSON.stringify({"Data":data}));
		alert(sResult);
		
		if(flag) data["Storys"] = storys;
		node.remove(flag);
	}
	
	// 按钮保存事件
	function saveTree(){
		// 数据过大有可能传到后台不正确
		var sResult = AsControl.RunJavaMethod("com.amarsoft.app.awe.framecase.widget.ExampleHtmlTree", "saveTree", JSON.stringify({"Data":tree.getRoot().getData()}));
		alert(sResult);
	}
	
	// 搜索表单按键按下事件
	function searchTextKeyDown(e){
		AsLink.stopEvent(e);
		if(e.keyCode == 13){
			searchRecord();
			searchInput.focus();
		}else{
			searchNodes = null;
			searchSpan.text("");
		}
	}
	
	// 搜索按钮事件
	function searchRecord(){
		if(!searchNodes){
			searchNodes = tree.getRoot().getNodes(searchInput.val());
			searchIndex = 0;
			searchSpan.text("0/"+searchNodes.length);
			if(searchNodes.length == 0){
				searchNodes = null;
				return;
			}
		}
		if(searchIndex >= searchNodes.length) searchIndex = 0;
		if(mark) mark.unmark("mark");
		searchNodes[searchIndex].mark("mark", true);
		mark = searchNodes[searchIndex];
		searchSpan.text(++searchIndex+"/"+searchNodes.length);
	}
	
	// 展示勾选节点事件
	function showChecked(){
		var nodes = tree.getRoot().getChecked(confirm("包括半选节点？"));
		var str = "选择了"+nodes.length+"个节点：";
		for(var i = 0; i < nodes.length; i++){
			str += "\n"+nodes[i].getAttribute("ItemName");
		}
		alert(str);
	}
	
	// 定位当前点击节点
	AsLink.setShortcut("Ctrl+Shift+P", function(){
		var node = tree.getClick();
		if(!node) return;
		node.focus();
	});
	// 快捷定位
	// 上方向键移动定位节点
	AsLink.setShortcut("UP", function(){
		if(!mark) return;
		var downnode = mark.getUp();
		if(!downnode) return;
		downnode.mark("mark", true);
		mark.unmark("mark");
		mark = downnode;
	});
	// 下方向键移动定位节点
	AsLink.setShortcut("DOWN", function(){
		if(!mark) return;
		var downnode = mark.getDown();
		if(!downnode) return;
		downnode.mark("mark", true);
		mark.unmark("mark");
		mark = downnode;
	});
	// Enter键移动点击定位节点
	AsLink.setShortcut("ENTER", function(){
		if(!mark) return;
		mark.click();
	});
	// 左方向键收起定位节点
	AsLink.setShortcut("LEFT", function(){
		if(!mark) return;
		mark.collapse();
	});
	// 右方向键打开定位节点
	AsLink.setShortcut("RIGHT", function(){
		if(!mark) return;
		mark.expand();
	});
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>