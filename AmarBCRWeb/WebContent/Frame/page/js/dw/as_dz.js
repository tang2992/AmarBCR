//begin ���ڸ�ʽ�����鱨����ʾ�������Զ�����
var bEditHtml = false; 
var bEditHtmlChange = false;
var bEditHtmlAutoSave = true;
var bManualModified = false;
//end
var SAVE_TMP=false;
var _user_validator = new Array();//У�����
var dwCSSPath = sWebRootPath+"/Frame/page/resources/css/dw/";
var behaviorForIE = "behavior:url("+sWebRootPath+"/Frame/page/dw/amarsoft_onchange.sct);";
var DZ = new Array();
var f_c=new Array();  
var r_c=new Array(); 
var rr_c=new Array(); 
var f_css = new Array(); 
var inputDates = new Array();
var pagenum = new Array();  
var pagesize = new Array(); 
var pageone = new Array(); 
var curpage = new Array();  
var my_change = new Array();           
var my_changedoldvalues = new Array(); 
var my_attribute =  new Array();       
var my_notnull = new Array();          
var my_notnull_temp = new Array();
var last_sel_rec = new Array();
var cur_sel_rec = new Array();
var last_sel_item = new Array();
var cur_sel_item = new Array();
var last_frame="";
var cur_frame="";
var needReComputeIndex = new Array();
var my_index = new Array(); 
var cur_sortfield = new Array();
var cur_sortorder = new Array();
var sort_begin = new Array();
var sort_end = new Array();
var myimgstr="";
var iCurRow=-1,iCurCol=0;
var sGDTitleSpace = "&nbsp;";
var bNotCheckModified = false;
//var sDateReadonlyColor = " readonly style={color:#848284;background:#EEEEFF} "; //add by hxd in 2004/03/15(�������ֶ�ֻ��ѡ��)
var sDateReadonlyColor = " style={color:#848284;background:#EEEEFF} "; //add by hxd in 2004/03/15(�������ֶμȿ�ѡ���ֿ�����)

var s_r_c=new Array(); //server row count,add by hxd in 2004/11/08
var s_p_s=new Array(); 
var s_p_c=new Array();
var s_c_p=new Array(); 
var bTextareaShowLimit = true; //add by hxd in 2005/01/07
var sSaveReturn = "";
var bSavePrompt = true;
var bHighlight = true;
var bNeedCA = false;  
var sContentType = "<meta HTTP-EQUIV=\"Content-Type\" CONTENT=\"text/html; charset=gb_2312-80\">";
var keyF7=118;
var sUnloadMessage = "\n\r��ǰҳ�������Ѿ����޸ģ�\n\r����ȡ���������ڵ�ǰҳ��Ȼ���ٰ���ǰҳ�ϵġ����桱��ť�Ա����޸Ĺ������ݣ�\n\r����ȷ�����򲻱����޸Ĺ������ݲ����뿪��ǰҳ��";
var bShowUnloadMessage=false;  //true for szcb_bank,ceb �˲����ѷ������벻Ҫ�޸�
var bCheckBeforeUnload=true;  //��� bShowUnloadMessage
var bHighlightFirst = false;
var bDoUnloadOne = true;  //for only one 
var bDoUnload = new Array();
var bShowGridSum = false;
var sSignature = "739D91A4A3A096A58493A4918B9AA097A0B776A795A0AAA6AC5F6261666976A798A2A3A0A6A57698A29185999C95A9AE759E94B2DAE3E26168666E6C719D92";
var dzRowIndex=0;

var sFFormInputStyle   = "font-family:����,arial,sans-serif;font-size: 10pt";
var sFFormCaptionStyle = "font-family:����,arial,sans-serif;font-size: 10pt;align=center";
var sGridInputStyle    = " ";
var sGridHeaderStyle   = " ";	//color:blue;
var REM_sGridHeaderStyle   = "font-family:����,arial,sans-serif;font-size: 10pt; background-color:#B4B4B4;cursor:pointer;text-decoration: none ";	//color:blue;

//var sHeaderStyle = "background-color:#B4B4B4;cursor:pointer;font-family:����;font-size: 10pt; text-decoration: none";	
var sHeaderStyle = " ";	
//var sTDStyle = " font-family:����; font-size: 10pt; text-decoration: none";	
var sTDStyle = " ";	
var sSumTDStyle = " background-color:#fff;font-family:����;font-size: 9pt; text-decoration: none";	

var hmRPTable = " align=left cellspacing=0 cellpadding=0 class='tableContainer' style='border:1px solid #bcbcbc;border-bottom:0px;border-top:0px;' ";
var hmRPPageTr = " ";
var hmRPPageTd = " style='font-family:����,arial,sans-serif;font-size:9pt;	font-weight: normal;color: #55554B;	padding-left:5px; border:1px solid #bcbcbc; padding-right:5px;padding-top:2px;padding-bottom:2px;background-color: #CDCDCD;valign:top;' ";
var hmRPHeaderTr = "bgColor=#fff";
var hmRPHeaderTd       = " nowrap align=middle style='background-color:#fff;cursor:pointer;font-family:����;font-size: 10pt; text-decoration: none' ";
var hmRPHeaderTdSerial = " nowrap align=middle style='background-color:#fff;cursor:pointer;font-family:����;font-size: 10pt; text-decoration: none' ";
var hmRPGroupSumTr = new Array();
var hmRPGroupSumTdSerial = new Array();
var hmRPGroupSumTd = new Array();
var itColor=new Array("#FFCCAA","#EE8844","#DD2299","#CC00CC","#BBBBBB","#AAAAAA","#999999","#888888","#777777","#666666","#555555","#444444","#333333","#222222","#111111","#000000");
for(var it1=0;it1<16;it1++){
	hmRPGroupSumTr[it1] = " ";
	hmRPGroupSumTdSerial[it1] = " nowrap align=middle style='background-color:#E4E4E4;font-family:����;font-size: 9pt; text-decoration: none ' ";
	hmRPGroupSumTd[it1]       = " nowrap              style='background-color:"+itColor[it1]+";font-family:����;font-size: 9pt; text-decoration: none ' ";
}
var hmRPContentTr = " ";
var hmRPContentTDSerial = " nowrap align=middle style='font-family:����; font-size: 9pt; text-decoration: none ' ";
var hmRPContentTD       = " nowrap              style='font-family:����; font-size: 9pt; text-decoration: none ' ";
var hmRPPageSumTr = " ";
var hmRPPageSumTdSerial  = " nowrap align=middle style='font-family:����; font-size: 9pt; text-decoration: none ' ";
var hmRPPageSumTd        = " nowrap              style='font-family:����; font-size: 9pt; text-decoration: none ' ";
var hmRPTotalSumTr = " ";
var hmRPTotalSumTdSerial = " nowrap align=middle style='font-family:����; font-size: 9pt; text-decoration: none ' ";
var hmRPTotalSumTd       = " nowrap              style='font-family:����; font-size: 9pt; text-decoration: none ' ";

var hmDate =         "<input type=button class='inputDate' value='...'  ";
var hmSelectButton = "<input type=button class='inputDate' value='...'  ";

var hmFFTable = " class='fftable' border=0 cellspacing=0 cellpadding=2 ";
var hmFFTr = " class='fftr1' ";
var hmFFCaptionTD = " class='fftdhead' nowrap ";
var hmFFSpanTips = " class='ffspantips' nowrap onmouseover='parent._showTips(document, this, event)'";
var hmFFDivTips = " class='ffdivtips'";
var hmFFTextAreaCaptionTD = hmFFCaptionTD;//" class='fftdheadTextArea' nowrap ";
var hmFFContentTD = " class='FFContentTD' nowrap ";
var hmFFContentInput = " class='fftdinput' style='"+behaviorForIE+"' ";
var hmFFContentArea = " class='fftdarea' style='"+behaviorForIE+"' ";
var hmFFContentSelect = " class='fftdselect' style='"+behaviorForIE+"' " ;
var hmFFBlankTD = " class='FFContentTD' nowrap ";

var hmGDTable = " /**hmGDTable*/ style='border-collapse:collapse;'";
var hmGDHeaderTr = " /**hmGDHeaderTr*/ bgColor=#fff height=20";
var hmGdTdPage = " /**hmGdTdPage*/ class='GdTdPage'";
var hmGDTdHeader = " /**hmGDTdHeader*/ nowrap class='GDTdHeader' ";
var hmGDTdHeader_last = " /**hmGDTdHeader*/ nowrap class='GDTdHeader_last' ";
var hmGDTdSerialWidth = "width=20";//�кſ��
var hmCountLineHeight = 20;//���ܱ���и߶�
//var hmGdTdSerial = " /**hmGdTdSerial*/ style='cursor:pointer;font-size: 9pt;color:black;align:absmiddle;valign:top' bgcolor=#999999 noWrap align=middle valign=top width=14  class='TCSelImageUnselected' ";
var hmGdTdSerial = " /**hmGdTdSerial*/ align=center valign=top " + hmGDTdSerialWidth+ "  ";

var hmGdSumTr = "";
var hmGdSumTdSerial = " <TD nowrap id='T0' style='cursor:pointer;font-size: 9pt;color:black;align:absmiddle;valign:top' bgcolor=#EEE1D2 align=center valign=top  >�ܼ�</TD> ";
var hmGdSumTd = " style='font-family:����,arial,sans-serif;font-size: 9pt ' ";

var sMandatorySignal = " &nbsp;<font color=red>*</font> ";
var hmGdTdContent = " nowrap ";//bgcolor=#FEFEFE

var hmGdTdContentInput1 = " class='GDTdContentInput' ";
var hmGdTdContentArea1 = " class='hmGdTdContentArea' ";
var hmGdTdContentSelect1 = " class='GdTdContentSelect' ";

var hmGdTdContentInput2 =  " style='"+behaviorForIE+"' "+hmGdTdContentInput1 ;
var hmGdTdContentArea2 =   " style='"+behaviorForIE+"' "+hmGdTdContentArea1;
var hmGdTdContentSelect2 = " style='"+behaviorForIE+"' "+hmGdTdContentSelect1;
var hmGdTdContentRadio = " style='height: 13px;margin-right: 2px;margin-left: 2px;' ";
var hmGdTdContentCheckbox = " style='height: 13px;margin-right: 2px;margin-left: 2px;' ";

if(navigator.appName != "Microsoft Internet Explorer"){
	hmFFContentInput = " class='fftdinput' ";
	hmFFContentArea = " class='fftdarea' ";
	hmFFContentSelect = " class='fftdselect' " ;
	hmGdTdContentInput2 =  hmGdTdContentInput1 ;
	hmGdTdContentArea2 =   hmGdTdContentArea1;
	hmGdTdContentSelect2 = hmGdTdContentSelect1;
}

// datawindow �Ų�����
var arrangements = new Array();
var harbors = new Array();
var bFreeFormMultiCol = false;

//below can modify in jsp
function myAfterLoadGrid(iDW){
	//setColor(iDW,sEvenColor);
	//Add you code
}

function myAfterLoadFreeForm(iDW){
	//add for rich editor in 2014/09/15
	initHTMLEditorForIframe("myiframe"+iDW);
	//Add you code
}
//add for rich editor in 2014/09/12
function initHTMLEditorForIframe(sIFrameName) {
	var curDocument = window.frames[sIFrameName].document;
    var oBody = curDocument.getElementsByTagName("body")[0];
    var oHead = curDocument.getElementsByTagName("head");
    var curHead = null;
    if(oHead && oHead.length){
    	curHead = oHead[0];
    }else{
    	curHead = oBody;
    }
    
    var oScript= curDocument.createElement("script");
    oScript.id = "oScript1";
    oScript.type = "text/javascript";
    oScript.src = sWebRootPath+"/Frame/page/resources/ckeditor/ckeditor/ckeditor.js?t=B37D54V";
    var oScriptTag1 = curDocument.getElementById("oScript1");
    if(!oScriptTag1){
    	curHead.appendChild(oScript);
    }

	oScript.onload = oScript.onreadystatechange = function(){
	    if ((!this.readyState) || this.readyState == "complete" || this.readyState == "loaded" ){
	    	var iEleCount = curDocument.all.length; 
	    	var cks = new Array();
	    	for(var iEle = 0; iEle < iEleCount; iEle++ ){
	    		if(curDocument.all[iEle].tagName == "TEXTAREA" && curDocument.all[iEle].getAttribute("rich")=="true"){
	    			cks.push(curDocument.all[iEle].id);
	    		}
	    	}
	    	for(var i=0;i<cks.length;i++){
    			window.frames[sIFrameName].CKEDITOR.replace(cks[i] ,{
					"toolbar_Full":
					[
					    {items : ['Cut','Copy','Paste','-','Undo','Redo','-','Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat','-','NumberedList','BulletedList','-','Outdent','Indent','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock','-','Source']},
					    {items : ['Styles','Format','Font','FontSize','-','TextColor','BGColor','-',/*'Image','-',*/'Maximize'] },
					],
					"autoUpdateElement":false,
					"resize_enabled":false,
					"removePlugins":"elementspath",
					//"width":"100%",
					"image_previewText":"&nbsp;"
					}
					); // CKEDITOR()���� �� �����js�ļ���
	    	}
	    }else{
		  //  alert("can not load the ckeditor.js file");
	    }
 	 };
}

