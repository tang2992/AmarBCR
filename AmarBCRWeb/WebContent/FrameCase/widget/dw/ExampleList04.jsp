<%@ page contentType="text/html; charset=GBK"%>
<div style="z-index:9999;position:absolute;right:0;top:0;background:#fff;border:1px solid #aaa;font-size:12px;">
	<pre>
	
	����ѡ���б�һ����¼���ᴥ������mySelectRow()
	function mySelectRow(){
		viewAndEdit();//ѡ��ĳ��¼�Զ�չ������
    	}
    </pre>
	<a style="position:absolute;top:5px;left:5px;" href="javascript:void(0);" onclick="$(this).parent().slideUp();">X</a>
</div>
<%@
 include file="/IncludeBegin.jsp"%><%
	/*
		ҳ��˵��: DW�����¼�ʾ��ҳ��
	 */
	String PG_TITLE = "DW�����¼�ʾ��ҳ��";

	//ͨ����ʾģ�����ASDataObject����doTemp
	ASDataObject doTemp = new ASDataObject("ExampleList",Sqlca);
	ASDataWindow dwTemp = new ASDataWindow(CurPage ,doTemp,Sqlca);
	dwTemp.Style="1";      //����DW��� 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //�����Ƿ�ֻ�� 1:ֻ�� 0:��д
	dwTemp.setPageSize(15);
 
	//����HTMLDataWindow
	Vector vTemp = dwTemp.genHTMLDataWindow("");
	for(int i=0;i<vTemp.size();i++) out.print((String)vTemp.get(i));
	
	String sButtons[][] = {};
%><%@include file="/Resources/CodeParts/List05.jsp"%>
<script type="text/javascript">
	function viewAndEdit(){
		var sExampleId=getItemValue(0,getRow(),"ExampleId");
		if (typeof(sExampleId)=="undefined" || sExampleId.length==0){
			alert("��ѡ��һ����¼��");
			return;
		}
		AsControl.PopView("/FrameCase/widget/dw/ExampleInfo.jsp","ExampleId="+sExampleId+"&PrevUrl=/FrameCase/widget/dw/ExampleList04.jsp","");
	}

	<%/*ѡ���б�һ����¼���ᴥ������mySelectRow()*/%>
	function mySelectRow(){
		viewAndEdit();//ѡ��ĳ��¼�Զ�չ������
    }

	$(document).ready(function(){
		AsOne.AsInit();
		init();
		my_load(2,0,'myiframe0');
	});
</script>	
<%@ include file="/IncludeEnd.jsp"%>