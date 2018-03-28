<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
		页面说明: 机构信息详情
	 */
	//获得页面参数	
	String sOrgID =  CurPage.getParameter("CurOrgID");
	if(sOrgID == null) sOrgID = "";
	//通过显示模版产生ASDataObject对象doTemp
	ASObjectModel doTemp = new ASObjectModel("OrgInfo");
	if(sOrgID.equals("")) doTemp.setReadOnly("OrgID,OrgLevel", false);
    //设置上级机构选择方式
    doTemp.setUnit("BelongOrgName","<input type=button class=inputDate value=\"...\" name=button1 onClick=\"javascript:getOrgName();\"> ");
	doTemp.setHtmlEvent("BelongOrgName","ondblclick", "getOrgName");
	doTemp.appendHTMLStyle("OrgID,SortNo"," onkeyup=\"value=value.replace(/[^0-9]/g,&quot;&quot;) \" onbeforepaste=\"clipboardData.setData(&quot;text&quot;,clipboardData.getData(&quot;text&quot;).replace(/[^0-9]/g,&quot;&quot;))\" ");
			
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	dwTemp.genHTMLObjectWindow(sOrgID);

	String sButtons[][] = {
		{(CurUser.hasRole("099")?"true":"false"),"","Button","保存","保存修改","saveRecord()","","","",""},
		{"true","","Button","返回","返回到列表界面","doReturn()","","","",""}
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

	<%/*~[Describe=弹出机构选择窗口，并置将返回的值设置到指定的域;]~*/%>
	function getOrgName(){
		var sOrgID = getItemValue(0,getRow(),"OrgID");
		var sOrgLevel = getItemValue(0,getRow(),"OrgLevel");
		if (typeof(sOrgID) == 'undefined' || sOrgID.length == 0){
        	alert(getMessageText("ALS70900"));//请输入机构编号！
        	return;
        }
		if (typeof(sOrgLevel) == 'undefined' || sOrgLevel.length == 0){
        	alert(getMessageText("ALS70901"));//请选择级别！
        	return;
        }
		sParaString = "OrgID"+","+sOrgID+","+"OrgLevel"+","+sOrgLevel;
		
		if(sOrgID.indexOf("10") == 0){ //以10开头的编号
			setObjectValue("SelectOrgFunction","","@BelongOrgID@0@BelongOrgName@1",0,0,"");//针对总行职能部门
	    }else{
	    	setObjectValue("SelectOrg",sParaString,"@BelongOrgID@0@BelongOrgName@1",0,0,"");//针对一般机构
		}
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>