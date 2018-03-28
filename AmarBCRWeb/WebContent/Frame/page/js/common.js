var sScreenWidth = screen.availWidth;
var sScreenHeight = screen.availHeight;
var sDefaultDialogStyle= "dialogWidth="+sScreenWidth+"px;dialogHeight="+sScreenHeight+"px;resizable=yes;maximize:yes;help:no;status:no;";
var OpenStyle="width="+sScreenWidth+"px,height="+sScreenHeight+"px,top=0,left=0,toolbar=no,scrollbars=yes,resizable=yes,status=no,menubar=no";
var sDefaultModelessDialogStyle = "dialogLeft="+(sScreenWidth*0.6)+";dialogWidth="+(sScreenWidth*0.4)+"px;dialogHeight="+(sScreenHeight)+"px;resizable=yes;status:yes;maximize:yes;help:no;";

function over_change(index,src,clrOver){
	if (!src.contains(event.fromElement)){ 
 		src.style.cursor = 'pointer';
 		src.background = clrOver;
 	}
}

function out_change(index,src,clrIn){
	if (!src.contains(event.toElement)){
		src.style.cursor = 'default';
		src.background = clrIn;
	}
}

bIsLocked=false;

function checkIfLocked(){
	if(bIsLocked){
		if(!confirm("���Ѿ��õ�����ʽ����һ����ҳ�棬�뿪��ҳ�潫���ܵ��³���\n�ô��󽫲���Ӱ��ϵͳ�������С�\n��ȷ��Ҫ�뿪��ҳ����")) 
			return true;
		else 
			return false;
	}else	
		return true;
}

//���ڼ�麯��	
function isDate(value,separator){
	if(typeof separator != "string" || typeof value != "string" || value.length<10)
		return false;
	if(separator != "." && value.indexOf(".") > -1) return false;
	var sItems = value.split(separator); // value.split("/");
	
    if (sItems.length!=3) return false;
    if (isNaN(sItems[0])) return false;
    if (isNaN(sItems[1])) return false;
    if (isNaN(sItems[2])) return false;
    //��ݱ���Ϊ4λ���·ݺ��ձ���Ϊ2λ
    if (sItems[0].length!=4) return false;
    if (sItems[1].length!=2) return false;
    if (sItems[2].length!=2) return false;

    if (parseInt(sItems[0],10)<1900 || parseInt(sItems[0],10)>2150) return false;
    if (parseInt(sItems[1],10)<1 || parseInt(sItems[1],10)>12) return false;
    if (parseInt(sItems[2],10)<1 || parseInt(sItems[2],10)>31) return false;

    if ((sItems[1]<=7) && ((sItems[1] % 2)==0) && (sItems[2]>=31)) return false;
    if ((sItems[1]>=8) && ((sItems[1] % 2)==1) && (sItems[2]>=31)) return false;
    //���겻������
	if (!((sItems[0] % 4)==0) && (sItems[1]==2) && (sItems[2]==29)){
		if ((sItems[1]==2) && (sItems[2]==29)) return false;
	}else{
		if ((sItems[1]==2) && (sItems[2]==30)) return false;
    }

    return true;
}

//�ı乤������С
function resizeLeft(){
	try{
		if(myleft.width==1){
			myleft.width=myleftwidth;
		}else{
			myleftwidth=myleft.width;
			myleft.width=1;
		 }
	}catch(e){ }
}
	 
function resizeTop(){
	if(mytop.height==25) {
		mytop.height=mytopheight;
	} else {
		mytopheight=top.mytop.height;
		mytop.height=25;
	 }
}

function maximizeWindow(){
	window.moveTo(0,0);
	if (document.all){ 
  		top.window.resizeTo(screen.availWidth,screen.availHeight); 
	} else if (document.layers||document.getElementById){ 
  		if (top.window.outerHeight<screen.availHeight||top.window.outerWidth<screen.availWidth){
    		top.window.outerHeight = screen.availHeight; 
    		top.window.outerWidth = screen.availWidth;
  		}
	}
}

function viewSource(){
	var ress  =parent.location;
	window.location="view-source:"+ress;
}
function key_up(e){
	if( document.event.shiftKey  && document.event.ctrlKey && document.event.altKey ){
		alert("ss");
		return;
	}
}
function GetPropertiesString(objObject){ //byhu: �˺������Բ쿴����������������
   var varProp="";
   var strProperties = objObject.id + "\n";
   for (varProp in objObject){
      strProperties += varProp + " = " + objObject[varProp] + "\n";
   }
   return strProperties;
}

