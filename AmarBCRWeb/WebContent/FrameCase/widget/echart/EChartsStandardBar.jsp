<%@page import="com.amarsoft.awe.ui.echarts.series.Line"%>
<%@page import="com.amarsoft.awe.ui.echarts.util.JSON"%>
<%@page import="com.amarsoft.awe.ui.echarts.Option"%>
<%@page import="com.amarsoft.awe.ui.echarts.util.Function"%>
<%@page import="com.amarsoft.awe.ui.echarts.code.Trigger"%>
<%@page import="com.amarsoft.awe.ui.echarts.Tooltip"%>
<%@page import="com.amarsoft.awe.ui.echarts.code.Y"%>
<%@page import="com.amarsoft.awe.ui.echarts.code.X"%>
<%@page import="com.amarsoft.awe.ui.echarts.Legend"%>
<%@page import="com.amarsoft.awe.ui.echarts.series.Bar"%>
<%@page import="com.amarsoft.awe.ui.echarts.axis.AxisLabel"%>
<%@page import="com.amarsoft.awe.ui.echarts.axis.ValueAxis"%>
<%@page import="com.amarsoft.awe.ui.echarts.axis.CategoryAxis"%>
<%@page import="com.amarsoft.awe.ui.echarts.axis.Axis"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<html>
<head>
<title>eCharts</title>
</head>
<body style="overflow: hidden; height: 100%; width: 100%; margin: 0; padding: 0;">
	<div id="echarts" style="height: 100%; width: 100%;"></div>
</body>
<script src="<%=sWebRootPath%>/Frame/resources/js/echarts-plain.js"></script>
<script type="text/javascript">
	var myCharts = echarts.init(document.getElementById("echarts"));
	myCharts.setOption(JSON.prettyFunction(<%
		Option option = new Option();
	
		// x轴
		Axis<CategoryAxis> xAxis = new CategoryAxis();
		xAxis.data("产权比率", "负债比率");
		option.xAxis(xAxis);
		// y轴
		ValueAxis yAxis = new ValueAxis();
		//yAxis.axisLabel().formatter("{value} %");
		//yAxis.axisLabel().formatter(new Function("function(value){return value+' %';}"));
		yAxis.axisLabel().formatter(new Function("getYLabel"));
		yAxis.max(100);
		option.yAxis(yAxis);
		
		// 数据内容
		Bar bar1 = new Bar("目标企业");
		bar1.data(64.01, 54.01);
		bar1.barCategoryGap("80%");
		option.series(bar1);
		Bar bar2 = new Bar("优质企业");
		bar2.data(94.01, 64.01);
		option.series(bar2);

		// 图例
		option.legend("目标企业", "优质企业");
		option.getLegend().setX(X.left);
		option.getLegend().setY(Y.bottom);
		
		// 设置鼠标停浮
		option.tooltip(Trigger.item);
		//option.tooltip().setFormatter("{a}<br/>{b}:{c}%");
		option.tooltip().setFormatter(new Function("getTips"));
		
		//System.out.println(JSON.encode(option));
		
		out.print(JSON.encode(option));
	%>));
	myCharts.on(echarts.config.EVENT.CLICK, function(param){
		//alert(this.getDataURL("png"));
		//alert(param.type+" "+param.seriesIndex+" "+param.dataIndex);
		var option = this.getOption();
		var serie = option.series[param.seriesIndex];
		var xdata = option.xAxis[0].data;
		var data = serie.data;
		alert("你点击到了【"+serie.name+"】的【"+xdata[param.dataIndex]+"】数据：【"+data[param.dataIndex]+"%】");
	});
	$(window).resize(myCharts.resize);
	
	// alert(JSON.stringify(myCharts.getOption()));
	function getTips(items){
		return items[0]+"<br>"+items[1]+":"+items[2]+"%";
	}
	
	function getYLabel(value){
		return value+" %";
	}
</script>
</html>
<%@ include file="/IncludeEnd.jsp"%>