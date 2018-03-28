<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>
<%
	/* ҳ��˵��: ʾ������ҳ�� */
	String PG_TITLE = "����������Ϣ����";

	// ���ҳ�����
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
	
	//��ֻ�ܲ�ѯ��ģ�������ر��水ť
	String sIsQuery = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("IsQuery"));
	if(sIsQuery == null) sIsQuery = "";
	//�����ڴ���ҳ���еı������ذ�ť������
	String sQueryType = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("QueryType"));
	if(sQueryType == null) sQueryType = "";

	String sShow = "true";
	//ֻҪ��HIS��,�������ۺϲ�ѯ���õ�ҳ��,����ӵ�в鿴Ȩ�޶���ӵ��ά��Ȩ��,��ô�����ذ�ť
	if(sQueryType.equals("ERROR")){
		if(sFlag.equals("his")||sIsQuery.equals("true")||(CurUser.hasRole("0200")&&!CurUser.hasRole("0201"))){
		sShow = "false";
		}	
	}else{
		if(sFlag.equals("his")||sIsQuery.equals("true")||(CurUser.hasRole("0100")&&!CurUser.hasRole("0101"))){
			sShow = "false";
		}	
	}
	
	// ͨ��DWģ�Ͳ���ASDataObject����doTemp
	String sTempletNo =sDono;//ģ�ͱ��
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
	
	   //��from��������		
			doTemp.SelectClause=doTemp.SelectClause.replace("ECR_", "HIS_");
			doTemp.FromClause=doTemp.FromClause.replace("ECR_", "HIS_");


	if(doTemp.getColumn("REGISTERTYPE")!=null)
		doTemp.setDDDWSql("REGISTERTYPE", "SELECT PBCode,Note FROM ECR_codemap where colname='9039'");//ע������
	if(doTemp.getColumn("CAPITALCURRENCY")!=null)
			doTemp.setDDDWSql("CAPITALCURRENCY", "SELECT PbCode,Note FROM ECR_codemap where colname='1501' ");//����
	doTemp.setDDDWCodeTable("CUSTOMERTYPE", "1,�������ͻ�,2,�Ŵ����ͻ�,3,���ǻ����������Ŵ���,X,δ֪");
	doTemp.setDDDWCodeTable("ORGTYPE", "1,��ҵ,2,��ҵ��λ,3,����,4,�������,7,���幤�̻�,9,����");//��֯�������
	if(doTemp.getColumn("ORGNATURE")!=null)
		doTemp.setDDDWSql("ORGNATURE", "SELECT distinct PBCODE ,NOTE   FROM ECR_codemap where colname='9044' ");//��������
	if(doTemp.getColumn("ORGTYPESUB")!=null)
			doTemp.setDDDWSql("ORGTYPESUB", "SELECT PbCode,Note FROM ECR_codemap where colname='9045' ");//��֯�������ϸ��
	doTemp.setDDDWCodeTable("SCOPE", "2,������ҵ,3,������ҵ,4,С����ҵ,5,΢����ҵ,9,����,X,δ֪");//��ҵ��ģ
	doTemp.setDDDWCodeTable("ACCOUNTSTATUS", "1,����,2,����,3,ע��,4,�����,9,����,X,δ֪");//������״̬
	doTemp.setDDDWCodeTable("INCREMENTFLAG", "1,����,2,ҵ����,4,ɾ��,6,�ֹ��ս�,8,��Ǩ��");//��Ϣ����״̬
	doTemp.setDDDWCodeTable("ORGSTATUS", "1,����,2,ע��,9,����,X,δ֪");//����״̬
	doTemp.setDDDWCodeTable("MANAGERTYPE", "0,ʵ�ʿ�����,1,���³�,2,�ܾ���/��Ҫ������,3,��������,4,���³�,5,����������");//��ϵ������
	if(doTemp.getColumn("CERTTYPE")!=null)
		doTemp.setDDDWSql("CERTTYPE", "SELECT PBCode,Note FROM ECR_codemap where colname in ('9047','9039')");//֤������
	doTemp.setDDDWCodeTable("STOCKHOLDERTYPE", "1,��Ȼ��,2,����");//�ɶ�����
	doTemp.setDDDWCodeTable("MEMBERRELATYPE", "1,��ż,2,��ĸ,3,��Ů,4,����Ѫ��,5,��������");
	if(doTemp.getColumn("MANAGERCERTTYPE")!=null||doTemp.getColumn("MEMBERCERTTYPE")!=null)
		doTemp.setDDDWSql("MANAGERCERTTYPE,MEMBERCERTTYPE", "SELECT PBCode,Note FROM ECR_codemap where colname in('9047','9039')");//֤������
	if(doTemp.getColumn("RELATIONSHIP")!=null)
		doTemp.setDDDWSql("RELATIONSHIP", "SELECT PBCode,Note FROM ECR_codemap where colname ='9049' ");//������ҵ��������
		
	//doTemp.setDefaultValue("OCCURDATE",StringFunction.getToday());
	doTemp.setDefaultValue("UPDATEDATE",StringFunction.getToday());	
	ASDataWindow dwTemp = new ASDataWindow(CurPage,doTemp,Sqlca);
	dwTemp.Style="2";      // ����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0"; // �����Ƿ�ֻ�� 1:ֻ�� 0:��д
	if("false".equals(sShow))dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	else dwTemp.ReadOnly = "0";
	//����HTMLDataWindow
	if(sKeyValue!=null&&sKeyValue.length()>0)sKeyValue=sKeyValue.replace("@", ",").substring(0, sKeyValue.length()-1);
	Vector vTemp = dwTemp.genHTMLDataWindow(sKeyValue);//�������,���ŷָ�
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));	

	String sButtons[][] = {
		{sShow,"","Button","����","���������޸�","saveRecord()",sResourcesPath},
	};
