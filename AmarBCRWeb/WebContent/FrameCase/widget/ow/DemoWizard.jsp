<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_simplelist.jspf"%>
<%	
	ASObjectModel doTemp = new ASObjectModel("TestCustomerList");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.setPageSize(20);
	dwTemp.Style="0";      //����ΪGrid���
	dwTemp.ReadOnly = "1";//ֻ��ģʽ
	dwTemp.genHTMLObjectWindow("");
	String sButtons[][] = {
		{"true","","Button","����","����","add()","","","","btn_icon_add",""},
		{"true","","Button","����","����","edit()","","","","btn_icon_detail",""},
		{"true","","Button","�����˵��༭","�����˵��༭","editd()","","","","btn_icon_detail",""},
		{"true","","Button","ɾ��","ɾ��","if(confirm('ȷʵҪɾ����?'))as_delete(0)","","","","btn_icon_delete",""},
	};

	Wizard wizard = new Wizard();
	wizard.setDefId("03");
	wizard.items.add(new WizardItem("01", "��һ��", "01"));
	wizard.items.add(new WizardItem("02", "�ڶ���", "02"));
	wizard.items.add(new WizardItem("03", "������", "03"));
	wizard.items.add(new WizardItem("04", "���Ĳ�", "04"));
	wizard.items.add(new WizardItem("05", "���岽", "05"));
	wizard.items.add(new WizardItem("06", "������", "06"));
	wizard.items.add(new WizardItem("07", "���߲�", "07"));
	wizard.items.add(new WizardItem("08", "�ڰ˲�", "08"));
	wizard.items.add(new WizardItem("09", "�ھŲ�", "09"));
	wizard.items.add(new WizardItem("10", "��ʮ��", "10"));
	wizard.items.add(new WizardItem("11", "��ʮһ��", "11"));
	wizard.items.add(new WizardItem("12", "��ʮ����", "12"));
	wizard.items.add(new WizardItem("13", "��ʮ����", "13"));
	wizard.items.add(new WizardItem("14", "��ʮ�Ĳ�", "14"));
	wizard.items.add(new WizardItem("15", "��ʮ�岽", "15"));
	wizard.items.add(new WizardItem("16", "��ʮ����", "16"));
	wizard.items.add(new WizardItem("17", "��ʮ�߲�", "17"));
	wizard.items.add(new WizardItem("18", "��ʮ�˲�", "18"));
	sASWizardHtml = wizard.getHtmlText();
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function WizardCellOnClick(curItem, targetItem){
		if(!curItem) return true;
		if(curItem["sort"] > targetItem["sort"])
			return confirm("��"+curItem["id"]+"���˵�"+targetItem["id"]);
		
		return confirm("��"+curItem["id"]+"��ת��"+targetItem["id"]);
	}
	
	function add(){
		 var sUrl = "/FrameCase/widget/ow/DemoInfoSimple.jsp";
		 OpenPage(sUrl,'_self','');
	}
	function edit(){
		 var sUrl = "/FrameCase/widget/ow/DemoInfoSimple.jsp";
		 OpenPage(sUrl+'?SerialNo=' + getItemValue(0,getRow(0),'SerialNo'),'_self','');
	}
	function editd(){
		 var sUrl = "/FrameCase/widget/ow/DemoInfoDMenu.jsp";
		 OpenPage(sUrl+'?SerialNo=' + getItemValue(0,getRow(0),'SerialNo'),'_self','');
	}
</script>
<%@include file="/Frame/resources/include/include_end.jspf"%>
