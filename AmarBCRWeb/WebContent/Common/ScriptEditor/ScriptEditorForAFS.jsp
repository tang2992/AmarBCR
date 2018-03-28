<%@ page import="com.amarsoft.biz.finance.*" %>
<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBeginMD.jsp"%><%
	String sScriptText = CurPage.getParameter("ScriptText");
	String sModelNo = CurPage.getParameter("ModelNo");
	if (sScriptText==null) sScriptText="";
	if (sModelNo==null) sModelNo="";
	sScriptText = StringFunction.replace(sScriptText,"$[wave]","~");
	
	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"公式设置","right");

	int i=0;
	int j=0;
	String sFolder = "";
	String sSql2="";
	ASResultSet rs2=null;
	String sSql="select RC1.ModelNo,RC1.ModelName,RC1.ModelName||'['||RC1.ModelNo||']' from REPORT_CATALOG RC1,REPORT_CATALOG RC2 "+
	            "where RC1.ModelClass=RC2.ModelClass and RC2.ModelNo=:ModelNo order by RC1.ModelNo";
	ASResultSet rs=Sqlca.getASResultSet(new SqlObject(sSql).setParameter("ModelNo",sModelNo));
	while(rs.next()){
	    j=0;
	    sFolder = tviTemp.insertFolder("root",rs.getString(2),rs.getString(1),i++);
	    sSql2 = "select distinct FI.ItemNo,FI.ItemName||'['||FI.ItemNo||']' from REPORT_MODEL RM,FINANCE_ITEM FI "+
	            "where RM.RowSubject=FI.ItemNo and RM.ModelNo=:ModelNo order by FI.ItemNo";
	    rs2 = Sqlca.getASResultSet(new SqlObject(sSql2).setParameter("ModelNo",rs.getString(1)));
	    while (rs2.next()){
	        tviTemp.insertPage(sFolder,rs2.getString(2),"javascript:parent.mySelection(\""+rs.getString(3)+"\",\""+rs2.getString(2)+"\")",j++);
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
                    <td valign=middle>会计月份：
                    <select name="MyAccount">
                    <%
                    sSql="select ItemNo,ItemName  from CODE_LIBRARY where codeno='RelativeMonth' order by SortNo";
                    rs=Sqlca.getASResultSet(sSql);
                    while (rs.next()){
                        out.println("<option value='"+rs.getString(1)+"' id='ID"+rs.getString(1)+"' text='"+rs.getString(2)+"'>"+rs.getString(2)+"</option>");  
					}
                    rs.getStatement().close();
                    %>
                    </select>
                    </td>
                    <td width=10>&nbsp;</td>
                    <td >可选表项：
                        <input type="radio" value="LEFT" name="myColOption" onclick="javascript:clickMyColOption('LEFT','左栏')" checked>左栏
                        <input type="radio" value="RIGHT" name="myColOption"  onclick="javascript:clickMyColOption('RIGHT','右栏')">右栏
                    </td>
                </tr>
            </table>
	    </td>
	</tr>
	<tr>
		<td valign="top">
			<table style="width: 100%;height: 100%;border: 0;" cellspacing="0" cellpadding="0" class="content_table"  id="content_table">
				<tr> 
					<td id="myleft" width=25%> 
						<iframe name="left" src="" width=100% height=100% frameborder=0 scrolling=no ></iframe>
					</td>
					<td id="mycenter" class="mycenter">
						<div id=divDrag title='可拖拽改变窗口大小 Drag to resize' style="z-index:0; cursor: w-resize; "	ondrag="if(event.x>16 && event.x<400) {myleft_top.style.display='block';myleft.style.display='block';myleft_bottom.style.display='block';myleft.width=event.x-6;}if(event.x<=16 && event.y>=4) {myleft_top.style.display='none';myleft.style.display='none';myleft_bottom.style.display='none';}if(event.x<4) window.event.returnValue = false;">
							<span class="imgDrag" style="display:inline-block;">&nbsp;</span>
						</div>
					</td>
					<td id="myright" class="myright">
						<table style="width: 100%;height: 100%;border: 0;" cellspacing="0" cellpadding="0">
							<tr> 
								<td colspan=2 > 
									<div  class="groupboxmaxcontent" id="window1"> 
                                       <textarea id="myTextArea" name="myTextArea" rows="35" cols="100" onselect="storeCaret(this);" onclick="storeCaret(this);" onkeyup="storeCaret(this);" WRAP=soft style="overflow:auto">
                                       </textarea>
                                       <iframe name="right" style="display:none"></iframe>
									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>
<script type="text/javascript">
    //置可选表项的初始值
	var sCurOptValue="LEFT";
    var sCurOptName="左栏";
	
	function startMenu(){
		<%=tviTemp.generateHTMLTreeView()%>
	}
    
    function returnText(){
        sReturn = PopPageAjax("/Common/ScriptEditor/TranslateAFSBackToSourceAjax.jsp");
        top.returnValue = amarsoft2Real(sReturn);
		top.close();
	}

    function translateScriptText(){
        saveParaToComp("AFScriptSourceAfterEdit="+document.getElementById("myTextArea").value,"returnText()");
    }
	
    function cancel(){
    	top.close();
	}
    
    //选择“左栏”和“右栏”
    function clickMyColOption(sPara1,sPara2){
        sCurOptValue=sPara1;
        sCurOptName=sPara2;
    }

    function mySelection(sPara1,sPara2){
        var sCurAccountValue=document.all("MyAccount").value;
	    var sCurAccountName=document.all("ID"+sCurAccountValue).text;
        var returnValue="{"+sCurAccountName+"."+sPara1+"."+sPara2+"."+sCurOptName+"}";
        if (confirm("确定插入："+returnValue+"?")){
            insertAtCaret(document.getElementById("myTextArea"), returnValue);
        }
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

    $(document).ready(function(){
		startMenu();
		expandNode('root');
	    //载入时去除值两边的空格
	    document.getElementById("myTextArea").value = amarsoft2Real("<%=Report.transExpression(0,sScriptText.trim(),Sqlca)%>");
    });
</script>
<%@ include file="/IncludeEnd.jsp"%>