<%@page import="com.amarsoft.awe.ui.layout.grouppage.GroupModelManager"%>
<%@ page import="com.amarsoft.are.jbo.*" %>
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin.jspf"%><%
	String sGroupID = CurPage.getParameter("GroupID");
	List<BizObject> items = new GroupModelManager().getItemsByGroupID(sGroupID);
%>
<body>
<textarea cols="90" rows="27" id="code">
&lt;%@page import="com.amarsoft.awe.ui.layout.grouppage.GroupModelManager"%&gt;
&lt;%@ page contentType="text/html; charset=GBK"%&gt;&lt;%@
 include file="/Frame/resources/include/include_begin.jspf"%&gt;&lt;%
    //������ҳ�������ʵ��
    GroupModelManager m = new GroupModelManager("<%=sGroupID %>",CurUser);
    //����ȫ�ֲ���
    m.setParameter("key=value");

    //���ò�������ItemNoΪ��������Ϊֵ
  <%
  for(int i=0;i<items.size();i++){
	String pre = "    ";
	if(i==0)pre = "  ";
  	out.println(pre+"m.setParameter(\""+items.get(i).getAttribute("ItemNo").getString()+"\",\"key=value\");");
  }
  %>
    //���
    out.println(m.getHtmlText());
%&gt;&lt;%@ include file="/Frame/resources/include/include_end.jspf"%&gt;
</textarea>
	<div style="margin-top: 6px;" align="center">
		<table>
			<tr>
				<td><%=new Button("���Ƶ�ճ����","���Ƶ�ճ����","copyToClipboard()").getHtmlText()%></td>
				<td><%=new Button("���Ϊ�ļ�","���Ϊ�ļ�","saveAS()").getHtmlText()%></td>
			</tr>
		</table>
	</div>
	<iframe name="SaveAS" style="display: none"></iframe>
</body>
<script type="text/javascript">
	var txt = document.getElementById("code").innerHTML;
	txt = txt.replace(/&lt;/g,"<");
	txt = txt.replace(/&gt;/g,">");
	
	function saveAS(){
		var fileName="<%=sGroupID %>";
		var winaa = window.open("","SaveAS","");
		winaa.document.open("text/html","replace");
		winaa.document.charset="GBK";
		winaa.document.write(txt);
		winaa.document.execCommand("SAVEAS",false,fileName);
		winaa.close();		
	}

	function copyToClipboard() {
	    if(window.clipboardData) {   
            window.clipboardData.clearData();   
            var sReturn = window.clipboardData.setData("Text", txt);
	        if(sReturn)alert("���Ƴɹ�");
	        else {
	        	alert("����ʧ��");
	        	return;
	        }
	    } else if(navigator.userAgent.indexOf("Opera") != -1) {   
	         window.location = txt;   
	    } else if (window.netscape) {   
	         try {   
	              netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");   
	         } catch (e) {   
	              alert("���������ʹ��FireFox��\n�����������ַ������'about:config'���س�\nȻ��'signed.applets.codebase_principal_support'����Ϊ'true'");   
	         }   
	         var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);   
	         if (!clip)   
	              return;   
	         var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);   
	         if (!trans)   
	              return;   
	         trans.addDataFlavor('text/unicode');   
	         var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);   
	         var copytext = txt;
	         str.data = copytext;   
	         trans.setTransferData("text/unicode",str,copytext.length*2);   
	         var clipid = Components.interfaces.nsIClipboard;   
	         if (!clip)   
	              return false;   
	         clip.setData(trans,null,clipid.kGlobalClipboard);   
	         alert("���Ƴɹ���");
	    }   
	} 
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>