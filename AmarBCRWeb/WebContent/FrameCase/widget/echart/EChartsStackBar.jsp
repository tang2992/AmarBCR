<%@page import="com.amarsoft.awe.ui.echarts.code.SeriesType"%>
<%@page import="com.amarsoft.awe.ui.echarts.series.Bar"%>
<%@page import="com.amarsoft.awe.ui.echarts.code.Trigger"%>
<%@page import="com.amarsoft.awe.ui.echarts.code.Magic"%>
<%@page import="com.amarsoft.awe.ui.echarts.Title"%>
<%@page import="com.amarsoft.awe.ui.echarts.feature.MagicType"%>
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
	$(window).resize(echarts.init(document.getElementById("echarts")).setOption(JSON.prettyFunction(<%
		Map<String, String> magicTitle = new HashMap<String, String>();
		magicTitle.put("tiled", "分开");
	
		Option option = new Option();
		option.xAxis().add(new CategoryAxis().data("产权比率", "负债比率"));
		option.yAxis().add(new ValueAxis().axisLabel(new AxisLabel().formatter("{value} %")));
		option.legend().data("目标企业", "优质企业").x(X.left).y(Y.bottom);
		option.toolbox().show(true).x(X.left).y(Y.top).feature(new MagicType(Magic.stack, Magic.tiled).title(magicTitle).show(true));
		option.tooltip().formatter("{a}<br/>{b}:{c}%").trigger(Trigger.item);
		option.animation(false);
		option.series().add(new Bar("目标企业").type(SeriesType.bar).stack("比率").barCategoryGap("80%").data(64.01, 54.01));
		option.series().add(new Bar("优质企业").type(SeriesType.bar).stack("比率").data(94.01, 64.01));
		
		out.println(JSON.encode(option));
	%>)).resize);
</script>
</html>
<%@ include file="/IncludeEnd.jsp"%>