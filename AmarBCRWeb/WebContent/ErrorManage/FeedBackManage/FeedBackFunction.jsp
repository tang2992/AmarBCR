<script type="text/javascript">
/*~[Describe=;InputParam=��;OutPutParam=��;]~*/
	function report(action){
		var sTableName = "<%=sTableName%>";
		var sTraceNumber = getItemValue(0,getRow(),"TRACENUMBER");
		var sSessionID = getItemValue(0,getRow(),"SESSIONID");
		var sWhere;
		var sReturn;
		
		if(typeof(sSessionID)=="undefined"||sSessionID==''){
			alert("����ѡ��һ����¼!");
			return;		
		}
		//�����Ѿ��ϱ�����ҵ���ܲ��������ݲ���
		if(typeof(sSessionID) != "undefined" && sSessionID!="9999999999" && sSessionID!="1111111111" && sSessionID!="0000000000" && sSessionID!="6666666666" &&(action=="2"||action=="3"))
		{
			if(confirm("�ñ�ҵ���Ѿ��ϱ�����,�Ƿ�ӷ����������ɾ��������¼?")){
				PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TraceNumber="+sTraceNumber,"_self","");
				alert("������¼�Ѵӷ����������ɾ��!");
				return;
			}
		}
		//û����Ϣ���ٱ��,���������ϱ�
		if((typeof(sTraceNumber) == "undefined" || sTraceNumber.length == 0)&&action=="2")
		{
			alert("��Ϣ���ٱ�Ų�����,�޷������ر�!");
			return;
		}
		if(action=="2"){
			if(confirm("ȷ�������ϱ�?")){
				sWhere = "and TRACENUMBER = '"+sTraceNumber+"'";
				sReturn = PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TableName="+sDBTableName+"&TraceNumber="+sTraceNumber+"&Where="+sWhere+"&Action="+action,"_self","");
				if(sReturn == "Success"){
					alert("�����ر���־�ɹ�!");
				}else{
					alert("�����ر���־ʧ��!");
				}
			}
		}else if(action=="3"){
			if(confirm("ȷ���ݲ��ϱ�?")){
				sWhere = "and TRACENUMBER = '"+sTraceNumber+"'";
				sReturn = PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TableName="+sDBTableName+"&TraceNumber="+sTraceNumber+"&Where="+sWhere+"&Action="+action,"_self","");
				if(sReturn == "Success"){
					alert("�����ݲ��ϱ���־�ɹ�!");
				}else{
					alert("�����ݲ��ϱ���־ʧ��!");
				}
			}
		}else if(action=="4"){
			if(confirm("ȷ����������?")){
			var sWhere = " where 1=1 and " + "<%=sKeyName[0]%>" + "='" + getItemValue(0,getRow(),"<%=sKeyName[0]%>") + "'";
	    	<%
	    		for(int i=1;i<sKeyName.length;i++){
	    	%>
	    			sKeyValue =  getItemValue(0,getRow(),"<%=sKeyName[i]%>");
	    			if("<%=sKeyName[i]%>"=="RETURNTIMES")
	    				sWhere = sWhere + " and " + "<%=sKeyName[i]%>" + "=" + sKeyValue;
	    			else
	    				sWhere = sWhere + " and " + "<%=sKeyName[i]%>" + "='" + sKeyValue + "'";
	    	<%				
	    		}
	    	%>
				sReturn = PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TableName="+sTableName+"&Where="+sWhere+"&Action="+action,"_self","");
				if(sReturn == "Success"){
					alert("���ò�����־�ɹ�!");
				}else{
					alert("���ò�����־ʧ��!");
				}
			}
		}
		reloadSelf();
	}
	
	
	
</script>