<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin.jspf" %>
<%
	String sBillType = CurPage.getParameter("BillType");
	if(sBillType==null||"".equals(sBillType))throw new Exception("����BillType��ʧ���������");
	String sObjectNo = CurPage.getParameter("ObjectNo");
	String sObjectType = CurPage.getParameter("ObjectType");
	
    String[][] sButtons = {
            {"true","All","Button","ȷ��","","executeUpload()","","","",""},
            {"true","All","Button","ȡ��","","doCancel()","","","",""},
    };
%>
<link rel="stylesheet" type="text/css" href="<%=sWebRootPath%>/Frame/page/resources/css/syspage.css"/>
<body style="overflow:hidden;" onload="javascript:ready();" onresize="javascript:changeStyle();">
<div id="ButtonsDiv" style="margin-left:5px;">
<table><tr>
    <td><form name="Attachment" style="margin-bottom:0px;" enctype="multipart/form-data" action="<%=sWebRootPath%>/AppConfig/FileImport/ExecuteBillImport.jsp?CompClientID=<%=CurComp.getClientID()%>" method="post">
        <input type="file" name="File" />
        <input type="hidden" name="FileName" />
        <input type="hidden" name="BillType" value ='<%=sBillType%>'/>
        <input type="hidden" name="ObjectNo" value='<%=sObjectNo%>' />
        <input type="hidden" name="ObjectType" value='<%=sObjectType%>' />
    </form></td>
    <td><%@ include file="/Frame/resources/include/ui/include_buttonset.jspf" %></td>
    <%
   	if("1".equals(sBillType))
   	{
    %>
    <td> <div class="download_block">
        <div class="download_show">
            <div class="download_icon">
            </div>
            <a class="download_name">���гжһ�Ʊ����ģ��</a>
            <div class="download_info">
            �ļ���С:24KB
            </div>
            <div class="download_btn">
            <a class="download_link" href="<%=sWebRootPath%>/AppConfig/FileImport/doc/BankAcceptor.xls">����</a>
            </div>
        </div>
        <div class="download_shadow">
        </div>
    </div>
    </td>
    <%}
   	else if("2".equals(sBillType))
   	{
    %>
     <td> <div class="download_block">
        <div class="download_show">
            <div class="download_icon">
            </div>
            <a class="download_name">���гжһ�Ʊ���ֵ���ģ��</a>
            <div class="download_info">
            �ļ���С:27KB
            </div>
            <div class="download_btn">
            <a class="download_link" href="<%=sWebRootPath%>/AppConfig/FileImport/doc/BankAcceptorBill.xls">����</a>
            </div>
        </div>
        <div class="download_shadow">
        </div>
    </div>
    </td>
    <%
    }
   	else if("3".equals(sBillType))
   	{
    %>
     <td> <div class="download_block">
        <div class="download_show">
            <div class="download_icon">
            </div>
            <a class="download_name">��ҵ�жһ�Ʊ���ֵ���ģ��</a>
            <div class="download_info">
            �ļ���С:27KB
            </div>
            <div class="download_btn">
            <a class="download_link" href="<%=sWebRootPath%>/AppConfig/FileImport/doc/BizAcceptorBill.xls">����</a>
            </div>
        </div>
        <div class="download_shadow">
        </div>
    </div>
    </td>
    <%
    }
    %>
    
</tr></table>
</div>
<iframe name="AttachmentList" id="AttachmentList" style="width:100%;" frameborder="0"></iframe>
</body>
<script type="text/javascript">
    function executeUpload(){
        var o = document.forms["Attachment"];
        o.BillType.value = "<%=sBillType%>";
        o.ObjectNo.value = "<%=sObjectNo%>";
        o.ObjectType.value = "<%=sObjectType%>";
        var sFileName = o.File.value;
        if (typeof(sFileName) == "undefined" || sFileName==""){
            alert("��ѡ��һ���ļ�");//��ѡ��һ���ļ���!
            return false;
        }
        var fileSize;
        /* if(typeof(ActiveXObject) == "function"){ // IE
            var fso = new ActiveXObject("Scripting.FileSystemObject");
        	alert(fso);
            var f1 = fso.GetFile(sFileName);
            fileSize = f1.size;
        }else{
            fileSize = o.AttachmentFileName.files[0].size;
        }
        if(fileSize > 2*1024*1024){
			alert("�ļ�����2048k�������ϴ���");
            return false;
        } */
        return o.submit();
    }
    
    function doCancel(){
    	top.close();
    }

    function ready(){
        changeStyle();
    }
    
    function changeStyle(){
        document.getElementById("AttachmentList").style.height = document.body.clientHeight - document.getElementById("ButtonsDiv").offsetHeight;
    }
</script>
<%@ include file="/Frame/resources/include/include_end.jspf" %>