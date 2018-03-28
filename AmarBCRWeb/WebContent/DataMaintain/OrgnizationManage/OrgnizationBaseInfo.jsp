<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%>
<%
	/* 页面说明: 示例详情页面 */
	String PG_TITLE = "机构基本信息详情";

	// 获得页面参数
	String sCIFCustomerID =  CurPage.getParameter("sCIFCustomerID");
	if(sCIFCustomerID==null) sCIFCustomerID="";
	String sKeyValue =  CurPage.getParameter("sKeyValue");
	if(sKeyValue==null||"".equals(sKeyValue)) sKeyValue=sCIFCustomerID+"@";
	String sKeyName= CurPage.getParameter("sKeyName");
	if(sKeyName==null) sKeyName="";
	String sSessionID= CurPage.getParameter("sSessionID");
	if(sSessionID==null) sSessionID="";
	String sTable =  CurPage.getParameter("sTable");
	if(sTable==null) sTable="";
	String sFlag =  CurPage.getParameter("sFlag");
	if(sFlag==null) sFlag="";
	String sFlags =  CurPage.getParameter("sFlags");
	if(sFlags==null) sFlags="";
	//在只能查询的模块中隐藏保存按钮
	String sIsQuery = CurComp.getParameter("IsQuery");
	if(sIsQuery == null) sIsQuery = "";
	//用于在错误页面中的保存和相关按钮的隐藏
	String sQueryType = CurComp.getParameter("QueryType");
	if(sQueryType == null) sQueryType = "";

	String sShow = "true";
	//只要是HIS表,或者是综合查询调用的页面,并且拥有查看权限而不拥有维护权限,那么就隐藏按钮
	if(sQueryType.equals("ERROR")){
		if(sFlag.equals("his")||sIsQuery.equals("true")||(CurUser.hasRole("0200")&&!CurUser.hasRole("0201"))){
		sShow = "false";
		}	
	}else{
		if(sFlag.equals("his")||sIsQuery.equals("true")||(CurUser.hasRole("0100")&&!CurUser.hasRole("0101"))){
			sShow = "false";
		}	
	}
	
	//历史表将from条件更改
	if(sFlag.equals("his"))
		sTable=sTable.replace("ECR_", "HIS_");
	
	ASObjectModel doTemp = null;
	if(sTable.toUpperCase().equals("ECR_ORGANATTRIBUTE") ||sTable.toUpperCase().equals("HIS_ORGANATTRIBUTE")){
		 doTemp = new ASObjectModel("OrgAttributeInfo");
		 doTemp.setJboClass("jbo.ecr."+sTable);
	}else{ 
		BizObjectManager boManager = JBOFactory.getFactory().getManager("jbo.ecr."+sTable.toUpperCase());
		doTemp = new ASObjectModel(boManager);
		//设置数字类型右对齐
		for(DataElement de:boManager.getManagedClass().getAttributes()){
			if(de.getType()==DataElement.DOUBLE || de.getType()==DataElement.INT || de.getType()==DataElement.LONG){
				doTemp.setAlign(de.getName(), "3");
			}
		}
	}

	//更改where条件
	String jBOWhere="";
	String args="";

	if(sKeyName.isEmpty()&&(!sFlag.equals("new"))){
		 jBOWhere="CIFCustomerID=:CIFCustomerID";
	     args=sCIFCustomerID;
	}else{
		String[] nameArr=sKeyName.split("@");
		String[] valueArr=sKeyValue.split("@");
		for(int i=0; i<nameArr.length; i++){
			String k = nameArr[i];
			String v = valueArr[i];
			jBOWhere =jBOWhere+" and "+k+"=:"+k;
			args = args+","+v;
		}
		jBOWhere = jBOWhere.substring(4);
		args = args.substring(1);
	} 
	//历史表将from条件更改
	/* 	if(sFlag.equals("his")){			
			for(int i=0;i<sKeyName.split("@").length-1;i++)
			doTemp.WhereClause+=" and  "+sKeyName.split("@")[i]+"='"+sKeyValue.split("@")[i]+"' " +" and SESSIONID='"+sSessionID+"'" ;
		} */
    doTemp.setJboWhere(jBOWhere);
	
	doTemp.setVisible("ATTRIBUTE1,MODFLAG,TRACENUMBER,RECORDFLAG,ERRORCODE,SESSIONID,OCCURDATE", false);
	doTemp.setReadOnly("CIFCustomerID", true);
	doTemp.setRequired("CIFCustomerID,FINANCEID,CUSTOMERTYPE,GATHERDATE,UPDATEDATE", true);
    //日期格式
    doTemp.setEditStyle("GATHERDATE,OCCURDATE,REGISTERDATE,REGISTERDUEDATE,UPDATEDATE","Date");
    
    doTemp.setEditStyle("REGISTERTYPE,CAPITALCURRENCY,CUSTOMERTYPE,ORGTYPE,ORGNATURE,ORGTYPESUB,SCOPE,ACCOUNTSTATUS,INCREMENTFLAG,ORGSTATUS,MANAGERTYPE,CERTTYPE,STOCKHOLDERTYPE,RELATIONSHIP,MEMBERRELATYPE,MANAGERCERTTYPE,MEMBERCERTTYPE", "Select");
	doTemp.setDDDWJbo("REGISTERTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9039'"); //注册类型
	doTemp.setDDDWJbo("CAPITALCURRENCY", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='1501'"); //币种
	doTemp.setDDDWJbo("CUSTOMERTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9040'");
	doTemp.setDDDWJbo("ORGTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9043'");//组织机构类别
	doTemp.setDDDWJbo("ORGNATURE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9044'");//经济类型
    doTemp.setDDDWJbo("ORGTYPESUB", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9045'");//组织机构类别细分
	doTemp.setDDDWJbo("SCOPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9050'");//企业规模
	doTemp.setDDDWJbo("ACCOUNTSTATUS", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9042'");//基本户状态
	doTemp.setDDDWCodeTable("INCREMENTFLAG", "1,新增,2,业务变更,4,删除,6,手工终结,8,已迁移");//信息操作状态
	doTemp.setDDDWJbo("ORGSTATUS", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9041'");//机构状态
	doTemp.setDDDWJbo("MANAGERTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9046'");//关系人类型
	doTemp.setDDDWJbo("STOCKHOLDERTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9048'");//股东类型
	if(sTable.equals("ECR_ORGANSTOCKHOLDER")||sTable.equals("HIS_ORGANSTOCKHOLDER"))
		doTemp.setDDDWJbo("CERTTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname in ('9047','9039')");//证件类型
	else
		doTemp.setDDDWJbo("CERTTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9047'");//证件类型
	doTemp.setDDDWJbo("MEMBERRELATYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='5555'");
	doTemp.setDDDWJbo("MANAGERCERTTYPE,MEMBERCERTTYPE", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9047'");//证件类型
	doTemp.setDDDWJbo("RELATIONSHIP", "jbo.ecr.WEB_CODEMAP,pbcode,note,colname='9049'");//关联企业关联类型
	doTemp.setUnit("RegistercountryName","<input type=button class=inputDate   value=\"...\" name=button1 onClick=\"javascript:getRegisterCountryAnIndustry('5509');\"> ");
	doTemp.setUnit("IndustryName","<input type=button class=inputDate   value=\"...\" name=button2 onClick=\"javascript:getRegisterCountryAnIndustry('5525');\"> ");
	doTemp.setDefaultValue("UPDATEDATE",DateX.format(new java.util.Date(), "yyyy/MM/dd")); 
     
	doTemp.setColCount(2);
   
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="2";      // 设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; // 设置是否只读 1:只读 0:可写
	if("false".equals(sShow))dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	else dwTemp.ReadOnly = "0";
	dwTemp.genHTMLObjectWindow(args);//传入参数,逗号分割 
	
	
	String sButtons[][] = {
		{sShow,"","Button","保存","保存所有修改","saveRecord()","","","",""},
		{((sFlags.equals("Info")&&!sFlag.equals("his"))||"syn".equals(sFlag))?"false":"true","","Button","返回","返回列表页面","goBack('"+sFlag+"')","","","",""},
		{(sFlags.equals("Info")&&!sFlag.equals("his"))?"true":"false","","Button","查看历史记录","查看历史记录","showHISContent('"+sTable+"','"+sKeyValue.split(",")[0]+"')","","","",""} 
	};
%>
<%@include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
	function saveRecord(){
		if (!ValidityCheck()) return;
		as_save("myiframe0");
	}
	//添加校验信息
	function ValidityCheck(){
		var sTable="<%=sTable%>";
		if("ECR_ORGANINFO"==sTable || "HIS_ORGANINFO"==sTable){
			//机构信用代码校验
			var CreditCode = getItemValue(0,0,"CREDITCODE");
			if(CreditCodeCheck(CreditCode)==false&&typeof(CreditCode)!="undefined"&&CreditCode!=""){
				alert("机构信用代码格式错误！");
				return false;
			}
			//组织机构代码校验
			var sCorpID=getItemValue(0,0,"CORPID");
			if(typeof(sCorpID)!="undefined"&&sCorpID!=""){
				if(!CheckORG(sCorpID)){
					alert('组织机构代码输入有误!');
					return false;
				}
			}
		}
		//贷款卡编号校验
		var sLoanCardNo = getItemValue(0,0,"LOANCARDNO");
		if(typeof(sLoanCardNo)!="undefined"&&sLoanCardNo!=""){
			if(!CheckLoanCardID(sLoanCardNo)){
				alert('贷款卡编号输入有误!');
				return false;
			}
		}
	
		var sSTOCKHOLDERTYPE = getItemValue(0,0,"STOCKHOLDERTYPE");
		var sCERTID=getItemValue(0,0,"CERTID");
		var sCORPID=getItemValue(0,0,"CORPID");
		var sCREDITCODE=getItemValue(0,0,"CREDITCODE");
		if(sSTOCKHOLDERTYPE=="2"){
			if((sCERTID==""||sCERTID==null)&&(sCORPID==""||sCORPID==null)&&(sCREDITCODE==""||sCREDITCODE==null)){
             alert("证件号码/登记注册号码、组织机构代码、机构信用代码不能全为空！");
	         return false;
		   }
		}		
		return true;
	}
	
	//获取国别和经济行业类型
 	function getRegisterCountryAnIndustry(scolName){
		var sReturn = PopComp("GetMyFrame","/DataMaintain/GetMyFrame.jsp","DataType="+scolName,"dialogWidth:320px;dialogHeight:540px;resizable:no;scrollbars:no;status:no;help:no");
		if(typeof(sReturn)=="undefined" || sReturn=="") return;
		var sReturnvalues = sReturn.split("@");
		 if(scolName=="5509"){
		    setItemValue(0,0,"REGISTERCOUNTRY",sReturnvalues[0]);
		    setItemValue(0,0,"RegistercountryName",sReturnvalues[1]);	
		}else if(scolName="5525"){
			 setItemValue(0,0,"INDUSTRY",sReturnvalues[0]);
			 setItemValue(0,0,"IndustryName",sReturnvalues[1]);	
		}else{
			return;
		} 
	}  
	
	//经济行业分类

		function CreditCodeCheck(CreditCode){
			var patt1 = new RegExp("[A-Z]{1}[0-9]{16}[0-9A-Z\\*]{1}");
			var result = patt1.test(CreditCode);
			return result;
		}

	function goBack(sFlag){
		if(sFlag=="his"){
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","sTable=<%=sTable%>&sFlag=his&sCIFCustomerID=<%=sKeyValue.split("@")[0]%>&IsQuery=<%=sIsQuery%>","_self");
		}else{					
		 OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","sTable=<%=sTable%>&sFlag=Detail&sCIFCustomerID=<%=sKeyValue.split("@")[0]%>&IsQuery=<%=sIsQuery%>","_self");
		}
	}
	
	//显示历史记录
	function showHISContent(sTable){
		AsControl.OpenView("/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","sFlag=his&sTable="+sTable+"&sCIFCustomerID=<%=sKeyValue.split("@")[0]%>","_blank","");
	}
	
	function initRow(){
		if (getRowCount(0)==0){//如当前无记录，则新增一条
			setItemValue(0,getRow(),"CIFCustomerID","<%=sCIFCustomerID%>");
		}
    }
	
	initRow();
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>