function reloadSelf(){
	//��ס��ǰ��ҳ�ź��к�
	rememberPageRow();
	if(document.forms["DOFilter"]==null){
		self.location.reload();
	} else if(typeof(document.forms["DOFilter"])=="undefined"){
		self.location.reload();
	}else{
		document.forms["DOFilter"].submit();
	}
}
function rememberPageRow(){
	try{
		//document.getElementById("DWCurPage").value=curpage[0];
		var page = s_c_p[0];
		if(isNaN(page)) page = 0;
		document.getElementById("DWCurPage").value=page;
		document.getElementById("DWCurRow").value=getRow(0);
	}catch(e){}
}

function sessionOut(){
	if(confirm("ȷ���˳���ϵͳ��"))
		OpenPage("/SignOut.jsp","_top","");
}


function getSerialNo(sTableName,sColumnName,sPrefix){
	if(typeof(sPrefix)=="undefined" || sPrefix=="") sPrefix="";
	return RunJspAjax("/Frame/page/sys/GetSerialNo.jsp?TableName="+sTableName+"&ColumnName="+sColumnName+"&Prefix="+sPrefix);
}






function onSubmit(sUrl,sParameter) {
	var waitingInfo = document.getElementById(getNetuiTagName("waitingInfo"));
	//������ʾ
	waitingInfo.style.display = ""; 
	//������ʼ
	progress_update(); 
	//�������
	for(var i=0;i<1000000;i++){
		j=i+i;
	}
	OpenPage(sUrl,sParameter,""); 
}






function onFromAction(sUrl,sFormName) {
	var waitingInfo = document.getElementById(getNetuiTagName("waitingInfo"));
	waitingInfo.style.display = ""; 
	progress_update(); 
	for(var i=0;i<1000000;i++){
		j=i+i;
	}
	//������Ϣ����
	//showMess("���ڴ���, ���Ժ�......");
	if(sFormName == "report"){
		document.report.action = sUrl;
		document.report.submit();
	}
	if(sFormName == "DOFilter"){
		sUrl.submit();
	}
}

// Build the netui_names table to map the tagId attributes to the real id written into the HTML
if (netui_names == null)
var netui_names = new Object();
netui_names.selectButton="portlet_15_1selectButton";
// method which will return a real id for a tagId
function getNetuiTagName(id) {
	return netui_names[id];
}

// method which will return a real id for a tagId,
// the tag parameter will be used to find the scopeId for containers that may scope their ids
function getNetuiTagName(id, tag) {
	var scopeId = getScopeId(tag);
	if (scopeId == "")
		return netui_names[id];
	else
		return netui_names[scopeId + "__" + id];
}

// method which get a tag will find any scopeId that was inserted by the containers
function getScopeId(tag) {
	if (tag == null)
		return "";
	if (tag.getAttribute) { 
		if (tag.getAttribute('scopeId') != null)
			return tag.getAttribute('scopeId');
	} 
	if (tag.scopeId != null)
		return tag.scopeId;
		return getScopeId(tag.parentNode);
}

// Build the netui_names table to map the tagId attributes to the real id written into the HTML
if (netui_names == null)
var netui_names = new Object();
netui_names.waitingInfo="waitingInfo";

//������
var progressEnd = 18; 
//��������ɫ
var progressColor = 'green'; 
var progressInterval = 200; // set to time between updates (milli-seconds)
var progressAt = progressEnd;
var progressTimer;

function progress_clear() {
	for (var i = 1; i <= progressEnd; i++) 
		document.getElementById('progress'+i).style.backgroundColor = 'transparent';
	progressAt = 0;
}
function progress_update() {
	progressAt++;
	if (progressAt > progressEnd) progress_clear();
	else document.getElementById('progress'+progressAt).style.backgroundColor = progressColor;
	progressTimer = setTimeout('progress_update()',progressInterval);
}
function progress_stop() {
	clearTimeout(progressTimer);
	progress_clear();
}
//*******************************end*********************************

