<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
 <%
	/*
		ҳ��˵��: ʾ���б�ҳ��
	 */
	String PG_TITLE = "����ҵ�������Ϣ�б�ҳ��";
	//���ҳ�����
	String IsQuery =  CurPage.getParameter("IsQuery");
	if(IsQuery==null) IsQuery="";
	
	ASObjectModel doTemp = new ASObjectModel("GuaranteeInfoList");
	String jboWhere = doTemp.getJboWhere();
	doTemp.setJboWhere(jboWhere);
	
	/* sASWizardHtml = "<font color=red>��ҳ���������ϴ���ͨ����ѯ������ѯ</font>";
	doTemp.setJboWhereWhenNoFilter(" and 1=2 "); */
	
	//doTemp.setDDDWJbo("REGISTERTYPE","jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9039'");
	//˫���¼�
    doTemp.appendHTMLStyle("","style=\"cursor: pointer;\" ondblclick=\"javascript:viewAndEdit()\"");
	
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(13);

	//����HTMLDataWindow
	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {
		{"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""}
	};
%>
<%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">

	function viewAndEdit(){
		var sGBusinessNo = getItemValue(0,getRow(),"GBUSINESSNO");
		if (typeof(sGBusinessNo)=="undefined" || sGBusinessNo.length==0){
			alert("��ѡ��һ����¼��");
			return;
		}
		 
     	AsControl.OpenView("/DataMaintain/GuaranteeMaintain/GuaranteeRelativeList.jsp","IsQuery=<%=IsQuery%>&GBusinessNo="+sGBusinessNo,"_blank","");  
		reloadSelf();
	}
</script>	
<%@ include file="/Frame/resources/include/include_end.jspf"%>
