<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	ASObjectModel doTemp = new ASObjectModel("AWEQueryHisList");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1";//ֻ��ģʽ
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");
	sASWizardHtml = "<div><font size=\"2pt\" color=\"#930055\">��ѯ�����б�</font></div>";
	
	String sButtons[][] = {
		{"true","All","Button","����","������ѯ","newRecord()","","","",""},
		{"true","All","Button","����","�鿴����","viewDetail()","","","",""},
		{"true","All","Button","ɾ��","ɾ��","deleteRecord()","","","",""},
  	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
	    OpenPage("/AppConfig/QueryScheme/QuerySchemeInfo.jsp","rightdown","");  
	}

	function viewDetail(){
		mySelectRow();
	}
	
	function deleteRecord(){
		var queryNo = getItemValue(0, getRow(), "QUERYSCHEMENO");
		if(typeof(queryNo)=="undefined" || queryNo.length == 0){
			alert("��ѡ��һ����¼��");
			return;
		}
		
		if(confirm("�������ɾ������Ϣ��")){
			as_delete("myiframe0");
		}
	}
	function mySelectRow(){
		var queryNo = getItemValue(0, getRow(), "QUERYSCHEMENO");
		if(typeof(queryNo)=="undefined" || queryNo.length == 0){
			return;
		}else{
			AsControl.OpenView("/AppConfig/QueryScheme/QuerySchemeInfo.jsp","queryNo="+queryNo,"rightdown","");
		}
	}
	mySelectRow();
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>