function setObjectInfo(sObjectType,sValueString,iArgDW,iArgRow,sStyle){
	//sObjectType����������
	//sValueString��ʽ�� ������� @ ID���� @ ID�ڷ��ش��е�λ�� @ Name���� @ Name�ڷ��ش��е�λ��
	//iArgDW: �ڼ���DW��Ĭ��Ϊ0
	//iArgRow: �ڼ��У�Ĭ��Ϊ0
	if(typeof(sStyle)=="undefined" || sStyle=="") sStyle = "dialogWidth:700px;dialogHeight:540px;resizable:yes;scrollbars:no;status:no;help:no";
	var iDW = iArgDW;
	if(iDW == null) iDW=0;
	var iRow = iArgRow;
	if(iRow == null) iRow=0;
	
	var sValues = sValueString.split("@");
	var sParaString = sValues[0];
	var i=sValues.length;
   	i=i-1;
   	if (i%2!=0){
   		alert("setObjectInfo()���ز����趨����!\r\n��ʽΪ:@ID����@ID�ڷ��ش��е�λ��...");
		return;
   	}else{
		var j=i/2,m,sColumn,iID;	
		sObjectNoString = selectObjectInfo(sObjectType,sParaString,sStyle);
		if(typeof(sObjectNoString)=="undefined" || sObjectNoString=="null" || sObjectNoString==null || sObjectNoString=="_CANCEL_"){
			return;
		}else if(sObjectNoString=="_CLEAR_"){
			for(m=1;m<=j;m++){
				sColumn = sValues[2*m-1];
				if(sColumn!="")
					setItemValue(iDW,iRow,sColumn,"");
			}
		}else if(sObjectNoString!="_NONE_" && sObjectNoString!="undefined"){
			sObjectNos = sObjectNoString.split("@");
			for(m=1;m<=j;m++){
				sColumn = sValues[2*m-1];
				iID = parseInt(sValues[2*m],10);
				if(sColumn!="")
					setItemValue(iDW,iRow,sColumn,sObjectNos[iID]);
			}
		}else{
			//alert("ѡȡ������ʧ�ܣ��������ͣ�"+sObjectType);
			return;
		}
		return sObjectNoString;
	}	
}
	
function selectObjectInfo(sObjectType,sParaString,sStyle){
	if(typeof(sStyle)=="undefined" || sStyle=="") sStyle = "dialogWidth:680px;dialogHeight:540px;resizable:yes;scrollbars:no;status:no;help:no";
	sObjectNoString = PopPage("/Frame/ObjectSelect.jsp?ObjectType="+sObjectType+"&ParaString="+sParaString,"",sStyle);
	return sObjectNoString;
}










function setObjectValuePretreat(sObjectType,sParaString,sValueString,iArgDW,iArgRow,sStyle){
	//alert("sParaString="+sParaString);
	var regexp = /#{[A-Za-z0-9]+}/g;
	var cols = sParaString.match(regexp);
	if(cols){
		for(var i=0;i<cols.length;i++){
			var sCol = cols[i].substring(2,cols[i].length-1);
			var sColValue = getItemValue(0, 0, sCol);
			sParaString = sParaString.replace("#{"+sCol+"}", sColValue);
		}
	}
	setObjectValue(sObjectType,sParaString,sValueString,iArgDW,iArgRow,sStyle);
}







function setObjectValue(sObjectType,sParaString,sValueString,iArgDW,iArgRow,sStyle){
	if(typeof(sStyle)=="undefined" || sStyle=="")
		sStyle = "dialogWidth:700px;dialogHeight:540px;resizable:yes;scrollbars:no;status:no;help:no";
	var iDW = iArgDW;
	if(isNaN(iDW)) iDW=0;
	var iRow = iArgRow;
	if(isNaN(iRow)) iRow=0;
	
	var sValues = sValueString.split("@");
	var i=sValues.length;
 	i=i-1;
 	if (i%2!=0){
 		alert("setObjectValue()���ز����趨����!\r\n��ʽΪ:@ID����@ID�ڷ��ش��е�λ��...");
 		return;
 	}else{
		var j=i/2,m,sColumn,iID;
		var sObjectNoString = selectObjectValue(sObjectType,sParaString,sStyle);
		if(typeof(sObjectNoString)=="undefined" || sObjectNoString=="null" || sObjectNoString==null || sObjectNoString=="_CANCEL_" ){
			return;	
		}else if(sObjectNoString=="_CLEAR_"){
			for(m=1;m<=j;m++){
				sColumn = sValues[2*m-1];
				if(sColumn!="")
					setItemValue(iDW,iRow,sColumn,"");
			}
		}else if(sObjectNoString!="_NONE_" && sObjectNoString!="undefined"){
			sObjectNos = sObjectNoString.split("@");
			for(m=1;m<=j;m++){
				sColumn = sValues[2*m-1];
				iID = parseInt(sValues[2*m],10);
				
				if(sColumn!="")
					setItemValue(iDW,iRow,sColumn,sObjectNos[iID]);
			}	
		}else{
			//alert("ѡȡ������ʧ�ܣ��������ͣ�"+sObjectType);
			return;
		}
		return sObjectNoString;
	}
}


