<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%
	String PG_TITLE = "֪ͨ�б�"; // ��������ڱ��� <title> PG_TITLE </title>
	%>
<%	
	/*
        Author: #{author} #{createddate}
        Content: 
        History Log: 
    */
	ASObjectModel doTemp = new ASObjectModel(JBOFactory.getBizObjectManager("jbo.ecr.BOARD_LIST"));
    doTemp.setColumnFilter("*", false);
    doTemp.setColumnFilter("BoardName,BoardTitle", true);
    doTemp.setVisible("*", false);
    doTemp.setVisible("BoardName,BoardTitle,BoardDesc,IsPublish,IsNew,IsEject", true);
	doTemp.setAlign("IsNew,IsEject,IsPublish","2");
	doTemp.setHTMLStyle("IsNew,IsEject,IsPublish"," style={width:60px} ");
	doTemp.setHTMLStyle("BoardTitle"," style={width:300px}");
	doTemp.setDDDWCodeTable("IsPublish,IsNew,IsEject", "1,��,2��");
     
     
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--����ΪGrid���--
	//dwTemp.MultiSelect = true;	 //��ѡ/**�޸�ģ��ʱ�벻Ҫ�޸���һ��*/
	//dwTemp.ShowSummary="1";	 	 //����/**�޸�ģ��ʱ�벻Ҫ�޸���һ��*/
	dwTemp.ReadOnly = "1";	 //ֻ��ģʽ
	dwTemp.setPageSize(10);
	//˫��������
	String sStyle = "style= \"cursor:hand\" ondblclick=\"javascript:viewAndEdit();\" ";
	doTemp.appendHTMLStyle("",sStyle);
	
	dwTemp.genHTMLObjectWindow("");

	//0���Ƿ�չʾ 1��	Ȩ�޿���  2�� չʾ���� 3����ť��ʾ���� 4����ť�������� 5����ť�����¼�����	6��	7��	8��	9��ͼ�꣬CSS�����ʽ 10�����
	String sButtons[][] = {
		{"true","","Button","����","��������","newRecord()","","","btn_icon_add",""},
		{"true","","Button","����","�鿴����","viewAndEdit()","","","btn_icon_detail",""},
		{"true","","Button","ɾ��","ɾ������","deleteRecord()","","","btn_icon_delete",""}						
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		AsControl.PopView("/SystemManage/Board/BoardInfo.jsp","Flag=New","dialogWidth=400px;dialogHeight=350px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
		reloadSelf();
	}
	function viewAndEdit(){
		var sBoardNo = getItemValue(0,getRow(),"BoardNo");
		if (typeof(sBoardNo)=="undefined" || sBoardNo.length==0)
		{
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return;
		}
	    AsControl.PopView("/SystemManage/Board/BoardInfo.jsp","BoardNo="+sBoardNo,"");
		reloadSelf();
	}
	function deleteRecord(){
		sBoardNo = getItemValue(0,getRow(),"BoardNo");	
		if (typeof(sBoardNo)=="undefined" || sBoardNo.length==0)
		{
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return;
		}
		if(confirm(getHtmlMessage('2')))//�������ɾ������Ϣ��
		{
			as_delete('myiframe0');
			as_save('myiframe0');  //�������ɾ������Ҫ���ô����
		}	
	}
	
	function mySelectRow()
	{		
	}
	function initRow()
	{
		if (getRowCount(0)==0)
		{
		 	as_add("myiframe0");
		}		
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>