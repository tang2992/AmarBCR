<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		ҳ��˵��: ʾ���б�ҳ��
	 */
	String PG_TITLE = "ʾ���б�ҳ��";
	
	//ͨ��DWģ�Ͳ���ASDataObject����doTemp
	ASDataObject doTemp = new ASDataObject("ExampleList",Sqlca);
	ASDataWindow dwTemp = new ASDataWindow(CurPage ,doTemp,Sqlca);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(15);

	//����HTMLDataWindow
	Vector vTemp = dwTemp.genHTMLDataWindow("");
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));

	String sButtons[][] = {
		{"true","","Button","����","����һ����¼","newRecord()","","","",""},
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
		{"true","","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","",""},
		{"true","","Button","����Excel","����Excel","amarExport('myiframe0')","","","",""},
		{"true","","Button","ʹ��ObjectViewer��","ʹ��ObjectViewer��","openWithObjectViewer()","","","",""},
	};
%><%@include file="/Resources/CodeParts/List05.jsp"%>
<script type="text/javascript">
	function filterAction(sObjectID,sFilterID,sObjectID2,sColName){
		//alert([sObjectID,sFilterID,sObjectID2,sColName]);
		var oMyObj = document.getElementById(sObjectID);
		var oMyObj2 = document.getElementById(sObjectID2);
		if(sColName.toUpperCase()=="INPUTUSER"){
			var sParaString = "SortNo,<%=CurOrg.getSortNo()%>";
			var sReturn =setObjectValue("SelectUserInOrg",sParaString,"",0,0,"");
			if(typeof(sReturn) == "undefined" || sReturn == "_CANCEL_")
				return;
			
			if(sReturn == "_CLEAR_"){
				oMyObj.value = "";
				oMyObj2.value = "";
			}else{
				sReturns = sReturn.split("@");
				oMyObj.value=sReturns[0];
				oMyObj2.value=sReturns[1];
			}
		}else if(sColName.toUpperCase()=="CUSTOMERTYPE"){
			var sReturn = AsDialog.OpenSelector("SelectCodes", "CodeNo,CustomerType", "");
			if(typeof(sReturn) == "undefined" || sReturn == "_CANCEL_")
				return;
			
			if(sReturn == "_CLEAR_"){
				oMyObj.value = "";
				oMyObj2.value = "";
			}else{
				var items = sReturn.split("~");
				var nos = "";
				var names = "";
				for(var i = 0; i < items.length; i++){
					if(!items[i]) continue;
					var item = items[i].split("@");
					nos += "|"+item[0];
					names += "|"+item[1];
				}
				
				oMyObj.value = nos.substring(1);
				oMyObj2.value = names.substring(1)
			}
		}
	}
	
	function newRecord(){
		AsControl.OpenView("/FrameCase/widget/dw/ExampleInfo.jsp","","_self","");
	}
	
	function deleteRecord(){
		var sExampleId = getItemValue(0,getRow(),"ExampleId");
		if (typeof(sExampleId)=="undefined" || sExampleId.length==0){
			alert("��ѡ��һ����¼��");
			return;
		}
		
		if(confirm("�������ɾ������Ϣ��")){
			as_del("myiframe0");
			as_save("myiframe0");  //�������ɾ������Ҫ���ô����
		}
	}

	function viewAndEdit(){
		var sExampleId = getItemValue(0,getRow(),"ExampleId");
		if (typeof(sExampleId)=="undefined" || sExampleId.length==0){
			alert("��ѡ��һ����¼��");
			return;
		}
		AsControl.OpenView("/FrameCase/widget/dw/ExampleInfo.jsp","ExampleId="+sExampleId,"_self","");
	}
	
	<%/*~[Describe=ʹ��ObjectViewer��;InputParam=��;OutPutParam=��;]~*/%>
	function openWithObjectViewer(){
		var sExampleId = getItemValue(0,getRow(),"ExampleId");
		if (typeof(sExampleId)=="undefined" || sExampleId.length==0){
			alert("��ѡ��һ����¼��");
			return;
		}
		
		AsControl.OpenObject("Example",sExampleId,"001");//ʹ��ObjectViewer����ͼ001��Example��
	}

	$(document).ready(function(){
		AsOne.AsInit();
		init();
		//window.topHtml = "<span style='color:blue;display:block;width:100%;text-align:center;'>DWͷ�ϵ�HTML����</span>";
		//window.bottomHtml = "<span style='color:red;margin-left:20px;'>DWβ���HTML����</span>";
		bHighlightFirst = true;
		my_load(2,0,'myiframe0');
	});
</script>	
<%@ include file="/IncludeEnd.jsp"%>