<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
 	/* 
 		ҳ��˵���� ͨ�����鶨������strip���ҳ��ʾ��
 	*/
 	String sMAINBUSINESSNO=CurPage.getParameter("MAINBUSINESSNO");
 	 if(sMAINBUSINESSNO==null) sMAINBUSINESSNO="";
 	 String sCIFCustomerID=sMAINBUSINESSNO;
  
	String sRECORDTYPE = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("sRECORDTYPE"));
	if(sRECORDTYPE == null) sRECORDTYPE = "";
	String sFlag = DataConvert.toRealString(iPostChange,(String)CurComp.getParameter("sFlag"));
	if(sFlag == null) sFlag = "";
	//��ֻ�ܲ�ѯ��ģ�������ر��水ť
	String sSql1="";
	  String sFirstValue = sCIFCustomerID;
	
	ASResultSet rs = null;
	if("allHis".equals(sFlag)){
		sSql1=" select CIFCustomerID,GETRORGANNAME(CIFCustomerID),LOANCARDNO from HIS_ORGANINFO  where CIFCustomerID='"+sCIFCustomerID+"'" ;
	}else{
		sSql1=" select CIFCustomerID,GETRORGANNAME(CIFCustomerID),LOANCARDNO from HIS_ORGANINFO  where CIFCustomerID='"+sCIFCustomerID+"' and SESSIONID='9999999999'" ;
	
	rs = Sqlca.getASResultSet(sSql1);
	String sShowButton = "false";
	//��ʾУ����Ϣ��������Ϣ�ȵ�
	%>	
	<%@include file="/Resources/CodeParts/Table08.jsp"%>
	<%
	rs.getStatement().close();
	}
    //table���� 1.���� 2.�������� 3.LISTģ���� 4.LISTģ��������
	String[][] sTableName = {
			{"HIS_ORGANATTRIBUTE","��������������Ϣ��","HIS_ORGANBASELIST","������Ϣ�б�"},
			{"HIS_ORGANSTATUS","����״̬��Ϣ��","HIS_ORGANSTATUSLIST","����״̬�б�"},
			{"HIS_ORGANCONTACT","����������Ϣ��","HIS_ORGANCONTACTLIST","����������Ϣ�б�"},
			{"HIS_ORGANKEEPER","�����߹ܼ���Ҫ��ϵ�˱�","HIS_ORGANKEEPERLIST","�����߹ܼ���Ҫ��ϵ���б�"},
			{"HIS_ORGANSTOCKHOLDER","������Ҫ�ɶ���","HIS_ORGANSTOCKHOLDERLIST","��Ҫ�ɶ��б�"},
			{"HIS_ORGANRELATED","������Ҫ������ҵ��","HIS_ORGANRELATEDLIST","����������ҵ�б�"},
			{"HIS_ORGANSUPERIOR","�����ϼ�������","HIS_ORGANSUPERIORLIST","�ϼ������б�"},
			{"HIS_ORGANFAMILY","���������Ա��","HIS_ORGANFAMILYLIST","�����Ա�б�"},
		  };    
    
    //����Strips�Ƿ�ɼ��������ݲ��ɼ�
    String sStripVisible[]={"true","true","true","true","true","true","true","true"};
    String[] sParameter =new String[8];//���崫�ݲ���

    for(int i=0;i<sTableName.length;i++){
    	String sSql;
    	if("allHis".equals(sFlag)){
    		sSql="select count(*) from "+sTableName[i][0]+" where CIFCustomerID='"+sCIFCustomerID+"'";
    	}else{
    		sSql="select count(*) from "+sTableName[i][0]+" where CIFCustomerID='"+sCIFCustomerID+"'"+" and SESSIONID='9999999999'";
        	  	}
    		String sCount=Sqlca.getString(sSql);
    	if(sCount.equals("0")||sCount==null){
    	    sStripVisible[i]="false";
    	}
    	
    	if("allHis".equals(sFlag)){
    		sParameter[i]="sTablbeName="+sTableName[i][0]+"&sDono="+sTableName[i][2]+"&sFlag=Detail&sCIFCustomerID="+sCIFCustomerID+"&IsShow=true&IsPatch=true";
    	}else{
    		sParameter[i]="sTablbeName="+sTableName[i][0]+"&sDono="+sTableName[i][2]+"&sFlag=Detail&sCIFCustomerID="+sCIFCustomerID;
    	}
    } 
    
 	//����strip���飺
 	//������0.�Ƿ���ʾ, 1.���⣬2.�߶ȣ�3.���ID��4.URL��5����������6.�¼�
	String sStrips[][] = {
		{"true","����������Ϣ��" ,"120","OrgnizationBaseList","/ErrorManage/FeedBackManage/FeedbackOrgan/OrgnizationBaseList.jsp","sTablbeName=HIS_ORGANINFO&sDono=HIS_ORGANBASELIST&sFlag=Detail&IsShow=true&IsPatch=true&sCIFCustomerID="+sCIFCustomerID,""},
		{sStripVisible[0],"��������������Ϣ��" ,"120","OrgnizationAttribute","/ErrorManage/FeedBackManage/FeedbackOrgan/OrgnizationBaseList.jsp",sParameter[0],""},
		{sStripVisible[1],"����״̬��Ϣ��" ,"120","OrgnizationStatusList","/ErrorManage/FeedBackManage/FeedbackOrgan/OrgnizationBaseList.jsp",sParameter[1],""},
		{sStripVisible[2],"����������Ϣ��" ,"120","OrgnizationContactList","/ErrorManage/FeedBackManage/FeedbackOrgan/OrgnizationBaseList.jsp",sParameter[2],""},
		{sStripVisible[3],"�����߹ܼ���Ҫ��ϵ�˱�" ,"120","OrgnizationKeeperList","/ErrorManage/FeedBackManage/FeedbackOrgan/OrgnizationBaseList.jsp",sParameter[3],""},
		{sStripVisible[4]," ������Ҫ�ɶ���" ,"120","OrgnizationStockHolderList","/ErrorManage/FeedBackManage/FeedbackOrgan/OrgnizationBaseList.jsp",sParameter[4],""},
		{sStripVisible[5],"������Ҫ������ҵ��" ,"120","OrgnizationRelatedList.jsp","/ErrorManage/FeedBackManage/FeedbackOrgan/OrgnizationBaseList.jsp",sParameter[5],""},
		{sStripVisible[6],"�����ϼ�������" ,"120","OrgnizationSuperiorList","/ErrorManage/FeedBackManage/FeedbackOrgan/OrgnizationBaseList.jsp",sParameter[6],""},
		{sStripVisible[7],"���������Ա��" ,"120","OrgnizationFamilyList","/ErrorManage/FeedBackManage/FeedbackOrgan/OrgnizationBaseList.jsp",sParameter[7],""}		
	};
 	String sButtons[][] = {
 	};
 	if(!"allHis".equals(sFlag)){
%>
<%/*~BEGIN~�ɱ༭��~[Editable=true;CodeAreaID=Strip05;Describe=���尴ť;]~*/%>
 <div style="float:left;width:100px; overflow: hidden;padding_left:25px;"><%=new Button("������ʷ��Ϣ","������ʷ��Ϣ","javascript:showAllInfo()","","").getHtmlText() %></div>
 <div style="float:left;width:70px; overflow: hidden"><%=new Button("ȫ���ر�","ȫ���ر�","javascript:reReport()","","").getHtmlText() %></div>
 <div style="width:90px; overflow: hidden"><%=new Button("ȫ�����ϱ�","ȫ�����ϱ�","javascript:unReport()","","").getHtmlText() %></div>
<div></div>
<%}/*~END~*/%>