function mySelectRow(){ 
	//Add you code
	//setColor();	
}

function myHandleSelectChangeByIndex(iDW,iRow,iCol){
	sCol = getColName(iDW,iCol);
	myHandleSelectChange(iDW,iRow,sCol);
}

function myHandleSelectChange(iDW,iRow,sCol){
}

function myNumberBFP(myobj){
	try {
		clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d\-+.]/g,''));
	}catch(e){}
}	

function myNumberFC(myobj){
	myobj.value=myobj.value.replace(/,/g,"");
	myNumberPOS(myobj);
}	

function myNumberPOS(myobj)  {
	try {
	   if  (myobj.createTextRange)  {
		   var  r  =  myobj.createTextRange();
		   var  ipos = myobj.value.indexOf('.');
		   if (ipos == -1) {
			   ipos = myobj.value.length;
		   }
		   r.moveStart('character',ipos);
		   r.collapse();
		   r.select();
	   }
	} catch(e) {}
}

function myNumberKD(myobj,event){
	try {
		var mycode = event.keyCode;
		if (mycode == 8 || mycode == 46) { //delete,backspace
		  //event.keyCode = 8; //backspace
		  event.returnValue = true;
		  return;
		}else if (mycode == 13 || mycode == 9 || mycode == 27 ) { //enter,tab,esc
		  event.returnValue = true;
		  return;
		}else if (mycode >= 16 && mycode <= 18 ) { //shift,ctrl,alt
		  event.returnValue = true;
		  return;
		}else if (event.ctrlKey == true && (mycode == 67 || mycode == 86 || mycode == 88)) { //ctrl+cvx
		  event.returnValue = true;
		  return;
		}else if ((mycode == 110 || mycode == 190) && myobj.value.indexOf('.')==-1) {//'.'
		  event.returnValue = true;
		  return;
		}else if (mycode == 109 || mycode == 189) {//'-'
		  event.returnValue = true;
		  return;
		}else if (event.shiftKey == false && mycode >= 48 && mycode <= 57 ) { //0-9
		  event.returnValue = true;
		  return;
		}else if (mycode == 40) { //down
		  event.keyCode = 9; //tab
		  event.returnValue = true;
		  return;
		}else if (mycode >= 33 && mycode <= 40) { //left,right,home...
		  event.returnValue = true;
		  return;
		}else if (mycode == 229 ) { //chinese
		  event.returnValue = true;
		  return;
		}else if (mycode >= 96 && mycode <= 105 ) { //[num]0-9
		  event.returnValue = true;
		  return;
		}else {
		  event.returnValue = false;
		  return;
		}
	} catch(e) {}
}

function myNumberKU(myobj, event){
	event = event || window.frames["myiframe0"].event;
	var mycode = event.keyCode;
	if( (mycode>=33 && mycode<=39 )|| mycode==16 || mycode==17 ||mycode==18 ||mycode==8) //left,right,home...alt,ctrl,shift,delete
		return; 
	if(mycode!=43 && mycode!=44 && mycode!=45 && mycode!=46 &&
	mycode!=187 && mycode!=188 && mycode!=189 && mycode!=190 &&
	mycode!= 48 && mycode!= 49 && mycode!= 50 && mycode!= 51 && mycode!= 52 &&
	mycode!= 53 && mycode!= 54 && mycode!= 55 && mycode!= 56 && mycode!= 57 && //+,-. 0123456789
	mycode!= 96 && mycode!= 97 && mycode!= 98 && mycode!= 99 && mycode!= 100 &&  //numlock:0-4
	mycode!= 101 && mycode!= 102 && mycode!= 103 && mycode!= 104 && mycode!= 105 &&  //numlock:5-9
	mycode!= 107 && mycode!= 109 && mycode!= 110 ) {//numlock: + - .
		myobj.value=myobj.value.replace(/[^\d\-+.,]/g,'');
		myNumberPOS(myobj);
	}
}	

function myNumberKP(myobj, event){
	try {
		var mycode = event.keyCode;
		if (mycode == 45) {//'-'
		  if (myobj.value.indexOf('-')==-1) {
			  myobj.value = '-' + myobj.value;
		  } else {
			  myobj.value=myobj.value.replace(/-/,"");
		  }
		  myNumberPOS(myobj);
		  event.returnValue = false;
		  return;
		}

		if(myobj.value!="") {
			var a;
			a=parseFloat(myobj.value,10);
			if(Math.abs(a)>999999999999999) {
				alert("���ݲ�������");
				myobj.value="";
				event.returnValue = false;
			}
		}
	} catch(e) {}
}	

function myNumberBL(myobj, objpname){
	try {
		var sValue = myobj.value.replace(/[^\d\-+.]/g, "");
		var myi = objpname.substring(objpname.length-1);
		var iEnd = myobj.name.indexOf("F");
		var iField = parseInt(myobj.name.substring(iEnd+1));
		sValue = amarMoney(sValue, DZ[myi][1][iField][12]);

		if(typeof(myobj.myvalid) != "undefined" && myobj.myvalid!="undefined" ) {
			var sTempValue = sValue.replace(/[^\d\-+.]/g, "");
			if(sTempValue != "" && !eval(myobj.myvalid.replace(/myobj.value/g, sTempValue))){	 //kick �� ,
				alert(myobj.mymsg);
				myobj.focus();
			}
		}
		myobj.value = sValue;
	} catch(e) {alert(e.message);}
}	

//�����������ݵ�С��λ�Ƿ񳬹��涨��λ��
function FormatNumber(srcStr,nBeforeDot,nAfterDot){ //��ʽ������ (int srcStr,int С��λ��)
	srcStr = new String(srcStr);
	if(srcStr=="" || srcStr==null) return true;
	strLen = srcStr.length;	
	dotPos = srcStr.indexOf(".");		
	if(strLen > (nBeforeDot + nAfterDot +1)){return false;} 
	else {
		if (dotPos == -1) {
			if(strLen> (nBeforeDot + nAfterDot)){return false;}  
		}else if((strLen - dotPos) > (nAfterDot + 1)){return false;} 
	}	
	return true;	
}

//�ж�����������Ƿ�ȫ��Ϊ���ֻ�һ�����(.)�����������,����true.
function reg_Num(str){
	var Letters = "-1234567890.,";
	var j = 0;		
	if(str=="" || str==null) return true;
	for (var i=0;i<str.length;i++) {
		var CheckChar = str.charAt(i);
		if (Letters.indexOf(CheckChar) == -1){return false;}
		if (CheckChar == "."){j = j + 1;}
	}
	if (j > 1){return false;}
	return true;
}

//��֤��ֵ ,��������Ϸ���reg_Num()��ȫ��һ��    add by zhuang 2010-03-23
function validateNum(str){
    var Letters = "-1234567890.,";
    var j = 0;
    var m = 0;   
    if(str=="0"){
    	return "true";
    }
    if(str=="" || str==null) return "true";//����ֵΪ ��true����ʾ����Ϸ�
    if(str.charAt(0)=="." || str.charAt(str.length-1)==".") {return "false";}//����ֵΪ ��false����ʾ����Ϸ�

    for(var i=0;i<str.length;i++){
        var CheckChar = str.charAt(i);
        if (Letters.indexOf(CheckChar) == -1){return "false";}
        if (CheckChar == "."){j = j + 1;} 
    }  
                        
    if (j > 1){
        return "false";
    }else{
    	if(j==1){
    		var sStrSubs = str.split(".");//��ȡ��������
    		sStrSub =  sStrSubs[0];           
    	}else if(j==0){
    		sStrSub = str;    
        }
    	for (var k=0;k<sStrSub.length;k++){   
    		CheckChar = sStrSub.charAt(k);               
    		if (CheckChar == "0"){  
    			m = m + 1;
    		}else{
    			break;  
            }
        }
    	//m==1:����ֵʱ������������ĵ�һ����Ϊ0ʱ�Ĵ���
    	if((m==1) && (str.indexOf(".")==-1)){
        	return k=1;
        }
    	if(m>1){
    		if(m==sStrSub.length){k = k - 1;}
    		return k;//���ص�һ������Ч 0 ���±� ������������ȫΪ0ʱ�����ڶ���0���±�ֵ
    	}else{
            return "true";
        }
    }
}

//�����Զ���С��λ����������,����objectΪ�������ֵ,����decimalΪ����С��λ��
function roundOff(number,digit){
	var sNumstr = 1;
	for (var i=0;i<digit;i++) {
		sNumstr=sNumstr*10;
	}
	sReturnValue = Math.round(parseFloat(number)*sNumstr)/sNumstr;
	return sReturnValue;
}

function beforeKeyDown(myiframe){
	try {
		if(window.frames[myiframe].event.srcElement.name.indexOf("Radio")>0)
			return false;
	} catch(e) {}
	return true;
}

function doKeyDown(myiframe){ }

function afterKeyDown(myiframe){ }

function beforeKeyUp(myiframe){
	try {
		if(window.frames[myiframe].event.srcElement.name.indexOf("Radio")>0)
			return false;
	} catch(e) {}
	return true;
}

function doKeyUp(myiframe){
	try {
		if(window.frames[myiframe].event.keyCode==13) {
	   		var j = "0";
			var obj = window.frames[myiframe].event.srcElement;
			for(var i=0;i<window.frames[myiframe].document.all.length;i++){
				if(window.frames[myiframe].document.all[i].name==obj.name){
					j="1";
					continue;
				}
				//kick btnR(keyF7)
				if(j=="1" && window.frames[myiframe].document.all[i].name!=null && window.frames[myiframe].document.all[i].name.indexOf("R")!=-1 && window.frames[myiframe].document.all[i].name.substring(0,4)!="btnR")
				{
					if (window.frames[myiframe].document.all[i].disabled==true||window.frames[myiframe].document.all[i].readOnly==true) {
						continue;
					}
					window.frames[myiframe].document.all[i].focus();
					break;
				}
			}   			
	   	}	
	} catch(e) {}
}

function afterKeyUp(myiframe){ }

function beforeMouseDown(myiframe){
	if(cur_frame=="myform999")
		cur_frame=myiframe;
		
	return true;
}
	
function doMouseDown(myiframe){ }

function afterMouseDown(myiframe){ }

function beforeKeyUp_show(e, myiframe){
	//modify by hxd in 2008/04/10
	//return true;  //2008/02/01 citibank����Ҫdw export
	return !myHandleSpecialKey(e, myiframe); //����ȡ��
}

function doKeyUp_show(myiframe){ }

function afterKeyUp_show(myiframe){ }

function beforeMouseDown_show(myiframe){
	return true;
}

function doMouseDown_show(myiframe){ }

function afterMouseDown_show(myiframe){ }

function mymu(){
	alert("up");
}	
//frames["myiframe0"].document.body.onmouseup = mymu;
	
//���º���Ϊ������ʹ�� 
var FILTER_OPERATORS = new Array(14);
FILTER_OPERATORS[0] = new Array('SmallerThanOrEquals','#{FilterID}_TD_4,#{FilterID}_TD_5,#{FilterID}_TD_6','#{FilterID}_TD_3');
FILTER_OPERATORS[1] = new Array('BeginsWith','#{FilterID}_TD_4,#{FilterID}_TD_5','#{FilterID}_TD_3,#{FilterID}_TD_6');
FILTER_OPERATORS[2] = new Array('BetweenNumber','','#{FilterID}_TD_3,#{FilterID}_TD_4,#{FilterID}_TD_5');
FILTER_OPERATORS[3] = new Array('BetweenString','','#{FilterID}_TD_3,#{FilterID}_TD_4,#{FilterID}_TD_5,#{FilterID}_TD_6');
FILTER_OPERATORS[4] = new Array('BiggerThan','#{FilterID}_TD_4,#{FilterID}_TD_5,#{FilterID}_TD_6','#{FilterID}_TD_3');
FILTER_OPERATORS[5] = new Array('BiggerThanOrEquals','#{FilterID}_TD_4,#{FilterID}_TD_5,#{FilterID}_TD_6','#{FilterID}_TD_3');
FILTER_OPERATORS[6] = new Array('Contains','#{FilterID}_TD_4,#{FilterID}_TD_5','#{FilterID}_TD_3,#{FilterID}_TD_6');
FILTER_OPERATORS[7] = new Array('NotContains','#{FilterID}_TD_4,#{FilterID}_TD_5','#{FilterID}_TD_3,#{FilterID}_TD_6');
FILTER_OPERATORS[8] = new Array('EndWith','#{FilterID}_TD_4,#{FilterID}_TD_5','#{FilterID}_TD_3,#{FilterID}_TD_6');
FILTER_OPERATORS[9] = new Array('EqualsNumber','#{FilterID}_TD_4,#{FilterID}_TD_5','#{FilterID}_TD_3');
FILTER_OPERATORS[10] = new Array('EqualsString','#{FilterID}_TD_4,#{FilterID}_TD_5','#{FilterID}_TD_3,#{FilterID}_TD_6');
FILTER_OPERATORS[11] = new Array('NotEquals','#{FilterID}_TD_4,#{FilterID}_TD_5','#{FilterID}_TD_3,#{FilterID}_TD_6');
FILTER_OPERATORS[12] = new Array('SmallerThan','#{FilterID}_TD_4,#{FilterID}_TD_5,#{FilterID}_TD_6','#{FilterID}_TD_3');
FILTER_OPERATORS[13] = new Array('IsNull','#{FilterID}_TD_3,#{FilterID}_TD_4,#{FilterID}_TD_5,#{FilterID}_TD_6','');
FILTER_OPERATORS[14] = new Array('IsNotNull','#{FilterID}_TD_3,#{FilterID}_TD_4,#{FilterID}_TD_5,#{FilterID}_TD_6','');
// add by byhu 2008.02.21 �������֤18λ��15λ����
FILTER_OPERATORS[15] = new Array('EqualsCert','#{FilterID}_TD_4,#{FilterID}_TD_5','#{FilterID}_TD_3,#{FilterID}_TD_6');
FILTER_OPERATORS[16] = new Array('InString','#{FilterID}_TD_4,#{FilterID}_TD_5','#{FilterID}_TD_3,#{FilterID}_TD_6');

