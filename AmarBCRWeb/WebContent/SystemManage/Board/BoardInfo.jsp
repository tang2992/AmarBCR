<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
        Author: #{author} #{createddate}
        Content: ʾ������ҳ��
        History Log: 
    */
	/*
	ҳ��˵��: ��������
 */
    String PG_TITLE = "��������";  
    
    String sFlag = CurPage.getParameter("Flag");
    if(sFlag==null) sFlag="";
	String sBoardNo = CurPage.getParameter("BoardNo");
	if(sBoardNo == null) sBoardNo = "";
	ASObjectModel doTemp = new ASObjectModel(JBOFactory.getBizObjectManager("jbo.ecr.BOARD_LIST"));
	doTemp.setJboWhere("O.BoardNo=:BoardNo");
	doTemp.setVisible("*", false);
	doTemp.setVisible("BoardName,BoardTitle,BoardDesc,IsPublish,IsNew,IsEject", true);
	doTemp.setEditStyle("IsPublish,IsNew,IsEject", "Select");
	//doTemp.setDDDWCode("IsPublish,IsNew,IsEject","1")
	doTemp.setDDDWCodeTable("IsPublish,IsNew,IsEject", "1,��,2,��");
	//doTemp.setHTMLStyle("BoardTitle,BoardDesc"," style={width:300px}");
	doTemp.setRequired("BoardName,BoardTitle",true);
    doTemp.setLimit("BoardName,BoardTitle",100);
	doTemp.setLimit("BoardDesc",200);

	ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	dwTemp.Style = "2";//����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0";//�Ƿ�ֻ�� -2 -ֻ��������ʾ�ؼ���ֻ��info��Ч 1-ֻ�� 0-�ɱ༭ -1 �Զ�ʶ��infoʱ�ɱ༭��listʱֻ��
	dwTemp.genHTMLObjectWindow(sBoardNo);
	
	String sButtons[][] = {
			{"true","","Button","����","���������޸�","saveRecord()","","","",""},
			{"true","","Button","�ϴ��ļ�","�ϴ��ļ�","fileadd()","","","",""},
	};
%><%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
    var bIsInsert = false; //���DW�Ƿ��ڡ�����״̬��
    function saveRecord(){
    	if(bIsInsert){
    		setItemValue(0,getRow(),"BoardNo", getSerialNo("BOARD_LIST","BoardNo",""));
			setItemValue(0,getRow(),"DocNo", getSerialNo("DOC_LIBRARY","DocNo",""));
			bIsInsert = false;
    	}
    	as_save("myiframe0","");
    }
    
    function getSerialNo(sTableName,sColumnName,sPrefix) 
    {
    	if(typeof(sPrefix)=="undefined" || sPrefix=="") sPrefix="";
    	//ʹ��GetSerialNo.jsp����ռһ����ˮ��
    	var sSerialNo = AsControl.PopPage("/Common/ToolsB/GetSerialNo.jsp","TableName="+sTableName+"&ColumnName="+sColumnName+"&Prefix="+sPrefix,"resizable=yes;dialogWidth=0;dialogHeight=0;center:no;status:no;statusbar:no");
    	//����ˮ�������Ӧ�ֶ�
    	return sSerialNo;
    }
    
    function fileadd(){
    	var sDocNo = getItemValue(0,getRow(),"DocNo");
    	if(typeof(sDocNo)=="undefined" || sDocNo.length==0){
    		alert("���ȱ������ϴ��ļ�");
    		return;
    	}
    	AsControl.PopView("/AppConfig/Document/AttachmentFrame.jsp", "DocNo="+sDocNo, "dialogWidth=650px;dialogHeight=350px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;"); 
    }
    
	
	function initRow(){
		if (getRowCount(0)==0){
			bIsInsert = true;
		}
    }
	initRow();
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>