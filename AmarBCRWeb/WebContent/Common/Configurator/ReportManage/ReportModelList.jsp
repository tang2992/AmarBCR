<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		Content: ���񱨱�ģ���б�
	 */
	String sModelNo =  CurPage.getParameter("ModelNo");
	if (sModelNo == null) 	sModelNo = "";

	ASObjectModel doTemp = new ASObjectModel("ReportModelList");
	doTemp.appendHTMLStyle("Col1Def,Col2Def,Col3Def,Col4Def"," style=\"cursor: pointer;\" ondblclick=\"myDBLClick(this)\"");
	//doTemp.appendHTMLStyle("RowSubjectName"," style=\"cursor: pointer;\" ondblclick=\"SelectSubject()\"");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(50);
	dwTemp.genHTMLObjectWindow(sModelNo);
	
	String sButtons[][] = {
		{"true","","Button","����","����һ����¼","newRecord()","","","",""},
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		{"true","","Button","����","�����޸�","saveRecord()","","","",""},
		{"true","","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","",""},
		{"true","","Button","����/���¹�ʽ����","��ʽ�����Ľ�������/���µ�formulaexp�ֶ���","genExplain()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		var sReturn=popComp("ReportModelInfo","/Common/Configurator/ReportManage/ReportModelInfo.jsp","ModelNo=<%=sModelNo%>","");
        //�޸����ݺ�ˢ���б�
		if (typeof(sReturn)!='undefined' && sReturn.length!=0){
			sReturnValues = sReturn.split("@");
			if (sReturnValues[0].length !=0 && sReturnValues[1]=="Y"){
				OpenPage("/Common/Configurator/ReportManage/ReportModelList.jsp?ModelNo="+sReturnValues[0],"_self","");           
            }
        }
	}
    
	function saveRecord(){
		as_save("myiframe0","");
	}

	function myDBLClick(myobj){
		//OW��DW��ȡ��input����ͬ
		myobj = $("input:first",myobj)[0];
        editObjectValueWithScriptEditorForAFS(myobj,'<%=sModelNo%>');
    }

	function viewAndEdit(){
		var sModelNo = getItemValue(0,getRow(),"ModelNo");
		var sRowNo = getItemValue(0,getRow(),"RowNo");
		if(typeof(sModelNo)=="undefined" || sModelNo.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
		sReturn=popComp("ReportModelInfo","/Common/Configurator/ReportManage/ReportModelInfo.jsp","ModelNo="+sModelNo+"&RowNo="+sRowNo,"");
        //�޸����ݺ�ˢ���б�
		if (typeof(sReturn)!='undefined' && sReturn.length!=0){
			sReturnValues = sReturn.split("@");
			if (sReturnValues[0].length !=0 && sReturnValues[1]=="Y"){
				OpenPage("/Common/Configurator/ReportManage/ReportModelList.jsp?ModelNo="+sReturnValues[0],"_self","");           
            }
        }
	}

	function deleteRecord(){
		var sRowNo = getItemValue(0,getRow(),"RowNo");
		if(typeof(sRowNo)=="undefined" || sRowNo.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return ;
		}
		if(confirm(getHtmlMessage('2'))){
			as_delete("myiframe0");
		}
	}
	
	function genExplain(){
		var sReturn = RunMethod("Configurator","GenFinStmtExplain","<%=sModelNo%>");
		if(typeof(sReturn)!="undefined" && sReturn=="succeeded"){
			alert("�ѽ���ʽ�����Ľ�������/���µ�formulaexp1��formulaexp2�ֶ��С�");
		}else{
			alert(sReturn);
		}
	}

	function SelectSubject(){
		setObjectValue("SelectAllSubject","","@RowSubject@0@RowSubjectName@1",0,0,"");			
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>