<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		ҳ��˵��:ʾ��������Ϣ�鿴ҳ��
	 */
	String PG_TITLE = "��Ϣά���б�"; // ��������ڱ��� <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;��Ϣά���б�&nbsp;&nbsp;"; //Ĭ�ϵ�����������
	String PG_CONTNET_TEXT = "��������б�";//Ĭ�ϵ�����������
	String PG_LEFT_WIDTH = "200";//Ĭ�ϵ�treeview���

	//�������
	ASResultSet rs = null;
	String sSql="";
	int size=79;
	String sCustomerID = CurPage.getParameter("CustomerID");
	if(sCustomerID == null) sCustomerID = "";
	//��ȡ����
	String sLOANCARDNO = CurPage.getParameter("LoanCardNo");
	if(sLOANCARDNO == null) sLOANCARDNO = "";

	//��ȡ���е���صĹ�����Ϣ�������ͻ�ID,�ͻ�����,�������
	sSql=" select CIFCUSTOMERID,GETRORGANNAME(CIFCUSTOMERID),LOANCARDNO from ECR_ORGANINFO  where CIFCUSTOMERID='"+sCustomerID+"'";
	rs = Sqlca.getASResultSet(new SqlObject(sSql));
%>
<div id="view_top" style="overflow:auto;">
	<%@include file="/Resources/CodeParts/Table03.jsp"%> 
</div>
<%
	rs.getStatement().close();
%>
<%	
	String[][] sTableName = {
			{"ECR_ORGANINFO","����˸ſ���Ϣ"},
			{"ECR_LOANCONTRACT","����˴����ͬ��Ϣ"},
			{"ECR_FACTORING","����˱�����Ϣ"},
			{"ECR_DISCOUNT","�����Ʊ��������Ϣ"},
			{"ECR_FINAINFO","�����ó��������Ϣ"},
			{"ECR_CREDITLETTER","���������֤��Ϣ"},
			{"ECR_GUARANTEEBILL","����˱���ҵ����Ϣ"},
			{"ECR_ACCEPTANCE","����˳жһ�Ʊ��Ϣ"},
			{"ECR_CUSTOMERCREDIT","����˹���������Ϣ"},
			{"ECR_FLOORFUND","����˵����Ϣ"}
		};

		sSql = "select 0, count(*) from " +  sTableName[0][0] +" where LSCustomerID='"+sCustomerID+"'";
		String  sLoanCardNoName = "LoanCardNo";
		for(int k=1;k<sTableName.length;k++){
			sSql = sSql + " union all " + "select "+k+", count(*) from " + sTableName[k][0] +" where LoanCardNo='" +sLOANCARDNO+"'";
		}
		rs = Sqlca.getASResultSet(new SqlObject(sSql));
		
		int[] iShow = new int[sTableName.length];
		String[] sShow = new String[sTableName.length];
		
		for(int j=0;j<sShow.length;j++){
			sShow[j] = "false";
			iShow[j] = 0;
		}
		while(rs.next()){
			int l  = rs.getInt(2);
			if(l>0){
				sShow[rs.getInt(1)]="true";
				iShow[rs.getInt(1)] = l;
			}
		}
		rs.getStatement().close();
		
		String sCustomerCompName = "OrgnizationBaseInfo";
		String sCustomerCompPath = "/DataMaintain/OrgnizationManage/OrgnizationBaseInfo.jsp";
		String sBusinessCompName = "SynthesisMaintanceRelativeList";
		String sBusinessCompPath = "/DataMaintain/SynthesisMaintance/SynthesisMaintanceRelativeList.jsp";
		String[][] sStrips = new String[sTableName.length][7];
		
		
		for(int t=0;t<sTableName.length;t++){
			//if(sShow[t].equals("true")){
				sStrips[t][0]= "true";
				sStrips[t][1]= sTableName[t][1]+"(����" + iShow[t] + "��)";
				if(iShow[t]>20){
					iShow[t] = 22;
				}
				sStrips[t][2]= String.valueOf(size+iShow[t]*23);
				if(t==0){
					sStrips[t][3]= sCustomerCompName;
					sStrips[t][4]= sCustomerCompPath;
					sStrips[t][5]= "MetaTableName="+sTableName[0][0]+"&DBTableName="+sTableName[0][0]+"&CustomerID="+sCustomerID+"&TableFlag=ECR";
				}else{
					sStrips[t][3]= sBusinessCompName;
					sStrips[t][4]= sBusinessCompPath;
					sStrips[t][5]= "sTableName="+sTableName[t][0]+"&DBTableName="+sTableName[t][0]+"&KeyName=LoanCardNo&KeyValue="+sLOANCARDNO+"&TableFlag=ECR&SynthesisMaintance=true";
				}
				sStrips[t][6]="";
				
		//	}
		}
		String sButtons[][] = {
		
			};
	//����Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"�ۺ���Ϣ","right");
	tviTemp.toRegister = false; //�����Ƿ���Ҫ�����еĽڵ�ע��Ϊ���ܵ㼰Ȩ�޵�
	tviTemp.TriggerClickEvent=true; //�Ƿ��Զ�����ѡ���¼�

	//������ͼ�ṹ
	//������ͼ�ṹ
	int iTreeNode=1;
	for(int i=0;i<sTableName.length;i++){
		tviTemp.insertPage("root",sTableName[i][1]+"("+iShow[i]+"��)","","",iTreeNode++);
	}
	
	//����������������Ϊ��
	//ID�ֶ�(����),Name�ֶ�(����),Value�ֶ�,Script�ֶ�,Picture�ֶ�,From�Ӿ�(����),OrderBy�Ӿ�,Sqlca
