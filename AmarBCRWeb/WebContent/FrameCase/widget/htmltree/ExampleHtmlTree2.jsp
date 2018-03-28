<%@page import="com.amarsoft.are.util.json.JSONEncoder"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin.jspf"%>
<script type="text/javascript" src="<%=sWebRootPath%>/Frame/page/js/widget/htmltree.js"></script>
<%
	ObjectTree tree = new ObjectTree("��ѡ�ΰ밸��");
	int m = 25, n = 2 , p = 10;
	for(int i = 0; i < m; i++){
		TreeStory story1 = new TreeStory("", "�ڵ�"+(i+1), "");
		if(i == 0) story1.getAttributes().put("AttrKey", "AttrValue");
		tree.getStorys().add(story1);
		if(i < m/2) story1.setCheck(TreeStory.MULTI);
		for(int j = 0; j < n; j++){
			TreeStory story2 = new TreeStory("", "�ڵ�"+(i+1)+"."+(j+1), "");
			story1.getStorys().add(story2);
			for(int k = 0; k < p; k++){
				TreeStory story3 = new TreeStory("�ڵ�"+(i+1)+"."+(j+1)+"."+(k+1));
				if((i == 0 && j == 0) || k % 2 == 1) story3.setCheck(TreeStory.MULTI);
				if(k == p - 1) story3.setIcon("folder");
				story2.getStorys().add(story3);
			}
		}
	}
	System.out.println("==ObjectTree��JSON�ṹ=============================================");
	System.out.println(JSONEncoder.encode(tree));
	System.out.println("===============================================");
%>
<body>
<div style="width:100%;"><%
out.print(new Button("ȫѡ", "", "tree.getRoot().check()").getHtmlText());
out.print(new Button("ȫ��ѡ", "", "tree.getRoot().uncheck()").getHtmlText());
out.print(new Button("��ȡ��ѡ�ڵ�", "", "showChecked()").getHtmlText());
out.print(new Button("�ڵ�����", "", "alert('����'+tree.getRoot().getNodes().length+'���ڵ�')").getHtmlText());
%></div>
<div id="test" style="width:600px;height:500px;overflow:auto;"></div>
</body>
<script type="text/javascript">
	var tree = new HtmlTree(document.getElementById("test"), <%=JSONEncoder.encode(tree)%>);
	
	function showChecked(){
		var nodes = tree.getRoot().getChecked(confirm("������ѡ�ڵ㣿"));
		var str = "ѡ����"+nodes.length+"���ڵ㣺";
		for(var i = 0; i < nodes.length; i++){
			str += "\n"+nodes[i].getText();
		}
		alert(str);
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>