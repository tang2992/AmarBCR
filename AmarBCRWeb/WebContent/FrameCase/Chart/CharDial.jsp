<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin.jspf"%><%@
 page import="com.amarsoft.awe.ui.chart.*"%>
<script type="text/javascript" src="<%=sWebRootPath %>/Frame/resources/js/chart/swfobject.js"></script>
<script type="text/javascript">
<%
/*initValue ��ʼֵ,minValue ��Сֵ,maxValue ���ֵ,
safeMaxValue ��ɫ��ȫ�������ֵ,alarmMaxValue ��ɫ�����������ֵ,minorNums С�̶�����,step ��̶Ȳ���ֵ 
(��ز���ֵ�ɶ�̬��ȡ��ƴ�ӳ����и�ʽ����)
*/
	String flashVars="kpiName:'����������',initValue:4,minValue:0,maxValue:100,"+
					  "safeMaxValue:20,alarmMaxValue:60,minorNums:10,step:10";
%>
document.onready = function(){
	<%=ChartHelp.getDial(sWebRootPath,"mychart","50%","50%",flashVars)%>
};
</script>
<style>
body { margin: 0px; overflow:hidden }
</style>
<body>
<div id=mychart></div>
</body>
<%@ include file="/Frame/resources/include/include_end.jspf"%>