%><div id="view_bottom"><%@include file="/Resources/CodeParts/View04.jsp"%></div>
<script type="text/javascript"> 
	function openChildComp(sURL,sParameterString){
		sParaStringTmp = "";
		sLastChar=sParameterString.substring(sParameterString.length-1);
		if(sLastChar=="&") sParaStringTmp=sParameterString;
		else sParaStringTmp=sParameterString+"&";

		/*
		 * ������������
		 * ToInheritObj:�Ƿ񽫶����Ȩ��״̬��ر��������������
		 * OpenerFunctionName:�����Զ�ע�����������REG_FUNCTION_DEF.TargetComp��
		 */
		sParaStringTmp += "ToInheritObj=y&OpenerFunctionName="+getCurTVItem().name;
		AsControl.OpenView(sURL,sParaStringTmp,"right");
	}
	
	//treeview����ѡ���¼�
	//treeview����ѡ���¼�
	function TreeViewOnClick(){
		var sCurItemname = getCurTVItem().name;
		
		<%
		for(int i=0;i<sTableName.length;i++){
			if(i==0){
				%>
				if(sCurItemname=="<%=sTableName[i][1]%>(<%=iShow[i]%>��)"){
					openChildComp("<%=sStrips[i][4]%>","sTable=ECR_ORGANINFO&sCIFCustomerID=<%=sCustomerID%>&Type=Info&sFlag=syn");
				}
		<%				
			}else if(i>0){
		%>
		if(sCurItemname=="<%=sTableName[i][1]%>(<%=iShow[i]%>��)"){
			openChildComp("<%=sStrips[i][4]%>","<%=sStrips[i][5]%>");
		}
		<%
		}
		}
		%>
		setTitle(getCurTVItem().name);
	}
	
	function initTreeView(){
		<%=tviTemp.generateHTMLTreeView()%>
		expandNode('root');
		selectItemByName("<%=sTableName[0][1]%>(<%=iShow[0]%>��)");
	}
		
	initTreeView();
	
	(function(){
		$(window).resize(function(){
			var height = $("body").height();
			var height0 = $("#view_top").height("auto").height();
			if(height0 > height/2)
				$("#view_top").height(height0 = height/2);
			$("#view_bottom").height(height - height0 - 30);
		}).resize();
	})();
</script>
<%@ include file="/IncludeEnd.jsp"%>
