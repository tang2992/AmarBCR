<%@page import="com.amarsoft.awe.ui.echarts.style.AreaStyle"%>
<%@page import="com.amarsoft.awe.ui.echarts.style.ItemStyle"%>
<%@page import="com.amarsoft.awe.ui.echarts.style.itemstyle.Normal"%>
<%@page import="com.amarsoft.awe.ui.echarts.series.Line"%>
<%@page import="com.amarsoft.awe.ui.echarts.code.Trigger"%>
<%@page import="com.amarsoft.awe.ui.echarts.code.Y"%>
<%@page import="com.amarsoft.awe.ui.echarts.code.X"%>
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
		option.xAxis().add(new CategoryAxis().boundaryGap(false).data("产权比率", "负债比率"));
		option.yAxis().add(new ValueAxis().axisLabel(new AxisLabel().formatter("{value} %")));
		option.legend().x(X.left).y(Y.bottom).data("目标企业", "优质企业");
		option.tooltip().formatter("{a}<br/>{b}:{c}%").trigger(Trigger.item);
		option.animation(false);
		option.series().add(new Line("目标企业").data(64.01, 54.01).itemStyle(new ItemStyle().normal(new Normal().areaStyle(new AreaStyle().type("default")))));
		option.series().add(new Line("优质企业").data(94.01, 64.01).itemStyle(new ItemStyle().normal(new Normal().areaStyle(new AreaStyle().type("default")))));
	
		out.print(JSON.encode(option));
	%>).resize);
</script>
</html>
<%@ include file="/IncludeEnd.jsp"%>