<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_info.jspf"%>
<%
	 String sOrgId = CurPage.getParameter("OrgId");
	 if(sOrgId == null) sOrgId = "";
	 String isNew = CurPage.getParameter("isNew");
	 if(isNew == null) isNew = "0";
	
	 BizObjectManager manager=JBOFactory.getBizObjectManager("jbo.ecr.ORG_TASK_INFO");
	 ASObjectModel doTemp = new ASObjectModel(manager);
	 if("1".equals(isNew)){
		 doTemp.setJboWhere("1=2");
		 doTemp.setVisible("Currenttask,Taskstatus,Starttime,Endtime,SortNo", false);
	 }else{
	 	doTemp.setJboWhere("OrgId=:OrgId");
	 }
	 doTemp.setVisible("Attribute1,Taskrunuserid,Taskrundate,SortNo", false);
	 doTemp.setRequired("Orgid,Orgname,Orgcode", true);
	 doTemp.setUnit("Orgcode","<input type=button class=inputDate   value=\"...\" name=button1 onClick=\"javascript:getContact();\">");
		
	 ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	 dwTemp.Style = "2";//freeform
	 dwTemp.ReadOnly = "0"; //设置是否只读 1:只读 0:可写
	 //dwTemp.ReadOnly = "-2";//只读模式
	 //doTemp.setDefaultValue("TaskRunDate",new SimpleDateFormat("yyyy/MM/dd").format(new java.util.Date()));
	 dwTemp.genHTMLObjectWindow(sOrgId);
	 String sButtons[][] = {
		{"true","All","Button","保存","保存所有修改","asSave()","","","btn_icon_save","",""},
		{"true","All","Button","返回","返回列表","returnList()","","","",""}
	 };
	//sButtonPosition = "south";
%>

<%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
    function asSave(){
    	as_save('myiframe0','');
    }
   
	function returnList(){
		AsControl.OpenView("/WebTask/ReportOrgList.jsp","","_parent");
	}
	
	  function getContact(){
		   var sStyle = "dialogWidth:880px;dialogHeight:540px;resizable:yes;scrollbars:no;status:no;help:no";
		   var sReturnValue = PopComp("ContactPersonList","/WebTask/ContactPersonList.jsp","isQuery=0",sStyle);
		   if (typeof(sReturnValue)!="undefined"){
				setItemValue(0,0,"Orgcode",sReturnValue);
				parent.OpenPage("/WebTask/ContactPersons.jsp?OrgCode="+sReturnValue,"frame_list","");
           } 
	  }
	
</script>

<%@ include file="/Frame/resources/include/include_end.jspf"%>
