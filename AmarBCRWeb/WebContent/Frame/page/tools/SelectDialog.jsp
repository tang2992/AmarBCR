<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin.jspf" %>
<%if(CurPage.getParameter("SelectDialogTitle")!=null){%>
<title><%=CurPage.getParameter("SelectDialogTitle")%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</title><%}%>
<body style="overflow-y:hidden;" onload="javascript:changeStyle();" onresize="javascript:changeStyle();">
<iframe id="SelectDialog" name="SelectDialog" style="height:100%;width:100%;" src="<%=sWebRootPath+CurPage.getParameter("SelectDialogUrl")%>?CompClientID=<%=sCompClientID%>" frameborder="0"></iframe>
<div id="ButtonsDiv" align="center"><table><tr>
	<td width="33%"></td>
	<td align="center"><%=new Button("确认","","javascript:doSure()","","","high2").getHtmlText() %></td>
	<%--
	<%if("true".equals(CurPage.getParameter("append"))){%><td align="center"><%=new Button("添加","","javascript:window.frames['SelectDialog'].doAppend();","","","high2").getHtmlText() %></td><%}%>
	 --%>
	<td align="right" width="23%"><%=new Button("清空","","javascript:doClear();","","","high").getHtmlText() %></td>
	<td align="right" width="10%"><%=new Button("取消","","javascript:doCancel();","","","high").getHtmlText() %></td>
</tr></table></div>
</body>
<script type="text/javascript">
<!--
	function doSure(){
		<%if("true".equals(CurPage.getParameter("append"))){%>
		//if(confirm("此操作会覆盖原来的数据，确实要继续吗")==false)
		//	return;
		<%}%>
		window.frames['SelectDialog'].doSure();
	}
	function doAppend(){
		window.frames['SelectDialog'].doAppend();
	}

	function doClear(){
		if(typeof window.frames['SelectDialog'].doClear != "function"){
			closeDialog("_CLEAR_");
		}else{
			window.frames['SelectDialog'].doClear();
		}
	}
	
	function doCancel(){
		if(typeof window.frames['SelectDialog'].doCancel != "function"){
			closeDialog();
		}else{
			window.frames['SelectDialog'].doCancel();
		}
	}

	function closeDialog(sStr){
		top.returnValue = sStr;
		top.close();
	}
	
	document.onkeydown = function(e){
		var e = e || window.event;
		if(e.keyCode==27){
			doCancel();
		}
	}
	
	function changeStyle(){
		document.getElementById("SelectDialog").style.height = document.body.clientHeight - document.getElementById("ButtonsDiv").offsetHeight - 24;
	}
//-->
</script>
<%@ include file="/Frame/resources/include/include_end.jspf" %>