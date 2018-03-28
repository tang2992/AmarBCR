var AsDebug = {
	URL:"",
	_isWindowOpen:false,
	_isReportWindowOpen:false,
	toggleWindow:function() {
		if (this._isWindowOpen) {
			this.hideWindow();
		} else {
			this.showWindow();
		}
	},
	showWindow:function() {
		if (!this._isWindowOpen) {
			var topDiv = $("#debugTool");
			topDiv.show();
			var obj = $("#debugTool_subdiv");//var obj = topDiv.children(".datawindow_overdiv_subdiv");
			obj.show();
			var iLeft = (topDiv[0].offsetWidth-obj[0].offsetWidth)/2;//100 + document.body.scrollLeft;
			var iTop = (topDiv[0].offsetHeight-obj[0].offsetHeight)/2;//100 + document.body.scrollTop;
			obj.css({left:iLeft,top:iTop});
			document.getElementById('sp_debug_overdiv_top').style.display= 'inline';
			this._isWindowOpen = true;
		}
	},
	hideWindow:function() {
		if (this._isWindowOpen) {
			this._isWindowOpen = false;
			$("#debugTool_subdiv").hide();
			$("#debugTool").hide();
		}
	},
	getURL:function() {
		if (typeof(AsDebug_URL) != "undefined")
			this.URL = AsDebug_URL;
		if (this.URL != "")	return this.URL.substring(this.URL.lastIndexOf(sWebRootPath)+sWebRootPath.length);
		return document.URL;
	},
	getPage:function() {
		if (typeof(AsDebug_URL) != "undefined")
			this.URL = AsDebug_URL;
		if (this.URL != "")	return this.URL.substring(this.URL.lastIndexOf("/")+1);
		return document.URL;
	},
	reloadAREService:function(serviceId){
		if (typeof(serviceId) == "undefined" || serviceId.length == 0) serviceId = "JBO";
		var sReturn = RunJavaMethod("com.amarsoft.app.util.ReloadServiceAction","reloadService","ServiceId="+serviceId);
		if(sReturn=="SUCCESS") alert("����ARE����ɹ���");
		else alert("����ARE����ʧ�ܣ�");
	},
	reloadCacheAll:function(){
		var sReturn = RunJavaMethod("com.amarsoft.app.util.ReloadCacheConfigAction","reloadCacheAll","");
		if(sReturn=="SUCCESS") alert("���ز�������ɹ���");
		else alert("���ز�������ʧ�ܣ�");
	},
	reloadCache:function(CacheType){
		var sReturn = RunJavaMethod("com.amarsoft.app.util.ReloadCacheConfigAction","reloadCache","ConfigName="+CacheType);
		if(sReturn=="SUCCESS") alert("ˢ�²�������ɹ���");
		else alert("ˢ�²�������ʧ�ܣ�");
	},
	reloadFixSkins:function(){
		var sReturn = PopPageAjax("/AppConfig/OrgUserManage/ReloadSkin.jsp?ReloadType=FixSkins");
		if(sReturn=="SUCCESS")  alert("���ض���Ƥ���ɹ���");
		else alert("���ض���Ƥ��ʧ�ܣ�");
	},
	reloadConfigFile:function(){
		var sReturn = PopPageAjax("/AppConfig/ControlCenter/ClearConfigFileCache.jsp","","");
		if(sReturn=="SUCCESS") alert("���������ļ��ɹ���");
		else alert("���������ļ�ʧ�ܣ�");
	},
	openControlCenter:function() {
		this.hideWindow();
		popComp("ControlCenter","/AppConfig/ControlCenter/ControlCenterTab.jsp","","","");
	},
	displayHTML:function(oBody) {
		showModalDialog(sWebRootPath+"/Frame/page/debug/tools/viewsource.htm", oBody,"status:no;resizable:yes;center:yes;dialogHeight:688px;dialogWidth:968px;");
	},
	displayBodyHTML:function() {
		this.hideWindow();
		this.displayHTML(document.body);
	},
	viewCompDetail:function() {
		this.hideWindow();
		popComp("CompDetail","/Frame/page/debug/tools/CompDetail.jsp","ToShowClientID="+sCompClientID,"","");
	},
	displayDwInfo:function() {
		this.hideWindow();
		try{
			var sUrl = "/Frame/page/dw/DisplayDWInfo.jsp";
			if(!window.WindowType) sUrl = "/Frame/page/ow/DisplayOWInfo.jsp";
			//displayHTML(myiframe0.document.body);
			window.open(sWebRootPath + sUrl+ "?dono="+DisplayDONO+"&url="+this.getURL(),"","status:no,resizable:yes,scrollbars=yes,height:688,width:968");
		}catch(e){
			alert("No DWInfo");
		}
	},
	displayURL:function displayURL() {	
		prompt("URLName                                                         ",this.getURL());
	},
	displayPageName:function() {	
		prompt("PageName                                       ",this.getPage());
	},
	displayURLnPara:function() {	
		prompt("URL",document.URL);
	},
	showOnlineUserList:function(){
		OpenPage("/AppConfig/ControlCenter/OnlineUserList.jsp?rand="+randomNumber());
	},
	editDW:function(){
		if(typeof(DisplayDONO)=="undefined" || DisplayDONO.length == 0){
			alert("No DWInfo");
			return;
		}
		if(typeof(WindowType) !="undefined" && WindowType.length != 0){
			AsControl.PopView("/AppConfig/PageMode/DWConfig/DataObjectStrip.jsp","DONO="+DisplayDONO+"&RightType=All","","");
		}else{
			AsControl.PopView("/AppConfig/PageMode/DWConfig/ObjectModelStrip.jsp","DONO="+DisplayDONO+"&RightType=All","","");
		}
	}
};






function keydownAction(event){
	if(event.altKey && event.keyCode == 49){ //alt+1
		AsDebug.toggleWindow();
		return true;
	}else if(event.altKey && event.keyCode == 50){ //alt+2
		if(typeof OverrideAlt2 == 'function') OverrideAlt2();
		else AsDebug.editDW();
		return true;
	}else if(event.altKey && event.keyCode == 51){ //alt+3
		AsDebug.reloadCacheAll();
		return true;
	}else if(event.altKey && event.keyCode == 52){ //alt+4
		AsDebug.reloadAREService();
		return true;
	}else if(event.keyCode == "27"){ //esc
		AsDebug.hideWindow();
		return true;
	}else if(event.keyCode==113 && window.as_defaultExport){//F2����excel
		as_defaultExport();
		return true;
	}else if(event.keyCode==8){ // backspace
		var target = $(event.target);
		// ����ȡ��ֵ��Ϊ�ɱ༭�ı�����Ϊ��ť/����ѡ��/��ѡ/ֻ��������ʹ��backspace��
		return !!target.val() && target.is(":input:enabled") && !target.is(":button,:selected,:checked,[readonly]");
	}
}
$(document).keydown(keydownAction);