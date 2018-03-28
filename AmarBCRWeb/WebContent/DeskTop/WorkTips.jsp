<%@page import="com.amarsoft.dict.als.object.Item"%>
<%@page import="com.amarsoft.dict.als.manage.CodeManager"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Main00;Describe=注释区;]~*/%>
	<%
	/*
		Content: 我的工作台
		History Log: syang 2009/09/28 页面重新整理，去除多余无用的HTML
					 syang 2009/10/20页面待处理工作提示整理，让这些页面可配置
					 				请参考代码表代码：PlantformTask的配置情况。
									增加一个未完成工作提示，只需要配置好相应页面URL地址即可，不需要再来修改此页面
					 syang 2009/12/10 工作台style样式文件分享，引入走马灯库，不再使用HTML走马灯效果
		注意：新增工作提示，请不要修改此页面，请参考代码[PlantformTask]的配置，只需要在该代码里配置好相应页面即可
	 */
	%>
<%/*~END~*/%>
<html>
<head>
	<title>日常工作提示</title>
	<link rel="stylesheet" href="<%=sWebRootPath%>/AppMain/resources/css/worktips.css">
	<link rel="stylesheet" type="text/css" href="<%=sWebRootPath%><%=sSkinPath%>/css/worktips.css">
</head>
<body class="pagebackground" leftmargin="0" topmargin="0" id="mybody">
<%
	String sAllItemNo = "";
	//取出代码对象
	Item[] codeDef = CodeManager.getItems("PlantformTask");
%>
	<div id="WindowDiv">
		<!-- 日历 -->
		<div id="CalendarDiv">
			<table cellspacing='0' cellpadding='0' style="border:1px solid #ccc;width: 100%;height: 100%;">
		   		<tr>
					<td align="center" nowrap height="20">我的日历</td>
				</tr>
				<tr>
					<td bgcolor= #dcdcdc width=100% valign="top" align="center">
						<iframe name="MyCalendar" src="<%=com.amarsoft.awe.util.Escape.getBlankJsp(sWebRootPath,"正在打开页面，请稍候")%>" width=100% height=100% frameborder=0 scrolling="no"></iframe>
					</td>
				</tr>
			</table>
			<span style="font-size:12px;">[<a href="javascript:void(0);" onclick="viewWorkRecord()">全部工作笔记</a>]</span>
		</div>
		
		<!-- 注意：新增工作提示，请不要修改此页面，请参考代码[PlantformTask]的配置，只需要在该代码里配置好相应页面即可 -->
		<!-- 工作任务 -->
		<div id="WorkPlanDiv">
			<table style="border: 0;width: 100%;" align='left' cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF" >
	        <%
	        for(int i=0;i<codeDef.length;i++){
	        		Item vpItem = codeDef[i];
	    			String sItemNo = (String)vpItem.getItemNo();
	    			String sItemName = (String)vpItem.getItemName();
	    			String sRoleID = (String)vpItem.getRelativeCode();//配置的角色
	    			String sAttribute = (String)vpItem.getAttribute1();
	    			boolean bPass = false;
	    			
	    			//检查当前用户是否有查看的角色
	    			if(sRoleID == null || sRoleID.length() == 0){	//如果没有配置角色限制，则默认全部可见
	    				sRoleID = "";
	    				bPass = true;
	    			}
	    			if(bPass == false){
	    				String[] roleIDArray = sRoleID.split(",");
	    				for(int j=0;j<roleIDArray.length;j++){	//角色检查
	    					if(CurUser.hasRole(roleIDArray[j])){
	    						bPass = true;
	    						break;
	    					}
	    				}
	    			}
	    			//检查是否走登记最终审批意见
	    			String sApproveNeed = CurConfig.getConfigure("ApproveNeed");
	    			if(sAttribute == null) sAttribute = "";
	    			if(sApproveNeed == null) sApproveNeed = "";
	    			if(sApproveNeed.equalsIgnoreCase("true")){
	    				if(sAttribute.indexOf("SWITapprove")> -1){
	    					bPass = true;
	    				}else{
	    					bPass = false;
	    				}
	    			}else{
	    				if(sAttribute.indexOf("SWITapply")> -1){
	    					bPass = true;
	    				}else{
	    					bPass = false;
	    				}
	    			}
	    					
	    			//如果角色检查未通过，则不显示当前类别的数据了
	    			if(bPass == false){
	    				continue;
	    			}
	    			sAllItemNo += (","+sItemNo);
					%> 
					<tr id="Item<%=sItemNo%>">
						<td align="left" colspan="2"  background="<%=sWebRootPath%>/DeskTop/WorkTipsAJAX/workTipLine.gif" >
							<table style="border: 0" cellspacing="0" cellpadding="0">
								<tr>
									<td onclick="javascript:touchPlantform('<%=sItemNo%>');">
										<span class="FilterIcon" style="display:inline-block;" id="Plus<%=sItemNo%>" >&nbsp;</span>
										<span class="FilterIcon2" style="display:none" id="Minus<%=sItemNo%>" >&nbsp;</span>
									</td>
									<td onclick="javascript:touchPlantform('<%=sItemNo%>');">
										<b><a href="javascript:void(0);" ><%=sItemName%>&nbsp;<span id="CountSpan<%=sItemNo%>"></span>&nbsp;件</a></b>
									</td>
								</tr>
							</table>
	           		</td>
					</tr>
   	     <!-- 内容区域 -->
					<tr>
						<td align="left" colspan="2" class="DataList" id="DataList<%=sItemNo%>"></td>
					</tr>
         <%} 
	        if(sAllItemNo != null && sAllItemNo.length() > 0){
	        	sAllItemNo = sAllItemNo.substring(1,sAllItemNo.length());
	        }
         %>       		
				</table>
		</div>
	</div>
