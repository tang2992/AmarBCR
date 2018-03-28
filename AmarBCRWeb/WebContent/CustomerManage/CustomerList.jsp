<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
    /*
        Content: 案例客户信息列表，只展示大型企业客户
    */
    String PG_TITLE = "客户信息列表"   ; // 浏览器窗口标题 <title> PG_TITLE </title>  

    //定义变量
    String sUserID = CurUser.getUserID(); //用户ID
    String sOrgID = CurOrg.getOrgID(); //机构ID
    
    //获得组件参数    ：客户类型、客户显示模版号
    String sCustomerType = CurPage.getParameter("CustomerType");
    String sTempletNo = CurPage.getParameter("CustomerListTemplet");
    String sCurItemID = CurPage.getParameter("CurItemID"); //用户点击的树图项ID，在集团客户管理时，由此来确定在页面上显示的按钮
    //将空值转化为空字符串
    if(sCustomerType == null) sCustomerType = "";
    if(sTempletNo == null) sTempletNo = "";
    if(sCurItemID == null) sCurItemID = "";
    
    //通过显示模版产生ASDataObject对象doTemp
    ASObjectModel doTemp = new ASObjectModel(sTempletNo);
    ASObjectWindow dwTemp = new ASObjectWindow(CurPage ,doTemp,request);
    dwTemp.setPageSize(20); //add by hxd in 2005/02/20 for 加快速度
    dwTemp.Style="1"; //设置DW风格 1:Grid 2:Freeform      
    dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
    dwTemp.genHTMLObjectWindow(sUserID+","+sCustomerType+","+sOrgID+","+CurOrg.getSortNo());

    String sbCustomerType = sCustomerType.substring(0,2);
    String sButtons[][] = {
	    {"true","","Button","新增","新增一条记录","newRecord()","","","",""}, 
	    {"true","","Button","详情","查看/修改详情","viewAndEdit()","","","",""},
	    {(sCurItemID.equals("02")?"false":"true"),"","Button","删除","删除所选中的记录","deleteRecord()","","","",""}, 
	    {(sbCustomerType.equals("01")?"true":"false"),"","Button","客户信息预警","客户信息预警","alarmCustInfo()","","","",""},
	    {"true","","Button","填写调查报告","填写调查报告","genReport()","","","",""},
	    {"true","","Button","查看调查报告","查看调查报告","viewReport()","","","",""},
	    {(sbCustomerType.equals("02")?"false":"true"),"","Button","客户开户查询(实时接口)","查询客户开户信息","queryCusomerInfo()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
    /*~[Describe=新增记录;InputParam=无;OutPutParam=无;]~*/
    function newRecord(){
        var sCustomerType='<%=sCustomerType%>'; //--客户类型
        var sCustomerID ='';                                        //--客户代码
        var sReturn ='';                                                //--返回值，客户的录入信息是否成功
        var sReturnStatus = '';                                 //--存放客户信息检查结果
        var sStatus = '';                                               //--存放客户信息检查状态      
        var sReturnValue = '';                                  //--存放客户输入信息
        var sCustomerOrgType ='';                               //--客户类型性质
        var sHaveCustomerType = "";
        var sHaveCustomerTypeName = "";
        var sHaveStatus = "";

        //客户信息录入模态框调用   
        //这里区分客户类型，仅为控制对话框的展示大小
        if(sCustomerType.substring(0,2) == "01"||sCustomerType.substring(0,2) == "03")
            sReturnValue = PopPage("/CustomerManage/AddCustomerDialog.jsp?CustomerType="+sCustomerType,"","resizable=yes;dialogWidth=350px;dialogHeight=200px;center:yes;status:no;statusbar:no");
        else
        	sReturnValue = PopPage("/CustomerManage/AddCustomerDialog.jsp?CustomerType="+sCustomerType,"","resizable=yes;dialogWidth=350px;dialogHeight=150px;center:yes;status:no;statusbar:no");                
        //判断是否返回有效信息
        if(typeof(sReturnValue) != "undefined" && sReturnValue.length != 0 && sReturnValue != '_CANCEL_'){
            sReturnValue = sReturnValue.split("@");
            //得到客户输入信息
            sCustomerOrgType = sReturnValue[0];
            sCustomerName = sReturnValue[1];
            sCertType = sReturnValue[2];
            sCertID = sReturnValue[3];
        
            //检查客户信息存在状态
            sReturnStatus = RunMethod("CustomerManage","CheckCustomerAction",sCustomerType+","+sCustomerName+","+sCertType+","+sCertID+",<%=CurUser.getUserID()%>");
            //得到客户信息检查结果和客户号
            sReturnStatus = sReturnStatus.split("@");
            sStatus = sReturnStatus[0];
            sCustomerID = sReturnStatus[1];
            sHaveCustomerType = sReturnStatus[2];
            sHaveCustomerTypeName = sReturnStatus[3];
            sHaveStatus = sReturnStatus[4];

			//由于是公共页面，检查当前引入的客户客户类型是否与当前页面操作的客户类型一致
			if(sStatus != "01"){
				if(sCustomerType != sHaveCustomerType){
					alert("客户号："+sCustomerID+"，属于："+sHaveCustomerTypeName+"，不能在此引入");
					return;
				}
			}
            
            //02为当前用户以与该客户建立有效关联
            if(sStatus == "02"){
                if(sHaveCustomerType == sCustomerType){
                    alert(getMessageText('ALS70105')); //该客户已被自己引入过，请确认！
                }else{
                    alert("客户号："+sCustomerID+"已在"+sHaveCustomerTypeName+"客户管理页面被自己引入过，请确认！");
                }
                return;
            }
            //01为该客户不存在本系统中
            if(sStatus == "01"){                
                //取得客户编号
                sCustomerID = getSerialNo("CUSTOMER_INFO","CustomerID","");
            }
            //01 当检查结果为无该客户
            //04 没有和任何客户建立主办权
            //05 和其他客户建立主办权时进行对数据库操作
            if(sStatus == "01" || sStatus == "04" || sStatus == "05"){
                //参数说明CustomerID,CustomerName,CustomerType,CertType,CertID,Status,CustomerOrgType,UserID,OrgID
                var sParam = "";
                sParam = sCustomerID+","+sCustomerName+","+sCustomerType+","+sCertType+","+sCertID+
                         ","+sStatus+","+sCustomerOrgType+",<%=CurUser.getUserID()%>,<%=CurUser.getOrgID()%>,"+sHaveCustomerType;
                sReturn = RunMethod("CustomerManage","AddCustomerAction",sParam);
                //当该客户与其他用户建立有效关联且为企业客户和关联集团 ,需要向系统管理员申请权限
                if(sReturn == "1"){
                    if(sStatus == "05"){
                        if(confirm("客户号："+sCustomerID+"已成功引入，要立即申请该客户的权限吗？")) //客户已成功引入，要立即申请该客户的管户权吗？
                            popComp("RoleApplyInfo","/CustomerManage/RoleApplyInfo.jsp","CustomerID="+sCustomerID+"&UserID=<%=CurUser.getUserID()%>&OrgID=<%=CurOrg.getOrgID()%>","");
                    }else if(sStatus == "04"){
                        alert("客户号："+sCustomerID+"已成功引入!");
                    }else if(sStatus == "01"){
                        alert("客户号："+sCustomerID+"新增成功!"); //新增客户成功
                    }                                   
                //当该客户没有与任何用户建立有效关联、当前用户以与该客户建立无效关联、该客户与其他用户建立有效关联（个人客户/个体工商户/农户/联保小组）已经引入客户
                }else if(sReturn == "2"){
                    alert("引入客户号："+sCustomerID+"的客户类型为"+sHaveCustomerTypeName+"，不能在本页面引入！");
                //已经新增客户
                }else{
                    alert("新增客户失败！"); //新增客户成功
                    return;
                }
            }           
            if(sStatus == "01" || sStatus == "04"){
                //如果是中小企业，要更新其认定状态为未认定.
                if(sCustomerType == "0120")
                    RunMethod("CustomerManage","UpdateCustomerStatus",sCustomerID+","+"0");             
            }
            openObject("Customer",sCustomerID,"001");
            reloadSelf();
        }
    }
    
    /*~[Describe=删除记录;InputParam=无;OutPutParam=无;]~*/
    function deleteRecord(){
    	var sCustomerID = getItemValue(0,getRow(),"CustomerID");        
        if (typeof(sCustomerID)=="undefined" || sCustomerID.length==0){
            alert(getHtmlMessage('1')); //请选择一条信息！
            return;
        }
        
        if(confirm(getHtmlMessage('2'))){ //您真的想删除该信息吗？
            sReturn = PopPage("/CustomerManage/DelCustomerBelongAction.jsp?CustomerID="+sCustomerID+"","","");
            if(sReturn == "ExistApply"){
                alert(getMessageText('ALS70113'));//该客户所属申请业务未终结，不能删除！
                return;
            }
            if(sReturn == "ExistApprove"){
                alert(getMessageText('ALS70112'));//该客户所属最终审批意见业务未终结，不能删除！
                return;
            }
            if(sReturn == "ExistContract"){
                alert(getMessageText('ALS70111'));//该客户所属合同业务未终结，不能删除！
                return;
            }
            if(sReturn == "DelSuccess"){
                alert(getMessageText('ALS70110'));//该客户所属信息已删除！
                reloadSelf();
            }
        }
    }
    
    //客户信息预警
    function alarmCustInfo(){
    	var sCustomerID = getItemValue(0,getRow(),"CustomerID");
        if (typeof(sCustomerID)=="undefined" || sCustomerID.length==0){
            alert(getHtmlMessage('1')); //请选择一条信息！
        }else {
            sReturn = autoRiskScan("005","ObjectType=Customer&ObjectNo="+sCustomerID);      
        }       
    }

    /*~[Describe=查看及修改详情;InputParam=无;OutPutParam=无;]~*/
    function viewAndEdit(){
		var sCustomerID = getItemValue(0,getRow(),"CustomerID");
		if (typeof(sCustomerID) == "undefined" || sCustomerID.length == 0){
		    alert(getHtmlMessage('1'));//请选择一条信息！
		    return;
		}
		openObject("Customer",sCustomerID,"001");
		reloadSelf();
    }

	/*~[Describe=填写调查报告;InputParam=无;OutPutParam=无;]~*/
	function genReport(){
		//获得申请类型、申请流水号
		var sObjectType = "Customer";
		var sObjectNo = getItemValue(0,getRow(),"CustomerID");
		var sDocID = "S01";
		if (typeof(sObjectNo)=="undefined" || sObjectNo.length==0){
			alert(getHtmlMessage('1'));//请选择一条信息！
			return;
		}			

		var sReturn = PopPage("/FormatDoc/AddData.jsp?DocID="+sDocID+"&ObjectNo="+sObjectNo+"&ObjectType="+sObjectType+"&CustomerID="+sObjectNo,"","");
		if(typeof(sReturn)!='undefined' && sReturn!=""){
			sReturnSplit = sReturn.split("?");
			var sFormName=randomNumber().toString();
			sFormName = "AA"+sFormName.substring(2);
			OpenComp("FormatDoc",sReturnSplit[0],sReturnSplit[1],"_blank",OpenStyle); 
		}
	}
	
	/*~[Describe=生成调查报告;InputParam=无;OutPutParam=无;]~*/
	function createReport(){
		//获得申请类型、申请流水号、客户编号
		var sObjectType = "Customer";
		var sObjectNo   = getItemValue(0,getRow(),"CustomerID");
		var sCustomerID = getItemValue(0,getRow(),"CustomerID");
		if (typeof(sObjectNo)=="undefined" || sObjectNo.length==0){
			alert(getHtmlMessage('1'));//请选择一条信息！
			return;
		}	
		
		var sDocID = AsControl.RunJsp("/FormatDoc/ReportTypeSelect.jsp","ObjectNo="+sObjectNo+"&ObjectType="+sObjectType);
		if (typeof(sDocID)=="undefined" || sDocID.length==0){
			alert(getMessageText('ALS70505'));//调查报告还未填写，请先填写调查报告再查看！
			return;
		}
		var sAttribute = "";
		if (confirm(getMessageText('ALS70504'))){ //是否要增加打印内容,如果是请点击确定按钮！
			sAttribute = PopPage("/FormatDoc/DefaultPrint/DefaultPrintSelect.jsp?DocID="+sDocID,"","dialogWidth=580px;dialogHeight=350px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;");
			if (typeof(sAttribute)=="undefined" || sAttribute.length==0 || sAttribute == "_none_") return;
		}else{
			sAttribute = PopPage("/FormatDoc/DefaultPrint/GetAttributeAction.jsp?DocID="+sDocID,"","");
			if (typeof(sAttribute)=="undefined" || sAttribute.length==0) return;
		}
		var CurOpenStyle = "width=720,height=540,top=20,left=20,toolbar=no,scrollbars=yes,resizable=yes,status=yes,menubar=no,";
		OpenPage("/FormatDoc/ProduceFile.jsp?DocID="+sDocID+"&ObjectNo="+sObjectNo+"&ObjectType="+sObjectType+"&CustomerID="+sCustomerID+"&Attribute="+sAttribute,"_blank02",CurOpenStyle); 
	}	
	
	/*~[Describe=查看调查报告;InputParam=无;OutPutParam=无;]~*/
	function viewReport(){
		//获得申请类型、申请流水号
		var sObjectType = "Customer";
		var sObjectNo = getItemValue(0,getRow(),"CustomerID");
		if (typeof(sObjectNo)=="undefined" || sObjectNo.length==0){
			alert(getHtmlMessage('1'));//请选择一条信息！
			return;
		}
		
		var sDocID = AsControl.RunJsp("/FormatDoc/ReportTypeSelect.jsp","ObjectNo="+sObjectNo+"&ObjectType="+sObjectType);
		if (typeof(sDocID)=="undefined" || sDocID.length==0){
			alert(getMessageText('ALS70505'));//调查报告还未填写，请先填写调查报告再查看！
			return;
		}
		
		var sReturn = AsControl.RunJsp("/FormatDoc/GetReportFile.jsp","ObjectNo="+sObjectNo+"&ObjectType="+sObjectType+"&DocID="+sDocID);
		if (sReturn == "false"){
			createReport();
			return;
		}else{
			if(confirm(getMessageText('ALS70503'))){ //调查报告有可能更改，是否生成调查报告后再查看！
				createReport();
				return; 
			}else{
				var CurOpenStyle = "width=720,height=540,top=20,left=20,toolbar=no,scrollbars=yes,resizable=yes,status=yes,menubar=no,";
				OpenPage("/FormatDoc/PreviewFile.jsp?DocID="+sDocID+"&ObjectNo="+sObjectNo+"&ObjectType="+sObjectType,"_blank02",CurOpenStyle); 
			}
		}
	}
    
    /*~[Describe=查询客户开户信息;InputParam=无;OutPutParam=无;]~*/
    function queryCusomerInfo(){
    	var sCustomerID = getItemValue(0,getRow(),"CustomerID");
    	var sCertID = getItemValue(0,getRow(),"CertID");
        if (typeof(sCustomerID)=="undefined" || sCustomerID.length==0){
            alert(getHtmlMessage('1'));//请选择一条信息！
            return;
        }
        
        var sReturn = PopPage("/CustomerManage/QueryCustomer.jsp?CertID="+sCertID,"","");
        if(typeof(sReturn) != "undefined"){
            sReturn=sReturn.split("@");
            sStatus=sReturn[0];
            sMessage=sReturn[1];
            if(sStatus == "0"){
                sReturn = "操作成功！交易代码：" + "Q001" + "核心客户号为："+ sMessage + "更新数据库成功！";
            }else{
                sReturn = "核心提示："+"Q002"+" 交易失败！失败信息：" + sMessage;
            }
            alert(sReturn);
        }
    }
</script>   
<%@ include file="/Frame/resources/include/include_end.jspf"%>