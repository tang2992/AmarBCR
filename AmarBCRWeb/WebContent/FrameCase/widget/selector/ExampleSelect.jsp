<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%>
<br/>
<div>
	<pre>
  ��SELECT_CATALOG����������ѡ����Ϣ���Ƿ��ѡ�������õ�ѡ��ģʽ��Multi/Single����������
	��Ҫ���ѡ���ķ���ֵʱ���ŵ���AsDialog.OpenSelector()�򿪵���ѡ�������ȡ����ֵ��
	����ǽ���ͨ��ѡ���ķ���ֵ��DW���ֶθ�ֵ������DWģ��������
	AsDialog.OpenSelector(sSelname,sParaString,sStyle)
	sSelname��ѡ��Ի�����
	sParaString������ѡ��Ի���������Ҫ�Ĳ�����������ʽΪ    ������=����ֵ
	sStyle��  �Ի�����ʽ
	</pre>
	<%=new Button("�б�ѡ���","�б�ѡ���","selectList()","","btn_icon_detail","").getHtmlText()%>
	<%=new Button("��ͼѡ���","��ͼѡ���","selectTree()","","btn_icon_detail","").getHtmlText()%>
</div>
<br/>
<div>
	<pre>
  ����ʾģ������ѡ���б�
	A���򿪵���ѡ��򣬲���ȡ����ֵ
	����˵����1����ʾģ����  2��������������ֵ1,����ֵ2,...  
		3������ֵ���� �����ֶ�1@�����ֶ�2@...
		4��Ԥѡֵ��Ϊ��һ�������ֶε�ֵ����ֻ֧�ֶ�ѡ��
		5���Ƿ��ѡ (true/false)
	return : ����ֵ�������ֶη��أ�����Ƕ�ѡ�Է��š�~���ָ����磺0010@�ڵ�1@...~0020@�ڵ�2@...~...
	var sReturn = AsDialog.SelectGridValue("OrgList", "", "OrgID@OrgName", sSelected, true);
	</pre>
	<div>
		<%=new Button("����ʾģ�������б�ѡ���","�б�ѡ���","SelectGridValue()","","btn_icon_detail","").getHtmlText()%>
	</div>

<br/>
	<pre>
	B���򿪵���ѡ��򣬻�ȡ����ֵ����������ֵ���õ���Ӧ�ֶ�
	����˵����1����ʾģ����  2��������������ֵ1,����ֵ2,...	
		3�����ش��������ֶ�1=�����ֶ�1@�����ֶ�2=�����ֶ�2@...
		4��Ԥѡֵ
	AsDialog.SetGridValue("OrgList", "", "id=OrgID@name=OrgName", sSelected);
	</pre>
	<div><%=new Button("����ʾģ�����ɵ��б�ѡ������ֵ","�б�ѡ���","SetGridValue()","","btn_icon_detail","").getHtmlText()%></div>
	<div>
		id �����<input id="id" style="overflow:visible;" />
		name �����<input id="name" style="overflow:visible;" />
	</div>
</div>
<script type="text/javascript">
	<%/*~[Describe=������ͼѡ���;InputParam=��;OutPutParam=��;]~*/%>
	function selectTree(){
		//��Ҫ���ѡ���ķ���ֵʱ���ŵ���AsDialog.OpenSelector()�򿪵���ѡ�������ȡ����ֵ��
		//����ǽ���ͨ��ѡ���ķ���ֵ��DW���ֶθ�ֵ������DWģ��������
		//AsDialog.OpenSelector(sSelname,sParaString,sStyle)
		//sSelname��ѡ��Ի�����
		//sParaString������ѡ��Ի���������Ҫ�Ĳ�����������ʽΪ    ������=����ֵ
		//sStyle��  �Ի�����ʽ
		var sReturn = AsDialog.OpenSelector("SelectAllOrg","","");
		alert("�����ַ��� ��"+sReturn);//ע�ⷵ���ַ����ķ�����ʽ
	}
	
	<%/*~[Describe=�����б�ѡ���;InputParam=��;OutPutParam=��;]~*/%>
	function selectList(){
		//��Ҫ���ѡ���ķ���ֵʱ���ŵ���AsDialog.OpenSelector()�򿪵���ѡ�������ȡ����ֵ��
		//����ǽ���ͨ��ѡ���ķ���ֵ��DW���ֶθ�ֵ������DWģ��������
		//AsDialog.OpenSelector(sSelname,sParaString,sStyle)
		//sSelname��ѡ��Ի�����
		//sParaString������ѡ��Ի���������Ҫ�Ĳ�����������ʽΪ    ������=����ֵ
		//sStyle��  �Ի�����ʽ
		var sReturn  = AsDialog.OpenSelector("SelectAllUser","","");
		alert("�����ַ��� ��"+sReturn);//ע�ⷵ���ַ����ķ�����ʽ
	}
	
	<%/* DataWindowѡ����ѡ�� */%>
	function SelectGridValue(){
		var oldIds = getItemValue(0, 0, "id");
		var oldNames = getItemValue(0, 0, "name");
		var sSelected = [oldIds, oldNames];
		var sReturn = AsDialog.SelectGridValue("TestCustomerList", "", "SerialNo@CustomerName", sSelected, true);
		if(!sReturn) return;
		//alert(sReturn);
		var sIds = "";
		var sNames = "";
		if(sReturn != "_CLEAR_"){
			var aReturn = sReturn.split("~");
			//alert(aReturn.length);
			for(var i = 0; i < aReturn.length; i++){
				var aIdName = aReturn[i].split("@");
				sIds += ","+aIdName[0];
				sNames += ","+aIdName[1];
			}
			if(sIds != "") sIds = sIds.substring(1);
			if(sNames != "") sNames = sNames.substring(1);
		}
		setItemValue(0, 0, "id", sIds);
		setItemValue(0, 0, "name", sNames);
	}
	
	<%/* DataWindowѡ�������� */%>
	function SetGridValue(){
		var sSelected = getItemValue(0, 0, "id");
		AsDialog.SetGridValue("TestCustomerList", "", "id=SerialNo@name=CustomerName", sSelected);
	}
	
	<%/* ����Ϊģ��DataWindow���� */%>
	function getItemValue(iDW, iRow, sField){
		return document.getElementById(sField).value;
	}
	function setItemValue(iDW, iRow, sField, sValue){
		var odom = document.getElementById(sField);
		odom.value = sValue;
		odom.style.background = "red";
		setTimeout(function(){
			odom.style.background = "";
		}, 500);
	}
	function getRow(){
		return 0;
	}
</script>
<%@ include file="/IncludeEnd.jsp"%>