<%@ page contentType="text/html; charset=GBK" import="com.amarsoft.are.util.json.JSONEncoder"%>
<html>
<head>
<title></title>
<link rel="stylesheet" type="text/css" href="<%=sWebRootPath%>/Frame/page/resources/css/strip.css">
<link rel="stylesheet" type="text/css" href="<%=sWebRootPath%>/Frame/page/resources/css/tabs.css">
<link rel="stylesheet" type="text/css" href="<%=sWebRootPath%><%=sSkinPath%>/css/tabs.css">
<script type="text/javascript" src="<%=sWebRootPath%>/Frame/resources/js/tabstrip-1.0.js"></script>
</head>
<body leftmargin="0" topmargin="0" style="overflow:hidden;height:100%;width:100%;">
<%try{if(!StringX.isSpace(CurPage.getAttribute("BeforeTabStripHtml"))){%><div id="BeforeTabStrip"><%=CurPage.getAttribute("BeforeTabStripHtml")%></div><%}}catch(Exception e){}%>
<div id="window1" style="vertical-align:middle;padding:0;border:0px solid #F00;height:100%;width: 100%; overflow:hidden">
</div>
</body>
<script type="text/javascript">
<%int _first = 0;try{_first = Integer.valueOf(CurPage.getAttribute("First"));}catch(Exception e){}%>
var tabCompent = new TabStrip("T01", "����TabStrip��", "<%=_sView%>", "#window1");
(function(datas, first){
	var nums = new Array();
	for(var i = 0; i < datas.length; i++){
		// ������0.�Ƿ���ʾ, 1.���⣬2.URL��3��������, 4. Strip�߶�(Ĭ��600px)��5. �Ƿ��йرհ�ť(Ĭ����) 6. �Ƿ񻺴�(Ĭ����)
		if(datas[i][0] != "true") continue;
		nums.push(i);
		var script = "";
		if(datas[i][2]) script = "AsControl.OpenComp('"+datas[i][2]+"', '"+datas[i][[3]]+"', 'TabContentFrame')";
		tabCompent.addDataItem(self.name+i, datas[i][1], script, datas[i][6] == "false" ? false : true, datas[i][5] == "true" ? true : false, datas[i][4]);
	}
	if(nums.indexOf(first) < 0) first = nums[0];
	tabCompent.setSelectedItem(self.name+first);
	tabCompent.init();
	
	var bts = document.getElementById("BeforeTabStrip");
	if(bts) $(window).resize(function(){
		$("#window1").height($("body").height() - $(bts).height());
	}).resize();
})(<%=JSONEncoder.encode(sTabStrip)%>, <%=_first%>);

function addTabStripItem(sTitle, sUrl, sParas, bOpen){
	if(bOpen != false) bOpen = true;
	var script = !sUrl ? "" : "AsControl.OpenView('"+sUrl+"', '"+sParas+"', 'TabContentFrame')";
	tabCompent.addItem(self.name+escape(sTitle).replace(/[^A-z0-9]/g, ""), sTitle, script, true, true, bOpen);
}
</script>
</html>