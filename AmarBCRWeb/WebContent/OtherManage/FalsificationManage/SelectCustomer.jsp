<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%>
<%
	/*
		Author: lmlan
		Tester:
		Content: 选择客户对话框页面
		Input Param:
		Output param:
		History Log: 
	 */
	%>
<%
	String PG_TITLE = "客户信息选择"; // 浏览器窗口标题 <title> PG_TITLE </title>
	%>
<%	
	/*
        Author: #{author} #{createddate}
        Content: 
        History Log: 
    */
    ASObjectModel doTemp = new ASObjectModel(JBOFactory.getBizObjectManager("jbo.ecr.ECR_ORGANINFO"));
        
     //双击选中
    String sStyle = "style= \"cursor:hand\" ondblclick=\"javascript:doSearch();\"";
    doTemp.appendHTMLStyle("",sStyle);
    doTemp.setVisible("*", false);//所有的字段设置为不可见
    doTemp.setVisible("MfcustomerId,LscustomerId,CifcustomerId,FinanceId,LoanCardNo",true);//设置可见字段
    doTemp.setColumnFilter("*", false);
    doTemp.setColumnFilter("CifcustomerId,LoanCardNo", true);//设计过滤查询字段
    doTemp.setJboWhere("LoanCardNo is not null and LoanCardNo <> '0000000000000000'");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--设置为Grid风格--
	//dwTemp.MultiSelect = true;	 //多选/**修改模板时请不要修改这一行*/
	//dwTemp.ShowSummary="1";	 	 //汇总/**修改模板时请不要修改这一行*/
	dwTemp.ReadOnly = "1";	 //只读模式
	dwTemp.setPageSize(15);
	dwTemp.genHTMLObjectWindow("");

	//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
	String sButtons[][] = {
			{"true","","Button","确定","确定","doSearch()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function doSearch(){
		var sCustomerID = getItemValue(0,getRow(),"CIFCUSTOMERID");
		var sLoanCordNO = getItemValue(0,getRow(),"LOANCARDNO");
		if(typeof(sCustomerID)=="undefined" || sCustomerID.length==0)
		{
			alert("请选择一条客户信息!");//请选择一条信息！
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