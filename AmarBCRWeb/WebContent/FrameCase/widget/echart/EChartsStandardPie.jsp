<%@page import="com.amarsoft.awe.ui.echarts.code.SelectedMode"%>
<%@page import="com.amarsoft.awe.ui.echarts.series.Pie"%>
<%@page import="com.amarsoft.awe.ui.echarts.code.Y"%>
<%@page import="com.amarsoft.awe.ui.echarts.code.X"%>
<%@page import="com.amarsoft.awe.ui.echarts.code.Trigger"%>
<%@page import="com.amarsoft.awe.ui.echarts.util.JSON"%>
<%@page import="com.amarsoft.awe.ui.echarts.Option"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<html>
<head>
<title>eCharts</title>
</head>
<body
	style="overflow: hidden; height: 100%; width: 100%; margin: 0; padding: 0;">
	<div id="echarts" style="height: 100%; width: 100%;"></div>
</body>
<script src="<%=sWebRootPath%>/Frame/resources/js/echarts-plain.js"></script>
<script type="text/javascript">
	$(window).resize(echarts.init(document.getElementById("echarts")).setOption(<%
		Option option = new Option();
		option.tooltip().trigger(Trigger.item).formatter("{b} : {d}%");
		option.legend().x(X.left).y(Y.bottom).data("目标企业", "优质企业");
		Map<String, Object> data1 = new HashMap<String, Object>();
		data1.put("name", "目标企业");
		data1.put("value", 37.82);
		Map<String, Object> data2 = new HashMap<String, Object>();
		data2.put("name", "优质企业");
		data2.put("value", 62.18);
		option.series().add(new Pie("产权比率").radius("55%").selectedMode(SelectedMode.single).center("50%", "50%").data(data1, data2));
		
		out.print(JSON.encode(option));
	%>).resize);
</script>
</html>
<%@ include file="/IncludeEnd.jsp"%>