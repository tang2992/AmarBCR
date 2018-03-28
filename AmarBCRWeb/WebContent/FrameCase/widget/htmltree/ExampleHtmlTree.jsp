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

	ObjectTree tree = new ObjectTree("ģ����������");
	tree.procureAppendHtml().append("&nbsp;<a href=\"javascript:void(0);\" onclick=\"viewNode(this, event);return false;\" style=\"color:#0f0;\">����</a>"+
									"&nbsp;<a href=\"javascript:void(0);\" onclick=\"addNode(this, event);return false;\" style=\"color:#00f;\">����</a>"+
									"&nbsp;<a href=\"javascript:void(0);\" onclick=\"addNode(this, event, true);return false;\" style=\"color:#00f;\">ǰ��</a>"+
									"&nbsp;<a href=\"javascript:void(0);\" onclick=\"addNode(this, event, false);return false;\" style=\"color:#00f;\">����</a>"+
									"&nbsp;<a href=\"javascript:void(0);\" onclick=\"delNode(this, event);return false;\" style=\"color:#f00;\">ɾ��</a>");
	
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
	
	TreeStory story = new TreeStory("new", "�����ڵ�", "");
	story.getStorys().add(new TreeStory("", "aaa", ""));
	story.getAttributes().put("ItemNo", "New");
	story.getAttributes().put("ItemName", "�����ڵ�");
