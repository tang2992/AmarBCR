<%@ page contentType="text/html; charset=GBK"%><%@
include file="/IncludeBegin.jsp"%><%
 	/* 
 		ҳ��˵���� ͨ�����鶨������strip���ҳ��ʾ��
 	*/
 	//����strip���飺
 	//������0.�Ƿ���ʾ, 1.���⣬2.URL��3.��������4.�߶�(��λ��px��Ĭ��600)
	String sTabStrip[][] = {
		{"true", "����List", "/FrameCase/widget/dw/ExampleList.jsp", "", "400"},
		{"true", "����Info", "/FrameCase/widget/dw/ExampleInfo.jsp", "ExampleId=2012081700000001", "500"},
		{"true", "����List", "/FrameCase/widget/dw/ExampleList.jsp", "", "400"},
	};
%>
<div style="z-index:9999;position:absolute;right:0;top:0;background:#fff;border:1px solid #aaa;font-size:12px;">
  	<pre>
  	
  	ͨ�����鶨������strip���ҳ��ʾ��
	1. ����strip��ά���飺
	������0.�Ƿ���ʾ, 1.���⣬2.URL��3����������4.�߶�(��λ��px��Ĭ��600)
	ʾ��: String sTabStrip[][] = {
		{"true", "����Info", "/FrameCase/widget/dw/ExampleInfo.jsp", "ExampleId=2012081700000001"},
		};
	2. include �ļ� /Resources/CodeParts/Strip01.jsp
	</pre>
	<a style="position:absolute;top:5px;left:5px;" href="javascript:void(0);" onclick="$(this).parent().slideUp();">X</a>
</div>
<%@include file="/Resources/CodeParts/Strip01.jsp"%>
<%@ include file="/IncludeEnd.jsp"%>