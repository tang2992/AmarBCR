<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><% 
	/*
		Describe: �ͻ����񱨱��б�
	 */
	//�������������ͻ�����
	String sCustomerID =  CurPage.getParameter("CustomerID");

	ASObjectModel doTemp = new ASObjectModel("CustomerFSList");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����ΪGrid���
	dwTemp.ReadOnly = "1"; //����Ϊֻ��
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow(sCustomerID);
	
	String sButtons[][] = {
		{"true","","Button","��������","�����ͻ�һ�ڲ��񱨱�","AddNewFS()","","","",""},
		{"false","","Button","����˵��","�޸Ŀͻ�һ�ڲ��񱨱������Ϣ","FSDescribe()","","","",""},
		{"true","","Button","��������","�鿴���ڱ������ϸ��Ϣ","FSDetail()","","","",""},
		{"true","","Button","��������","�������ڱ���","FSExport()","","","",""},
		{"true","","Button","���뱨��","���뱨��","FSImport()","","","",""},
		{"true","","Button","�޸ı�������","�޸ı�������","ModifyReportDate()","","","",""},
		{"true","","Button","ɾ������","ɾ�����ڲ��񱨱�","DeleteFS()","","","",""},
		{"true","","Button","���","���ñ���Ϊ���״̬","FinishFS()","","","",""},//���ñ�־λ�����Ʊ���Ȩ�ޣ�������ɰ�ť��ʵ�ֲ��񱨱�������״̬ת��Ϊ���״̬��
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	var ObjectType = "CustomerFS";
	//����һ�ڲ��񱨱�
	function AddNewFS(){
   		//�жϸÿͻ���Ϣ�в��񱨱�������Ƿ�ѡ��
   		sModelClass = PopPageAjax("/CustomerManage/EntManage/FindFSTypeAjax.jsp?CustomerID=<%=sCustomerID%>&rand="+randomNumber(),"","");
   		if(sModelClass == "false"){
   			alert(getMessageText('ALS70162'));//�ͻ��ſ���Ϣ���벻��������������ͻ��ſ���Ϣ��
   		}else{
   			sReturn = AsControl.PopView("/CustomerManage/EntManage/AddFSPre.jsp","CustomerID=<%=sCustomerID%>&ModelClass="+sModelClass,"dialogWidth=600px;dialogHeight=680px;resizable:yes;scrollbars:no;");
   			if(sReturn=="ok"){
   				reloadSelf();
	   			FSDetail();
   			}
   		}
	}
	
	function FSImport(){
		var sReportDate = getItemValue(0,getRow(),"ReportDate");
		if(!sReportDate){
			alert("��ѡ��һ����¼��");
			return;
		}
		var sObjectNo = getItemValue(0,getRow(),"CustomerID");
		var sReportScope = getItemValue(0,getRow(),"ReportScope");
		
		var o = document.forms["importfsform"];
		if(!o){
			$("<div style='position:absolute;top:0;left:0;width:100%;height:100%;'>"+
				"<iframe name='importfsframe' style='display:none;'></iframe>"+
				"<div style='position:absolute;top:0;left:0;width:100%;height:100%;background:#eee;filter:alpha(opacity=70);opacity:0.70;'></div>"+
				"<div style='position:absolute;top:10%;left:40%;margin-left:-100px;margin-top:-50px;padding:10px;border:1px solid #aaa;background:#eee;'>"+
					"<form name='importfsform' method='post' enctype='multipart/form-data' target='importfsframe'>"+
						"<input type=file name=importfsfile />"+
						"<input type=button value='����' onclick='upload(this)' />"+
					"</form>"+
					"<a onclick='$(this).parent().parent().hide();' href='javascript:void(0);' style='position:absolute;top:0px;right:1px;display:block;color:red;'>x</a>"+
				"</div>"+
			"</div>").appendTo("body");
			o = document.forms["importfsform"];
		}
		$(o).parent().parent().show();
		o.action = "Common/FinanceReport/ExcelImport.jsp?CompClientID="+sCompClientID+"&ObjectType="+ObjectType+"&ObjectNo="+sObjectNo+"&ReportScope="+sReportScope+"&ReportDate="+sReportDate
	}
	
	function upload(btn){
		var form = btn.parentNode;
		var div = form.parentNode;
		var board = $(div).prev();
		board.insertAfter(div);
		form.submit();
	}
	
	function afterUpload(flag){
		var o = document.forms["importfsform"];
		var div = o.parentNode;
		var board = $(div).next();
		if(board.length != 1) return;
		
		board.insertBefore(div);
		if(flag==true) board.parent().hide();
	}
	
	function FSExport(){
		var sReportDate = getItemValue(0,getRow(),"ReportDate");
		if(!sReportDate){
			alert("��ѡ��һ����¼��");
			return;
		}
		var sObjectNo = getItemValue(0,getRow(),"CustomerID");
		var sReportScope = getItemValue(0,getRow(),"ReportScope");
		AsControl.ExportFinanceReport(ObjectType, sObjectNo, sReportScope, sReportDate);
	}
	
	//�޸ı��������Ϣ
	function FSDescribe(){
	    var srole = "has";
		var sEditable="true";
		var sUserID = getItemValue(0,getRow(),"UserID");
		var sRecordNo = getItemValue(0,getRow(),"RecordNo");
		if (typeof(sRecordNo) != "undefined" && sRecordNo != "" ){
			if(FSLockStatus())
				sEditable="false";
			if(sUserID!="<%=CurUser.getUserID()%>")
				sEditable="false";
			OpenComp("FinanceStatementInfo","/CustomerManage/EntManage/FinanceStatementInfo.jsp","Role="+srole+"&RecordNo="+sRecordNo+"&Editable="+sEditable,"_self",OpenStyle);
		}else{
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
		}
	}
	
	//������ϸ��Ϣ
	function FSDetail(){
	    var srole = "has";
		var sCustomerID = getItemValue(0,getRow(),"CustomerID");
		var sReportDate = getItemValue(0,getRow(),"ReportDate");
		var sRecordNo = getItemValue(0,getRow(),"RecordNo");
		var sReportScope = getItemValue(0,getRow(),"ReportScope");
		var sUserID = getItemValue(0,getRow(),"UserID");
		if (typeof(sCustomerID) != "undefined" && sCustomerID != "" ){
			var sEditable="true";
			if(FSLockStatus())
				sEditable="false";
			if(sUserID!="<%=CurUser.getUserID()%>")
				sEditable="false";
			AsControl.OpenComp("/Common/FinanceReport/FinanceReportTab.jsp","Role="+srole+"&RecordNo="+sRecordNo+"&ObjectType="+ObjectType+"&CustomerID="+sCustomerID+"&ReportDate="+sReportDate+"&ReportScope="+sReportScope+"&Editable="+sEditable,"_blank",OpenStyle);
		    reloadSelf();
		}else{
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
		}
	}
	
	//�޸ı�������
	function ModifyReportDate(){
		if(FSLockStatus()){
			alert("���ڲ��񱨱��������������޸�!");
			return;
		}
		sReportDate = getItemValue(0,getRow(),"ReportDate");
		sReportScope = getItemValue(0,getRow(),"ReportScope");
		sRecordNo = getItemValue(0,getRow(),"RecordNo");
		if(typeof(sReportDate)!="undefined"&& sReportDate != "" ){
			//ȡ�ö�Ӧ�ı����·�
			sReturnMonth = PopPage("/Common/ToolsA/SelectMonth.jsp?rand="+randomNumber(),"","dialogWidth=250px;dialogHeight=170px;center:yes;status:no;statusbar:no");
			if(typeof(sReturnMonth) != "undefined" && sReturnMonth != ""){
				sToday = "<%=StringFunction.getToday()%>";//��ǰ����
				sToday = sToday.substring(0,7);//��ǰ���ڵ�����
				if(sReturnMonth >= sToday){
					alert(getMessageText('ALS70163'));//�����ֹ���ڱ������ڵ�ǰ���ڣ�
					return;		    
				}
				
				if(confirm("��ȷ��Ҫ�� "+sReportDate+"���񱨱� ����Ϊ"+sReturnMonth+"��")){
					//�����Ҫ���Խ��б���ǰ��Ȩ���ж�
					sPassRight = PopPageAjax("/CustomerManage/EntManage/FinanceCanPassAjax.jsp?ReportDate="+sReturnMonth+"&ReportScope="+sReportScope,"","resizable=yes;dialogWidth=0;dialogHeight=0;center:no;status:no;statusbar:no");
					if(sPassRight == "pass"){
						//������صĲ��񱨱�
						sReturn = RunMethod("BusinessManage","InitFinanceReport","CustomerFS,<%=sCustomerID%>,"+sReportDate+","+sReportScope+","+sRecordNo+","+""+","+sReturnMonth+",ModifyReportDate,<%=CurOrg.getOrgID()%>,<%=CurUser.getUserID()%>");
						if(sReturn == "ok"){
							alert("���ڲ��񱨱��Ѿ�����Ϊ"+sReturnMonth);	
							reloadSelf();	
						}
					}else{
						alert(sReturnMonth +" �Ĳ��񱨱��Ѵ��ڣ�");
					}
				}
			}
		}else{
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
		}
	}
	
	//ɾ��һ�ڲ��񱨱�
	function DeleteFS(){
		if(FSLockStatus()){
			alert("���ڲ��񱨱�������������ɾ��!");//��������״̬�ı�������ɾ����
			return;
		}
		sReportDate = getItemValue(0,getRow(),"ReportDate");
		sUserID = getItemValue(0,getRow(),"UserID");
		sReportScope = getItemValue(0,getRow(),"ReportScope");
		sRecordNo = getItemValue(0,getRow(),"RecordNo");
		if (typeof(sReportDate) != "undefined" && sReportDate != "" ){
			if(sUserID=='<%=CurUser.getUserID()%>'){
    			if(confirm(getHtmlMessage('2'))){
	    			as_delete('myiframe0');
    			}
			}else{
				alert(getHtmlMessage('3')); //�Բ�������Ȩɾ��������Ϣ��
			}
		}else{
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
		}
	}

	//���ò����Ĳ��񱨱�Ϊ���״̬
	function FinishFS(){
		if(FSLockStatus()){
			alert("���ڲ��񱨱��������������޸�!");
			return;
		}
		sReportDate = getItemValue(0,getRow(),"ReportDate");
		sReportScope = getItemValue(0,getRow(),"ReportScope");
		if (typeof(sReportDate) != "undefined" && sReportDate != "" ){
			sReportStatus = '02';//01��ʾ����״̬��02��ʾ���״̬��03��ʾ����״̬
			sReturn = RunMethod("CustomerManage","UpdateFSStatus","<%=sCustomerID%>,"+sReportStatus+","+sReportDate+","+sReportScope);
			if(typeof(sReturn) != "undefined" && sReturn.length>=0){
				alert("���񱨱�����Ϊ���״̬��");	
			}else{
				alert("����ʧ�ܣ�");	
			}
		}else{
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
		}
		reloadSelf();
	}
	
	//�����񱨱��Ƿ�Ϊ����״̬���磺��ѯ���Ϊ03������״̬������true�����򷵻�false
	//�˷�������ȫ�������CheckFSinEvaluateRecord��������Ϊ���д���03״̬�ı������������õȼ������ˡ�
	function FSLockStatus(){
		sCustomerID = getItemValue(0,getRow(),"CustomerID");
		sReportDate = getItemValue(0,getRow(),"ReportDate");
		sReportScope = getItemValue(0,getRow(),"ReportScope");
		sReturn=RunMethod("CustomerManage","CheckFSStatus",sCustomerID+","+sReportDate+","+sReportScope);
		return sReturn == '03';
	}
</script>
<%@	include file="/Frame/resources/include/include_end.jspf"%>