<%@include file="/Resources/CodeParts/Strip05.jsp"%>
<script type="text/javascript">
/*~[Describe=©�������������ת��ECRҳ�棬�����������в���©���ļ�¼;InputParam=��;OutPutParam=��;]~*/
function showAllInfo(){
		//��ʾ���еļ�¼
		AsControl.PopView("/ErrorManage/FeedBackManage/FeedbackOrgan/FeedBackOrganDetail.jsp","sFlag=allHis","");
	}


function reReport(){
if(confirm("ȷ������ҵ���ȫ�������¼�����ϱ�?")){
	sReturn = PopPage("/ErrorManage/UpdateAllSessionIDAction.jsp?MainBusinessNo=<%=sMAINBUSINESSNO%>&CustomerID=<%=sCIFCustomerID%>&Flag=REREPORT","_self","");

	if(sReturn == "Success"){
			alert("�����ر���־�ɹ�!");
			
		}else{
			alert("�����ر���־ʧ��!");
		}
	}
	top.close(); 
}
function unReport(){
	if(confirm("ȷ������ҵ���ȫ�������¼�ݲ��ϱ�?")){
		sReturn = PopPage("/ErrorManage/UpdateAllSessionIDAction.jsp?MainBusinessNo=<%=sMAINBUSINESSNO%>&CustomerID=<%=sCIFCustomerID%>&Flag=UNREPORT","_self","");
		if(sReturn == "Success"){
			alert("�����ݲ��ϱ���־�ɹ�!");
			
		}else{
			alert("�����ݲ��ϱ���־ʧ��!");
		}
	}
	top.close(); 
}
</script>
<%@ include file="/IncludeEnd.jsp"%>
