<%@page import="com.amarsoft.app.awe.config.worktip.WorkTip"%>
<%@page import="com.amarsoft.app.awe.config.worktip.WorkTips"%>
<%@page import="com.amarsoft.app.bcr.common.worktip.*"%>
<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@ include file="/IncludeBegin.jsp"%>
<%@page import="com.amarsoft.awe.res.MenuManager"%><html>
<head>
<title>工作提示</title>
<style type="text/css">
	body {
		background: transparent;
		overflow: hidden;
		overflow-y: auto;
		height: 100%;
	}
	#main {
		border-left: 2px solid #f1d5d4;
	}
	.container {
		display: block;
		width: 100%;
		margin-left: 20px;
		padding-left: 10px;
	}
	.infoa {
		display: block;
		width: 100%;
		font-size: 12px;
		color: #013372;
		height: 20px;
		line-height: 20px;
		white-space: nowrap;
	}
	.infoa span {
		display: inline-block;
		cursor: pointer;
	}
	.infoa .expand {
		position: absolute;
		left: 10px;
	}
	em {
		color: #f00;
		margin-right: 3px;
	}
	em.init {
		display: inline-block;
		width: 20px;
		height: 20px;
		background: url(Frame/page/resources/images/main/icons/35.gif) no-repeat center;
	}
	img {
		border: none;
	}
</style>
<script type="text/javascript">
	function toggleTips(a, e){
		a = $(a);
		if(e){
			AsLink.stopEvent(e);
			a = a.parent();
		}
		var div = a.next();
		if(!div.is("div")) return;
		var span = $(".expand", a);
		if(span.text() == "-"){
			span.text("+");
			div.hide();
		}else{
			span.text("-");
			div.show();
		}
	}
</script>
</head>
<body>
	<div id="main" class="container" >
	</div>
</body>
<script type="text/javascript">
(function(){
	drawWorkTips($("#main"), <%// 初始提示信息对象
		WorkTips workTip = new WorkTips();
		workTip.information.add(new WorkTip("待处理的校验错误<font color='red'> "+WorkTipUtil.getValidateErrCount(CurUser.getUserID(),CurUser.getRelativeOrgID())+" </font>条", "com.amarsoft.app.bcr.common.worktip.ValidateWorkTip@tableName=BCR_ERRHISTORY", "", false));
		workTip.information.add(new WorkTip("待处理的反馈错误<font color='red'> "+WorkTipUtil.getFeedbackErrCount(CurUser.getUserID(),CurUser.getRelativeOrgID())+" </font>条", "com.amarsoft.app.bcr.common.worktip.ValidateWorkTip@tableName=BCR_FEEDBACK", "", false));
		workTip.information.add(new WorkTip("待解析的反馈报文<font color='red'> "+WorkTipUtil.getFeedbackFileTotal(CurUser.getUserID(),CurUser.getRelativeOrgID())+" </font>件", "com.amarsoft.app.ecr.common.worktip.FeedbackWorkTip", "", false));
		out.print(workTip.getInformation());%>, parent.aem?[parent.aem[self.name]]:null);

	function drawWorkTips(container, datas, ems){
		//alert(JSON.stringify(datas));
		for(var i = 0; i < datas.length; i++){
			drawWorkTip(container, datas[i], ems);
		}
	}

	function drawWorkTip(container, data, ems){
		setTimeout(function(){
			if(!ems) ems = new Array();
			if(!data["Action"]) data["Action"] = "toggleTips(this)";

			var a = $("<a class=\"infoa\" href=\"javascript:void(0);\" onclick=\""+data["Action"]+";return false;\">"+data["Text"]+"</a>").appendTo(container);
			if(!data["Runner"]){
				setNums(ems, data["Num"]);
				return;
			}
			
			ems = ems.slice();
			var em = a.find("em:first");
			if(em.length == 1){
				ems.push(em.addClass("init"));
			}
			var div = $("<div class=\"container\""+(!data["Expand"]?" style=\"display:none;\"":"")+">").appendTo(container);
			var span = $("<span class=\"expand\" onclick=\"toggleTips(this, event);\">+</span>").prependTo(a);
			if(data["Expand"]) span.text("-");
			AsControl.RunJsp("/AppMain/WorkTipAjax.jsp", "Runner="+data["Runner"], function(sReturnText){
				em.removeClass("init");
				setNums(ems, 0);
				if(!sReturnText) return;
				if(sReturnText.substring(0,1) != "["){
					alert(sReturnText);
					return;
				}
				var datas = eval("("+sReturnText+")");
				if(datas.length == 1 && datas[0]["Action"] == "void(0)"){
					span.text("-");
					div.show();
				}
				drawWorkTips(div, datas, ems);
			});
		}, 100);
	}
	
	function setNums(ems, n){
		for(var i = ems.length - 1; i >= 0; i--){
			var num = parseInt(ems[i].text(), 10);
			if(isNaN(num)) num = 0;
			ems[i].text(num+n);
		}
	}
})();
</script>
</html>
<%@ include file="/IncludeEnd.jsp"%>