function selectObjectValue(sObjectType,sParaString,sStyle){
	if(typeof(sStyle)=="undefined" || sStyle=="") sStyle = "dialogWidth:680px;dialogHeight:540px;resizable:yes;scrollbars:no;status:no;help:no";
	sObjectNoString = PopPage("/Frame/DialogSelect.jsp?SelName="+sObjectType+"&ParaString="+sParaString,"",sStyle);
	return sObjectNoString;
}


function selectMultipleGrid(sObjectType,sParaString,sStyle){
	if(typeof(sStyle)=="undefined" || sStyle=="") sStyle = "dialogWidth:680px;dialogHeight:540px;resizable:yes;scrollbars:no;status:no;help:no";
	sObjectNoString = PopComp("SelectMultipleGridDialog","/Frame/SelectMultipleGridDialog.jsp","SelName="+sObjectType+"&ParaString="+sParaString,sStyle);
	return sObjectNoString;
}


function editRule(sTable,sRegisteredColumn){
	sScript=getItemValue(0,getRow(),sRegisteredColumn);
	saveParaToComp("Script="+sScript,"openRuleEditor('"+sTable+"','"+sRegisteredColumn+"')");
	//openRuleEditor(sTable,sRegisteredColumn,sScript);
}

function openRuleEditor(sTable,sColumnName){
	if(sScreenWidth>=1000) sDialogWidth = "950px", sDialogHeight="700px";
	sValue = PopComp("RuleEditor","/Common/Configurator/RuleManage/RuleEditor.jsp","Table="+sTable+"&Column="+sColumnName,"");
	if (sValue!=null && sValue!='undefined') {
		setItemValue(0,getRow(),sColumnName,sValue);
	}
}


function testRule(sScript){
	sScript = real2Amarsoft(sScript);
	var sData = getCompAttribute("ScenarioPara");
	if(sData==null ||sData=="null" || sData=="") sData = selectObjectValue("SelectAllCBTestApply","","");
	if(typeof(sData)=="undefined" || sData=="") return;
	sDatas = sData.split("@");
	
	var sScriptScenario = getCompAttribute("Scenario");
	if(sScriptScenario==null ||sScriptScenario=="null" || sScriptScenario=="") sScriptScenario = selectObjectValue("SelectAllScriptScenario","","");
	if(typeof(sScriptScenario)=="undefined" || sScriptScenario=="") return;
	if(sScriptScenario=="_CANCEL_") return;
	sScriptScenario = sScriptScenario.split("@")[0];
	
	var sReturn = PopPage("/Common/Configurator/RuleManage/TestScript.jsp?Scenario="+sScriptScenario+"&ParaString=TaskNo="+sDatas[1]+"&Script="+sScript,"","width:0px;height:0px");
	if(typeof(sReturn)=="undefined") return;
	if(sReturn=="_CANCEL_") return;
	if(sReturn.indexOf("LogID=")>=0){
		PopComp("DecisionFlow","/Common/Configurator/RuleManage/DecisionFlowDisplay.jsp","Path="+sReturn);
	}else{
		alert("����ִ�еĽ��Ϊ:\n\n"+sReturn);
	}
}

//���������ͻ
function checkPrimaryKey(sTable,sColumnString){
	if(typeof(sTable)=="undefined" || sTable=="") return false;
	if(typeof(sColumnString)=="undefined" || sColumnString=="") return false;
	var sParameters = "Type=PRIMARYKEY&TableName="+sTable+"";
	var sColumns=sColumnString.split("@");
	for(var i=0;i<sColumns.length;i++){
		if(i==4){
			alert("�ؼ������4��");
			return false;
		}
		sParameters+="&FieldName"+(i+1)+"="+sColumns[i];
		sParameters+="&FieldValue"+(i+1)+"="+getItemValue(0,0,sColumns[i]);
	}
	var sReturnValue = RunJspAjax("/Common/ToolsB/CheckPrimaryKeyAction.jsp?"+sParameters);
	if(sReturnValue == "TRUE"){
		return true;
	}else{
		return false;
	}
}