function filterAction(sObjectID,sFilterID){
	alert(sObjectID+" "+sFilterID);
}

function selectFilterDate(sObjectID,sFilterID){
	var oInput = document.getElementById(sObjectID);
	AsDialog.OpenCalender(oInput,"yyyy/MM/dd","1900/01/01","2100/12/31");
	//sReturn = PopPage("/Common/ToolsA/SelectDate.jsp","","dialogwidth:320px;dialogheight:280px");
	//if(typeof(sReturn)!="undefined" && sReturn!="" && sReturn!="_CANCEL_"){
	//ѡ�����ʱ�������
	//if(typeof(sReturn)!="undefined" && sReturn!="_CANCEL_"){
	//	oInput.value=sReturn;
	//}
}

function applyFilters(){
	alert("abc");
}

function checkDOFilterForm(oForm){
	if(typeof(oForm)=='string') oForm = document.forms[oForm];
	var myi=0;
	//var i=0;
	//var j=0;
	//var bHaveEquals = false;
	//var bHaveOrgAndNoValue = false;
	//var sOrgCaption = "";
	var specialChar = new Array('%','"','\'','\\','$','��');//���ò�ѯ������Ҫ���˵������ַ�   

	for(var i = 0; i < oForm.length; i++){
		var oEle = oForm.elements[i];
		var sValue = oEle.value;
		if(!sValue) continue;
		
		var sName = oEle.name;
		var i1 = sName.indexOf("DOFILTER_"), i2 = sName.indexOf("_VALUE");
		if(i1 < 0 || i2 < 0) continue;
		
		var sFix = sName.substring(i1+9, i2);
		sFix = sFix.split("_")[0];
		if(!sFix) continue;
		
		var oTD = document.getElementById(sFix+"_TD_1");
		if(!oTD) continue;
		var sHeader = oTD.innerHTML;
		
		//�����׶ο������ε�����FORѭ�����룬�Ӷ����ò�ѯ�����е������ַ����˹��ܡ�
		for(var j = 0; j < specialChar.length; j++){
			if(sValue.indexOf(specialChar[j]) > -1){
				alert("["+sHeader+"]���ܺ��������ַ�"+specialChar[j]+"��");
				return false;
			}
		}
		
		for(j = 0; j < DZ[myi][1].length; j++){
			if(DZ[myi][1][j][0]!=sHeader) continue;
			if(DZ[myi][1][j][12]==2 || DZ[myi][1][j][12]==5 || DZ[myi][1][j][12]>10){ //����
				if(isNaN(sValue)){
					alert("["+sHeader+"]ӦΪ���֣�");
					return false;
				}
			}
		}
		/*
		if(oForm.elements[i].tagName.toUpperCase()=="TD" && oForm.elements[i].id.indexOf("_TD_1")>0 ){
			for(j=0;j<DZ[myi][1].length;j++){
				try {
				if(DZ[myi][1][j][0]==oForm.elements[i].innerText){
					if(oForm.document.getElementById(oForm.elements[i].id.replace("_TD_1","")+"_OP_ID").value=="EqualsString" &&
						oForm.document.getElementById("DOFILTER_"+oForm.elements[i].id.replace("_TD_1","")+"_1_VALUE").value!=""  )
						bHaveEquals = true;
				
					if(DZ[myi][1][j][12]==2 || DZ[myi][1][j][12]==5 || DZ[myi][1][j][12]>10){ //����
						if(isNaN(oForm.document.getElementById("DOFILTER_"+oForm.elements[i].id.replace("_TD_1","")+"_1_VALUE").value) ||
							isNaN(oForm.document.getElementById("DOFILTER_"+oForm.elements[i].id.replace("_TD_1","")+"_2_VALUE").value) ) 
						{
							alert("["+oForm.elements[i].innerText+"]ӦΪ���֣�");
							return false;
						}
					}	
					//�����׶ο������ε�����FORѭ�����룬�Ӷ����ò�ѯ�����е������ַ����˹��ܡ�
					for(var k=0;k<specialChar.length;k++ ){
						if(oForm.document.getElementById("DOFILTER_"+oForm.elements[i].id.replace("_TD_1","")+"_1_VALUE").value.indexOf(specialChar[k]) > -1 || 
							oForm.document.getElementById("DOFILTER_"+oForm.elements[i].id.replace("_TD_1","")+"_2_VALUE").value.indexOf(specialChar[k]) > -1)
						{
							alert("["+oForm.elements[i].innerText+"]���ܺ��������ַ�"+specialChar[k]+"��");
							return false;
						}
					}
				
					//����漰˭�õ��ˣ������е���һ��
					//if(oForm.elements[i].innerText=="�Ǽǻ���"||oForm.elements[i].innerText=="�ܻ�����" ||oForm.elements[i].innerText=="�������"||oForm.elements[i].innerText=="��������")
					if(DZ[myi][1][j][15].toUpperCase( ).indexOf("ORGID")>0){
						if((oForm.document.getElementById("DOFILTER_"+oForm.elements[i].id.replace("_TD_1","")+"_1_VALUE").value=="" || 
							oForm.document.getElementById("DOFILTER_"+oForm.elements[i].id.replace("_TD_1","")+"_1_VALUE").value==null))
						{
							//alert("["+oForm.elements[i].innerText+"]����Ϊ�գ���ѡ����Ӧ��"+"["+oForm.elements[i].innerText+"]");
							//return false;
							bHaveOrgAndNoValue = true;
							sOrgCaption = oForm.elements[i].innerText;
						}else{
							bHaveOrgAndNoValue = false;
						}
					}
					break;			
				}
				}catch(e){}
			}
		}
		*/
	}
	/*
	if( bHaveOrgAndNoValue && !bHaveEquals){
		alert("["+sOrgCaption+"]����Ϊ�գ���ѡ����Ӧ��"+"["+sOrgCaption+"]");
		return false;
	}
	*/
	
	ShowMessage("ϵͳ���ڴ������ݣ���ȴ�...",true,false);
	return true;
}


function submitFilterForm(sFormName){
	var oForm = document.forms[sFormName];
	//for(i=0;i<oForm.elements.length;i++) alert(oForm.elements[i].name+":"+oForm.elements[i].value);
	//oForm.submit();		
	oForm.style.display = "none";
	onFromAction(oForm,sFormName);
}
function clearFilterForm(sFormName){
	var oForm = document.forms[sFormName];
	for(var i=0;i<oForm.elements.length;i++){
		if(oForm.elements[i].name.indexOf("_OP")>=0 || oForm.elements[i].type=="button" || oForm.elements[i].type=="reset"|| oForm.elements[i].type=="submit"){
			continue;
		}else if(oForm.elements[i].type=="checkbox"){
			oForm.elements[i].checked=false;
		}else{
			oForm.elements[i].value="";
		}
	}
}
function resetFilterForm(sFormName){
	var oForm = document.forms[sFormName];
	oForm.reset();
}

function showHideFilterElements(sFilterID,oOperatorObj){
	try{
		for(var iOperators=0;iOperators<FILTER_OPERATORS.length;iOperators++){
			if(oOperatorObj.value==FILTER_OPERATORS[iOperators][0]){
				sObjectsToHide = replaceAll(FILTER_OPERATORS[iOperators][1],"#{FilterID}",sFilterID);
				sObjectsToShow = replaceAll(FILTER_OPERATORS[iOperators][2],"#{FilterID}",sFilterID);
				if(sObjectsToHide!="") showHideObjects(sObjectsToHide,"hide");
				if(sObjectsToShow!="") showHideObjects(sObjectsToShow,"show");
			}
		}
	}catch(e){
		alert("��ʾ/���ع��������Ŷ�Ӧ�Ķ���ʱ��������Htmlģ�档");
	}
}

function showHideObjects(sObjects,sShowOrHide){
	if(sObjects=="") return;
	var sTargetObjects = sObjects.split(",");
	if(sTargetObjects=="") return;
	for (var iObject=0;iObject<sTargetObjects.length;iObject++){
		if(sShowOrHide=="hide"){
			try{
				sCurObj = document.getElementById(sTargetObjects[iObject]);
				sCurObj.style.display = "none";
			}catch(e){
				alert("���ع��������Ŷ�Ӧ�Ķ���ʱ��������Htmlģ�档"+e);
			}
		}else{
			try{
				sCurObj = document.getElementById(sTargetObjects[iObject]);
				sCurObj.style.display = "";
			}catch(e){
				alert("��ʾ���������Ŷ�Ӧ�Ķ���ʱ��������Htmlģ�档"+e);
			}
		}
	}
}





function multiSelectAll(flag){
	if(flag != true) flag = false;
	var iDW = 0;
	var b = getRowCount(iDW);
	var iCol = getColIndex(iDW, "MultiSelectionFlag");
	var form = window.frames["myiframe"+iDW].document.forms[0];
	for(var iMSR = 0 ; iMSR < b ; iMSR++){
		var element = form.elements["R"+iMSR+"F"+iCol];
		element.checked = flag;
		element.value = flag ? "��" : "";
	}
}






function getCheckedRows(iDW){
	var iDW = 0;
	var b = getRowCount(iDW);
	var iCol = getColIndex(iDW, "MultiSelectionFlag");
	var form = window.frames["myiframe"+iDW].document.forms[0];
	var result = new Array();
	for(var iMSR = 0 ; iMSR < b ; iMSR++){
		var element = form.elements["R"+iMSR+"F"+iCol];
		if(element.checked){
			result[result.length] = iMSR;
		}
	}
	return result;
}







function getItemValueArray(iDW,sColumnID){
	var b = getRowCount(iDW);
	var sSelected = new Array();
	for(var iMSR = 0 ; iMSR < b ; iMSR++){
		var a = getItemValue(iDW,iMSR,"MultiSelectionFlag");
		if(a == "��"){
			sSelected.push(getItemValue(iDW,iMSR,sColumnID));
		}
	}
	return sSelected;
}

function editWithScriptEditor(iDW,sCol){
	var myobj = getASObject(iDW,getRow(0),sCol);
	editObjectValueWithScriptEditor(myobj);
}

function checkModified(){
	var myobjname = cur_frame;
	//begin ���ڸ�ʽ�����鱨����ʾ�������Զ�����
	if(bEditHtml && bEditHtmlChange ){
        if(confirm(sUnloadMessage)) return true;
        else return false;
    }
    //end
	if(isModified(myobjname) && bCheckBeforeUnload){
		if(confirm(sUnloadMessage)) return true;//"��ǰҳ�������Ѿ����޸ģ�����ȷ�����򲻱����޸Ĺ������ݲ����뿪��ǰҳ������ȡ���������ڵ�ǰҳ��Ȼ���ٰ���ǰҳ�ϵġ����桱��ť�Ա����޸Ĺ������ݡ�";
		else return false;
	}else{
		return true;
	}
}

function f_myPad0(myi){
	var f_mys0 = "";
	if(myi<10)
		f_mys0 = "0"+myi.toString(10);
	else
		f_mys0 = myi.toString(10);
	return f_mys0;
}

function f_myDate(){
	var d = new Date();
	var s = "" ;
	
	s += f_myPad0(d.getYear());
	s += f_myPad0(d.getMonth()+1);
	s += f_myPad0(d.getDate());
	s += f_myPad0(d.getHours());
	s += f_myPad0(d.getMinutes());
	s += f_myPad0(d.getSeconds());
	s += f_myPad0(d.getMilliseconds());
	
	return s;
}
	
