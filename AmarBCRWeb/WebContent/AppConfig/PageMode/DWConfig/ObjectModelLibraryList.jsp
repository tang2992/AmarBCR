<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	String sDONO = CurPage.getParameter("DONO");
	if(sDONO == null) sDONO = "";
	
	ASObjectModel doTemp = new ASObjectModel("ObjectModelLibraryList");
	doTemp.setLockCount(2); //��������
	doTemp.setDDDWJbo("GROUPID", "jbo.ui.system.DATAOBJECT_GROUP,DockID,DockName,DONO='"+sDONO+"' order by SortNo");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����ΪGrid���
	dwTemp.ReadOnly = "0";//�༭ģʽ
	dwTemp.setPageSize(20);
	dwTemp.ConvertCode2Title = "1";
	dwTemp.genHTMLObjectWindow(sDONO);
	
	String sButtons[][] = {
		{"true", "All","Button","��������","��ǰҳ������","afterAdd()","","","","btn_icon_add"},
		{"true", "All","Button","���ٱ���","���ٱ��浱ǰҳ��","afterSave()","","","","btn_icon_save"},
		{"true", "All","Button","���ٸ���","���ٸ��Ƶ�ǰ��¼","quickCopy()","","","",""},
		{"true", "All","Button","�ֶ��¼�","���ô����ֶοؼ����¼�","changeControlEvent()","","","",""},
		{"true", "All", "Button", "ɾ��", "", "deleteRecord()", "", "", "", ""},
		{"true", "All", "Button", "������Ϣ����", "������Ϣ����", "setGroup()", "", "", "", "btn_icon_edit"},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	var sDONO = "<%=sDONO%>";
	function afterSave(){
		var dox = "";
		RunJavaMethodTrans("com.amarsoft.app.awe.config.dw.action.ObjectModelLibListAction","setDoX","doX=0");
		if(as_isPageChanged()){
			if(confirm('���ֶ�ͬ�����²���?')){
				dox = "1";
			}else{
				dox = "0";
			}
		}
		RunJavaMethodTrans("com.amarsoft.app.awe.config.dw.action.ObjectModelLibListAction","setDoX","doX="+dox);
		as_save(0);
	}
	function changeControlEvent(){
		var row = getRow();
		var sDoNo = getItemValue(0, row, "DoNo");
		var sColName = getItemValue(0, row, "ColName");
		AsControl.PopPage("/AppConfig/PageMode/DWConfig/ObjectModelEventList.jsp", "DoNo="+sDoNo+"&ColName="+sColName, "");
	}
	//��������
	function afterAdd(){
		as_add(0);
		//��������ʱ�����Ĭ��ֵ
		setItemValue(0,getRow(),"DONO",sDONO);
	}
	function quickCopy(){
		if(as_isPageChanged()){
			alert('ҳ���Ѿ��޸Ĺ��ˣ����ȱ��棡');
		}else{
			var sColIndex = getItemValue(0,getRow(),"ColIndex");
			var returnValue = doX(sColIndex,"quickCopyLib");
			if(returnValue == 'SUCCESS')alert('���Ƴɹ���');
			else alert('�Բ��𣬸���ʧ�ܣ�');
			reloadSelf();
		}
	}
	//����ɾ��
	function deleteRecord(){
		if(as_isPageChanged()){
			alert('ҳ���Ѿ��޸Ĺ��ˣ����ȱ��棡');
		}else{
			var sColIndex = getItemValue(0,getRow(),"ColIndex");
			if(!confirm(getMessageText('AWEW1002'))) return;
			var returnValue = doX(sColIndex,"quickDeleteLib");
			if(returnValue == 'SUCCESS')alert('ɾ���ɹ���');
			else alert('�Բ���ɾ��ʧ�ܣ�');
			reloadSelf();	
		}
	}
	//����function
	function doX(sColIndex,method){
		var doWithX = "0";
		var returnValue = RunJavaMethodTrans("com.amarsoft.app.awe.config.dw.action.ObjectModelLibListAction","isAlert","DONO="+sDONO+",ColIndex="+sColIndex);
		if(returnValue == 'SUCCESS'){
			if(confirm('���ֶ�ͬ�����²���?'))
				doWithX = "1";
			else
				doWithX = "0";		
			returnValue = RunJavaMethodTrans("com.amarsoft.app.awe.config.dw.action.ObjectModelLibListAction",method,"DONO="+sDONO+",ColIndex="+sColIndex+",doWithX="+doWithX);
		}else{
			returnValue = RunJavaMethodTrans("com.amarsoft.app.awe.config.dw.action.ObjectModelLibListAction",method,"DONO="+sDONO+",ColIndex="+sColIndex+",doWithX="+doWithX);
		}
		return returnValue;
	}
	
	function setGroup(){
		AsControl.PopView("/AppConfig/PageMode/DWConfig/ObjectModelGroupList.jsp","DONO="+sDONO);
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