function selectCode(codeNo,Caption,defaultValue,filterExpr){
    if(typeof(filterExpr) == "undefined") filterExpr = "";
    var codePage = "/Common/ToolsA/SelectCode.jsp";
    var sPara = "CodeNo="+codeNo+"&Caption="+Caption+"&DefaultValue="+defaultValue
				+"&ItemNoExpr="+encodeURIComponent(filterExpr);  //������Ҫ������ת������������&,%,+�����ַ������������
    style = "resizable=yes;dialogWidth=25;dialogHeight=10;center:yes;status:no;statusbar:no";
    return PopPage(codePage+"?"+sPara,"",style);
}

//*************************begin*************************************
//ͨ����Ϣ������as_dz.js��ֲ������
function showMess(mess){
	ShowMessage(mess,true,true);
	setTimeout(hideMessage,500);
}
function waitMess(mess){
	ShowMessage(mess,true,false);
	setTimeout(hideMessage,1000*10);//maxʱ��:�ȴ�10s
}
function hideMessage(){
	try{
		var msgDiv = document.getElementById("msgDiv");
		msgDiv.removeChild(document.getElementById("msgTxt"));
		msgDiv.removeChild(document.getElementById("msgTitle"));
		document.body.removeChild(msgDiv);
		document.body.removeChild(document.getElementById("bgDiv"));
	}catch(e){ }
}
function ShowMessage(str,showGb,clickHide){
	//����ͨ�����������жϴ����Ƿ��Ѵ�
	//��ȡ�滻����ȡ���Ĳ����������ظ���
 	if(document.getElementById("msgDiv"))
		return ;	 	

	var msgw=300;//��Ϣ��ʾ���ڵĿ��
	var msgh=125;//��Ϣ��ʾ���ڵĸ߶�
	var scrollTop = document.body.scrollTop+document.body.clientHeight*0.4+"px";
	
	//**���Ʊ�����**/	
	var bgObj=document.createElement("div");
	bgObj.setAttribute('id','bgDiv');
	bgObj.className = "message_bg";

	//�����㶯�� ����ر�
	if(clickHide)
		bgObj.onclick=hideMessage;
	if(showGb)
		document.body.appendChild(bgObj);
	
	//**������Ϣ��**/
	var msgObj=document.createElement("div");
	msgObj.setAttribute("id","msgDiv");
	msgObj.setAttribute("align","center");
	msgObj.className = "message_div";
	
	msgObj.style.top= scrollTop; //"40%";
	msgObj.style.marginTop = -75+document.documentElement.scrollTop+"px";
	//msgObj.style.width = msgw + "px";
	msgObj.style.height =msgh + "px";
	
	document.body.appendChild(msgObj);
	
	//**���Ʊ����**/ ����ر�
	var title=document.createElement("h4");
	title.setAttribute("id","msgTitle");
	title.setAttribute("align","left");
	title.className = "message_title";
	title.innerHTML="ϵͳ������...";
	if(clickHide){
		title.innerHTML="�ر�";
		title.style.cursor="pointer";			
		title.onclick = hideMessage;
	}	
	
	document.getElementById("msgDiv").appendChild(title);
	
	//**�����ʾ��Ϣ**/
	str = "<br>"+str.replace(/\n/g,"<br>");
	var txt=document.createElement("p");
	txt.style.margin="1em 0";
	txt.setAttribute("id","msgTxt");
	txt.innerHTML=str;
	document.getElementById("msgDiv").appendChild(txt);
}
//*******************************end*********************************


//*************************begin*************************************
//�ű��༭����saveParaToComp��������Datawindow��أ���˴�as_dz.js��ֲ������
var oTempObj; // ������ʱ��ת������
function editObjectValueWithScriptEditor(oObject,sScriptLanguage){
	var sTempLanguage;
	if(typeof(sScriptLanguage)!="undefined" && sScriptLanguage!="")
		sTempLanguage = sScriptLanguage;
	else sTempLanguage = "AmarScript";

	sInput = oObject.value;
	sInput = real2Amarsoft(sInput);
	sInput = replaceAll(sInput,"~","$[wave]");
	oTempObj = oObject;
	if(sTempLanguage=="AFS")
		saveParaToComp("ScriptText="+sInput+"&ScriptLanguage="+sTempLanguage,"openScriptEditorForAFSAndSetText()");
	else
		saveParaToComp("ScriptText="+sInput+"&ScriptLanguage="+sTempLanguage,"openScriptEditorAndSetText()");
}

