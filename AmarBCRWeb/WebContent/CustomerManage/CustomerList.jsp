<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
    /*
        Content: �����ͻ���Ϣ�б�ֻչʾ������ҵ�ͻ�
    */
    String PG_TITLE = "�ͻ���Ϣ�б�"   ; // ��������ڱ��� <title> PG_TITLE </title>  

    //�������
    String sUserID = CurUser.getUserID(); //�û�ID
    String sOrgID = CurOrg.getOrgID(); //����ID
    
    //����������    ���ͻ����͡��ͻ���ʾģ���
    String sCustomerType = CurPage.getParameter("CustomerType");
    String sTempletNo = CurPage.getParameter("CustomerListTemplet");
    String sCurItemID = CurPage.getParameter("CurItemID"); //�û��������ͼ��ID���ڼ��ſͻ�����ʱ���ɴ���ȷ����ҳ������ʾ�İ�ť
    //����ֵת��Ϊ���ַ���
    if(sCustomerType == null) sCustomerType = "";
    if(sTempletNo == null) sTempletNo = "";
    if(sCurItemID == null) sCurItemID = "";
    
    //ͨ����ʾģ�����ASDataObject����doTemp
    ASObjectModel doTemp = new ASObjectModel(sTempletNo);
    ASObjectWindow dwTemp = new ASObjectWindow(CurPage ,doTemp,request);
    dwTemp.setPageSize(20); //add by hxd in 2005/02/20 for �ӿ��ٶ�
    dwTemp.Style="1"; //����DW��� 1:Grid 2:Freeform      
    dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
    dwTemp.genHTMLObjectWindow(sUserID+","+sCustomerType+","+sOrgID+","+CurOrg.getSortNo());

    String sbCustomerType = sCustomerType.substring(0,2);
    String sButtons[][] = {
	    {"true","","Button","����","����һ����¼","newRecord()","","","",""}, 
	    {"true","","Button","����","�鿴/�޸�����","viewAndEdit()","","","",""},
	    {(sCurItemID.equals("02")?"false":"true"),"","Button","ɾ��","ɾ����ѡ�еļ�¼","deleteRecord()","","","",""}, 
	    {(sbCustomerType.equals("01")?"true":"false"),"","Button","�ͻ���ϢԤ��","�ͻ���ϢԤ��","alarmCustInfo()","","","",""},
	    {"true","","Button","��д���鱨��","��д���鱨��","genReport()","","","",""},
	    {"true","","Button","�鿴���鱨��","�鿴���鱨��","viewReport()","","","",""},
	    {(sbCustomerType.equals("02")?"false":"true"),"","Button","�ͻ�������ѯ(ʵʱ�ӿ�)","��ѯ�ͻ�������Ϣ","queryCusomerInfo()","","","",""}
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
    /*~[Describe=������¼;InputParam=��;OutPutParam=��;]~*/
    function newRecord(){
        var sCustomerType='<%=sCustomerType%>'; //--�ͻ�����
        var sCustomerID ='';                                        //--�ͻ�����
        var sReturn ='';                                                //--����ֵ���ͻ���¼����Ϣ�Ƿ�ɹ�
        var sReturnStatus = '';                                 //--��ſͻ���Ϣ�����
        var sStatus = '';                                               //--��ſͻ���Ϣ���״̬      
        var sReturnValue = '';                                  //--��ſͻ�������Ϣ
        var sCustomerOrgType ='';                               //--�ͻ���������
        var sHaveCustomerType = "";
        var sHaveCustomerTypeName = "";
        var sHaveStatus = "";

        //�ͻ���Ϣ¼��ģ̬�����   
        //�������ֿͻ����ͣ���Ϊ���ƶԻ����չʾ��С
        if(sCustomerType.substring(0,2) == "01"||sCustomerType.substring(0,2) == "03")
            sReturnValue = PopPage("/CustomerManage/AddCustomerDialog.jsp?CustomerType="+sCustomerType,"","resizable=yes;dialogWidth=350px;dialogHeight=200px;center:yes;status:no;statusbar:no");
        else
        	sReturnValue = PopPage("/CustomerManage/AddCustomerDialog.jsp?CustomerType="+sCustomerType,"","resizable=yes;dialogWidth=350px;dialogHeight=150px;center:yes;status:no;statusbar:no");                
        //�ж��Ƿ񷵻���Ч��Ϣ
        if(typeof(sReturnValue) != "undefined" && sReturnValue.length != 0 && sReturnValue != '_CANCEL_'){
            sReturnValue = sReturnValue.split("@");
            //�õ��ͻ�������Ϣ
            sCustomerOrgType = sReturnValue[0];
            sCustomerName = sReturnValue[1];
            sCertType = sReturnValue[2];
            sCertID = sReturnValue[3];
        
            //���ͻ���Ϣ����״̬
            sReturnStatus = RunMethod("CustomerManage","CheckCustomerAction",sCustomerType+","+sCustomerName+","+sCertType+","+sCertID+",<%=CurUser.getUserID()%>");
            //�õ��ͻ���Ϣ������Ϳͻ���
            sReturnStatus = sReturnStatus.split("@");
            sStatus = sReturnStatus[0];
            sCustomerID = sReturnStatus[1];
            sHaveCustomerType = sReturnStatus[2];
            sHaveCustomerTypeName = sReturnStatus[3];
            sHaveStatus = sReturnStatus[4];

			//�����ǹ���ҳ�棬��鵱ǰ����Ŀͻ��ͻ������Ƿ��뵱ǰҳ������Ŀͻ�����һ��
			if(sStatus != "01"){
				if(sCustomerType != sHaveCustomerType){
					alert("�ͻ��ţ�"+sCustomerID+"�����ڣ�"+sHaveCustomerTypeName+"�������ڴ�����");
					return;
				}
			}
            
            //02Ϊ��ǰ�û�����ÿͻ�������Ч����
            if(sStatus == "02"){
                if(sHaveCustomerType == sCustomerType){
                    alert(getMessageText('ALS70105')); //�ÿͻ��ѱ��Լ����������ȷ�ϣ�
                }else{
                    alert("�ͻ��ţ�"+sCustomerID+"����"+sHaveCustomerTypeName+"�ͻ�����ҳ�汻�Լ����������ȷ�ϣ�");
                }
                return;
            }
            //01Ϊ�ÿͻ������ڱ�ϵͳ��
            if(sStatus == "01"){                
                //ȡ�ÿͻ����
                sCustomerID = getSerialNo("CUSTOMER_INFO","CustomerID","");
            }
            //01 �������Ϊ�޸ÿͻ�
            //04 û�к��κοͻ���������Ȩ
            //05 �������ͻ���������Ȩʱ���ж����ݿ����
            if(sStatus == "01" || sStatus == "04" || sStatus == "05"){
                //����˵��CustomerID,CustomerName,CustomerType,CertType,CertID,Status,CustomerOrgType,UserID,OrgID
                var sParam = "";
                sParam = sCustomerID+","+sCustomerName+","+sCustomerType+","+sCertType+","+sCertID+
                         ","+sStatus+","+sCustomerOrgType+",<%=CurUser.getUserID()%>,<%=CurUser.getOrgID()%>,"+sHaveCustomerType;
                sReturn = RunMethod("CustomerManage","AddCustomerAction",sParam);
                //���ÿͻ��������û�������Ч������Ϊ��ҵ�ͻ��͹������� ,��Ҫ��ϵͳ����Ա����Ȩ��
                if(sReturn == "1"){
                    if(sStatus == "05"){
                        if(confirm("�ͻ��ţ�"+sCustomerID+"�ѳɹ����룬Ҫ��������ÿͻ���Ȩ����")) //�ͻ��ѳɹ����룬Ҫ��������ÿͻ��Ĺܻ�Ȩ��
                            popComp("RoleApplyInfo","/CustomerManage/RoleApplyInfo.jsp","CustomerID="+sCustomerID+"&UserID=<%=CurUser.getUserID()%>&OrgID=<%=CurOrg.getOrgID()%>","");
                    }else if(sStatus == "04"){
                        alert("�ͻ��ţ�"+sCustomerID+"�ѳɹ�����!");
                    }else if(sStatus == "01"){
                        alert("�ͻ��ţ�"+sCustomerID+"�����ɹ�!"); //�����ͻ��ɹ�
                    }                                   
                //���ÿͻ�û�����κ��û�������Ч��������ǰ�û�����ÿͻ�������Ч�������ÿͻ��������û�������Ч���������˿ͻ�/���幤�̻�/ũ��/����С�飩�Ѿ�����ͻ�
                }else if(sReturn == "2"){
                    alert("����ͻ��ţ�"+sCustomerID+"�Ŀͻ�����Ϊ"+sHaveCustomerTypeName+"�������ڱ�ҳ�����룡");
                //�Ѿ������ͻ�
                }else{
                    alert("�����ͻ�ʧ�ܣ�"); //�����ͻ��ɹ�
                    return;
                }
            }           
            if(sStatus == "01" || sStatus == "04"){
                //�������С��ҵ��Ҫ�������϶�״̬Ϊδ�϶�.
                if(sCustomerType == "0120")
                    RunMethod("CustomerManage","UpdateCustomerStatus",sCustomerID+","+"0");             
            }
            openObject("Customer",sCustomerID,"001");
            reloadSelf();
        }
    }
    
    /*~[Describe=ɾ����¼;InputParam=��;OutPutParam=��;]~*/
    function deleteRecord(){
    	var sCustomerID = getItemValue(0,getRow(),"CustomerID");        
        if (typeof(sCustomerID)=="undefined" || sCustomerID.length==0){
            alert(getHtmlMessage('1')); //��ѡ��һ����Ϣ��
            return;
        }
        
        if(confirm(getHtmlMessage('2'))){ //�������ɾ������Ϣ��
            sReturn = PopPage("/CustomerManage/DelCustomerBelongAction.jsp?CustomerID="+sCustomerID+"","","");
            if(sReturn == "ExistApply"){
                alert(getMessageText('ALS70113'));//�ÿͻ���������ҵ��δ�սᣬ����ɾ����
                return;
            }
            if(sReturn == "ExistApprove"){
                alert(getMessageText('ALS70112'));//�ÿͻ����������������ҵ��δ�սᣬ����ɾ����
                return;
            }
            if(sReturn == "ExistContract"){
                alert(getMessageText('ALS70111'));//�ÿͻ�������ͬҵ��δ�սᣬ����ɾ����
                return;
            }
            if(sReturn == "DelSuccess"){
                alert(getMessageText('ALS70110'));//�ÿͻ�������Ϣ��ɾ����
                reloadSelf();
            }
        }
    }
    
    //�ͻ���ϢԤ��
    function alarmCustInfo(){
    	var sCustomerID = getItemValue(0,getRow(),"CustomerID");
        if (typeof(sCustomerID)=="undefined" || sCustomerID.length==0){
            alert(getHtmlMessage('1')); //��ѡ��һ����Ϣ��
        }else {
            sReturn = autoRiskScan("005","ObjectType=Customer&ObjectNo="+sCustomerID);      
        }       
    }

    /*~[Describe=�鿴���޸�����;InputParam=��;OutPutParam=��;]~*/
    function viewAndEdit(){
		var sCustomerID = getItemValue(0,getRow(),"CustomerID");
		if (typeof(sCustomerID) == "undefined" || sCustomerID.length == 0){
		    alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
		    return;
		}
		openObject("Customer",sCustomerID,"001");
		reloadSelf();
    }

	/*~[Describe=��д���鱨��;InputParam=��;OutPutParam=��;]~*/
	function genReport(){
		//����������͡�������ˮ��
		var sObjectType = "Customer";
		var sObjectNo = getItemValue(0,getRow(),"CustomerID");
		var sDocID = "S01";
		if (typeof(sObjectNo)=="undefined" || sObjectNo.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
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
	
	/*~[Describe=���ɵ��鱨��;InputParam=��;OutPutParam=��;]~*/
	function createReport(){
		//����������͡�������ˮ�š��ͻ����
		var sObjectType = "Customer";
		var sObjectNo   = getItemValue(0,getRow(),"CustomerID");
		var sCustomerID = getItemValue(0,getRow(),"CustomerID");
		if (typeof(sObjectNo)=="undefined" || sObjectNo.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return;
		}	
		
		var sDocID = AsControl.RunJsp("/FormatDoc/ReportTypeSelect.jsp","ObjectNo="+sObjectNo+"&ObjectType="+sObjectType);
		if (typeof(sDocID)=="undefined" || sDocID.length==0){
			alert(getMessageText('ALS70505'));//���鱨�滹δ��д��������д���鱨���ٲ鿴��
			return;
		}
		var sAttribute = "";
		if (confirm(getMessageText('ALS70504'))){ //�Ƿ�Ҫ���Ӵ�ӡ����,���������ȷ����ť��
			sAttribute = PopPage("/FormatDoc/DefaultPrint/DefaultPrintSelect.jsp?DocID="+sDocID,"","dialogWidth=580px;dialogHeight=350px;status:no;center:yes;help:no;minimize:no;maximize:no;border:thin;");
			if (typeof(sAttribute)=="undefined" || sAttribute.length==0 || sAttribute == "_none_") return;
		}else{
			sAttribute = PopPage("/FormatDoc/DefaultPrint/GetAttributeAction.jsp?DocID="+sDocID,"","");
			if (typeof(sAttribute)=="undefined" || sAttribute.length==0) return;
		}
		var CurOpenStyle = "width=720,height=540,top=20,left=20,toolbar=no,scrollbars=yes,resizable=yes,status=yes,menubar=no,";
		OpenPage("/FormatDoc/ProduceFile.jsp?DocID="+sDocID+"&ObjectNo="+sObjectNo+"&ObjectType="+sObjectType+"&CustomerID="+sCustomerID+"&Attribute="+sAttribute,"_blank02",CurOpenStyle); 
	}	
	
	/*~[Describe=�鿴���鱨��;InputParam=��;OutPutParam=��;]~*/
	function viewReport(){
		//����������͡�������ˮ��
		var sObjectType = "Customer";
		var sObjectNo = getItemValue(0,getRow(),"CustomerID");
		if (typeof(sObjectNo)=="undefined" || sObjectNo.length==0){
			alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
			return;
		}
		
		var sDocID = AsControl.RunJsp("/FormatDoc/ReportTypeSelect.jsp","ObjectNo="+sObjectNo+"&ObjectType="+sObjectType);
		if (typeof(sDocID)=="undefined" || sDocID.length==0){
			alert(getMessageText('ALS70505'));//���鱨�滹δ��д��������д���鱨���ٲ鿴��
			return;
		}
		
		var sReturn = AsControl.RunJsp("/FormatDoc/GetReportFile.jsp","ObjectNo="+sObjectNo+"&ObjectType="+sObjectType+"&DocID="+sDocID);
		if (sReturn == "false"){
			createReport();
			return;
		}else{
			if(confirm(getMessageText('ALS70503'))){ //���鱨���п��ܸ��ģ��Ƿ����ɵ��鱨����ٲ鿴��
				createReport();
				return; 
			}else{
				var CurOpenStyle = "width=720,height=540,top=20,left=20,toolbar=no,scrollbars=yes,resizable=yes,status=yes,menubar=no,";
				OpenPage("/FormatDoc/PreviewFile.jsp?DocID="+sDocID+"&ObjectNo="+sObjectNo+"&ObjectType="+sObjectType,"_blank02",CurOpenStyle); 
			}
		}
	}
    
    /*~[Describe=��ѯ�ͻ�������Ϣ;InputParam=��;OutPutParam=��;]~*/
    function queryCusomerInfo(){
    	var sCustomerID = getItemValue(0,getRow(),"CustomerID");
    	var sCertID = getItemValue(0,getRow(),"CertID");
        if (typeof(sCustomerID)=="undefined" || sCustomerID.length==0){
            alert(getHtmlMessage('1'));//��ѡ��һ����Ϣ��
            return;
        }
        
        var sReturn = PopPage("/CustomerManage/QueryCustomer.jsp?CertID="+sCertID,"","");
        if(typeof(sReturn) != "undefined"){
            sReturn=sReturn.split("@");
            sStatus=sReturn[0];
            sMessage=sReturn[1];
            if(sStatus == "0"){
                sReturn = "�����ɹ������״��룺" + "Q001" + "���Ŀͻ���Ϊ��"+ sMessage + "�������ݿ�ɹ���";
            }else{
                sReturn = "������ʾ��"+"Q002"+" ����ʧ�ܣ�ʧ����Ϣ��" + sMessage;
            }
            alert(sReturn);
        }
    }
</script>   
<%@ include file="/Frame/resources/include/include_end.jspf"%>