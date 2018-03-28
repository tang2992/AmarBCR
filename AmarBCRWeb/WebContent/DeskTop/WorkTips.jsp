<%@page import="com.amarsoft.dict.als.object.Item"%>
<%@page import="com.amarsoft.dict.als.manage.CodeManager"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Main00;Describe=ע����;]~*/%>
	<%
	/*
		Content: �ҵĹ���̨
		History Log: syang 2009/09/28 ҳ����������ȥ���������õ�HTML
					 syang 2009/10/20ҳ�����������ʾ��������Щҳ�������
					 				��ο��������룺PlantformTask�����������
									����һ��δ��ɹ�����ʾ��ֻ��Ҫ���ú���Ӧҳ��URL��ַ���ɣ�����Ҫ�����޸Ĵ�ҳ��
					 syang 2009/12/10 ����̨style��ʽ�ļ�������������ƿ⣬����ʹ��HTML�����Ч��
		ע�⣺����������ʾ���벻Ҫ�޸Ĵ�ҳ�棬��ο�����[PlantformTask]�����ã�ֻ��Ҫ�ڸô��������ú���Ӧҳ�漴��
	 */
	%>
<%/*~END~*/%>
<html>
<head>
	<title>�ճ�������ʾ</title>
	<link rel="stylesheet" href="<%=sWebRootPath%>/AppMain/resources/css/worktips.css">
	<link rel="stylesheet" type="text/css" href="<%=sWebRootPath%><%=sSkinPath%>/css/worktips.css">
</head>
<body class="pagebackground" leftmargin="0" topmargin="0" id="mybody">
<%
	String sAllItemNo = "";
	//ȡ���������
	Item[] codeDef = CodeManager.getItems("PlantformTask");
%>
	<div id="WindowDiv">
		<!-- ���� -->
		<div id="CalendarDiv">
			<table cellspacing='0' cellpadding='0' style="border:1px solid #ccc;width: 100%;height: 100%;">
		   		<tr>
					<td align="center" nowrap height="20">�ҵ�����</td>
				</tr>
				<tr>
					<td bgcolor= #dcdcdc width=100% valign="top" align="center">
						<iframe name="MyCalendar" src="<%=com.amarsoft.awe.util.Escape.getBlankJsp(sWebRootPath,"���ڴ�ҳ�棬���Ժ�")%>" width=100% height=100% frameborder=0 scrolling="no"></iframe>
					</td>
				</tr>
			</table>
			<span style="font-size:12px;">[<a href="javascript:void(0);" onclick="viewWorkRecord()">ȫ�������ʼ�</a>]</span>
		</div>
		
		<!-- ע�⣺����������ʾ���벻Ҫ�޸Ĵ�ҳ�棬��ο�����[PlantformTask]�����ã�ֻ��Ҫ�ڸô��������ú���Ӧҳ�漴�� -->
		<!-- �������� -->
		<div id="WorkPlanDiv">
			<table style="border: 0;width: 100%;" align='left' cellspacing="0" cellpadding="0" bordercolordark="#FFFFFF" >
	        <%
	        for(int i=0;i<codeDef.length;i++){
	        		Item vpItem = codeDef[i];
	    			String sItemNo = (String)vpItem.getItemNo();
	    			String sItemName = (String)vpItem.getItemName();
	    			String sRoleID = (String)vpItem.getRelativeCode();//���õĽ�ɫ
	    			String sAttribute = (String)vpItem.getAttribute1();
	    			boolean bPass = false;
	    			
	    			//��鵱ǰ�û��Ƿ��в鿴�Ľ�ɫ
	    			if(sRoleID == null || sRoleID.length() == 0){	//���û�����ý�ɫ���ƣ���Ĭ��ȫ���ɼ�
	    				sRoleID = "";
	    				bPass = true;
	    			}
	    			if(bPass == false){
	    				String[] roleIDArray = sRoleID.split(",");
	    				for(int j=0;j<roleIDArray.length;j++){	//��ɫ���
	    					if(CurUser.hasRole(roleIDArray[j])){
	    						bPass = true;
	    						break;
	    					}
	    				}
	    			}
	    			//����Ƿ��ߵǼ������������
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
	    					
	    			//�����ɫ���δͨ��������ʾ��ǰ����������
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
										<b><a href="javascript:void(0);" ><%=sItemName%>&nbsp;<span id="CountSpan<%=sItemNo%>"></span>&nbsp;��</a></b>
									</td>
								</tr>
							</table>
	           		</td>
					</tr>
   	     <!-- �������� -->
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
		//��������
		OpenComp("MyCalendar","/AppMain/MyCalendar.jsp","","MyCalendar","");
		//���ع�������������ʾ
		sAllItemNo = "<%=sAllItemNo%>";
		ItemNoArray = sAllItemNo.split(",");
		for(var i=0;i<ItemNoArray.length;i++){
			CountPlantform(ItemNoArray[i]); 
		}
	});

	function openFile(sDocNo){
	    AsControl.PopView("/AppConfig/Document/AttachmentFrame.jsp", "DocNo="+sDocNo+"&RightType=ReadOnly", "dialogWidth=650px;dialogHeight=350px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
	}
	//�鿴ȫ�������ʼ�
	function viewWorkRecord(){
		PopComp("WorkRecordList","/DeskTop/WorkRecordList.jsp","NoteType=All","","");
	}
	/**
	 *ͳ�ƴ������ҵ������
	 *@ItemNo ���
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
				//ͳ��������Ϊ0�������ظ�����ʾ
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
	 *�����Ӧ��Tripʱ��չʾ��Ӧ������
	 *@ItemNo ���
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