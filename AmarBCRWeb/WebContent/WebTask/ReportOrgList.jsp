<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
 <%
	String PG_TITLE = "�෨�˱�������";

	BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr.ORG_TASK_INFO");
	ASObjectModel doTemp = new ASObjectModel(boManager);

	if(!"system".equals(CurUser.getUserID()))
		doTemp.setJboWhere(" O.OrgCode='" + CurUser.getRelativeOrgID()+ "'"); 
		
	doTemp.setJboOrder(" O.SortNo ");
	doTemp.setVisible("Attribute1,Sortno,Taskrundate", false);
	doTemp.setColumnFilter("*", false);
	doTemp.setColumnFilter("Orgid,Orgname,Orgcode", true);
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(10);
	dwTemp.MultiSelect = true; //�����ѡ
	dwTemp.genHTMLObjectWindow("");
	
	String sButtons[][] = {
			{"true","","Button","��������","ִ�б�����������","doReport()","","","","",""},
			{"system".equals(CurUser.getUserID())?"true":"false","","Button","��ӻ���","��ӱ������ɻ���","newRecord()","","","","",""},
			{"system".equals(CurUser.getUserID())?"true":"false","","Button","�޸Ļ�����Ϣ","�޸ı������ɻ���","viewAndEdit()","","","","",""},
			{"true","","Button","�鿴��ϵ����Ϣ","�鿴������ϵ����Ϣ","viewContact()","","","","",""},
			{"system".equals(CurUser.getUserID())?"true":"false","","Button","�鿴������ϵ��","�鿴���л�����ϵ����Ϣ","viewAllContact()","","","","",""},
			{"system".equals(CurUser.getUserID())?"true":"false","","Button","ɾ��","ɾ���������ɻ���","deleteRecord()","","","","",""},
	};
%><%@
include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		OpenPage("/WebTask/OrgAndContactFrame.jsp?isNew=1","_self","");
		reloadSelf();
	}

	function deleteRecord(){
		var ORGID = getItemValue(0,getRow(),"OrgId");
		if (typeof(ORGID)=="undefined" || ORGID.length==0){
			alert("��ѡ��һ����¼��");
			return;
		}		
		if(confirm("�������ɾ������Ϣ��")){
			as_delete("myiframe0");
		} 
	}
	
	function viewAndEdit(){
		var sOrgId = getItemValue(0,getRow(),"OrgId");
		var sOrgCode = getItemValue(0,getRow(),"OrgCode");
		if (typeof(sOrgId)=="undefined" || sOrgId.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
		}else{
			//OpenPage("/Icr/WebTask/ReportOrgInfo.jsp?OrgId="+sOrgId,"_self","");
			OpenPage("/WebTask/OrgAndContactFrame.jsp?OrgId="+sOrgId+"&OrgCode="+sOrgCode,"_self","");
		}
	}
	
	function viewContact(){
		var sOrgCode = getItemValue(0,getRow(),"OrgCode");
		if (typeof(sOrgCode)=="undefined" || sOrgCode.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
		}else{
			popComp("ContactPersons","/WebTask/ContactPersons.jsp","OrgCode="+sOrgCode,"dialogWidth=800px;dialogHeight=600px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
			//OpenPage("/Icr/WebTask/ContactPersons.jsp?OrgCode="+sOrgCode,"_self","");
		}
	}
	
	function viewAllContact(){
		popComp("ContactPersonList","/WebTask/ContactPersonList.jsp","","dialogWidth=800px;dialogHeight=600px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
		//OpenPage("/Icr/WebTask/ContactPersonList.jsp?","_self","");
	}
	
	function doReport(){
		var rows= getCheckedRows(0);
		if(rows.length<1){
			alert("��û�й�ѡ�κ���");
			return;
		}else{
			var orglist = "";
			for(var i =0;i<rows.length;i++){
				orglist = orglist+"~"+getItemValue(0,rows[i],"OrgId");
			}
		}
		if(typeof(orglist)!="undefined"||orglist.length!=0){
		orglist = orglist.substring(1);
		var ret = AsControl.RunJavaMethod("com.amarsoft.app.util.RunTask","doRun",
				"taskName=report,orgList="+orglist+",userID=<%=CurUser.getUserID()%>");
		alert(ret);
		return;
		}
		reloadSelf();
	}
	
</script>	
<%@
 include file="/Frame/resources/include/include_end.jspf"%>