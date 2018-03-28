





function autoRiskScan(scenarioID,bizArgs,subTypeNo){
	var sReturn = false;
	
	if(typeof(scenarioID) == "undefined" || scenarioID.length == 0){
		alert("����̽�⣬��Ҫ�����ţ��봫�볡���Ų�����");
		return sReturn;
	}
	if(typeof(bizArgs) == "undefined" || bizArgs.length == 0){
		alert("����̽�⣬��Ҫҵ�����ݣ��봫��ҵ�����ݲ�����");
		return sReturn;
	}
	if(typeof(subTypeNo) == "undefined" || subTypeNo.length == 0){
		subTypeNo = "";
	}
	
	sceCompUrl="/AppConfig/AutoRiskDetect/ScenarioAlarm.jsp";
	sceCompArgs = "ScenarioNo="+scenarioID+"&SubTypeNo="+subTypeNo+"&BizArg="+encodeURI(bizArgs.replace(/&/gi,","));
	sceStyle = "dialogWidth=900px;dialogHeight=540px;status:no;center:yes;help:no;minimize:yes;maximize:no;border:thin;statusbar:no";
	sReturn = PopPage(sceCompUrl+"?"+sceCompArgs,"",sceStyle);
	return sReturn;
}




(function($){
    $.fn.riskScan = function(options) {
        var defaults = {
       		modelInvoker:"./AlarmModelInvoker.jsp",
       		scenarioSerial:""
        };
        var options = $.extend(defaults, options);  //Ӧ�ò���

        return this.each(function() {
        	//����Ĺ��ܺ���
	    	$.fn.isComplete = function(){
        		for(var i=0;i<group.size();i++){
        			var done = group.eq(i).attr("done");
        			if(!done||done!="true")return false;
        		}
        		return true;
	    	};
        	$.fn.isPass = function(){
        		for(var i=0;i<group.size();i++){
        			var p = group.eq(i).attr("pass");
        			if(!p||p!="true")return false;
        		}
        		return true;
        	};
        	//ȫ�ֱ���
        	var context = $(this);
        	var modelItems = $(".ck_item",context);
        	var group = $(".r_group",context);
        	//��ʼ������
        	context.data("complete","false");
        	init(context);
        	//����ִ�к�������
        	var funArray = new Array();
        	for(var i=0;i<modelItems.size();i++){
        		var modelItem = modelItems.eq(i);
        		funArray[i] = function(item){
        			var mItem = item;
        			return function(){
        				runModelItem(options,mItem,function(){
        					var scenarioMessage = $("#scenario-message");
        					var bComplete = context.isComplete(),bPass = context.isPass();
        					if(bComplete&&bPass){
        						scenarioMessage.addClass("scenario-message-pass");
        						scenarioMessage.html("���ս�������ͨ��!");
        					}else if(bComplete&&!bPass){
        						scenarioMessage.addClass("scenario-message-nopass");
        					}
        					context.dequeue("scanAction");
        				});
        			};
        		}(modelItem);
        	}
        	context.queue("scanAction",funArray);
        	
        	context.dequeue("scanAction");	//��ʼ����
        });
    };
    function init(context){
    	var context= null;
    	var scenarioMessage = $("#scenario-message");
    	scenarioMessage.html("");
    	scenarioMessage.attr("idx",0);
    	scenarioMessage[0].Spaned=undefined;
    	$(".r_group",context).each(function(){
    		$(this)[0]["done"]=undefined;
    		$(this)[0]["pass"]=undefined;
    		$(this).removeClass();
    		$(this).addClass("r_group");
    	});
    	$(".ck_item",context).each(function(){
    		$(this)[0]["done"]=undefined;
    		$(this)[0]["pass"]=undefined;
    		$(this).removeClass();
    		$(this).addClass("ck_item default");
    	});
    }
    function appendNoPassSummary(groupID,groupName){
    	var scenarioMessage = $("#scenario-message");
    	var bSpan = scenarioMessage.attr("Spaned");
    	var idx = scenarioMessage.attr("idx");
    	if(!idx)idx=0;
    	idx = parseInt(idx);
   		var anchor = $("<span><a href='#Group"+groupID+"'>"+(++idx)+"."+groupName+"</a></span>");
    	if(!bSpan)scenarioMessage.append("<span>���ս����δͨ��</span>");
    	scenarioMessage.append(anchor);
    	scenarioMessage.attr("idx",idx);
    	scenarioMessage.attr("Spaned","true");
    }
    function groupCheck(item){
    	var group = item.parents(".r_group");
    	var modelItems = $(".ck_item",group);//������������Ƿ��������
    	
    	var bGroupDone = true;
    	var bGroupPass = true;
   		for(var i=0;i<modelItems.size();i++){	//�����ϸ���Ƿ����
   			var done = modelItems.eq(i).attr("done");
   			if(!done||done!="true"){bGroupDone = false;break;}
   		}
   		if(bGroupDone){							//�����ϸ���Ƿ�ͨ��
	   		for(var i=0;i<modelItems.size();i++){
	   			var p = modelItems.eq(i).attr("pass");
	   			if(!p||p!="true"){bGroupPass = false;break;}
	   		}
   		}
   		//���±�־
   		group.attr("done","false");
   		if(bGroupDone){
   			try{scrollTo(0,group.offset().top-200);}catch(e){};
   			group.attr("done","true");
   			var gResult = $(".group_result",group);
   			gResult.hide();
   			gResult.fadeIn(1000);
   			if(bGroupPass){
   				group.attr("pass","true");
   				gResult.addClass("r_green").text("ͨ��");
   			}else{
   				group.attr("pass","false");
   				gResult.addClass("r_red").text("δͨ��");
   				appendNoPassSummary(group.attr("groupID"),group.attr("groupName"));
   			}
   		}
    }
	function runModelItem(options,item,callback){
		var context = item;
		var groupID = context.attr("groupID");
		var itemID = context.attr("itemID");
		var noPassDeal = context.attr("noPassDeal");	//10 ��ֹ����,20 ��ʾ
		$("td.message",context).html("������...");  
		var postData = new Array("GroupID="+groupID
				,"ItemID="+itemID
				,"SerializableScenario="+options.scenarioSerial
				);
		var errMsg = "�����[GroupID="+groupID+",ItemID="+itemID+"]���г�������ϵϵͳ����Ա��";
		$.ajax({
		   type: "POST",
		   cache: false,
		   async: true,
		   dataType:"json",
		   url: options.modelInvoker,
		   data: postData.join("&"),
		   success: function(msg){
				oReturn = msg;
				if(msg&&oReturn){
					var status = oReturn["status"];
					var message = oReturn["message"];
				   	//1.��ʶ�Ƿ�ͨ��
				   	context.removeClass("default");
				   	if(status=="true"||status==true){
				   		context.addClass("pass");
				   		context.attr("pass","true");
				   	}else{
				   		if(noPassDeal=="20"){
				   			context.addClass("nopass_prompt");
				   			context.attr("pass","true");
				   		}else{
				   			context.addClass("nopass_forbid");
				   			context.attr("pass","false");
				   		}
				   		$("td.viewer span.label",context).show();
				   		$("td.viewer span.label a",context).unbind("click");
				   		$("td.viewer span.label a",context).click(function(){
				   			var tdContext = $(this).parents("td");
				   			var scriptText = $("span.script",tdContext).text();
				   			if(scriptText)eval(scriptText);
				   		});
				   	}
				   	context.attr("done","true");
				   	//2.�����Ϣ
				   	$("td.message",context).html(formatMessage(message));
				   	//3.������
				   	groupCheck(item);
				   	//4.���ûص�����
				   	if(callback&&$.isFunction(callback))callback.call();
				}else{
					alert(errMsg);
				}
				context = gc(context);
				options = gc(options);
				callback = gc(callback);
		   },
		   error:function(){
			 context = gc(context);
			 options = gc(options);
			 callback = gc(callback);
		     alert(errMsg);
		   }
		});
	};
	function gc(x){
		delete x;
		x = null;
		return x;
	}




	function formatMessage(str){
		var msg = str.split(/\[\~\`\~\]/g);
		var message = "";
		for(var i=0;i<msg.length&&msg.length != 1;i++){
			if(msg[i].length <= 0) continue;
			message += ((i+1)+"."+msg[i]+"<br/>");
		}
		if(msg.length == 1)message = msg[0];
		if(message.length == 0) message = "&nbsp;";
		return message;
	}
})(jQuery);