function editObjectValueWithScriptEditorForAFS(oObject,sModelNo){
	var sTempModelNo;
	if(typeof(sModelNo)!="undefined" && sModelNo!="")
		sTempModelNo = sModelNo;
	else sTempModelNo = "";

	sInput = oObject.value;
	sInput = real2Amarsoft(sInput);
	sInput = replaceAll(sInput,"~","$[wave]");
	oTempObj = oObject;
    saveParaToComp("ScriptText="+sInput+"&ModelNo="+sTempModelNo,"openScriptEditorForAFSAndSetText()");
}

function editObjectValueWithScriptEditorForASScript(oObject){
	sInput = oObject.value;
	sInput = real2Amarsoft(sInput);
	sInput = replaceAll(sInput,"~","$[wave]");
	oTempObj = oObject;
    saveParaToComp("ScriptText="+sInput,"openScriptEditorForASScriptAndSetText()");
}

function openScriptEditorAndSetText(){
	var oMyobj = oTempObj;
	sOutPut = popComp("ScriptEditor","/Common/ScriptEditor/ScriptEditor.jsp","","");
	if(typeof(sOutPut)!="undefined" && sOutPut!="_CANCEL_"){
		oMyobj.value = amarsoft2Real(sOutPut);
	}
}

function openScriptEditorForAFSAndSetText(){
	var oMyobj = oTempObj;
	sOutPut = popComp("ScriptEditorForAFS","/Common/ScriptEditor/ScriptEditorForAFS.jsp","","");
	if(typeof(sOutPut)!="undefined" && sOutPut!="_CANCEL_"){
		oMyobj.value = amarsoft2Real(sOutPut);
	}
}

function openScriptEditorForASScriptAndSetText(){
	var oMyobj = oTempObj;
	sOutPut = popComp("ScriptEditorForASScript","/Common/ScriptEditor/ScriptEditorForASScript.jsp","","");
	if(typeof(sOutPut)!="undefined" && sOutPut!="_CANCEL_"){
		oMyobj.value = amarsoft2Real(sOutPut);
	}
}
	
//���ڶ�̬����iframe��ͨ��post�����ݴ�����ģ̬���� 
function generateIframe(){
	iframeName=randomNumber().toString();
	iframeName = "frame"+iframeName.substring(2);

	//modify in 2008/04/10,2008/02/14 for https
	//var sHTML="<iframe name='"+iframeName+"'  style='display:none'>";
	var sHTML="<iframe name='"+iframeName+"' src='"+sWebRootPath+"/amarsoft.html' style='display:none'>";
	
	document.body.insertAdjacentHTML("afterBegin",sHTML);
	//alert(sHTML);
	return iframeName;
}
//���ڶ�̬���� form ��ͨ��post�����ݴ�����ģ̬���� 
function saveParaToComp(paraString,postAction){
	var sFormName=randomNumber().toString();
	sFormName = "form"+sFormName.substring(2);
	var targetFrameName=generateIframe();
	var sHTML = "";
	if(typeof(dialogStyle)=="undefined" || dialogStyle=="") dialogStyle="";
	var sParaStringToPost = real2Amarsoft(paraString);
	
	sHTML+="<form name='"+sFormName+"' id='"+sFormName+"' target='"+targetFrameName+"' style='display:none'>";
	sHTML+="<input type=hidden name='CompClientID' value='"+sCompClientID+"'>";
	sHTML+="<input type=hidden name='TempParaString' id='TempParaString' value=''>";
	sHTML+="</form>";
	document.body.insertAdjacentHTML("afterBegin",sHTML);

	var oForm = document.forms[sFormName];
	var oElement = oForm.elements["TempParaString"];
	oElement.value = sParaStringToPost;
	$.ajax({
		   type: "POST",
		   url: sWebRootPath+"/Frame/page/dw/SaveParaToComp.jsp",
		   processData: false,
		   async:false,
		   data:$("#" +sFormName,document).serialize(),
		   success: function(msg){
			   try{
				   eval(postAction);
			   }catch(e){
				   alert("����"+e.name+" "+e.number+" :"+e.message+"\n\n���������������:"+sPostAction);
			   }
		   }
	});
}

