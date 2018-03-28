<%@page import="com.amarsoft.awe.ui.echarts.series.Bar"%>
<%@page import="com.amarsoft.awe.ui.echarts.code.Y"%>
<%@page import="com.amarsoft.awe.ui.echarts.code.X"%>
<%@page import="com.amarsoft.awe.ui.echarts.code.Trigger"%>
<%@page import="com.amarsoft.awe.ui.echarts.axis.AxisLabel"%>
<%@page import="com.amarsoft.awe.ui.echarts.axis.ValueAxis"%>
<%@page import="com.amarsoft.awe.ui.echarts.axis.CategoryAxis"%>
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
		option.xAxis().add(new CategoryAxis().data("流动比率", "产权比率", "总资产与固定资产比率"));
		option.yAxis().add(new ValueAxis().axisLabel(new AxisLabel().formatter("{value} %")));
		option.tooltip().formatter("{a}<br/>{b}:{c}%").trigger(Trigger.item);
		option.legend().x(X.left).y(Y.bottom).data("目标企业", "优质企业", "中等企业", "最差企业");
		option.series().add(new Bar("目标企业").barCategoryGap("80%").data(2.176, 64.01, 6.649));
		option.series().add(new Bar("优质企业").data(25.41, 15.367, 29.743));
		option.series().add(new Bar("中等企业").data(44.106, 10.551, 6.052));
		option.series().add(new Bar("最差企业").data(14.041, -32.248, 81.07));
		
		out.print(JSON.encode(option));
	%>).resize);
</script>
</html>
<%@ include file="/IncludeEnd.jsp"%>