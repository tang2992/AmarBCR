<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
 	/*�û���¼��Ϣһ��*/
	sASWizardHtml = "<font color=red>��ҳ���������ϴ���ͨ����ѯ������ѯ</font>";
	ASObjectModel doTemp = new ASObjectModel("UserLogonWelcomeList");
	doTemp.setJboWhereWhenNoFilter(" and 1=2 ");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����ΪGrid���
	dwTemp.ReadOnly = "1"; //����Ϊֻ��
	dwTemp.setPageSize(40); //��������ҳ
	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	/*~[Describe=ѡ��ĳ���û���½��Ϣ,������ʾ���û���½��������Ϣ;]~*/
	function mySelectRow(){
		var sUserID = getItemValue(0,getRow(),"UserID");
		if(typeof(sUserID)=="undefined" || sUserID.length==0) {
		}else{
			OpenPage("/Common/SecurityAudit/AuditUserLogonList.jsp?UserID="+sUserID,"rightdown","");
		}
	}
</script>
<%@include file="/Frame/resources/include/include_end.jspf"%>