//���ڶ�̬���� form ��ͨ��post�����ݴ�����ģ̬���� 
function saveParaToCompSession(paraString,postAction){
	var sFormName=randomNumber().toString();
	sFormName = "form"+sFormName.substring(2);
	var targetFrameName=generateIframe();
	var sHTML = "";
	if(typeof(dialogStyle)=="undefined" || dialogStyle=="") dialogStyle="";
	var sParaStringToPost = real2Amarsoft(paraString);
	
	sHTML+="<form name='"+sFormName+"' id='"+sFormName+"' target='"+targetFrameName+"' style='display:none'>";
	sHTML+="<input type=hidden name='CompClientID' value='"+sCompClientID+"'>";
	sHTML+="<input type=hidden name='TempParaString' id='TempParaString' value=''>";
	sHTML+="</form>";
	document.body.insertAdjacentHTML("afterBegin",sHTML);

	var oForm = document.forms[sFormName];
	var oElement = oForm.elements["TempParaString"];
	oElement.value = sParaStringToPost;
	$.ajax({
		   type: "POST",
		   url: sWebRootPath+"/Frame/page/dw/SaveParaToCompSession.jsp",
		   processData: false,
		   async:false,
		   data:$("#" +sFormName,document).serialize(),
		   success: function(msg){
			   try{
				   eval(postAction);
			   }catch(e){
				   alert("����"+e.name+" "+e.number+" :"+e.message+"\n\n���������������:"+sPostAction);
			   }
		   }
	});
}
//*******************************end*********************************


//*************************begin*************************************
//JS�˶��ַ�������������Datawindow��أ���˴�as_dz.js��ֲ������
//real,amarsoft,db,js,html,amarsoft_regex,real_regex
var sAmarReplace = new Array();
sAmarReplace[0] = new Array("\\",		"~[isl]",	"\\",	"\\\\",		"&#92;",		"~\\[isl\\]",	"\\\\");	//add for spdb in 2014/09/24 , add amarsoft_regex,real_regex
sAmarReplace[1] = new Array("'",		"~[sqt]",	"''",	"\\'",		"&#39;",		"~\\[sqt\\]",	"\'");
sAmarReplace[2] = new Array("\"",		"~[dqt]",	"\"",	"\"",		"&#34;",		"~\\[dqt\\]",	"\"");
sAmarReplace[3] = new Array("<",		"~[alt]",	"<",	"<",		"&#60;",		"~\\[alt\\]",	"\<");
sAmarReplace[4] = new Array(">",		"~[agt]",	">",	">",		"&#62;",		"~\\[agt\\]",	"\>");
sAmarReplace[5] = new Array("\r\n",		"~[arn]",	"\r\n",	"\\r\\n",	"&#13;&#10;",	"~\\[arn\\]",	"\\r\\n"); //\r\n
sAmarReplace[6] = new Array("\r",		"~[aor]",	"\r\n",	"\\r\\n",	"&#13;&#10;",	"~\\[aor\\]",	"\\r");
sAmarReplace[7] = new Array("\n",		"~[aon]",	"\r\n",	"\\r\\n",	"&#13;&#10;",	"~\\[aon\\]",	"\\n");
sAmarReplace[8] = new Array("#",		"~[pds]",	"#",	"#",		"#",			"~\\[pds\\]",	"\#");
sAmarReplace[9] = new Array("(",		"~[lpr]",	"(",	"(",		"(",			"~\\[lpr\\]",	"\\(");
sAmarReplace[10] = new Array(")",		"~[rpr]",	")",	")",		")",			"~\\[rpr\\]",	"\\)");
sAmarReplace[11] = new Array("+",		"~[pls]",	"+",	"+",		"+",			"~\\[pls\\]",	"\\+");




