<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBeginMD.jsp"%><%
	String sScriptText = CurPage.getParameter("ScriptText");
	String sSqlObjectType = CurPage.getParameter("SqlObjectType");
	if (sScriptText==null) sScriptText="";
	sScriptText = StringFunction.replace(sScriptText,"$[wave]","~");

	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"对象属性","right");

	int i=0;
	int j=0;
	String sFolder = "";
	String sSql2="";
	ASResultSet rs2=null;
	String sSql="select ObjectName,ObjectType from OBJECTTYPE_CATALOG where ObjectType =:ObjectType";
	ASResultSet rs=Sqlca.getASResultSet(new SqlObject(sSql).setParameter("ObjectType",sSqlObjectType));
	while(rs.next()){
	    j=0;
	    sFolder = tviTemp.insertFolder("root",rs.getString(1),"",i++);
	    sSql2 = "select distinct AttributeName,'<font color=red>{'||ObjectType||'}</font>.{'||AttributeName||'} ('||'MethodArgs' ||')',ltrim(rtrim(AttributeDescribe)),ltrim(rtrim(Remark)),SortNo from OBJECT_ATTRIBUTE "+
	            "where ObjectType=:ObjectType order by SortNo";
		rs2 = Sqlca.getASResultSet(new SqlObject(sSql2).setParameter("ObjectType",rs.getString(2)));
	    while (rs2.next()){
	        tviTemp.insertPage(sFolder,rs2.getString(1),"javascript:parent.mySelection(\""+DataConvert.toString(rs.getString(1))+"\",\""+DataConvert.toString(rs2.getString(1))+"\",\""+DataConvert.toString(rs2.getString(2))+"\",\""+DataConvert.toString(rs2.getString(3))+"\",\""+DataConvert.toString(rs2.getString(4))+"\")",j++);
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
                    	<%=new Button("显示对象属性列表", "显示对象属性列表", "showTree()", "", "").getHtmlText()%>
                    </td>
                </tr>
            </table>
	    </td>
	</tr>
	<tr>
		<td valign="top">
			<table style="width: 100%;height: 100%;border: 0;" cellspacing="0" cellpadding="0" class="content_table"  id="content_table">
				<tr> 
					<td id="myleft_left_top_corner" class="myleft_left_top_corner"></td>
					<td id="myleft_top" class="myleft_top"></td>
					<td id="myleft_right_top_corner" class="myleft_right_top_corner"></td>
					<td id="mycenter_top" class="mycenter_top"></td>
					<td id="myright_left_top_corner" class="myright_left_top_corner"></td>
					<td id="myright_top" class="myright_top"></td>
					<td id="myright_right_top_corner" class="myright_right_top_corner"></td>
				</tr>
				<tr> 
					<td id="myleft_leftMargin" class="myleft_leftMargin"></td>
					<td id="myleft" width=20%> 
						<iframe name="left" src="" width=100% height=100% frameborder=0 scrolling=no ></iframe>
					</td>
					<td id="myleft_rightMargin" class="myleft_rightMargin"> </td>
					<td id="mycenter" class="mycenter">
						<div id=divDrag title='可拖拽改变窗口大小 Drag to resize' style="z-index:0; cursor: w-resize; "	ondrag="if(event.x>16 && event.x<400) {myleft_top.style.display='block';myleft.style.display='block';myleft_bottom.style.display='block';myleft.width=event.x-6;}if(event.x<=16 && event.y>=4) {myleft_top.style.display='none';myleft.style.display='none';myleft_bottom.style.display='none';}if(event.x<4) window.event.returnValue = false;">
							<span class="imgDrag" style="display:inline-block;">&nbsp;</span>
						</div>
					</td>
					<td id="myright_leftMargin" class="myright_leftMargin"></td>
					<td id="myright" class="myright">
						<div  class="RightContentDiv" id="RightContentDiv"> 
							<table style="width: 100%;height: 100%;border: 0;" cellspacing="0" cellpadding="0">
								<tr> 
									<td colspan=2 id="myHelpText" height=10 class='Help_TextArea'>  正文
									</td>
								</tr>
                                <tr> 
									<td colspan=2 > 
										<div name="tt" class="groupboxmaxcontent" style="position:absolute; width: 100%;height:100%" id="window1"> 
                                        <iframe name="right" style="display:none"></iframe>
                                        <TEXTAREA name="myTextArea" ROWS="35" COLS="100" ONSELECT="storeCaret(this);" onCLICK="storeCaret(this);" onKEYUP="storeCaret(this);" WRAP=soft class="Script_TextArea"></TEXTAREA>
										</div>
									</td>
								</tr>
							</table>
						</div>
					</td>
					<td id="myright_rightMargin" class="myright_rightMargin"></td>
				</tr>
				<tr>
					<td id="myleft_left_bottom_corner" class="myleft_left_bottom_corner"></td>
					<td id="myleft_bottom" class="myleft_bottom"></td>
					<td id="myleft_right_bottom_corner" class="myleft_right_bottom_corner"></td>
					<td id="mycenter_bottom" class="mycenter_bottom"></td>
					<td id="myright_left_bottom_corner" class="myright_left_bottom_corner"></td>
					<td id="myright_bottom" class="myright_bottom"></td>
					<td id="myright_right_bottom_corner" class="myright_right_bottom_corner"></td>
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
		top.returnValue = amarsoft2Real(document.all("myTextArea").value);
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

    function mySelection(sObjectTypeName,sAttributeName,sMethod,sAttributeDescribe,sRemark){
        var sReturnValue="{"+sObjectTypeName+"}.{"+sAttributeName+"}";
        var sHelpText=sReturnValue+"<br>"+sAttributeDescribe+"<br>"+sRemark;
        sHelpText = sHelpText+"<br><br><a href=\"javascript:insertHelp('"+sReturnValue+"')\"><font color=red>插入光标处</font></a>";
//        alert(sHelpText);
        document.all("myHelpText").innerHTML=sHelpText;
    }
    
	function insertHelp(tmp){
        insertAtCaret(document.all("myTextArea"),tmp);
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
    document.all("myTextArea").value = amarsoft2Real("<%=sScriptText.trim()%>");
</script>
<%@ include file="/IncludeEnd.jsp"%>