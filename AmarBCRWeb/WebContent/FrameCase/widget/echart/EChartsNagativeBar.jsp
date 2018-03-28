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
		option.xAxis().add(new CategoryAxis().data("��������", "��Ȩ����", "���ʲ���̶��ʲ�����"));
		option.yAxis().add(new ValueAxis().axisLabel(new AxisLabel().formatter("{value} %")));
		option.tooltip().formatter("{a}<br/>{b}:{c}%").trigger(Trigger.item);
		option.legend().x(X.left).y(Y.bottom).data("Ŀ����ҵ", "������ҵ", "�е���ҵ", "�����ҵ");
		option.series().add(new Bar("Ŀ����ҵ").barCategoryGap("80%").data(2.176, 64.01, 6.649));
		option.series().add(new Bar("������ҵ").data(25.41, 15.367, 29.743));
		option.series().add(new Bar("�е���ҵ").data(44.106, 10.551, 6.052));
		option.series().add(new Bar("�����ҵ").data(14.041, -32.248, 81.07));
		
		out.print(JSON.encode(option));
	%>).resize);
</script>
</html>
<%@ include file="/IncludeEnd.jsp"%>