function macroReplace(sAttributes,sSource,sBeginIdentifier,sEndIdentifier,iAttID,iAttValue){
	var iPosBegin=0,iPosEnd=0;
	var sAttributeID="";
	var sReturn = sSource;
	while((iPosBegin=sReturn.indexOf(sBeginIdentifier,iPosBegin))>=0){
		iPosEnd = sReturn.indexOf(sEndIdentifier,iPosBegin);
		sAttributeID = sReturn.substring(iPosBegin ,iPosEnd + sEndIdentifier.length);
		sReturn = sReturn.substring(0,iPosBegin) + getAttribute(sAttributes,sAttributeID,iAttID,iAttValue) + sReturn.substring(iPosEnd+sEndIdentifier.length);
	}
	return sReturn;
}


function getAttribute(sAttributes,sAttributeName,iAttID,iAttValue){
	var sAttributeValue;
	for(var i=0;i<sAttributes.length;i++){
		if (sAttributes[i][iAttID]==sAttributeName){
			sAttributeValue = sAttributes[i][iAttValue];
			return sAttributeValue;
		}	
	}	
	return sAttributeValue;
}

function temptest(){
	var tmpstr = "~[pds]12345~[alt]";
	alert(macroReplace(sAmarReplace,tmpstr,"~[","]",1,0));
}

function amarsoft2Html(sSource){
	try{
		if(typeof(sSource)!='string') return sSource;
		sReturn = sSource;
		//sReturn = macroReplace(sAmarReplace,sReturn,"~[","]",1,4);
		for(var i=0;i<sAmarReplace.length;i++)
			sReturn = replaceAll_regex(sReturn,sAmarReplace[i][5],sAmarReplace[i][4]);
		return sReturn;
	}catch(e){
		alert(e.name+" "+e.number+" :"+e.message);
	}	
}

function amarsoft2Real(sSource){
	try{
		if(typeof(sSource)!='string') return sSource;
		sReturn = sSource;
		//sReturn = macroReplace(sAmarReplace,sReturn,"~[","]",1,0);
		for(var i=0;i<sAmarReplace.length;i++)
			sReturn = replaceAll_regex(sReturn,sAmarReplace[i][5],sAmarReplace[i][0]);
		return sReturn;
	}catch(e){
		alert(e.name+" "+e.number+" :"+e.message);
	}	
}
function real2Amarsoft(sSource){
	try{
		if(typeof(sSource)!='string') return sSource;
		sReturn = sSource;
		for(var i=0;i<sAmarReplace.length;i++)
			//sReturn = replaceAll(sReturn,sAmarReplace[i][0],sAmarReplace[i][1]);
			sReturn = replaceAll_regex(sReturn,sAmarReplace[i][6],sAmarReplace[i][1]);
		
		return sReturn;
	}catch(e){
		alert(e.name+" "+e.number+" :"+e.message);
	}	
}

function html2Amarsoft(sSource){
	try{
		if(typeof(sSource)!='string') return sSource;
		sReturn = sSource;
		for(var i=0;i<sAmarReplace.length;i++)
			sReturn = replaceAll(sReturn,sAmarReplace[i][4],sAmarReplace[i][1]);
		
		return sReturn;
	}catch(e){
		alert(e.name+" "+e.number+" :"+e.message);
	}	
}

function html2Real(sSource){
	try{
		if(typeof(sSource)!='string') return sSource;
		sReturn = sSource;
		for(var i=0;i<sAmarReplace.length;i++)
			sReturn = replaceAll(sReturn,sAmarReplace[i][4],sAmarReplace[i][0]);
		
		return sReturn;
	}catch(e){
		alert(e.name+" "+e.number+" :"+e.message);
	}	
}

function replaceAll(sSource,sOldString,sNewString){
	try{
		if(typeof(sSource)!='string') return sSource;
		var iPosBegin = 0;
		sReturn = sSource;
		//alert(sReturn+"\r\n"+sOldString+"\r\n"+sNewString);
		iPosBegin = sReturn.indexOf(sOldString,iPosBegin);
		while(iPosBegin>=0){
			//sReturn = sReturn.replace(sOldString,sNewString);
			sReturn = sReturn.substring(0,iPosBegin)+sNewString+sReturn.substring(iPosBegin+sOldString.length);
			iPosBegin = sReturn.indexOf(sOldString,iPosBegin+sNewString.length);
		}
		return sReturn;
	}catch(e){
		alert(e.name+" "+e.number+" :"+e.message);
	}
}

function replaceAll_regex(sSource,sOldString,sNewString){
    if(typeof(sSource)!='string') return sSource;
    var p = new RegExp(sOldString,"g");
    return sSource.replace(p,sNewString);
}

//*******************************end*********************************