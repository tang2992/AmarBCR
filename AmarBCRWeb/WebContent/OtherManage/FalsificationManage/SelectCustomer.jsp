<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%
	/*
		Author: lmlan
		Tester:
		Content: ѡ��ͻ��Ի���ҳ��
		Input Param:
		Output param:
		History Log: 
	 */
	%>
<%
	String PG_TITLE = "�ͻ���Ϣѡ��"; // ��������ڱ��� <title> PG_TITLE </title>
	%>
<%	
	/*
        Author: #{author} #{createddate}
        Content: 
        History Log: 
    */
    ASObjectModel doTemp = new ASObjectModel(JBOFactory.getBizObjectManager("jbo.ecr.ECR_ORGANINFO"));
        
     //˫��ѡ��
    String sStyle = "style= \"cursor:hand\" ondblclick=\"javascript:doSearch();\"";
    doTemp.appendHTMLStyle("",sStyle);
    doTemp.setVisible("*", false);//���е��ֶ�����Ϊ���ɼ�
    doTemp.setVisible("MfcustomerId,LscustomerId,CifcustomerId,FinanceId,LoanCardNo",true);//���ÿɼ��ֶ�
    doTemp.setColumnFilter("*", false);
    doTemp.setColumnFilter("CifcustomerId,LoanCardNo", true);//��ƹ��˲�ѯ�ֶ�
    doTemp.setJboWhere("LoanCardNo is not null and LoanCardNo <> '0000000000000000'");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--����ΪGrid���--
	//dwTemp.MultiSelect = true;	 //��ѡ/**�޸�ģ��ʱ�벻Ҫ�޸���һ��*/
	//dwTemp.ShowSummary="1";	 	 //����/**�޸�ģ��ʱ�벻Ҫ�޸���һ��*/
	dwTemp.ReadOnly = "1";	 //ֻ��ģʽ
	dwTemp.setPageSize(15);
	dwTemp.genHTMLObjectWindow("");

	//0���Ƿ�չʾ 1��	Ȩ�޿���  2�� չʾ���� 3����ť��ʾ���� 4����ť�������� 5����ť�����¼�����	6��	7��	8��	9��ͼ�꣬CSS�����ʽ 10�����
	String sButtons[][] = {
			{"true","","Button","ȷ��","ȷ��","doSearch()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function doSearch(){
		var sCustomerID = getItemValue(0,getRow(),"CIFCUSTOMERID");
		var sLoanCordNO = getItemValue(0,getRow(),"LOANCARDNO");
		if(typeof(sCustomerID)=="undefined" || sCustomerID.length==0)
		{
			alert("��ѡ��һ���ͻ���Ϣ!");//��ѡ��һ����Ϣ��
			return;
		}else 
		{
			var sReturnValue = "";			
			sReturnValue = sCustomerID + "@"+ sLoanCordNO ;
			if(sReturnValue != "undefined" && sReturnValue != ""){
				var sReturnSplit = sReturnValue.split("@");//
				if(sReturnSplit[0]=="undefined")
				{
					top.returnValue="";
				}else{
					top.returnValue = sReturnValue;
				}
			top.close();
			}
		}		
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>