%>
<%@include file="/Resources/CodeParts/Info05.jsp"%>
<script type="text/javascript">
	var bIsInsert = false; // ���DW�Ƿ��ڡ�����״̬��
	function saveRecord(sPostEvents){
		if (!ValidityCheck()) return;
		as_save("myiframe0",sPostEvents);
	}
	//���У����Ϣ
	function ValidityCheck(){
		var sDono="<%=sDono%>";
		if("ORGANINFOINFO"==sDono){		
			//�������ô���У��
			var CreditCode = getItemValue(0,0,"CREDITCODE");
			if(CreditCodeCheck(CreditCode)==false&&typeof(CreditCode)!="undefined"&&CreditCode!=""){
				alert("�������ô����ʽ����");
				return false;
			}
			//��֯��������У��
			var sCorpID=getItemValue(0,0,"CORPID");
			if(typeof(sCorpID)!="undefined"&&sCorpID!=""){
				if(!CheckORG(sCorpID)){
					alert('��֯����������������!');
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
             alert("֤������/�Ǽ�ע����롢��֯�������롢�������ô��벻��ȫΪ�գ�");
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

	
	//��ȡ����
	function getCountryName()
	{
		var sREGISTERCOUNTRY = getItemValue(0,0,"REGISTERCOUNTRY");
		var sReturn = PopComp("GetMyFrame","/DataMaintain/GetMyFrame.jsp","DataType=5509&IniteValue="+sREGISTERCOUNTRY,"dialogWidth:320px;dialogHeight:540px;resizable:no;scrollbars:no;status:no;help:no");
		if(typeof(sReturn)=="undefined" || sReturn=="") return;
		var sReturnvalues = sReturn.split("@");
		setItemValue(0,0,"REGISTERCOUNTRY",sReturnvalues[0]);
		setItemValue(0,0,"REGISTERCOUNTRYNAME",sReturnvalues[1]);
	}
	
	//��ҵ����
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
	
	//��ʾ��ʷ��¼
	function showHISContent(sDono,sCIFCustomerID){
		var sDono=sDono.substring(0,sDono.length-4)+"LIST";
		AsControl.OpenView("/DataMaintain/OrgnizationManage/OrgnizationBaseList.jsp","sFlag=his&sDono="+sDono+"&sCIFCustomerID="+sCIFCustomerID,"_blank","");
	}
	
	function initRow(){
		if (getRowCount(0)==0){//�統ǰ�޼�¼��������һ��
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
