<%@page import="com.amarsoft.awe.ui.echarts.series.Bar"%>
<%@page import="com.amarsoft.awe.ui.echarts.code.Trigger"%>
<%@page import="com.amarsoft.awe.ui.echarts.code.Y"%>
<%@page import="com.amarsoft.awe.ui.echarts.code.X"%>
<%@page import="com.amarsoft.awe.ui.echarts.util.JSON"%>
<%@page import="com.amarsoft.awe.ui.echarts.axis.CategoryAxis"%>
<%@page import="com.amarsoft.awe.ui.echarts.axis.AxisLabel"%>
<%@page import="com.amarsoft.awe.ui.echarts.axis.ValueAxis"%>
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
		option.xAxis().add(new ValueAxis().axisLabel(new AxisLabel().formatter("{value} %")));
		option.yAxis().add(new CategoryAxis().data("��Ȩ����", "��ծ����"));
		option.legend().x(X.left).y(Y.bottom).data("Ŀ����ҵ", "������ҵ");
		option.tooltip().formatter("{a}<br/>{b}:{c}%").trigger(Trigger.item);
		option.animation(false);
		option.series().add(new Bar("Ŀ����ҵ").barCategoryGap("80").data(64.01, 54.01));
		option.series().add(new Bar("������ҵ").data(94.01, 64.01));
		
		out.print(JSON.encode(option));
	%>).resize);
</script>
</html>
<%@ include file="/IncludeEnd.jsp"%>