%>
<body>
<div style="width:100%;">
<input id="search_input" onkeydown="searchTextKeyDown(event)" style="width:120px;" /><span></span>
<%
out.print(new Button("����", "", "searchRecord()").getHtmlText());
out.print(new Button("����", "", "saveTree()").getHtmlText());
out.print(new Button("�����нڵ�", "����Ч������", "tree.getRoot().expand(true)").getHtmlText());
out.print(new Button("�������нڵ�", "", "tree.getRoot().collapse(true)").getHtmlText());
if(aSelectItemNos != null){
	out.print(new Button("ȫѡ", "", "tree.getRoot().check()").getHtmlText());
	out.print(new Button("ȫ��ѡ", "", "tree.getRoot().uncheck()").getHtmlText());
	out.print(new Button("��ȡ��ѡ�ڵ�", "", "showChecked()").getHtmlText());
}
%></div>
<div id="test" style="width:600px;height:500px;overflow:auto;cursor:url();"></div>
</body>
<script type="text/javascript">
	// ��ʼ��������ͼ��Ĭ�ϴ��˸��ڵ�
	var tree = new HtmlTree(document.getElementById("test"), <%=JSONEncoder.encode(tree)%>);
	// ����ʽ�ļ�ǰ���뱻������ʽ�����ȼ�����ʽ�ļ������ʽ��
	tree.nearCss("<style>.htmltree li .mark {background: #0ff;}<style>", true); // IE�·�css�ļ����ܵ���ԭ����ʽ��ֻ����style
	// ����ʽ�ļ�����뱻������ʽ�����ȼ�����ʽ�ļ������ʽ��
	tree.nearCss("<style>.htmltree .new .icon {background-color: #b7dcf4;}</style>");
	
	// �����������
	var mark = null;
	var searchNodes = null;
	var searchInput = $("#search_input");
	var searchSpan = searchInput.next();
	var searchIndex = 0;
	
	// �����������¼�
	tree.NodeOnClick = function(node, e){
		//alert(JSON.stringify(node.getData()));
		if(mark) mark.unmark("mark");
		node.mark("mark");
		mark = node;
	};
	// ����˫�������¼�
	tree.NodeOnDblclick = function(node){
		node.toggle();
	};
	// ���年ѡ�����¼�
	tree.NodeOnCheck = function(nodes){
		alert("�˴ι�ѡ��"+nodes.length+"���ڵ�");
	};
	// ����ȥ����ѡ�����¼�
	tree.NodeOnUncheck = function(nodes){
		alert("�˴�ȥ���˹�ѡ"+nodes.length+"���ڵ�");
	};
	// �����ƶ��ڵ������¼�
	tree.NodeOnMove = function(node, parent, index){
		var str = "";
		if(node == parent || node.isHigher(parent)) str = "�ڵ㡾"+node.getText()+"��Ϊ���¼��ƶ�\n";
		return confirm("�ڵ㡾"+node.getText()+"�����ƶ����ڵ㡾"+parent.getText()+"���ĵ�"+index+"��λ����\n"+str+"�Ƿ��ƶ���");
	};
	// ����ѯ��ÿִ�ж��ٴ���ͣ(��������)��ֹͣ(���ط�����)���¼� funs��Ҫִ�е��¼����飬efuns��ִ�е��¼�����
	tree.EvalFunsAsk = function(funs, efuns){
		return tree.getEvalFunsAsk()(funs, efuns, 30); // �޸�Ϊÿ10��ѯ��һ��
	};
	
	// ��ť�����¼�
	function viewNode(btn, e){
		AsLink.stopEvent(e); // ��ֹð��
		var node = tree.getRoot().getNode(btn);
		alert(node.getText());
	}
	
	// ��ť�����¼� direction=true ǰ����direction=false ������ ���� ����
	function addNode(btn, e, direction){
		AsLink.stopEvent(e); // ��ֹð��
		var node = tree.getRoot().getNode(btn);
		node.add(<%=JSONEncoder.encode(story)%>, direction);
	}
	
	// ��ťɾ���¼�
	function delNode(btn, e){
		AsLink.stopEvent(e); // ��ֹð��
		if(!confirm("ȷ��Ҫɾ���ڵ㣿")) return;
		
		var node = tree.getRoot().getNode(btn);
		var data = node.getData();
		
		var flag = node.getChildren().length==0||confirm("�����ӽڵ㣿");
		var storys = data["Storys"];
		if(flag) data["Storys"] = new Array();
		
		var sResult = AsControl.RunJavaMethod("com.amarsoft.app.awe.framecase.widget.ExampleHtmlTree", "deleteStory", JSON.stringify({"Data":data}));
		alert(sResult);
		
		if(flag) data["Storys"] = storys;
		node.remove(flag);
	}
	
	// ��ť�����¼�
	function saveTree(){
		// ���ݹ����п��ܴ�����̨����ȷ
		var sResult = AsControl.RunJavaMethod("com.amarsoft.app.awe.framecase.widget.ExampleHtmlTree", "saveTree", JSON.stringify({"Data":tree.getRoot().getData()}));
		alert(sResult);
	}
	
	// ���������������¼�
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
	
	// ������ť�¼�
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
	
	// չʾ��ѡ�ڵ��¼�
	function showChecked(){
		var nodes = tree.getRoot().getChecked(confirm("������ѡ�ڵ㣿"));
		var str = "ѡ����"+nodes.length+"���ڵ㣺";
		for(var i = 0; i < nodes.length; i++){
			str += "\n"+nodes[i].getAttribute("ItemName");
		}
		alert(str);
	}
	
	// ��λ��ǰ����ڵ�
	AsLink.setShortcut("Ctrl+Shift+P", function(){
		var node = tree.getClick();
		if(!node) return;
		node.focus();
	});
	// ��ݶ�λ
	// �Ϸ�����ƶ���λ�ڵ�
	AsLink.setShortcut("UP", function(){
		if(!mark) return;
		var downnode = mark.getUp();
		if(!downnode) return;
		downnode.mark("mark", true);
		mark.unmark("mark");
		mark = downnode;
	});
	// �·�����ƶ���λ�ڵ�
	AsLink.setShortcut("DOWN", function(){
		if(!mark) return;
		var downnode = mark.getDown();
		if(!downnode) return;
		downnode.mark("mark", true);
		mark.unmark("mark");
		mark = downnode;
	});
	// Enter���ƶ������λ�ڵ�
	AsLink.setShortcut("ENTER", function(){
		if(!mark) return;
		mark.click();
	});
	// ���������λ�ڵ�
	AsLink.setShortcut("LEFT", function(){
		if(!mark) return;
		mark.collapse();
	});
	// �ҷ�����򿪶�λ�ڵ�
	AsLink.setShortcut("RIGHT", function(){
		if(!mark) return;
		mark.expand();
	});
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>