<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%><%
	String queryNo =  CurPage.getParameter("queryNo");
	if(queryNo == null) queryNo="";
	
	ASObjectModel doTemp = new ASObjectModel("AWEQueryInfo");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.genHTMLObjectWindow(queryNo);
	sASWizardHtml = "<div><font size=\"2pt\" color=\"#930055\">��ѯ��������</font></div>";

	String sButtons[][] = {
		{"true","All","Button","����","�����޸�","saveRecord()","","","",""},
		{"true","All","Button","��ѯ","�����������ѯ","as_doAction(0,'doQuery()','genJBOQL')","","","",""},
		{"true","All","Button","�鿴��ѯ���","�鿴��ѯ���","as_doAction(0,'viewJBOQL()','genJBOQL')","","","",""},
  	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function saveRecord(){
		as_save("myiframe0");
	}
    
	function doQuery(){
		as_save("myiframe0"); //�ȱ����ѯ����
		viewJBOQL();
		//parent.reloadSelf();
	}
    
	/*~[Describe=�鿴��ѯ���;]~*/
	function viewJBOQL(){
		var sResultInfo = getResultInfo(0);//�������
		if(sResultInfo!=''){
			var sJBOQL = sResultInfo.split("@")[0];
			var sMajorObjClass = sResultInfo.split("@")[1];
			var exportFields = sResultInfo.split("@")[2];
			var sumFields = sResultInfo.split("@")[3];
			var sParas = "MajorObjClass="+sMajorObjClass+"&JBOQL="+sJBOQL+"&ExportFields="+exportFields+"&SumFields="+sumFields;
			AsControl.PopComp("/AppConfig/QueryScheme/GenerateJBOQLPage.jsp", sParas, "dialogWidth=800px;dialogHeight=470px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;");
		}
	}
	
	/*~[Describe=ѡ��������;InputParam=ObjName ���������ֶ�;]~*/
	function selectMajorObjClass(){
		var sDefaultNode = getItemValue(0, 0, "BIZOBJCLASS");
		var sReturn = AsControl.PopComp("/AppConfig/QueryScheme/SelectBizObjectClass.jsp", "DefaultNode="+sDefaultNode, "");
		if(typeof(sReturn)!="undefined" && sReturn != "_CLEAR"){
			setItemValue(0,0,"BIZOBJCLASS",sReturn.split("@")[0]);
			setItemValue(0,0,"MajorClassName",sReturn.split("@")[1]);
		}else if(sReturn == "_CLEAR"){
			setItemValue(0,0,"BIZOBJCLASS","");
			setItemValue(0,0,"MajorClassName","");
		}
	}
	
	/*~[Describe=ѡ�񸽼Ӷ���;InputParam=ObjName ���������ֶ�,ObjAlias ��������ֶ�;]~*/
	function selectRelatedClass(){
		var bizObjClass = getItemValue(0, 0, "BIZOBJCLASS");
		if(typeof(bizObjClass)=="undefined" || bizObjClass.length == 0){
			alert("��ѡ��������");
			return;
		}
		var style = "dialogWidth:500px;dialogHeight:600px;resizable:yes;maximize:yes;help:no;status:no;";
		var sReturn = AsControl.PopComp("/AppConfig/QueryScheme/SelectRelatedClasses.jsp", "BizObjClass="+bizObjClass, style);
		if(typeof(sReturn)!="undefined" && sReturn != "_CLEAR"){
			setItemValue(0,0,"RELATEDCLASS",sReturn.split("@@")[0]);
			setItemValue(0,0,"RelatedClassName",sReturn.split("@@")[1]);
		}else if(sReturn == "_CLEAR"){
			setItemValue(0,0,"RELATEDCLASS","");
			setItemValue(0,0,"RelatedClassName","");
		}
	}
	
	/*~[Describe=ȡ����ѡ���������;]~*/
	function getSelectedClassAttrs(attrCol,nameCol,selectType){
		var bizObjClass = getItemValue(0, getRow(), "BizObjClass"); //������
		var relatedClass = getItemValue(0, getRow(), "RELATEDCLASS"); //���Ӷ���
		relatedClass = relatedClass.replace(/\"/g,"\\\""); //�� " ����
		if(typeof(bizObjClass)=="undefined" || bizObjClass.length == 0){
			alert("��ѡ��������");
			return;
		}
		var selectedAttrs = getItemValue(0, getRow(), attrCol);
		var paraString = "MajorClass="+bizObjClass+"&RelatedClasses="+relatedClass+"&SelectType="+selectType+"&SelectedAttrs="+selectedAttrs;
		var sReturn = AsControl.PopComp("/AppConfig/QueryScheme/GetSelectedClassAttrs.jsp",paraString,"dialogWidth:550px;dialogHeight:600px;center:yes;resizable:yes;scrollbars:no;status:no;help:no");
		if(typeof(sReturn) != "undefined" && sReturn !="_none_"){
			setItemValue(0,0,attrCol,sReturn.split("@")[0]);
			setItemValue(0,0,nameCol,sReturn.split("@")[1]);
		}
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>