<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	/*
		ҳ��˵��: �����б�
	 */
 	ASObjectModel doTemp = new ASObjectModel("BoardList");
 	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����ΪGrid���
	dwTemp.ReadOnly = "1"; //����Ϊֻ��
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {
		{"true","All","Button","��������","��������","my_add()","","","",""},
		{"true","All","Button","ɾ������","ɾ������","my_del()","","","",""},
		{"false","","Button","��������","�鿴��������","my_detail()","","","",""},
		{"true","","Button","���渽��","�鿴���渽��","DocDetail()","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function my_add(){
		AsControl.OpenView("/AppConfig/BoardManage/BoardInfo.jsp","","rightdown","");
	}
	
	function my_detail(){
		var sBoardNo = getItemValue(0,getRow(),"BoardNo");
		if (typeof(sBoardNo)=="undefined" || sBoardNo.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return;
		}
		AsControl.OpenView("/AppConfig/BoardManage/BoardInfo.jsp","BoardNo="+sBoardNo,"rightdown","");
	}
	
	<%/*[Describe=�鿴���渽��;]*/%>
	function DocDetail(){
		var sDocNo = getItemValue(0,getRow(),"DocNo");
		if(typeof(sDocNo)=="undefined" || sDocNo.length==0) {
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return;
		}
		//AsControl.OpenView("/AppConfig/Document/AttachmentList.jsp","DocNo="+sDocNo,"rightdown","");
		AsControl.PopView("/AppConfig/Document/AttachmentFrame.jsp", "DocNo="+sDocNo, "dialogWidth=650px;dialogHeight=350px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
	}
	
	function my_del(){
		var sBoardNo = getItemValue(0,getRow(),"BoardNo");
		if (typeof(sBoardNo)=="undefined" || sBoardNo.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return;
		}
		if(confirm(getHtmlMessage('2'))){ //�������ɾ������Ϣ��
			//as_delete('myiframe0');
			as_delete("myiframe0","");
		}
	}

	<%/*~[Describe=�����¼�;]~*/%>
	function mySelectRow(){
		var sBoardNo = getItemValue(0,getRow(),"BoardNo");
		if (typeof(sBoardNo)=="undefined" || sBoardNo.length==0){
			AsControl.OpenView("/Blank.jsp","TextToShow=����ѡ����Ӧ����Ϣ!","rightdown","");
		}else{
			AsControl.OpenView("/AppConfig/BoardManage/BoardInfo.jsp","BoardNo="+sBoardNo,"rightdown","");
		}
	}
</script>
<%@	include file="/Frame/resources/include/include_end.jspf"%>