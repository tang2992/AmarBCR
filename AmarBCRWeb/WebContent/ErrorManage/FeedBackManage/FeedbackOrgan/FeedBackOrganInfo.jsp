<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<%
	/* 页面说明: 示例详情页面 */
	String PG_TITLE = "机构基本信息详情";

	// 获得页面参数
	String sCIFCustomerID =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("sCIFCustomerID"));
	if(sCIFCustomerID==null) sCIFCustomerID="";
	String sKeyValue =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("sKeyValue"));
	if(sKeyValue==null||"".equals(sKeyValue)) sKeyValue=sCIFCustomerID+"@";
	String sKeyName= DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("sKeyName"));
	if(sKeyName==null) sKeyName="";
	String sDono =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("sDono"));
	if(sDono==null) sDono="ORGANBASEINFO";
	String sFlag =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("sFlag"));
	if(sFlag==null) sFlag="";
	String sFlags =  DataConvert.toRealString(iPostChange,(String)CurPage.getParameter("sFlags"));
	if(sFlags==null) sFlags="";
	
	//在只能查询的模块中隐藏保存按钮
	String sIsQuery = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("IsQuery"));
	if(sIsQuery == null) sIsQuery = "";
	//用于在错误页面中的保存和相关按钮的隐藏
	String sQueryType = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("QueryType"));
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
	
	// 通过DW模型产生ASDataObject对象doTemp
	String sTempletNo =sDono;//模型编号
	ASDataObject doTemp = new ASDataObject(sTempletNo,Sqlca);
	
	doTemp.setLimit("CORPID", 10);
	doTemp.setLimit("FINANCEID", 11);
	doTemp.setLimit("OLDFINANCEID", 11);
	doTemp.setLimit("CREDITCODE", 18);
	doTemp.setLimit("REGISTERNO", 20);
	doTemp.setLimit("NATIONALTAXNO", 20);
	doTemp.setLimit("LOCALTAXNO", 20);
	doTemp.setLimit("ACCOUNTPERMITNO", 20);
	doTemp.setLimit("LOANCARDNO", 16);
	doTemp.setLimit("CHINESENAME", 80);
	doTemp.setLimit("ENGLISHNAME", 80);
	doTemp.setLimit("REGISTERADD", 80);
	doTemp.setLimit("ACCOUNTPERMITNO", 20);
	
	   //将from条件更改		
			doTemp.SelectClause=doTemp.SelectClause.replace("ECR_", "HIS_");
			doTemp.FromClause=doTemp.FromClause.replace("ECR_", "HIS_");


	if(doTemp.getColumn("REGISTERTYPE")!=null)
		doTemp.setDDDWSql("REGISTERTYPE", "SELECT PBCode,Note FROM ECR_codemap where colname='9039'");//注册类型
	if(doTemp.getColumn("CAPITALCURRENCY")!=null)
			doTemp.setDDDWSql("CAPITALCURRENCY", "SELECT PbCode,Note FROM ECR_codemap where colname='1501' ");//币种
	doTemp.setDDDWCodeTable("CUSTOMERTYPE", "1,基本户客户,2,信贷户客户,3,既是基本户又是信贷户,X,未知");
	doTemp.setDDDWCodeTable("ORGTYPE", "1,企业,2,事业单位,3,机关,4,社会团体,7,个体工商户,9,其他");//组织机构类别
	if(doTemp.getColumn("ORGNATURE")!=null)
		doTemp.setDDDWSql("ORGNATURE", "SELECT distinct PBCODE ,NOTE   FROM ECR_codemap where colname='9044' ");//经济类型
	if(doTemp.getColumn("ORGTYPESUB")!=null)
			doTemp.setDDDWSql("ORGTYPESUB", "SELECT PbCode,Note FROM ECR_codemap where colname='9045' ");//组织机构类别细分
	doTemp.setDDDWCodeTable("SCOPE", "2,大型企业,3,中型企业,4,小型企业,5,微型企业,9,其他,X,未知");//企业规模
	doTemp.setDDDWCodeTable("ACCOUNTSTATUS", "1,正常,2,久悬,3,注销,4,待审核,9,其他,X,未知");//基本户状态
	doTemp.setDDDWCodeTable("INCREMENTFLAG", "1,新增,2,业务变更,4,删除,6,手工终结,8,已迁移");//信息操作状态
	doTemp.setDDDWCodeTable("ORGSTATUS", "1,正常,2,注销,9,其他,X,未知");//机构状态
	doTemp.setDDDWCodeTable("MANAGERTYPE", "0,实际控制人,1,董事长,2,总经理/主要负责人,3,财务负责人,4,监事长,5,法定代表人");//关系人类型
	if(doTemp.getColumn("CERTTYPE")!=null)
		doTemp.setDDDWSql("CERTTYPE", "SELECT PBCode,Note FROM ECR_codemap where colname in ('9047','9039')");//证件类型
	doTemp.setDDDWCodeTable("STOCKHOLDERTYPE", "1,自然人,2,机构");//股东类型
	doTemp.setDDDWCodeTable("MEMBERRELATYPE", "1,配偶,2,父母,3,子女,4,其他血亲,5,其他姻亲");
	if(doTemp.getColumn("MANAGERCERTTYPE")!=null||doTemp.getColumn("MEMBERCERTTYPE")!=null)
		doTemp.setDDDWSql("MANAGERCERTTYPE,MEMBERCERTTYPE", "SELECT PBCode,Note FROM ECR_codemap where colname in('9047','9039')");//证件类型
	if(doTemp.getColumn("RELATIONSHIP")!=null)
		doTemp.setDDDWSql("RELATIONSHIP", "SELECT PBCode,Note FROM ECR_codemap where colname ='9049' ");//关联企业关联类型
		
	//doTemp.setDefaultValue("OCCURDATE",StringFunction.getToday());
	doTemp.setDefaultValue("UPDATEDATE",StringFunction.getToday());	
	ASDataWindow dwTemp = new ASDataWindow(CurPage,doTemp,Sqlca);
	dwTemp.Style="2";      // 设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; // 设置是否只读 1:只读 0:可写
	if("false".equals(sShow))dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	else dwTemp.ReadOnly = "0";
	//生成HTMLDataWindow
	if(sKeyValue!=null&&sKeyValue.length()>0)sKeyValue=sKeyValue.replace("@", ",").substring(0, sKeyValue.length()-1);
	Vector vTemp = dwTemp.genHTMLDataWindow(sKeyValue);//传入参数,逗号分割
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));	

	String sButtons[][] = {
		{sShow,"","Button","保存","保存所有修改","saveRecord()",sResourcesPath},
	};
