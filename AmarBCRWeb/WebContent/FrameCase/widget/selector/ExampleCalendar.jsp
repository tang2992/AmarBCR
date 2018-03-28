<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<html>
<head>
<style>
	body {
		overflow: auto;
		padding: 10px;
	}
	.test {
		border: solid #aaa;
		border-width: 1px 1px 0 1px;
	}
	.test td {
		border: 0 solid #aaa;
		border-bottom-width: 1px;
		padding: 2px;
	}
	.test b {
		padding: 0 10px;
	}
	.test input {
		cursor:pointer;
	}
</style>
</head>
<body>
<table class="test" cellspacing=0 cellpadding=0 >
	<tr>
		<td colspan="5" style="padding-left:20px;"><pre>
/**
 * ����ѡ����
 * @param obj �󶨿ؼ���һ��Ϊtext�����
 * @param strFormat ���ڸ�ʽ���ַ���
 * @param startDate ��ѡ��������ֵ��"Today"����ǰ���ڡ����������ͣ��뵱ǰ���ڵ�����ƫ���������ַ�������strFormat��ʽһ�µ�ʱ�䡿���գ��������ơ�
 * @param endDate ��ѡ��������ֵ����startDate�Ľ���һ�¡�
 * @param postEvent ����ѡ������¼�������function(){...}
 * @param x ����ƫ����
 * @param y ����ƫ����
 */
AsDialog.OpenCalender(obj, strFormat, startDate, endDate, postEvent, x, y);
		</pre></td>
	</tr>
	<tr>
		<td rowspan="5" style="border-right-width:1px;">���ڸ�ʽ</td>
		<td colspan="2">ȫ��ʽ</td>
		<td><input id="test11" onclick="AsDialog.OpenCalender(this, 'yyyy/MM/dd hh:mm:ss');" /><button onclick="AsDialog.OpenCalender('test11', 'yyyy/MM/dd hh:mm:ss');" >...</button></td>
		<td>AsDialog.OpenCalender(obj, 'yyyy/MM/dd hh:mm:ss');</td>
	</tr>
	<tr>
		<td colspan="2">������(Ĭ��)</td>
		<td><input id="test12" onclick="AsDialog.OpenCalender(this);" /><button onclick="AsDialog.OpenCalender('test12');" >...</button></td>
		<td>AsDialog.OpenCalender(obj);<b>��</b>AsDialog.OpenCalender(obj, 'yyyy/MM/dd');</td>
	</tr>
	<tr>
		<td colspan="2">����</td>
		<td><input id="test13" onclick="AsDialog.OpenCalender(this, 'yyyy/MM');" /><button onclick="AsDialog.OpenCalender('test13', 'yyyy/MM');" >...</button></td>
		<td>AsDialog.OpenCalender(obj, 'yyyy/MM');</td>
	</tr>
	<tr>
		<td colspan="2">��</td>
		<td><input id="test14" onclick="AsDialog.OpenCalender(this, 'yyyy');" /><button onclick="AsDialog.OpenCalender('test14', 'yyyy');" >...</button></td>
		<td>AsDialog.OpenCalender(obj, 'yyyy');</td>
	</tr>
	<tr>
		<td colspan="2">���ĸ�ʽ</td>
		<td><input id="test15" onclick="AsDialog.OpenCalender(this, 'yyyy��MM��dd��hhʱmm��ss��');" style="overflow:visible;"/><button onclick="AsDialog.OpenCalender('test15', 'yyyy��MM��dd��hhʱmm��ss��');" >...</button></td>
		<td>AsDialog.OpenCalender(obj, 'yyyy��MM��dd��hhʱmm��ss��');</td>
	</tr>
	<tr>
		<td rowspan="7" style="border-right-width:1px;">��������</td>
		<td colspan="2">������(����ǰ��50��)</td>
		<td><input id="test21" onclick="AsDialog.OpenCalender(this, 'yyyy/MM/dd hh:mm:ss');" /><button onclick="AsDialog.OpenCalender('test21', 'yyyy/MM/dd hh:mm:ss');" >...</button></td>
		<td>AsDialog.OpenCalender(this, strFormat);</td>
	</tr>
	<tr>
		<td colspan="2">ǰ����</td>
		<td><input id="test22" onclick="AsDialog.OpenCalender(this, 'yyyy/MM/dd hh:mm:ss', '2012/10/25 12:30:00');" /><button onclick="AsDialog.OpenCalender('test22', 'yyyy/MM/dd hh:mm:ss', '2012/10/25 12:30:00');" >...</button></td>
		<td>AsDialog.OpenCalender(this, strFormat, beginDate);</td>
	</tr>
	<tr>
		<td colspan="2">������</td>
		<td><input id="test23" onclick="AsDialog.OpenCalender(this, 'yyyy/MM/dd hh:mm:ss', '', '2012/10/25 12:30:00');" /><button onclick="AsDialog.OpenCalender('test23', 'yyyy/MM/dd hh:mm:ss', '', '2012/10/25 12:30:00');" >...</button></td>
		<td>AsDialog.OpenCalender(this, strFormat, '', endDate);</td>
	</tr>
	<tr>
		<td colspan="2">ǰ������</td>
		<td><input id="test24" onclick="AsDialog.OpenCalender(this, 'yyyy/MM/dd hh:mm:ss', '2010/10/25 00:00:00', '2012/10/25 12:30:00');" /><button onclick="AsDialog.OpenCalender('test24', 'yyyy/MM/dd hh:mm:ss', '2010/10/25 00:00:00', '2012/10/25 12:30:00');" >...</button></td>
		<td>AsDialog.OpenCalender(this, strFormat, beginDate, endDate);</td>
	</tr>
	<tr>
		<td rowspan="3" style="border-right-width:1px;">�뵱ǰʱ�����</td>
		<td>��ǰʱ���</td>
		<td><input id="test31" onclick="AsDialog.OpenCalender(this, 'yyyy/MM/dd', 'today');" /><button onclick="AsDialog.OpenCalender('test31', 'yyyy/MM/dd', 'today');" >...</button></td>
		<td>AsDialog.OpenCalender(this, strFormat, 'today');</td>
	</tr>
	<tr>
		<td>��ǰʱ��ǰ</td>
		<td><input id="test32" onclick="AsDialog.OpenCalender(this, 'yyyy/MM/dd', '', 'today');" /><button onclick="AsDialog.OpenCalender('test32', 'yyyy/MM/dd', '', 'today');" >...</button></td>
		<td>AsDialog.OpenCalender(this, strFormat, '', 'today');</td>
	</tr>
	<tr>
		<td>��ǰʱ��ǰ3600���3600��</td>
		<td><input id="test33" onclick="AsDialog.OpenCalender(this, 'yyyy/MM/dd', -3600, 3600);" /><button onclick="AsDialog.OpenCalender('test33', 'yyyy/MM/dd', -3600, 3600);" >...</button></td>
		<td>AsDialog.OpenCalender(this, strFormat, -3600, 3600);</td>
	</tr>
</table>
</body>
</html>
<%@ include file="/IncludeEnd.jsp"%>