//add by syang 2009/11/19 ����ҳ��ҵ��Ҫ��
function amarExportTemplate(myname){
	try{
		window.showModalDialog(sWebRootPath+"/Frame/page/dw/GetDWTemplate.jsp?CompClientID="+sCompClientID+"&type=export&dw="+DZ[myname.substring(myname.length-1)][0][1]+"&rand="+randomNumber(),"_blank","width=240,height=100,left="+(screen.availWidth-200)/2+",top="+(screen.availHeight-100)/2+",center=yes,toolbar=no,menubar=no");
	}catch(e){
		alert(e.name+" "+e.number+" :"+e.message); 
	}		
}

function amarExport(myname){
	try{
		window.open(sWebRootPath+"/Frame/page/dw/GetDWDataAll.jsp?CompClientID="+sCompClientID+"&type=export&dw="+DZ[myname.substring(myname.length-1)][0][1]+"&rand="+randomNumber(),"myform999");
	}catch(e){
		alert(e.name+" "+e.number+" :"+e.message); 
	}		
}
function amarPrint(myname){
	try{
		window.showModalDialog(sWebRootPath+"/Frame/page/dw/GetDWDataAll.jsp?CompClientID="+sCompClientID+"&type=print&dw="+DZ[myname.substring(myname.length-1)][0][1]+"&rand="+randomNumber(),"_blank","width=240,height=100,left="+(screen.availWidth-200)/2+",top="+(screen.availHeight-100)/2+",center=yes,toolbar=no,menubar=no");
	}catch(e){
		alert(e.name+" "+e.number+" :"+e.message); 
	}
}

//add by hxd in 2008/04/10
function amarExportNew(myname){
	if(window.frames[myname].document.getElementById('div_myd')==null){
		var sHTML = "<div id='div_myd' style='position:absolute;z-index:9999;filter:alpha(opacity=25);background-color:black;visibility:visible'>"+
			"<table width=100% height=100% border=1><tr valign=middle align=center>"+
			"<td valign=middle align=center>"+
			"<table width=300 height=150 border=1 bordercolor='#000000' style='border-collapse:collapse;background-color:#FFFFFF' >"+
			"<tr height=30><td valign=middle align=center style='font:9pt;font-family:������;background-color:#0000FF;color:white' height=25>ϵͳ��Ϣ</td></tr>"+
			"<tr><td valign=middle align=center style='font:9pt;font-family:������;background-color:#FFFFFF;color:red;bold:true' >���ڴӷ�������ȡ����,���Ժ�...</td></tr>"+
			"<tr height=30><td valign=middle align=center style='font:9pt;font-family:������;background-color:white;color:black' >"+
			"<a href='javascript:;' onclick='myhide(\""+myname+"\")' style='font:9pt;font-family:������;color:black' >������ȡ����β���</a>"+
			"</td></tr></table></td></tr></table><iframe name='mydwexportall'></iframe></div>";
		document.body.insertAdjacentHTML('afterBegin',sHTML);
	}
	myshow(myname);
	window.open(sWebRootPath+"/Frame/page/dw/GetDWDataAllNew.jsp?CompClientID="+sCompClientID+"&type=export&dw="+DZ[myname.substring(myname.length-1)][0][1]+"&rand="+randomNumber(),'mydwexportall','');
}

var myt=new Object();
function myshow(myname){
   var select_menu = document.all.tags('select');
   for (var i=0; i < select_menu.length;i++)
   select_menu[i].style.display = 'none';
   
   var obj=document.getElementById('div_myd');
   obj.style.visibility='visible';
   obj.style.width=document.body.clientWidth;
   obj.style.height=document.body.clientHeight;
   
   obj.filters.alpha.opacity=60;
   
   return;
}
function myhide(myname){
   var select_menu = document.all.tags('select');
   for (var i=0; i < select_menu.length;i++)
   select_menu[i].style.display = 'block';
   
   var obj=document.getElementById('div_myd');
   if(obj.filters.alpha.opacity<=0){
	   obj.filters.alpha.opacity=0;
	   obj.style.visibility='hidden';
	   clearTimeout(myt.timer2);
	   return;
   }else{
	   obj.filters.alpha.opacity-=15;
	   myt.timer2=setTimeout("myhide('"+myname+"')",10);
   }
   
   return;
}

function checkIsNotEmpty(str){
    if(str.trim() == "")
        return false;
    else
        return true;
}








function myHandleSpecialKey(e, myname,fordebug){
	try{
		var e = window.frames[myname].event || e;
		//F2 �� ctrl+F3
		if(e.keyCode==113 || ( e.ctrlKey && e.keyCode==114) ){
			amarExport(myname); //amarExportNew(myname);	//amarPrint(myname);
			return true;
		}
		if(e.keyCode==119 && e.ctrlKey ){ 	 //CTRL+F8
			amarExportTemplate(myname);
			return true;
		}
		if(fordebug){
			//����as_debug ��as_cache��keydownAction�¼�
			return (keydownAction(e) == true);
		}
	}catch(e){
		alert(e.name+" "+e.number+" :"+e.message); 
		return true;	
	}		
	return false;		
}

//���ڼ�麯��
function isASDate(value,separator){
	if(value==null||value.length<10) return false;
	var sItems = value.split(separator); // value.split("/");

	if (sItems.length!=3) return false;
	if (isNaN(sItems[0])) return false;
	if (isNaN(sItems[1])) return false;
	if (isNaN(sItems[2])) return false;
	//��ݱ���Ϊ4λ���·ݺ��ձ���Ϊ2λ
	if (sItems[0].length!=4) return false;
	if (sItems[1].length!=2) return false;
	if (sItems[2].length!=2) return false;

	if(parseInt(sItems[0],10) == 9999){
		if(parseInt(sItems[1],10) != 12 || parseInt(sItems[2],10) != 31){
			return false;
		}
	}
	if (parseInt(sItems[0],10)<1900 || (parseInt(sItems[0],10) != 9999 && parseInt(sItems[0],10)>2200)) return false;
	if (parseInt(sItems[1],10)<1 || parseInt(sItems[1],10)>12) return false;
	if (parseInt(sItems[2],10)<1 || parseInt(sItems[2],10)>31) return false;

	if ((sItems[1]<=7) && ((sItems[1] % 2)==0) && (sItems[2]>=31)) return false;
	if ((sItems[1]>=8) && ((sItems[1] % 2)==1) && (sItems[2]>=31)) return false;
	//���겻������
	if (!((sItems[0] % 4)==0) && (sItems[1]==2) && (sItems[2]==29)){
		if ((sItems[1]==2) && (sItems[2]==29))
			return false;
	}else{
		if ((sItems[1]==2) && (sItems[2]==30))
			return false;
	}
	return true;
}	

function drawHarbor(myobjname,myact,iDW,iRow_now){
	var docks = new Array();
	for(var iDock=0;iDock<harbors[iDW][2].length;iDock++){
		//boat = getDWControlHtml(myobjname,myact,harbors[iDW][2][iDock][0]);
		boat = arrangeBoats(arrangements,harbors[iDW][2][iDock][0],myobjname,myact,iDW,harbors[iDW][2][iDock][2],harbors[iDW][2][iDock][4],harbors[iDW][2][iDock][5],harbors[iDW][2][iDock][6],harbors[iDW][2][iDock][7],iRow_now);
		docks[iDock] = new Array(harbors[iDW][2][iDock][0],boat);
	}
	//modify by hxd in 2005/07/08 for '
	//return macroReplace(docks,harbors[iDW][1][2],"${DOCK:","}",0,1);
	return macroReplace(docks,amarsoft2Real(harbors[iDW][1][2]),"${DOCK:","}",0,1);
}











function arrangeBoats(docs, docId, myobjname, myact, iDW, width, cols, defaultColspan, defaultColspanForLongType, defaultPosition, iRow){
	var sss = new Array(), jjj = 0;
	sss[jjj++] = "<table id='dztable' cellspacing=0 cellpadding=0 border=0 width='"+width+"'>"+"\r";
	width = parseInt(width.replace("%", ""), 10);
	var iWidth = parseInt(width/cols, 10);
	sss[jjj++] = "<tr>";
	for(var j = 0; j < cols; j++){
		sss[jjj++] = "<td width='"+(iWidth+(j==cols-1?width-iWidth*cols:0))+(width<=100?"%":"")+"'></td>";
	}
	sss[jjj++] = "</tr>";
	
	var leaveCols = cols; // ��������
	for(var iCol = 0; iCol < docs[iDW].length; iCol++){
		if(DZ[iDW][1][iCol][2] == 0) continue;
		if(docs[iDW][iCol][1] != docId) continue;
		
		if(leaveCols == 0) sss[jjj++] = "</tr>";
		
		var position = docs[iDW][iCol][3]; // ռλ��ʶ��FULLROW NEWROW
		var iColspan = parseInt(docs[iDW][iCol][2], 10); // ռ����
		if(position == "FULLROW") iColspan = cols;
		if(isNaN(iColspan) || iColspan < 2){
			if(bFreeFormMultiCol) iColspan = parseInt(cols/2, 10); // ˫��
			else iColspan = cols;
		}else if(iColspan > cols){
			iColspan = cols;
		}
		//alert(DZ[iDW][1][iCol][0]+" "+iColspan);
		if(leaveCols > 0 && leaveCols < cols && (position == "FULLROW" || position == "NEWROW" || iColspan > leaveCols)){
			sss[jjj++] = "<td colspan='"+leaveCols+"' "+hmFFBlankTD+">&nbsp;</td></tr>";
			leaveCols = 0;
		}
		
		if(leaveCols == 0){
			sss[jjj++] = "<tr>";
			leaveCols = cols;
		}
		
		sss[jjj++] = drawInputControl(docs,docId,iColspan,defaultColspanForLongType,myobjname,myact,iDW,iCol,iRow);
		
		leaveCols -= iColspan;
	}
	if(leaveCols > 0) sss[jjj++] = "<td colspan='"+leaveCols+"' "+hmFFBlankTD+">&nbsp;</td>";
	sss[jjj++] = "</tr></table>";
	
	return sss.join("");
}

//modify by xdzhu in 2013/04/02
//change style for adding default style
function _getStyle(DZ10, style){
	if(DZ10.indexOf("style=\"") < 0) return "style=\""+style+"\"";
	else return DZ10.replace("style=\"", "style=\""+style+";");
}
function resetColNameForValidation(colName,inputName){
	colName = colName.toUpperCase();
	if(_user_validator==undefined || _user_validator.length!=2)return;
	//alert(colName+":" + _user_validator[0].rules[colName]);
	if(_user_validator[0].rules[colName]!=undefined){
		_user_validator[1].rules[inputName] = _user_validator[0].rules[colName];
		_user_validator[1].messages[inputName] = _user_validator[0].messages[colName];
	}
}

