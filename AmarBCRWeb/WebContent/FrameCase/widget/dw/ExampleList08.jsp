<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBegin.jsp"%><%
	/*
		ҳ��˵��: DataWindow���ݹ�����ʾ��ҳ��
	 */
	String PG_TITLE = "DataWindow���ݹ�����ʾ��ҳ��";

	//ͨ��DWģ�Ͳ���ASDataObject����doTemp
	ASDataObject doTemp = new ASDataObject("ExampleList",Sqlca);
	
	//���ɲ�ѯ�������ApplySum�������Ĳ�ѯ����(�ֶ�)��DWģ��(��ʾģ��)�ﹴѡ���ɲ�ѯ��
//	doTemp.setFilter(Sqlca,"1","ApplySum","Operators=BetweenNumber;DOFilterHtmlTemplate=Number");//������������
//	doTemp.setFilter(Sqlca,"2","InputUser","Operators=EqualsString;HtmlTemplate=PopSelect");
	
	//��ʼ������ʾ�б�����,haveReceivedFilterCriteria()��ȡ�Ƿ���յ�filter����������״̬
	//if(!doTemp.haveReceivedFilterCriteria()) doTemp.WhereClause+=" and 1=2";
	
	ASDataWindow dwTemp = new ASDataWindow(CurPage ,doTemp,Sqlca);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д

	//����HTMLDataWindow
	Vector vTemp = dwTemp.genHTMLDataWindow("");
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));

	String sButtons[][] = {};
%><%@include file="/Resources/CodeParts/List05.jsp"%>
<script type="text/javascript">
	<%/*~[Describe=��ѯ���������Ի���;]~*/%>
	function filterAction(sObjectID,sFilterID,sObjectID2,sColName){
		//alert([sObjectID,sFilterID,sObjectID2,sColName]);
		var oMyObj = document.getElementById(sObjectID);
		var oMyObj2 = document.getElementById(sObjectID2);
		if(sColName.toUpperCase()=="INPUTUSER"){
			var sParaString = "SortNo,<%=CurOrg.getSortNo()%>";
			var sReturn =setObjectValue("SelectUserInOrg",sParaString,"",0,0,"");
			if(typeof(sReturn) == "undefined" || sReturn == "_CANCEL_")
				return;
			
			if(sReturn == "_CLEAR_"){
				oMyObj.value = "";
				oMyObj2.value = "";
			}else{
				sReturns = sReturn.split("@");
				oMyObj.value=sReturns[0];
				oMyObj2.value=sReturns[1];
			}
		}else if(sColName.toUpperCase()=="CUSTOMERTYPE"){ // ������ģ����
			var sReturn = AsDialog.OpenSelector("SelectCodes", "CodeNo,CustomerType", "");
			if(typeof(sReturn) == "undefined" || sReturn == "_CANCEL_")
				return;
			
			if(sReturn == "_CLEAR_"){
				oMyObj.value = "";
				oMyObj2.value = "";
			}else{
				var items = sReturn.split("~");
				var nos = "";
				var names = "";
				for(var i = 0; i < items.length; i++){
					if(!items[i]) continue;
					var item = items[i].split("@");
					nos += "|"+item[0]; // �����ԡ�|�����ָ���
					names += "|"+item[1]; // ����������������ָ�������Ϊ��ʾʹ��
				}
				
				oMyObj.value = nos.substring(1);
				oMyObj2.value = names.substring(1)
			}
		}
	}

	$(document).ready(function(){
		AsOne.AsInit();
		init();
		my_load(2,0,'myiframe0');
		//չ����ѯ����
		if(<%=!"true".equals(CurPage.getParameter("DWInSearch"))%>)
			showFilterArea();
	});
</script>
<%@ include file="/IncludeEnd.jsp"%>