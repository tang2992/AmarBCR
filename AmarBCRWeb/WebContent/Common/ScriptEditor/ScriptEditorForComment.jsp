<%@ page contentType="text/html; charset=GBK"%><%@ include file="/IncludeBeginMD.jsp"%><%
	String sScriptText = CurPage.getParameter("ScriptText");
	if (sScriptText==null) sScriptText="";
	sScriptText = StringFunction.replace(sScriptText,"$[wave]","~");
%>
<html>
<body leftmargin="0" topmargin="0" class="windowbackground" onload="loadSourceScript()">
<table style="width: 100%;height: 100%;border: 0;" cellspacing="0" cellpadding="0">
	<tr height=1>
	    <td>
            <table>
                <tr>
                	<td><%=new Button("确定", "确定", "getHTMLScript()", "", "").getHtmlText()%></td>
					<td><%=new Button("取消", "取消", "cancel()", "", "").getHtmlText()%></td>
                </tr>
            </table>
	    </td>
	</tr>
	<tr>
		<td valign="top">
			<table cellspacing="0" cellpadding="0" style="width: 100%;height: 100%;border: 0;" class="content_table"  id="content_table">
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
					<td id="myleft" > 
						
					</td>
					<td id="myleft_rightMargin" class="myleft_rightMargin"> </td>
					<td id="mycenter" class="mycenter">
						<div id=divDrag title='可拖拽改变窗口大小 Drag to resize' style="z-index:0; cursor: w-resize;"	ondrag="if(event.x>16 && event.x<400) {myleft_top.style.display='block';myleft.style.display='block';myleft_bottom.style.display='block';myleft.width=event.x-6;}if(event.x<=16 && event.y>=4) {myleft_top.style.display='none';myleft.style.display='none';myleft_bottom.style.display='none';}if(event.x<4) window.event.returnValue = false;">
							<span class="imgDrag" style="display:inline-block;">&nbsp;</span>
						</div>
					</td>
					<td id="myright_leftMargin" class="myright_leftMargin"></td>
					<td id="myright" class="myright">
						<div  class="RightContentDiv" id="RightContentDiv"> 
							<table style="width: 100%;height: 100%;border: 0;" cellspacing="0" cellpadding="0">
                                <tr style="width: 100%"> 
									<td> 
										<div class="groupboxmaxcontent" style="position:absolute; width: 100%;" id="window1"> 
                                        <iframe name="right" disabled=false  src="<%=com.amarsoft.awe.util.Escape.getBlankJsp(sWebRootPath,"请稍候...")%>" width=100% height=100% frameborder=0 scrolling=no ></iframe>
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
	function getHTMLScript(){
        sReturnValue=right.returnHTMLScript();
        top.returnValue = sReturnValue;
        top.close();
    }
	
    function cancel(){
    	top.close();
	}
    
    function loadSourceScript(){
        right.setHTMLScript('<%=sScriptText%>');
    }

	right.designMode="On";
	OpenPage("/Common/HtmlEditor/editor.jsp","right","");
</script>
<%@ include file="/IncludeEnd.jsp"%>