


var AsDebug = {




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




	reloadConfigFile:function(){
		var sReturn = PopPageAjax("/AppConfig/ControlCenter/ClearConfigFileCache.jsp","","");
		if(sReturn=="SUCCESS") alert("���������ļ��ɹ���");
		else alert("���������ļ�ʧ�ܣ�");
	}
};






function keydownAction(event){
	if(event.altKey && event.keyCode == 51){ //alt+3
		AsDebug.reloadCacheAll();
		return true;
	}else if(event.keyCode==8){ // backspace
		var target = $(event.target);
		// ����ȡ��ֵ��Ϊ�ɱ༭�ı�����Ϊ��ť/����ѡ��/��ѡ/ֻ��������ʹ��backspace��
		return !!target.val() && target.is(":input:enabled") && !target.is(":button,:selected,:checked,[readonly]");
	}
}
$(document).keydown(keydownAction);