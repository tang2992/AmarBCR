<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%
	String PG_TITLE = "最高额担保解除页面"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>
<%	

	ASObjectModel doTemp = new ASObjectModel(JBOFactory.getBizObjectManager("jbo.ecr.HIS_RELIEVEGUARANTY"));
    doTemp.setDDDWCodeTable("BusinessType","1,贷款业务,2,保理业务,3,贸易融资,4,信用证,5,保函业务,6,承兑汇票");
    doTemp.setDDDWCodeTable("GuarantyType","1,保证,2,抵押,3,质押");
    doTemp.setDDDWCodeTable("Status","1,正常,2,已撤销");
    doTemp.setDDDWJbo("IncrementFlag", "jbo.ecr.ECR_CODEMAP,CtCode,Note,ColName='7511'");
    doTemp.setVisible("Availabstatus,Updatedate,Relievetype,Oldoccurdate,Sessionid", false);
    doTemp.setColumnFilter("*", false);
    doTemp.setColumnFilter("OccurDate,ContractNo,GuarantyType", true);
    String sStyle = "style= \"cursor:hand\" ondblclick=\"javascript:viewAndEdit();\"";
	doTemp.appendHTMLStyle("",sStyle);
    
    
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--设置为Grid风格--
	//dwTemp.MultiSelect = true;	 //多选/**修改模板时请不要修改这一行*/
	//dwTemp.ShowSummary="1";	 	 //汇总/**修改模板时请不要修改这一行*/
	dwTemp.ReadOnly = "1";	 //只读模式
	dwTemp.setPageSize(10);
	dwTemp.genHTMLObjectWindow("");

	//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
	String sButtons[][] = {
		{"true","","Button","详情","查看/修改详情","viewAndEdit()","","","btn_icon_detail",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function viewAndEdit(){
		var sContractNo = getItemValue(0,getRow(),"ContractNo");
		var sGuarantyContNo = getItemValue(0,getRow(),"GuarantyContNo");
		var sGuarantySerialNo = getItemValue(0,getRow(),"GuarantySerialNo");
		var sInsertDate = getItemValue(0,getRow(),"InsertDate");
		//alert(sContractNo+"&&"+sGuarantyContNo+"&&"+sGuarantySerialNo+"$$"+sInsertDate);
		if (typeof(sContractNo)=="undefined" || sContractNo.length==0)
		{
			alert("请选择一条记录！");
			return;
		}
		AsControl.PopView("/OtherManage/TransferManage/RelieveGuarantyInfo.jsp","ContractNo="+sContractNo+"&InsertDate="+sInsertDate+"&GuarantyContNo="+sGuarantyContNo+"&GuarantySerialNo="+sGuarantySerialNo,"");
		//popComp("RelieveGuarantyInfo","/OtherManage/TransferManage/RelieveGuarantyInfo.jsp","ContractNo="+sContractNo+"&InsertDate="+sInsertDate+"&GuarantyContNo="+sGuarantyContNo+"&GuarantySerialNo="+sGuarantySerialNo,"");
		reloadSelf();
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>