</body>
</html>

<script type="text/javascript">
	$(document).ready(function(){
		//加载日历
		OpenComp("MyCalendar","/AppMain/MyCalendar.jsp","","MyCalendar","");
		//加载工作待处理工作提示
		sAllItemNo = "<%=sAllItemNo%>";
		ItemNoArray = sAllItemNo.split(",");
		for(var i=0;i<ItemNoArray.length;i++){
			CountPlantform(ItemNoArray[i]); 
		}
	});

	function openFile(sDocNo){
	    AsControl.PopView("/AppConfig/Document/AttachmentFrame.jsp", "DocNo="+sDocNo+"&RightType=ReadOnly", "dialogWidth=650px;dialogHeight=350px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
	}
	//查看全部工作笔记
	function viewWorkRecord(){
		PopComp("WorkRecordList","/DeskTop/WorkRecordList.jsp","NoteType=All","","");
	}
	/**
	 *统计待处理的业务数量
	 *@ItemNo 编号
 	 */
	function CountPlantform(ItemNo){
		var url="<%=sWebRootPath%>/DeskTop/WorkTipsAJAX/InvokerAjax.jsp?CompClientID=<%=SpecialTools.amarsoft2Real(sCompClientID)%>&ItemNo="+ItemNo+"&Type=0";
		var message = "";
		$.ajax({
 			type: "POST",
 			url: url,
 			processData: false,
 			async:false,
 			success: function(responseText){
 				message = responseText;
				//统计数据量为0，则隐藏该项提示
				if(message == 0){
					document.getElementById("Item"+ItemNo).style.display = "none";
				}else{
					message="<font color=red>"+message+"</font>";
				}
 			},
 			error: function(){
 				message = "<img border=0 src='<%=sWebRootPath%>/Frame/page/resources/images/main/icons/35.gif'>";
   			}
		});
		$("#CountSpan"+ItemNo).html(message);
	}
	/**
	 *点击相应的Trip时，展示相应的数据
	 *@ItemNo 编号
	 */
	function touchPlantform(ItemNo){
		if(eid("DataList"+ItemNo).innerHTML == ""){
			var url="<%=sWebRootPath%>/DeskTop/WorkTipsAJAX/InvokerAjax.jsp?CompClientID=<%=SpecialTools.amarsoft2Real(sCompClientID)%>&ItemNo="+ItemNo+"&Type=1";
			var message = "";
			$.ajax({
	 			type: "POST",
	 			url: url,
	 			processData: false,
	 			async:false,
	 			success: function(responseText){
	 				message = responseText;
	 			},
	 			error: function(){
	 				message = "<img border=0 bordercolordark='#CCCCCC' src='<%=sWebRootPath%>/Frame/page/resources/images/main/icons/33.gif'>";
	   			}
			});
			eid("DataList"+ItemNo).innerHTML=message;
			eid("Plus"+ItemNo).style.display = "none";
			eid("Minus"+ItemNo).style.display = "block";
		}else{
			eid("DataList"+ItemNo).innerHTML = "";
			eid("Plus"+ItemNo).style.display = "block";
			eid("Minus"+ItemNo).style.display = "none";
		}
	}
	function eid(id){
		return document.getElementById(id);
	}
</script>
<%@ include file="/IncludeEnd.jsp"%>