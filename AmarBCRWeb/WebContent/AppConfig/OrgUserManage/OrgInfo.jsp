<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		ҳ��˵��: ������Ϣ����
	 */
	//���ҳ�����	
	String sOrgID =  CurPage.getParameter("CurOrgID");
	if(sOrgID == null) sOrgID = "";
	//ͨ����ʾģ�����ASDataObject����doTemp
	ASObjectModel doTemp = new ASObjectModel("OrgInfo");
	if(sOrgID.equals("")) doTemp.setReadOnly("OrgID,OrgLevel", false);
    //�����ϼ�����ѡ��ʽ
    doTemp.setUnit("BelongOrgName","<input type=button class=inputDate value=\"...\" name=button1 onClick=\"javascript:getOrgName();\"> ");
	doTemp.setHtmlEvent("BelongOrgName","ondblclick", "getOrgName");
	doTemp.appendHTMLStyle("OrgID,SortNo"," onkeyup=\"value=value.replace(/[^0-9]/g,&quot;&quot;) \" onbeforepaste=\"clipboardData.setData(&quot;text&quot;,clipboardData.getData(&quot;text&quot;).replace(/[^0-9]/g,&quot;&quot;))\" ");
			
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.genHTMLObjectWindow(sOrgID);

	String sButtons[][] = {
		{(CurUser.hasRole("099")?"true":"false"),"","Button","����","�����޸�","saveRecord()","","","",""},
		{"true","","Button","����","���ص��б����","doReturn()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function saveRecord(){
       	as_save("myiframe0");
	}
    
	function doReturn(){
		if(parent.reloadView){
			parent.reloadView();
		}else{
			OpenPage("/AppConfig/OrgUserManage/OrgList.jsp","_self","");
		}
	}

	<%/*~[Describe=��������ѡ�񴰿ڣ����ý����ص�ֵ���õ�ָ������;]~*/%>
	function getOrgName(){
		var sOrgID = getItemValue(0,getRow(),"OrgID");
		var sOrgLevel = getItemValue(0,getRow(),"OrgLevel");
		if (typeof(sOrgID) == 'undefined' || sOrgID.length == 0){
        	alert(getMessageText("ALS70900"));//�����������ţ�
        	return;
        }
		if (typeof(sOrgLevel) == 'undefined' || sOrgLevel.length == 0){
        	alert(getMessageText("ALS70901"));//��ѡ�񼶱�
        	return;
        }
		sParaString = "OrgID"+","+sOrgID+","+"OrgLevel"+","+sOrgLevel;
		
		if(sOrgID.indexOf("10") == 0){ //��10��ͷ�ı��
			setObjectValue("SelectOrgFunction","","@BelongOrgID@0@BelongOrgName@1",0,0,"");//�������ְ�ܲ���
	    }else{
	    	setObjectValue("SelectOrg",sParaString,"@BelongOrgID@0@BelongOrgName@1",0,0,"");//���һ�����
		}
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>