%>
<%@include file="/Resources/CodeParts/Info05.jsp"%>
<script type="text/javascript">
	var bIsInsert = false; // 标记DW是否处于“新增状态”
	function saveRecord(sPostEvents){
		if (!ValidityCheck()) return;
		as_save("myiframe0",sPostEvents);
	}
	//添加校验信息
	function ValidityCheck(){
		var sDono="<%=sDono%>";
		if("ORGANINFOINFO"==sDono){		
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

	function CreditCodeCheck(CreditCode){
		var patt1 = new RegExp("[A-Z]{1}[0-9]{16}[0-9A-Z\\*]{1}");
		var result = patt1.test(CreditCode);
		return result;
	}

	
	//获取国别
	function getCountryName()
	{
		var sREGISTERCOUNTRY = getItemValue(0,0,"REGISTERCOUNTRY");
		var sReturn = PopComp("GetMyFrame","/DataMaintain/GetMyFrame.jsp","DataType=5509&IniteValue="+sREGISTERCOUNTRY,"dialogWidth:320px;dialogHeight:540px;resizable:no;scrollbars:no;status:no;help:no");
		if(typeof(sReturn)=="undefined" || sReturn=="") return;
		var sReturnvalues = sReturn.split("@");
		setItemValue(0,0,"REGISTERCOUNTRY",sReturnvalues[0]);
		setItemValue(0,0,"REGISTERCOUNTRYNAME",sReturnvalues[1]);
	}
	
	//行业类型
		function getIndustryType()
	{
		var sIndustryType = getItemValue(0,0,"INDUSTRY");
		var sReturn = PopComp("IndustryVFrame","/DataMaintain/IndustryVFrame.jsp","IndustryType="+sIndustryType,"dialogWidth:730px;dialogHeight:540px;resizable:no;scrollbars:no;status:no;help:no");
		if(typeof(sReturn)=="undefined" || sReturn=="") return;
		var sReturnvalues = sReturn.split("@");
		setItemValue(0,0,"INDUSTRY",sReturnvalues[0]);
		setItemValue(0,0,"INDUSTRYNAME",sReturnvalues[1]);
	}
	
	function goBack(sFlag){
		if(sFlag=="his"){
			OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","sDono=<%=sDono.substring(0,sDono.length()-4)+"LIST"%>&sFlag=his&sCIFCustomerID=<%=sKeyValue.split(",")[0]%>&IsQuery=<%=sIsQuery%>","_self");
		}else{					
		 OpenComp("OrgnizationBaseList","/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","sDono=<%=sDono.replace("INFO","LIST")%>&sFlag=Detail&sCIFCustomerID=<%=sKeyValue.split(",")[0]%>&IsQuery=<%=sIsQuery%>","_self");
		}
	}
	
	//显示历史记录
	function showHISContent(sDono,sCIFCustomerID){
		var sDono=sDono.substring(0,sDono.length-4)+"LIST";
		AsControl.OpenView("/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","sFlag=his&sDono="+sDono+"&sCIFCustomerID="+sCIFCustomerID,"_blank","");
	}
	
	function initRow(){
		if (getRowCount(0)==0){//如当前无记录，则新增一条
			as_add("myiframe0");
			bIsInsert = true;
		}
    }
	
	$(document).ready(function(){
		AsOne.AsInit();
		init();
		bFreeFormMultiCol = false;
		my_load(2,0,'myiframe0');
		initRow();
	});
</script>
<%@ include file="/IncludeEnd.jsp"%>
