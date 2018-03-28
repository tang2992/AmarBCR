<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_info.jspf"%><%
	/*
        Author: #{author} #{createddate}
        Content: 示例详情页面
        History Log: 
    */
	/*
	页面说明: 公告详情
 */
    String PG_TITLE = "公告详情";  
    
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
	doTemp.setDDDWCodeTable("IsPublish,IsNew,IsEject", "1,是,2,否");
	//doTemp.setHTMLStyle("BoardTitle,BoardDesc"," style={width:300px}");
	doTemp.setRequired("BoardName,BoardTitle",true);
    doTemp.setLimit("BoardName,BoardTitle",100);
	doTemp.setLimit("BoardDesc",200);

	ASObjectWindow dwTemp = new ASObjectWindow(CurPage, doTemp,request);
	dwTemp.Style = "2";//设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "0";//是否只读 -2 -只读，不显示控件，只对info有效 1-只读 0-可编辑 -1 自动识别：info时可编辑，list时只读
	dwTemp.genHTMLObjectWindow(sBoardNo);
	
	String sButtons[][] = {
			{"true","","Button","保存","保存所有修改","saveRecord()","","","",""},
			{"true","","Button","上传文件","上传文件","fileadd()","","","",""},
	};
%><%@ include file="/Frame/resources/include/ui/include_info.jspf"%>
<script type="text/javascript">
    var bIsInsert = false; //标记DW是否处于“新增状态”
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
    	//使用GetSerialNo.jsp来抢占一个流水号
    	var sSerialNo = AsControl.PopPage("/Common/ToolsB/GetSerialNo.jsp","TableName="+sTableName+"&ColumnName="+sColumnName+"&Prefix="+sPrefix,"resizable=yes;dialogWidth=0;dialogHeight=0;center:no;status:no;statusbar:no");
    	//将流水号置入对应字段
    	return sSerialNo;
    }
    
    function fileadd(){
    	var sDocNo = getItemValue(0,getRow(),"DocNo");
    	if(typeof(sDocNo)=="undefined" || sDocNo.length==0){
    		alert("请先保存再上传文件");
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