function MRCheckDate(obj){
	var sDate = obj.value.replace(/\//g,'');
	if(checkDate(sDate)){
		obj.value = sDate.substring(0,4) + "/" + sDate.substring(4,6) + "/" + sDate.substring(6,8);
		
		//��ʱ�������������ڸ�ʽδ���µ����
		var objID = obj.id;
		var iRow = objID.substring(1,objID.indexOf("F"));
		var iCol = objID.substring(objID.indexOf("F")+1);
		setItemValueByIndex(0,iRow,iCol,obj.value);
	}
}










function drawInputControl(myarrangement,myharbors,colspan,defaultColspanForLongType,myobjname,myact,myi,i,j){
	var myobjname = "myiframe"+myi;
	var myobj = window.frames[myobjname];
	var mysss = DZ[myi][1][i][17];
	var sss = new Array(), jjj = 0;
	
	//modify by hxd in 2008/04/10,2007/12/17 for citibank
	//var myS=new Array("","readonly","disabled","readonly"); 
	var myS=new Array("","readonly","disabled","readonly","readonly","disabled",
						"disabled","disabled","readonly","readonly","readonly",
						"readonly","readonly","readonly","readonly","readonly",
						"readonly","readonly","readonly","readonly","readonly","readonly"); 	
	var myR=DZ[myi][0][2]; 
	var myFR,myFS; 
	var myAlign=new Array(""," align=left "," align=center "," align=right ");
	var myAlign2=new Array("","left","center","right");
		
	pagesize[myi]=1;  
	var myevent_num=""; 

	var mysss = DZ[myi][1][i][17];
	// 1. ���滻 <input type='button' tipclick onclick=alert('չʾ��Ϣ') value='��ť����' />
	// 2. �滻���� <input type='button' onclick=alert('ֻ���������޸ģ�') style='display:none;' =parent.as_save(0) value='��ť����' />
	// 3. �滻��һ������ <input type='button' style='width:80px;' onclick=alert('ֻ���������޸ģ�') style='display:none;' =parent.as_save(0) value='��ť����' />
	if(myR==1&&!/tipclick/gi.test(mysss)) // �����׺��û��tipclick���ʣ���ô��׺�еİ�ť����¼����ĵ�������������
		mysss = mysss.replace(/onclick/gi,"onclick=alert('ֻ���������޸ģ�') style='display:none;' "); // �滻��onclick����Ϊ�����׺��ť�б�������style���ԣ�display:none��һ����Ч
	
	var mysMandatorySignal="";
	if(my_notnull[myi][i]==1) mysMandatorySignal=sMandatorySignal;	
	
	var mysTips = "";
	if(DZ[myi][1][i][19]) mysTips = "<span"+hmFFSpanTips+">&nbsp</span><div"+hmFFDivTips+">"+DZ[myi][1][i][19]+"</div>";
	try {    
	if(DZ[myi][1][i][11]==3){ //��ע��
		var sTextareaShowLimit="";
		//����������������ƣ�����ָ����Ҫ��ʾ��(�޸�����)��
		if(bTextareaShowLimit && DZ[myi][1][i][7]>0) sTextareaShowLimit = "(��" + (DZ[myi][1][i][7]/2) +"����)";
		sss[jjj++]=("<td  id=TDR"+j+"F"+i+" "+hmFFTextAreaCaptionTD+">"+DZ[myi][1][i][0]+ sTextareaShowLimit +mysMandatorySignal+mysTips+" </td>");
	} else    
		sss[jjj++]=("<td  id=TDR"+j+"F"+i+" "+hmFFCaptionTD+">"+DZ[myi][1][i][0]+mysMandatorySignal+mysTips+"</td>");
	} catch(e) {}   
	myFS = DZ[myi][1][i][11];  
	sValue = amarMoney(DZ[myi][2][my_index[myi][j]][i],DZ[myi][1][i][12]); 	
	if(myR==1 || (myR==0&&(DZ[myi][1][i][3]==1)) )
		str2=myS[myFS];    
	else
		str2=" ";
	
	if(DZ[myi][1][i][7]==0) str3=" ";			
	else                    str3=" maxlength="+DZ[myi][1][i][7];
	myevent_num=""; 
	
	//modify in 2008/04/10 for bccb number control
	if( DZ[myi][1][i][12]==2 || DZ[myi][1][i][12]==5 || DZ[myi][1][i][12]>10) //��������
		myevent_num="  onblur=parent.myNumberBL(this,'"+myobjname+"') onfocus=parent.myNumberFC(this) onkeypress=parent.myNumberKP(this,event) onkeydown=parent.myNumberKD(this,event) onkeyup=parent.myNumberKU(this,event) onbeforepaste=parent.myNumberBFP(this) "; 
	else {
		myevent_num=" "; 
		if(DZ[myi][1][i][7]>0) //��������ֵ
			myevent_num = " onkeydown=parent.textareaMaxByIndex("+myi+","+j+","+i+") onkeyup=parent.textareaMaxByIndex("+myi+","+j+","+i+") ";
	}

	str3 = str3+myevent_num+ " onblur=parent.trimField(this) ";
	var myCalCheck = "";
	// ���ð�ť�¼�
	var myInnerBtEvent = DZ[myi][1][i][22];
	var onclick = null;
	if(!myInnerBtEvent&&DZ[myi][1][i][12]==3 && DZ[myi][1][i][3]==0){
		myInnerBtEvent = "parent.myShowCalendar('"+myobj.name+"','R"+j+"F"+i+"','dataTable',"+((j-curpage[myi]*pagesize[myi]+1)*(f_c[myi]+1)+i+1)+")";
		onclick = myInnerBtEvent;
		myCalCheck = " onblur='parent.MRCheckDate(this)'";
		//��ӵ��������
		inputDates[inputDates.length] = "R"+j+"F"+i;
	}
	if(myR==1) myInnerBtEvent = "";
	//alert(myFS+"|"+myInnerBtEvent+"|");
	if(DZ[myi][1][i][12]==3 && DZ[myi][1][i][3]==0  )	
		myCale2 = sDateReadonlyColor;
	else				
		myCale2 = " ";
	var htmlStyle = DZ[myi][1][i][10];
	if(!htmlStyle) htmlStyle = "";
	
	if(myFS==1) {	//input
		sss[jjj++] = "<td colspan='"+(colspan-1)+"'  "+hmFFContentTD +" >";
		if(myInnerBtEvent)
			sss[jjj++] = "<span class='inner_bt_span'>";
		sss[jjj++] = "<input "+hmFFContentInput+" ";
		if(onclick&&htmlStyle.search(new RegExp("onclick","gi"))<0){
			sss[jjj++] = "onclick=\""+myInnerBtEvent+"\" ";
		}
		if(DZ[myi][1][i][8]==1) 
			sss[jjj++] = str2+htmlStyle+" type=text " + myCalCheck + myCale2 + " value='"+sValue+"' id=R"+j+"F"+i+" name=R"+j+"F"+i+"  "+str3+" >";
		else
			sss[jjj++] = str2+_getStyle(htmlStyle, "text-align:"+myAlign2[DZ[myi][1][i][8]]+";")+" type=text " + myCalCheck + myCale2 + " value='"+sValue+"' id=R"+j+"F"+i+" name=R"+j+"F"+i+"  "+str3+">";
		if(myInnerBtEvent)
			sss[jjj++] = "<a id=R"+j+"F"+i+"_innerbt onclick=\""+myInnerBtEvent+";return false;\" class='inner_bt_a' href='javascript:void(0);'>...</a></span>";
		sss[jjj++] = mysss+ "<label id=R"+j+"F"+i+"_label for=R"+j+"F"+i+" class='error' generated='true'>" + "</td>";
	}
	if(myFS==10) {	//password
		if(DZ[myi][1][i][8]==1) 
			sss[jjj++] = "<td colspan='"+(colspan-1)+"'  "+hmFFContentTD +" ><input type=password "+hmFFContentInput+" "+str2+htmlStyle+" type=text " + myCale2 + " value='"+sValue+"' name=R"+j+"F"+i+"  "+str3+" >"+mysss+(myInnerBtEvent?(hmDate+" onclick='javascript:"+myInnerBtEvent+";'>"):"")+"</td>";
		else
			sss[jjj++] = "<td colspan='"+(colspan-1)+"'  "+hmFFContentTD +" ><input type=password "+hmFFContentInput+" "+str2+htmlStyle+" type=text " + myCale2 + " value='"+sValue+"' name=R"+j+"F"+i+"  "+str3+" style={text-align:"+myAlign2[DZ[myi][1][i][8]]+";}>"+(myInnerBtEvent?(hmDate+" onclick='javascript:"+myInnerBtEvent+";'>"):"")+mysss+"</td>";
	}	
	if(myFS==3){ 	//textarea
		sss[jjj++] = "<td colspan='"+(colspan-1)+"'  "+hmFFContentTD +" >";
		if(myInnerBtEvent)
			sss[jjj++] = "<span class='inner_bt_span'>";
		sss[jjj++] = "<textarea "+hmFFContentArea+" onchange=parent.textareaMaxByIndex("+myi+","+j+","+i+") onkeydown=parent.textareaMaxByIndex("+myi+","+j+","+i+") onkeyup=parent.textareaMaxByIndex("+myi+","+j+","+i+") type=textfield "+str2+htmlStyle+" id=R"+j+"F"+i+" name=R"+j+"F"+i+" >"+sValue+"</textarea>";
		if(myInnerBtEvent)
			sss[jjj++] = "<a id=R"+j+"F"+i+"_innerbt onclick=\""+myInnerBtEvent+";return false;\" class='inner_bt_a' style='bottom:1px;' href='javascript:void(0);'>...</a></span>";
		sss[jjj++] = mysss+"<label id=R"+j+"F"+i+"_label for=R"+j+"F"+i+" class='error' generated='true'>" + "</td>";
	}
	if(myFS==31){ 	//���ı��༭�� add for rich editor in 2014/09/15
		sss[jjj++] = "<td colspan='"+(colspan-1)+"'  "+hmFFContentTD +" >";
		//if(myInnerBtEvent)
		//	sss[jjj++] = "<span class='inner_bt_span'>";
		sss[jjj++] = "<textarea rich=true "+hmFFContentArea+"  type=textfield "+str2+htmlStyle+" id=R"+j+"F"+i+" name=R"+j+"F"+i+" >"+sValue+"</textarea>";
		//if(myInnerBtEvent)
		//	sss[jjj++] = "<a id=R"+j+"F"+i+"_innerbt onclick=\""+myInnerBtEvent+";return false;\" class='inner_bt_a' style='bottom:1px;' href='javascript:void(0);'>...</a></span>";
		//sss[jjj++] = mysss+"<label id=R"+j+"F"+i+"_label for=R"+j+"F"+i+" class='error' generated='true'>" ;
		sss[jjj++] = "</td>";
	}
	if(myFS==2){ 	//select
		sss[jjj++] = "<td colspan='"+(colspan-1)+"'  "+hmFFContentTD +" ><select "+hmFFContentSelect+" "+str2+htmlStyle+" id=R"+j+"F"+i+" name=R"+j+"F"+i+" value='"+sValue+"' onchange='parent.mE(event,\""+myobj.name+"\");parent.myHandleSelectChangeByIndex("+myi+","+j+","+i+");' >";
		for(var k=0;k<DZ[myi][1][i][20].length/2;k++){
			//if(DZ[myi][1][i][20][2*k]==DZ[myi][2][my_index[myi][j]][i])
			//ת�壬��ֹһЩ�����ַ���չʾ����
			if(DZ[myi][1][i][20][2*k]==amarsoft2Html(DZ[myi][2][my_index[myi][j]][i]))
				sss[jjj++] = "<option value='"+DZ[myi][1][i][20][2*k]+"' selected>"+DZ[myi][1][i][20][2*k+1].replace(/ /g, "&nbsp;")+"</option>";
			else
				sss[jjj++] = "<option value='"+DZ[myi][1][i][20][2*k]+"'>"+DZ[myi][1][i][20][2*k+1].replace(/ /g, "&nbsp;")+"</option>";
		}
		sss[jjj++] =  "</select>"+mysss+ "<label id=R"+j+"F"+i+"_label for=R"+j+"F"+i+" class='error' generated='true'>" + "</td>";
	}
	// FlatSelect ��ƽ����ѡ��
	if(myFS==21){
		sss[jjj++] = "<td colspan='"+(colspan-1)+"'  "+hmFFContentTD +" >";
		if(DZ[myi][1][i][8]==1) 
			sss[jjj++] = "<input "+hmFFContentInput+" "+str2+htmlStyle+" type=text " + myCale2 + " value='"+sValue+"' id=R"+j+"F"+i+" name=R"+j+"F"+i+"  "+" >";
		else
			sss[jjj++] = "<input "+hmFFContentInput+" "+str2+_getStyle(htmlStyle, "text-align:"+myAlign2[DZ[myi][1][i][8]]+";")+" type=text " + myCale2 + " value='"+sValue+"' id=R"+j+"F"+i+" name=R"+j+"F"+i+"  "+">";
		sss[jjj++] = mysss+ "<label id=R"+j+"F"+i+"_label for=R"+j+"F"+i+" class='error' generated='true'>" + "</td>";
		var data = {};
		for(var k=0;k<DZ[myi][1][i][20].length/2;k++){
			if(!DZ[myi][1][i][20][2*k]) continue;
			data[DZ[myi][1][i][20][2*k]] = DZ[myi][1][i][20][2*k+1].replace(/ /g, "&nbsp;");
		}
		setTimeout(function(){
			AsForm.FlatSelect("#R"+j+"F"+i+"", data, 200, function(val){
				setItemValueByIndex(myi, j, i, val);
			}, myobj.document);
		}, 1);
	}

	if(myFS==5||myFS==6){ //radio
		var mybr = "<br>";
		if(myFS==5) mybr="";
		sss[jjj++] = "<td colspan='"+(colspan-1)+"'  "+hmFFContentTD +" >";
		
		/*������ֵ��DZ������DZ[myi][1][i][10]���*/
		var regexp1 = new RegExp("onclick\\s=\\s\"","gi");
		var regexp2 = new RegExp("onclick\\s=\\s","gi");
		if(htmlStyle.search(regexp1) > -1){
			htmlStyle = htmlStyle.replace(regexp1, "onclick=\"document.all('R"+j+"F"+i+"').value=this.value;parent.hC(document.all('R"+j+"F"+i+"'),'"+myobjname+"');");
		}else if(htmlStyle.search(regexp2) > -1){
			htmlStyle = htmlStyle.replace(regexp2, "onclick=document.all('R"+j+"F"+i+"').value=this.value;parent.hC(document.all('R"+j+"F"+i+"'),'"+myobjname+"');");
		}else{
			htmlStyle = htmlStyle + " onclick=\"document.all('R"+j+"F"+i+"').value=this.value;parent.hC(document.all('R"+j+"F"+i+"'),'"+myobjname+"');\"";
		}
		
		for(var k=0;k<DZ[myi][1][i][20].length/2;k++){
			//modify by hxd in 2008/04/10,2007/12/17 for citibank
			//if(DZ[myi][1][i][20][2*k+1]=='') DZ[myi][1][i][20][2*k+1]='(��ѡ��)';
			if(DZ[myi][1][i][20][2*k+1]=='') continue;

			//ע�⣺Radio���ں��棬��Ϊname.indexOf("R")������
			if(DZ[myi][1][i][20][2*k]==amarsoft2Html(DZ[myi][2][my_index[myi][j]][i]))
				sss[jjj++] = "<label for=R"+j+"F"+i+"_"+k+" style='cursor: pointer;'><input "+hmGdTdContentRadio+str2+" "+htmlStyle+" type=radio id=R"+j+"F"+i+"_"+k+" name=R"+j+"F"+i+"_Radio value='"+DZ[myi][1][i][20][2*k]+"' checked " +
						">"+DZ[myi][1][i][20][2*k+1].replace(/ /g, "&nbsp;")+mybr+"</label>";
			else
				sss[jjj++] = "<label for=R"+j+"F"+i+"_"+k+" style='cursor: pointer;'><input "+hmGdTdContentRadio+str2+" "+htmlStyle+" type=radio id=R"+j+"F"+i+"_"+k+" name=R"+j+"F"+i+"_Radio value='"+DZ[myi][1][i][20][2*k]+"' " +
						">"+DZ[myi][1][i][20][2*k+1].replace(/ /g, "&nbsp;")+mybr+"</label>";
		}
		sss[jjj++] = "<input type=hidden id=R"+j+"F"+i+" name=R"+j+"F"+i+" value='"+sValue+"'  >";
		sss[jjj++] =  mysss+ "<label id=R"+j+"F"+i+"_label for=R"+j+"F"+i+" class='error' generated='true'>" + "</td>";
	}
	
	if(myFS==7){ //checkbox
		sss[jjj++] = "<td colspan='"+(colspan-1)+"'  "+hmFFContentTD +" >";
		
		/*������ֵ��DZ������DZ[myi][1][i][10]���*/
		var regexp1 = new RegExp("onclick\\s=\\s\"","gi");
		var regexp2 = new RegExp("onclick\\s=\\s","gi");
		if(htmlStyle.search(regexp1) > -1){
			htmlStyle = htmlStyle.replace(regexp1, "onclick=\"document.all('R"+j+"F"+i+"').value=parent.getCheckboxValue("+j+","+i+",'"+myobjname+"');parent.hC(document.all('R"+j+"F"+i+"'),'"+myobjname+"');");
		}else if(htmlStyle.search(regexp2) > -1){
			htmlStyle = htmlStyle.replace(regexp2, "onclick=document.all('R"+j+"F"+i+"').value=parent.getCheckboxValue("+j+","+i+",'"+myobjname+"');parent.hC(document.all('R"+j+"F"+i+"'),'"+myobjname+"');");
		}else{
			htmlStyle = htmlStyle + " onclick=\"document.all('R"+j+"F"+i+"').value=parent.getCheckboxValue("+j+","+i+",'"+myobjname+"');parent.hC(document.all('R"+j+"F"+i+"'),'"+myobjname+"');\"";
		}
		for(k=0;k<DZ[myi][1][i][20].length/2;k++){
			if(DZ[myi][1][i][20][2*k+1]=='') continue;
			
			if(DZ[myi][2][my_index[myi][j]][i]=='' || 
					!ArrayOfcontains(DZ[myi][2][my_index[myi][j]][i].split(','),DZ[myi][1][i][20][2*k]))
				sss[jjj++] = "<label for=R"+j+"F"+i+"_"+k+" style='cursor: pointer;'><input "+hmGdTdContentRadio+str2+" "+htmlStyle+" type=checkbox id=R"+j+"F"+i+"_"+k+" name=R"+j+"F"+i+"_Checkbox value='"+DZ[myi][1][i][20][2*k]+"' " +
						">"+DZ[myi][1][i][20][2*k+1].replace(/ /g, "&nbsp;")+"</label>";
			else
				sss[jjj++] = "<label for=R"+j+"F"+i+"_"+k+" style='cursor: pointer;'><input "+hmGdTdContentRadio+str2+" "+htmlStyle+" type=checkbox id=R"+j+"F"+i+"_"+k+" name=R"+j+"F"+i+"_Checkbox value='"+DZ[myi][1][i][20][2*k]+"' checked " +
						">"+DZ[myi][1][i][20][2*k+1].replace(/ /g, "&nbsp;")+"</label>";
		}
		sss[jjj++] = "<input type=hidden id=R"+j+"F"+i+" name=R"+j+"F"+i+" value='"+sValue+"'  >";
		sss[jjj++] =  mysss+ "<label id=R"+j+"F"+i+"_label for=R"+j+"F"+i+" class='error' generated='true'>" + "</td>";
	}
	
	//add by hxd in 2005/11/29
	if(myFS==4){ //treeview(ֻ������һ��...��ť)(�Լ�һ�����ص�id)
		var sValue_C = "";
		sValue = DZ[myi][2][my_index[myi][j]][i];
		for(k=0;k<DZ[myi][1][i][20].length/2;k++){
			if(DZ[myi][1][i][20][2*k]==sValue)
				sValue_C = DZ[myi][1][i][20][2*k+1].replace(/ /g, "&nbsp;");
		}
		if(!myInnerBtEvent)
			myInnerBtEvent = "parent.popSelectWin('"+DZ[myi][1][i][21]+"',"+myi+","+j+","+i+")";
		else
			mysss = "<input class=inputdate type=button value=\"...\" onclick=parent.popSelectWin('"+DZ[myi][1][i][21]+"',"+myi+","+j+","+i+")>"+mysss;
		sss[jjj++] = "<td colspan='"+(colspan-1)+"'  "+hmFFContentTD +" ><span class='inner_bt_span'>";
		sss[jjj++] = "<input "+hmFFContentInput+" "+str2+htmlStyle+" type=text " + myCale2 + " value='"+sValue_C+"' name=R"+j+"F"+i+"_C  "+str3+" style={text-align:"+myAlign2[DZ[myi][1][i][8]]+";} readonly ><input type=hidden id=R"+j+"F"+i+" name=R"+j+"F"+i+" value='"+sValue+"' >";
		sss[jjj++] = "<a id=R"+j+"F"+i+"_innerbt onclick=\""+myInnerBtEvent+";return false;\" class='inner_bt_a' href='javascript:void(0);'>...</a>";
		sss[jjj++] = "</span>"+mysss+"<label id=R"+j+"F"+i+"_label for=R"+j+"F"+i+" class='error' generated='true'>" +"</td>";
	}

	if(myFS==8) {	//PopSelect
		sss[jjj++] = "<td colspan='"+(colspan-1)+"'  "+hmFFContentTD +" >";
		if(myInnerBtEvent) 
			sss[jjj++] = "<span class='inner_bt_span'>";
		if(DZ[myi][1][i][8]==1) 
			sss[jjj++] = "<input "+hmFFContentInput+" type=text " + myCale2 + " value='"+sValue+"' id=R"+j+"F"+i+" name=R"+j+"F"+i+"  "+str3+" "+str2+htmlStyle+" >";
		else
			sss[jjj++] = "<input "+hmFFContentInput+" type=text " + myCale2 + " value='"+sValue+"' id=R"+j+"F"+i+" name=R"+j+"F"+i+"  "+str3+" "+str2+_getStyle(htmlStyle, "text-align:"+myAlign2[DZ[myi][1][i][8]]+";")+" >";
		if(myInnerBtEvent)
			sss[jjj++] = "<a id=R"+j+"F"+i+"_innerbt onclick=\""+myInnerBtEvent+";return false;\" class='inner_bt_a' href='javascript:void(0);'>...</a></span>";
		sss[jjj++] = mysss+"<label id=R"+j+"F"+i+"_label for=R"+j+"F"+i+" class='error' generated='true'>" + "</td>";
	}
	
	//add by hxd in 2008/04/10,2007/12/17 for citibank
	if(myFS==9){ 	//flat_dropdown
		sss[jjj++] = "<td colspan='"+(colspan-1)+"'  "+hmFFContentTD +" >"+
			"<input "+hmFFContentInput+" "+str2+_getStyle(htmlStyle, "overflow-x: visible; width: 60px;")+" type=text " + myCale2 + 
			" value='"+sValue+"' id=R"+j+"F"+i+" name=R"+j+"F"+i+"  "+str3+
			" onblur='parent.mySelectBL(this,"+myi+","+j+","+i+")' >"+
			" <span id=spanR"+j+"F"+i+">"+myGetDDValue(myi,i,sValue)+"</span> "+
			mysss+ "<label id=R"+j+"F"+i+"_label for=R"+j+"F"+i+" class='error' generated='true'>" + "</td>";
	}
	resetColNameForValidation(DZ[myi][1][i][15],"R"+j+"F"+i);
	return sss.join("");
}

function ArrayOfcontains(aArray,element){
	for(var i=0;i<aArray.length;i++){
		if(aArray[i]==element) return true;
	}
	return false;
}

function getCheckboxValue(iRow,iCol,objname){
	var tempS = '';
	var boxs = window.frames[objname].document.forms[0].elements["R"+iRow+"F"+iCol+"_Checkbox"];
	for(var i=0;i<boxs.length;i++) {
		if(!boxs[i].checked) continue;
		if(tempS=='')
			tempS = tempS.concat(boxs[i].value);
		else if(tempS.length>0)
			tempS = tempS.concat(',',boxs[i].value);
	}
	return tempS;
}

//add by hxd in 2008/04/10,2007/12/17 for citibank 
//modify by hxd in 2008/03/04 for only one-radio 
//��ѡ������������radio button)����������ȥ��δѡ�� 
function emptyRadio(iDW,iRow,sCol) { 
	var iCol=getColIndex(iDW,sCol); 
	
	if(typeof(window.frames["myiframe"+iDW].document.all['R'+iRow+'F'+iCol+"_Radio"].length)=="undefined") 
		window.frames["myiframe"+iDW].document.all['R'+iRow+'F'+iCol+"_Radio"].checked=false; 
	else { 
		var ii=0; 
		for(ii=0;ii<window.frames["myiframe"+iDW].document.all['R'+iRow+'F'+iCol+"_Radio"].length;ii++){ 
			window.frames["myiframe"+iDW].document.all['R'+iRow+'F'+iCol+"_Radio"][ii].checked = false; 
		} 
	} 
	setItemValue(iDW,iRow,sCol,""); 
} 

//add by hxd in 2008/04/10,2007/12/17 for citibank
function myGetDDValue(iDW,iField,sValue){
	var myi=iDW;
	var i=iField;
	var k=0;
	var bFind = false;
	for(k=0;k<DZ[myi][1][i][20].length/2;k++){
		if(DZ[myi][1][i][20][2*k]==sValue){
			bFind = true;
			break;
		}			
	}
	if(!bFind)
		return "";
	else
		return DZ[myi][1][i][20][2*k+1].replace(/ /g, "&nbsp;");
}

//add by hxd in 2008/04/10,2007/12/17 for citibank
//����ѡ�񡣡��������������������򣬵�Ҫ����Ϸ��ԡ�
function mySelectBL(myobj,iDW,iRow,iField){
	var myi=iDW;
	var i=iField;
	var k=0;
	//try {
	var bFind = false;
	for(k=0;k<DZ[myi][1][i][20].length/2;k++){
		if(DZ[myi][1][i][20][2*k]==myobj.value){
			bFind = true;
			break;
		}			
	}
	if(!bFind){
		alert("������["+DZ[myi][1][i][0]+"]��������������!");
		if(my_notnull[myi][i]==1)//�����������ģ����ֽ���
			myobj.select(); 
		else //�����������
		{
			setItemValueByIndex(iDW,iRow,iField,"");
			myobj.value = "";
			window.frames["myiframe"+myi].document.getElementById("spanR"+iRow+"F"+iField).innerHTML = "";
		}
	}else{
		//�ں�����ʾ�ô����Ӧ������
		window.frames["myiframe"+myi].document.getElementById("spanR"+iRow+"F"+iField).innerHTML = DZ[myi][1][i][20][2*k+1].replace(/ /g, "&nbsp;") ;
	}
	//}	
	//catch(E){var a=1;}
}

//add by hxd in 2005/11/29
function popSelectWin(sArgPopSource,iArgDW,iArgRow,iArgCol){
	var sPopSource = sArgPopSource;
	var vPop = sPopSource.split(":");
	
	if(vPop[0]!="Code") return;
	var myCode = vPop[1];
	
	//sObjectType����������
	//iArgDW: �ڼ���DW��Ĭ��Ϊ0
	//iArgRow: �ڼ��У�Ĭ��Ϊ0
	var sObjectType,sParaString,sStyle;

	sObjectType = "SelectCode";
	sParaString = "CodeNo"+","+myCode;
	sStyle = "dialogWidth:700px;dialogHeight:540px;resizable:yes;scrollbars:no;status:no;help:no";

	var iDW = iArgDW;
	if(iDW == null) iDW=0;
	var iRow = iArgRow;
	if(iRow == null) iRow=0;
	var iCol = iArgCol;
	if(iCol == null) iCol=0;
	
	var sObjectNoString = selectObjectValue(sObjectType,sParaString,sStyle);
		
	if(typeof(sObjectNoString)=="undefined" ){
		return;	
	}else if(sObjectNoString=="_CANCEL_"  ){
		return;
	}else if(sObjectNoString=="_CLEAR_"){
		setItemValueByIndex(iDW,iRow,iCol,"");

		var objp = window.frames["myiframe"+iDW];
		var itemname = "R"+iRow+"F"+iCol+"_C";
		objp.document.forms[0].elements[itemname].value="";
	}else if(sObjectNoString!="_NONE_" && sObjectNoString!="undefined"){
		var sObjectNos = sObjectNoString.split("@");
		
		setItemValueByIndex(iDW,iRow,iCol,sObjectNos[0]);

		var objp = window.frames["myiframe"+iDW];
		var itemname = "R"+iRow+"F"+iCol+"_C";
		objp.document.forms[0].elements[itemname].value=sObjectNos[1];
	}else{
		//alert("ѡȡ������ʧ�ܣ��������ͣ�"+sObjectType);
		return;
	}

	return sObjectNoString;
}

function MR2_head(myobjname,myact){
	var myi=myobjname.substring(myobjname.length-1);
	var sss=new Array(),jjj=0;
	sss[jjj++]=("<head>");
	sss[jjj++]=(sContentType);
	if(DZ[myi][0][0]==1){
		sss[jjj++]=("<link href='"+dwCSSPath+"style_dw.css' rel=stylesheet>");
		sss[jjj++]=("<link href='"+sWebRootPath+sSkinPath+"/css/style_dw.css' rel=stylesheet>");
	}else{
		sss[jjj++]=("<link href='"+dwCSSPath+"style_ff.css' rel=stylesheet>");
		sss[jjj++]=("<link href='"+sWebRootPath+sSkinPath+"/css/style_ff.css' rel=stylesheet>");
	}
	sss[jjj++]=("</head>");
	
	return sss.join('');
}

function MR2_body(myobjname,myact){
	_user_validator[1] = new Object();
	_user_validator[1].rules = new Object();
	_user_validator[1].messages = new Object();
	
	var myobj=window.frames[myobjname];
	var myi=myobj.name.substring(myobj.name.length-1);
	var curPP=0;
	if(myact==5) curPP=0;//myobj.document.forms[0].elements["txtJump"].value;
	
	var sss=new Array(),jjj=0;
	sss[jjj++]=("<body oncontextmenu='self.event.returnValue=false' onmousedown='parent.mE(event,\""+myobj.name+"\");' onKeyDown='parent.kD(event,\""+myobj.name+"\")' onKeyUp='parent.kU(event,\""+myobj.name+"\")'>");
	sss[jjj++]=("<div style={position:absolute;width:100%;height:100;overflow: auto;}>");
	if(bNeedCA) 
		sss[jjj++]=(" <object id=doit style='display:none' classid='CLSID:8BE89452-A144-49BC-9643-A3D436D83241' border=0 width=0 height=0></object>  ");
	sss[jjj++]=("<form id='form1' name='form1' class='ffform'>");

	switch(myact){
		case 1:
			curpage[myi]=0;
			break;
		case 2:
			if(curpage[myi]>0) curpage[myi]--;
			break;
		case 3:
			if(curpage[myi]<rr_c[myi]-1) curpage[myi]++;
			break;
		case 4:
			curpage[myi]=rr_c[myi]-1;
			break;				
		case 5:
			curpage[myi]=curPP-1;
			if(curpage[myi]<0) curpage[myi]=0;
			if(curpage[myi]>rr_c[myi]-1) curpage[myi]=rr_c[myi]-1;			
			break;				
	};
		
	sss[jjj++]=("<span style='font-size: 9pt;display:none'>");
	sss[jjj++]=("<a href='javascript:parent.MR2(\""+myobjname+"\",1)'>�ױ�</a> <a href='javascript:parent.MR2(\""+myobjname+"\",2)'>ǰһ��</a> <a href='javascript:parent.MR2(\""+myobjname+"\",3)'>��һ��</a> <a href='javascript:parent.MR2(\""+myobjname+"\",4)'>β��</a> <br>");
	sss[jjj++]=("����&nbsp;"+rr_c[myi]+"&nbsp;����¼����ǰΪ��&nbsp;"+(curpage[myi]+1)+"&nbsp;����¼<br>");
	sss[jjj++]=("&nbsp;&nbsp;����&nbsp;<input type=text name=txtJump style='FONT-SIZE: 9pt;border-style:groove;text-align:center;width:30pt;height:13pt' size=1 onkeydown='javascript:parent.MRK2(\""+myobjname+"\",5)'>&nbsp;��");
	sss[jjj++]=("</span>");

	pagesize[myi]=1;  
	
	if(rr_c[myi]>0){
		for(var j=curpage[myi]*pagesize[myi];j<=curpage[myi]*pagesize[myi];j++){
			iCurRow = j; 
	     	
			//modify by hxd in 2005/07/08 for '
			//sss[jjj++] = amarsoft2Real(drawHarbor(myobjname,myact,myi,j));
			sss[jjj++] = amarsoft2Html(drawHarbor(myobjname,myact,myi,j));
		}
	}

	sss[jjj++]=("</form>");
	sss[jjj++]=("</div>");
	sss[jjj++]=("</body>");
	return sss.join('');			
}

function MR2(myobjname,myact){
	var myoldstatus = window.status;  
	window.status="����׼�����ݣ����Ժ�....";  

	var myobj=window.frames[myobjname];
	var myi=myobj.name.substring(myobj.name.length-1);
	myLastCB(cur_frame,cur_sel_item[cur_frame.substring(cur_frame.length-1)]);
	cur_sel_rec[myi]=-1;		
	cur_sel_item[myi]="";		

	myobj.document.writeln("<script type='text/javascript'>");
	myobj.document.writeln("window.history.forward(1);");
	myobj.document.writeln("</script>");
//	myobj.document.clear();	
	myobj.document.close();
	
	var sss=new Array(),jjj=0;
	sss[jjj++]=("<html>");
	sss[jjj++]=MR2_head(myobjname,myact);
	sss[jjj++]=MR2_body(myobjname,myact);
	sss[jjj++]=("</html>");

	//modify by hxd in 2005/07/08 for '
	//myobj.document.writeln(amarsoft2Html(sss.join('')));		
	myobj.document.writeln((sss.join('')));		
	myobj.document.close();		
		
	window.status="Ready";  
	window.status=myoldstatus;  
	
	//������У�� fian 2014/05/20
	//alert(inputDates.length);
	$(myobj.document).ready(function(event){
		//alert("inputDates.length="+inputDates.length);
		for(var kk=0;kk<inputDates.length;kk++){
			var sInputName = inputDates[kk];
			//alert($("#"+sName,myobj.document));
			//$("#"+sName,myobj.document).rules("add",{date : true,messages:{date:"��������ȷ�����ڸ�ʽ,���磺2014/01/01"}});
			try{
				$("#"+sInputName,myobj.document).rules("add",{date0 : true,messages:{date0:"��������ȷ�����ڸ�ʽ,���磺2014/01/01"}});
			}
			catch(e){
				var rules = _user_validator[1].rules;
				var messages = _user_validator[1].messages;
				if(!rules[sInputName])rules[sInputName] = new Object();
				if(!rules[sInputName].date0){
					rules[sInputName].date0 = true;
					if(!messages[sInputName]) messages[sInputName] = new Object();
					messages[sInputName].date0="��������ȷ�����ڸ�ʽ,���磺2014/01/01";
				}
			}
			
		}
	});
	
	myAfterLoadFreeForm(myi);
}

function MR2_add(myobjname,myact){
	var myoldstatus = window.status;  
	window.status="����׼�����ݣ����Ժ�....";  
	var myobj=window.frames[myobjname];
	var myi=myobj.name.substring(myobj.name.length-1);

	if(navigator.appName=="Netscape")
		myobj.document.body.outerHTML = MR2_body(myobjname,myact);
	else{
		myobj.document.write("");
		myobj.document.close();
		
		var sss=new Array(),jjj=0;
		sss[jjj++]=("<html>");
		sss[jjj++]=MR2_head(myobjname,myact);
		sss[jjj++]=MR2_body(myobjname,myact);
		sss[jjj++]=("</html>");

		//modify by hxd in 2005/07/08 for '
		//myobj.document.writeln(amarsoft2Html(sss.join('')));		
		myobj.document.writeln((sss.join('')));		
		myobj.document.close();		
	}
			
	window.status="Ready";  
	window.status=myoldstatus;  
	myAfterLoadFreeForm(myi);
}

//��my_load_s ��my_load_show_s ��ȡ����������
function getDWDataSort(my_sortorder,sort_which,myobjname,need_change){
	if(my_sortorder==1)   
		my_sortorder=0;  //(��)
	else if(my_sortorder==0)  
		my_sortorder=1;  //(��)
	else if(my_sortorder==2)  
		my_sortorder=0;
	
	var myi=myobjname.substring(myobjname.length-1);
	
	var myoldstatus = window.status;
	window.status="���ڴӷ�����������ݣ����Ժ�....";
	var sPageURL = sWebRootPath+"/Frame/page/dw/GetDWDataSort.jsp?dw="+DZ[myi][0][1]+"&pg=0&sortfield="+DZ[myi][1][sort_which][15]+"&sortorder="+my_sortorder;
	var script = $.ajax({url: sPageURL,async: false}).responseText.trim();
	script = replaceAll(replaceAll(script, "<script type=\"text/javascript\">", ""), "</script>", "");
	eval(script);
	
	window.status=myoldstatus;
	  
	init(false);
	needReComputeIndex[myi]=0;
}

//add by hxd in 2008/04/10 for sort
function my_load_s(my_sortorder,sort_which,myobjname,need_change){
	var my_sortorder_old = my_sortorder;		
	getDWDataSort(my_sortorder,sort_which,myobjname,need_change);
	
	my_load(my_sortorder_old,sort_which,myobjname,need_change);	  //��Ϊ my_load������sortת��
}
function my_toggle_n(obj){
	var group = obj.nextSibling;
	if(group.style.display == "none"){
		group.style.display = "";
		$(".icon", obj).removeClass("collapse");
	}
	else{
		group.style.display = "none";
		$(".icon", obj).addClass("collapse");
	}
}

//add by hxd in 2008/04/10 for sort
function my_load_show_s(my_sortorder,sort_which,myobjname){
	var my_sortorder_old = my_sortorder;		
	getDWDataSort(my_sortorder,sort_which,myobjname,true);
	
	my_load_show(my_sortorder_old,sort_which,myobjname);
}

//add by hxd in 2008/04/10 for vI_all(check)
function check6789(iEditStyle,sValue){
	return true;
}

function amarValue(sMoney,iType){
	if (sMoney==null || typeof(sMoney)=='undefined') return "";
	//modify in 2008/04/10 for ��λС��
	//if(iType!=2 && iType!=5 )
	if(iType!=2 && iType!=5 && iType<=10)
		return sMoney;
	else{
		//modify in 2008/04/10 for ��λС��
		//if(iType==2)
		if(iType==2 || iType>10){
			if(isNaN(parseFloat(sMoney.replace(/,/g,"")))) return "";
			else return parseFloat(sMoney.replace(/,/g,""));
		}
		if(iType==5){
			if(isNaN(parseInt(sMoney.replace(/,/g,""), 10))) return "";
			else return parseInt(sMoney.replace(/,/g,""), 10);
		}
	}
}

//��(���)��������ת������λһС������ʾ��ʽ������������λ�� <=11 ʱ��С������   >=6λ������λԽ�٣�С������Խ�ߣ�
function amarMoney(dMoney,iType){  //dMoney:��Ҫת���Ľ� iType:ת�����С��λ��
    if (dMoney==null || (dMoney==""&&dMoney!=0) || typeof(dMoney)=='undefined') return "";
    if(parseInt(iType,10)!=2 && parseInt(iType,10)!=5 && parseInt(iType,10)<11 ) return dMoney;
    else{
        if(parseInt(iType,10)>10)  iType=parseInt(iType,10)-10;
        else if(parseInt(iType,10)==5)  iType=0;

        if(dMoney==""){
            if( ("amar"+dMoney)=="amar") return "";
            else dMoney=0.00;
        }
        else
        	dMoney = parseFloat(dMoney,10);
        if(isNaN(dMoney)) dMoney=0.00;
        
        //modified by btan 2011/02/14
        //�������������������Ľ��Ϊ0������Ҫ����ڵ���6ʱ��������������Կ�ѧ��������ʾ������ת������
		if(dMoney == 0){
			var sReturnValue = "0";
			for(var p=0; p<iType; p++){
				if(p==0) sReturnValue = "0.";
				sReturnValue += "0";
			}
			return sReturnValue;  //���� 0.000000
		}
        
        var sMoney="",i,sTemp="",itemCount,iLength,digit=3,sign="",s1="",s2="",sResultSet="";
        
        //��ʾ����������ԭ���������С��λ��(iType)����һλ������������������
        var myFraction = 0.5;  //�������� ��ֻ����С����
			for(var ij=1;ij<=iType;ij++)
				myFraction *= 0.1;

        if(dMoney < 0){
            sign = "-";  //����λ
            dMoney = dMoney - myFraction;  //�������һλ
            sMoney = dMoney.toString().substring(1); //��ȥ����λ
        }else{
        	dMoney = dMoney + myFraction;
        	sMoney = dMoney.toString();
        }
        
        //�ֳ��������ֺ�С������
        if(sMoney.indexOf(".")>-1){
        	s1 = sMoney.substring(0, sMoney.indexOf("."));  //��������
        	s2 = sMoney.substring(sMoney.indexOf(".")+1, sMoney.indexOf(".")+1+iType);  //С������
        }else{
        	s1 = sMoney;
        	for(var p=0; p<iType; p++){
        		s2 += "0";
			}
        }
       
        //��λһС��
        iLength = s1.length;  //�������ֵĳ��ȣ�λ����
        itemCount = parseInt((iLength-1)/digit, 10) ;    //�����������ֵ���ʾ����    
        for (i=0;i<itemCount;i++){
            sTemp = ","+s1.substring(iLength-digit*(i+1),iLength-digit*i)+sTemp;
        }
        
        //���������������������ʾģʽ������λ+û�н�ȡ��������߼�λ+��������λ��
        sResultSet = sign+s1.substring(0,iLength-digit*i)+sTemp;       
       
        //����С������
        if(iType!=0)    sResultSet = sResultSet + "." + s2;    
       
        return sResultSet;
    }
}

function beforeInit(bSetPageSize){
	var i = 0, j = 0;
	for(i=0;i<DZ.length;i++) {
		my_notnull_temp[i] = new Array();
		for(j=0;j<f_c[i];j++)
			my_notnull_temp[i][j] = DZ[i][1][j][4];
	}
		
	return true;
}

function beforeInit_show(bSetPageSize){
	var i = 0, j = 0;
	for(i=0;i<DZ.length;i++) {
		my_notnull[i] = new Array();
		for(j=0;j<f_c[i];j++)
			my_notnull_temp[i][j] = DZ[i][1][j][4];
	}
		
	return true;
}

//����trimField���� 
function trimField(myobj){
	myobj.value=myobj.value.replace(/(^[\s]*)|([\s]*$)/g, "");
}

function beforeMRK1(myobjname,myact,my_sortorder,sort_which){
	return true;
}

function beforeMR1(myobjname,myact,my_sortorder,sort_which,need_change){
	return true;
}

function beforeMRK2(myobjname,myact){
	return true;
}

function beforeMy_load(my_sortorder,sort_which,myobjname,need_change){
	return true;
}

function beforeMy_load_show_action(myobjname,myact,my_sortorder,sort_which){
	return true;
}

function beforeMy_load_show(my_sortorder,sort_which,myobjname){
	return true;
}

function beforeSR(lastRec,iRec,myname){
	return true;
}

function beforeCSS(iRec,myname){
	return true;
}

function beforeSR_show(lastRec,iRec,myname){
	return true;
}

function beforeMyLastCB(myframename,curItemName){
	return true;
}

function beforeHC(obj,objpname){
	return true;
}

function beforeVI(obj,objpname){
	return true;
}

function beforeAsAdd(objname){
	return true;
}

function beforeAsDel(objname){
	return true;
}

function beforeVIAll(objpname){
	return true;
}

function beforeAsSave(objname,afteraction,aftertarget,afterprop){
	//add for rich editor in 2014/09/12
	setTextAreaForIframe(objname);
	
	if(!vI_all(objname))
		return false;
	else{
		ShowMessage("ϵͳ���ڴ������ݣ���ȴ�...",true,false);
		return true;
	}
}

//add for rich editor in 2014/09/12
function setTextAreaForIframe(sIFrameName){
	var myi=sIFrameName.substring(sIFrameName.length-1);
	if( DZ[myi][0][0]==1 ) return;
	
	for(var instance in window.frames[sIFrameName].CKEDITOR.instances){
		var dataHtml= window.frames[sIFrameName].CKEDITOR.instances[instance].getData(); 
		if(!dataHtml) dataHtml = "";
		//dataHtml = dataHtml.replace(/\(/g, "&#40;").replace(/\)/g, "&#41;").replace(/\</g, "&#60;").replace(/\>/g, "&#62;").replace(/\+/g, "&#43;");
		dataHtml = dataHtml.replace(/\'/g, "&#39;");
		
		var dataTextarea  = window.frames[sIFrameName].CKEDITOR.instances[instance].element.getValue();

		//ȥ��dataHtmlβ�͵Ļس�(%0A,\n) ���Լ��������� %0A��� %0D%0A
		var dataHtml0 = dataHtml;
		if( dataHtml0.substring(dataHtml.length-1)=="\n" ) dataHtml0 = dataHtml0.substring(0,dataHtml.length-1);
		dataHtml0 = dataHtml0.replace(/\n/g,"\r\n");

		var dataTextarea0 = dataTextarea.replace(/\'/g, "&#39;");
		if(dataHtml0 != dataTextarea0 ) {
			//alert("��"+dataHtml0+"��\r\n"+"��"+dataTextarea0+"��\r\n"+"��"+encodeURI(dataHtml0)+"��\r\n"+"��"+encodeURI(dataTextarea0)+"��");
			//window.frames[sIFrameName].CKEDITOR.instances[instance].element.setValue(dataHtml);
			var curItemName = window.frames[sIFrameName].CKEDITOR.instances[instance].name;
			iBegin=curItemName.indexOf("R");
			iEnd=curItemName.indexOf("F");
			iRec=parseInt(curItemName.substring(iBegin+1,iEnd));
			iField=parseInt(curItemName.substring(iEnd+1));
			
			// setValue
			setItemValueByIndex(0,iRec,iField,dataHtml0);				
		}
	}
}

function beforeMR1S(myobjname,myact,my_sortorder,sort_which,need_change){
	return true;
}

function before_my_load_show_action_s(myobjname,myact,my_sortorder,sort_which){
	return true;
}

function beforeMyLoadSave(my_sortorder,sort_which,myobjname){
	return true;
}

function beforeAsSaveResult(myobjname){
	return true;
}

function beforeIsModified(objname){
	return true;
}

function beforeCloseCheck(){
	return true;
}

function beforeSetPageSize(i,iSize){
	return true;
}

function setNoCheckRequired(iDw){
	SAVE_TMP=true;
	for(var i=0;i<f_c[iDw];i++) {
		//my_notnull_temp[iDw][i] = my_notnull[iDw][i];
		my_notnull[iDw][i] = 0;
	}
}

function setNeedCheckRequired(iDw){
	SAVE_TMP=false;
	for(var i=0;i<f_c[iDw];i++) 
		my_notnull[iDw][i] = DZ[iDw][1][i][4];
}


function setItemCaption(iDW,iRow,iCol,sValue){
	try {  
		var mysMandatorySignal="";
		if(my_notnull[iDW][iCol]==1) mysMandatorySignal=sMandatorySignal;	
		
		var obj; 
		obj = window.frames["myiframe"+iDW].document.getElementById("TDR"+iRow+"F"+iCol);
		if(DZ[iDW][1][iCol][11]==3){ 
			var sTextareaShowLimit="";
			//����������������ƣ�����ָ����Ҫ��ʾ��(�޸�����)��
			if(bTextareaShowLimit && DZ[iDW][1][iCol][7]>0) sTextareaShowLimit = "(��" + (DZ[iDW][1][iCol][7]/2) +"������)";
			obj.innerHTML = sValue + sTextareaShowLimit +mysMandatorySignal;
		} else 
			obj.innerHTML = sValue + mysMandatorySignal;
	} catch(e) {}   
} 

function showItemInnerBt(iDW,iRow,sItemName,bShow){
	var iCol = getColIndex(iDW,sItemName);
	var innerBt = window.frames["myiframe"+iDW].document.getElementById("R"+iRow+"F"+iCol+"_innerbt");
	if(!innerBt) return false;
	if(bShow == false){
		$(innerBt).parent().removeClass("inner_bt_span");
		return true;
	}else if(bShow == true){
		$(innerBt).parent().addClass("inner_bt_span");
		return true;
	}else{
		return false;
	}
}

function hideItemInnerBt(iDW,iRow,sItemName){
	return showItemInnerBt(iDW,iRow,sItemName,false);
}








function setItemRequired(iDW,iRow,sItemName,bRequired){
	var iCol = getColIndex(iDW,sItemName);
	if(bRequired)
		my_notnull[iDW][iCol] = 1;
	else
		my_notnull[iDW][iCol] = 0;
	setItemCaption(iDW,iRow,iCol,DZ[iDW][1][iCol][0]);
	//����Ϊ�޸�У�����Ĵ���  begin----------------------------------
	var sInputName = "R"+iRow+"F"+iCol;
	sItemName = sItemName.toUpperCase();
	if(bRequired){
		if(_user_validator.length>1){//infoģʽ
			try{
				$("#"+sInputName,frames["myiframe0"].document).rules("add",{required0 : true,messages:{required0:"������"+DZ[iDW][1][iCol][0]}});
			}
			catch(e){
				var rules = _user_validator[1].rules;
				var messages = _user_validator[1].messages;
				if(!rules[sInputName])rules[sInputName] = new Object();
				if(!rules[sInputName].required0){
					rules[sInputName].required0 = true;
					if(!messages[sInputName]) messages[sInputName] = new Object();
					messages[sInputName].required0="������"+DZ[iDW][1][iCol][0];
				}
			}
		}else{//listģʽ
			var rules = _user_validator[0].rules;
			var messages = _user_validator[0].messages;
			if(!rules[sItemName])rules[sItemName] = new Object();
			if(!rules[sItemName].required0){
				rules[sItemName].required0 = true;
				if(!messages[sItemName]) messages[sItemName] = new Object();
				messages[sItemName].required0="������"+DZ[iDW][1][iCol][0];
			}
		}
	}else{
		if(_user_validator.length>1){//infoģʽ
			try{
				$("#"+sInputName,frames["myiframe0"].document).rules("remove","required0");
			}
			catch(e){
				_user_validator[1].rules[sInputName] = undefined;
				_user_validator[1].messages[sInputName] = undefined;
			}
			
		}else{//listģʽ
			_user_validator[0].rules[sItemName] = undefined;
			_user_validator[0].messages[sItemName] = undefined;
		}
	}
	//�޸�У�����Ĵ���  end----------------------------------
}








function setItemHeader(iDW,iRow,sItemName,sHeader){
		var iCol = getColIndex(iDW,sItemName);
		setItemCaption(iDW,iRow,iCol,sHeader);
}









function getItemHeader(iDW,iRow,sItemName,sHeader){
	var iCol = getColIndex(iDW,sItemName);
	var obj = window.frames["myiframe"+iDW].document.getElementById("TDR"+iRow+"F"+iCol);
	return obj.innerHTML.toLowerCase().replace(/\"/g,'').replace(sMandatorySignal,'');
}
function _showTips(doc, span, e){
	if(!span) return;
	var $div = $(span, doc).next();
	$div.css({
		"left":e.clientX + 16,
		"top":e.clientY - 16 + $(doc.body).scrollTop()
	}).show();
	
	$(span, doc).bind("mouseleave", function(){
		$(this).unbind("mouseleave");
		$div.hide();
	});
}

//DWʹ�ã���˴�common.js�ƹ���
//add by hxd in 2008/04/10 
function reloadCurrentRow(_iDW,_iTempCurrRow){
	var iDW=0;
	var iTempCurrRow=0;
	
	if(arguments.length==0){
		iDW = 0;
		iTempCurrRow = getRow(0);
	}
	if(arguments.length==1){
		iDW = _iDW ;
		iTempCurrRow = getRow(iDW);
	}
	if(arguments.length==2){
		iDW = _iDW ;
		iTempCurrRow = _iTempCurrow;
	}
	
	var bHaveKey = false;
	var ii=0,mycond=""; 
	mycond = "dw="+DZ[iDW][0][1]+"&row="+iTempCurrRow;
	
	for(ii=0;ii<f_c[iDW];ii++){
		if(DZ[iDW][1][ii][1]==1){
			bHaveKey = true;
			mycond = mycond+"&col"+ii+"="+real2Amarsoft(DZ[iDW][2][iTempCurrRow][ii]);
		}
	}
	
	if(!bHaveKey){
		alert("��DW����û�ж������������ܶ�̬���£�");
		return;
	}

	var myoldstatus = window.status;   
	window.status="���ڴӷ�����������ݸ��µ�ǰ��¼�����Ժ�....";   
	self.showModalDialog(sWebRootPath+"/Frame/page/dw/GetDWCurrRow.jsp?"+mycond+"&rand="+amarRand(),window.self,
		"dialogWidth=10;dialogHeight=1;status:no;center:yes;help:no;minimize:yes;maximize:no;border:thin;statusbar:no"); 
	window.status=myoldstatus; 
	   
	for(ii=0;ii<f_c[iDW];ii++){
		try {
			setItemValue(iDW,iTempCurrRow,DZ[iDW][1][ii][15],DZ[iDW][2][iTempCurrRow][ii]);
		}catch(e){}
	}	
}