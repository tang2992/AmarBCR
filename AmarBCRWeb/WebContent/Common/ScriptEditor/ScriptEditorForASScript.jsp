<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBeginMD.jsp"%><%
	String sScriptText = CurPage.getParameter("ScriptText");
	if (sScriptText==null) sScriptText="";
	sScriptText = StringFunction.replace(sScriptText,"$[wave]","~");
	
	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"未命名","right");

	int i=0;
	int j=0;
	String sFolder = "";
	ASResultSet rs2=null;
	String sSql="select ClassName from CLASS_CATALOG ";
	String sSql2 = "select distinct MethodName,'<font color=red>'||ReturnType ||'</font>&nbsp;&nbsp;!'||ClassName ||'.'||MethodName||'('|| MethodArgs ||')',"+
				"MethodDescribe,MethodCode from CLASS_METHOD where ClassName=:ClassName order by MethodName";
	ASResultSet rs=Sqlca.getASResultSet(sSql);
	while(rs.next()){
	    j=0;
	    sFolder = tviTemp.insertFolder("root",rs.getString(1),"",i++);
	    rs2 = Sqlca.getASResultSet(new SqlObject(sSql2).setParameter("ClassName",rs.getString(1)));
	    while (rs2.next()){
	        tviTemp.insertPage(sFolder,rs2.getString(1),"javascript:parent.mySelection(\""+rs.getString(1)+"\",\""+rs2.getString(1)+"\",\""+rs2.getString(2)+"\",\""+rs2.getString(3)+"\",\""+rs2.getString(4)+"\")",j++);
	    }
	    rs2.getStatement().close();
	}
	rs.getStatement().close();
%>
<html>
<body leftmargin="0" topmargin="0" class="windowbackground" onload="">
<table style="width: 100%;height: 100%;border: 0;" cellspacing="0" cellpadding="0">
	<tr height=1>
	    <td>
            <table>
                <tr>
                	<td><%=new Button("确定", "确定", "translateScriptText()", "", "").getHtmlText()%></td>
					<td><%=new Button("取消", "取消", "cancel()", "", "").getHtmlText()%></td>
                    <td id="showTreeButtonTD">
                    	<%=new Button("显示方法树", "显示方法树", "showTree()", "", "").getHtmlText()%>
                    </td>
                </tr>
            </table>
	    </td>
	</tr>
	<tr>
		<td valign="top">
			<table cellspacing="0" cellpadding="0" style="width: 100%;height: 100%;border: 0;" class="content_table"  id="content_table">
				<tr> 
					<td id="myleft_leftMargin" class="myleft_leftMargin"></td>
					<td id="myleft" width=20%> 
						<iframe name="left" src="" width=100% height=100% frameborder=0 scrolling=no ></iframe>
					</td>
					<td id="myleft_rightMargin" class="myleft_rightMargin"> </td>
					<td id="mycenter" class="mycenter">
						<div id=divDrag title='可拖拽改变窗口大小 Drag to resize' style="z-index:0; cursor: w-resize;"	ondrag="if(event.x>16 && event.x<400) {myleft_top.style.display='block';myleft.style.display='block';myleft_bottom.style.display='block';myleft.width=event.x-6;}if(event.x<=16 && event.y>=4) {myleft_top.style.display='none';myleft.style.display='none';myleft_bottom.style.display='none';}if(event.x<4) window.event.returnValue = false;">
							<span class="imgDrag" style="display:inline-block;">&nbsp;</span>
						</div>
					</td>
					<td id="myright_leftMargin" class="myright_leftMargin"></td>
					<td id="myright" class="myright">
						<div class="RightContentDiv" id="RightContentDiv"> 
							<table style="width: 100%;height: 100%;border: 0;" cellspacing="0" cellpadding="0">
								<tr> 
									<td colspan=2 id="myHelpText" height=10 class='Help_TextArea'> Script 正文
									</td>
								</tr>
                                <tr> 
									<td colspan=2 > 
										<div class="groupboxmaxcontent" style="width: 100%;height:100%" id="window1"> 
                                        <iframe name="right" style="display:none"></iframe>
                                        <textarea name="myTextArea" id="myTextArea" onselect="storeCaret(this);" onclick="storeCaret(this);" style="width:100%;height:100%" onkeyup="storeCaret(this);" wrap=soft class="Script_TextArea"></textarea>
										</div>
									</td>
								</tr>
							</table>
						</div>
					</td>
					<td id="myright_rightMargin" class="myright_rightMargin"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>

<script type="text/javascript">
	function startMenu(){
		<%=tviTemp.generateHTMLTreeView()%>
	}
    
    function translateScriptText(){
        top.returnValue = amarsoft2Real(document.getElementById("myTextArea").value);
		top.close();
    }
	
    function cancel(){
    	top.close();
	}
    
    //选择“左栏”和“右栏”
    function clickMyColOption(sPara1,sPara2){
        sCurOptValue=sPara1;
        sCurOptName=sPara2;
    }

    function mySelection(sClassName,sMethodName,sMethod,sMethodDescribe,sMethodCode){
        var sReturnValue="!"+sClassName+"."+sMethodName+"()";
        var sHelpText=sMethod+"<br>"+sMethodDescribe+"<br>"+sMethodCode;
        sHelpText = sHelpText+"<br><br><a href=\"javascript:insertHelp('"+sReturnValue+"')\"><font color=red>插入该方法</font></a>";
//        alert(sHelpText);
        document.all("myHelpText").innerHTML=sHelpText;
    }
    
    function insertHelp(tmp){
        insertAtCaret(document.getElementById("myTextArea"),tmp);
    }

    //确定选择的位置
    function storeCaret (textEl) { 
	    if (textEl.createTextRange) 
	        textEl.caretPos = document.selection.createRange().duplicate(); 
    } 
    
    //插入数据
    function insertAtCaret (textEl, text) { 
	    if (textEl.createTextRange && textEl.caretPos) { 
	        var caretPos = textEl.caretPos; 
	        caretPos.text =text; 
	    }else 
	        textEl.value = textEl.value+text; 
    } 
    
    //利用String.replace函数，将字符串左右两边的空格替换成空字符串
    function Trim (sTmp){
        return sTmp.replace(/^(\s+)/,"").replace(/(\s+)$/,"");
    }
    
	function showTree(){
		myleft.width=200;
		startMenu();
		expandNode('root');
		showTreeButtonTD.style.display="none";
	}
	
	myleft.width=1;
    //载入时去除值两边的空格
    document.getElementById("myTextArea").value = amarsoft2Real("<%=sScriptText.trim()%>");
</script>
<%@ include file="/IncludeEnd.jsp"%>