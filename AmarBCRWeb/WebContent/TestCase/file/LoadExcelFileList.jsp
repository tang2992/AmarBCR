<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	/*
		Content: Excel文件导入列表页面
	 */
	String sButtons[][] = {
		{"true","","Button","新增","新增一个相关附件信息","newRecord()","","","",""},		
		{"true","","Button","读配置文件","读配置文件的信息","getConfigInfo()","","","",""}
	};
%>
<link rel="stylesheet" type="text/css" href="<%=sWebRootPath%>/Frame/page/resources/css/syspage.css"/>
<body style="height: 100%;overflow: hidden;">
<div class="download_tit">Excel文件导入列表</div><div>
<%@ include file="/Frame/resources/include/ui/include_buttonset_dw.jspf"%>
</div><div class="download_wrap" style="height:30px;">
<%	ASResultSet rs = Sqlca.getASResultSet(new SqlObject("select Name from TEST_FILE "));
	while(rs.next()){ %>
    <div class="download_block" >
		<div class="download_show">
            <div class="download_icon"></div>
            <a class="download_name"><%=rs.getString(1)%></a>
            <div class="download_info"></div>
        </div>
        <div class="download_shadow"></div>
    </div>
    <%}
	rs.close(); %>
</div>
</body>
<script type="text/javascript">
	function newRecord(){
		popComp("FileChooseDialog","/TestCase/file/FileChooseDialog.jsp","","dialogWidth=650px;dialogHeight=250px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
		reloadSelf();
	}
	
	function getConfigInfo(){
		popComp("ReadConfigFile","/TestCase/file/ReadConfigFile.jsp","","dialogWidth=650px;dialogHeight=250px;resizable=no;scrollbars=no;status:yes;maximize:no;help:no;");
	}
	
	(function(){
		var body = $(document.body);
		var div1 = $(">div:eq(0)", body);
		var div2 = $(">div:eq(1)", body);
		var div3 = $(">div:eq(2)", body);
		$(window).resize(function(){
			div3.height(body.innerHeight() - div1.outerHeight() - div2.outerHeight());
		}).resize();
	})();
</script>	
<%@ include file="/IncludeEnd.jsp"%>