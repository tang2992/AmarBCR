<script type="text/javascript">
/*~[Describe=;InputParam=无;OutPutParam=无;]~*/
	function report(action){
		var sTableName = "<%=sTableName%>";
		var sTraceNumber = getItemValue(0,getRow(),"TRACENUMBER");
		var sSessionID = getItemValue(0,getRow(),"SESSIONID");
		var sWhere;
		var sReturn;
		
		if(typeof(sSessionID)=="undefined"||sSessionID==''){
			alert("请先选择一条记录!");
			return;		
		}
		//正常已经上报过的业务不能补报或者暂不报
		if(typeof(sSessionID) != "undefined" && sSessionID!="9999999999" && sSessionID!="1111111111" && sSessionID!="0000000000" && sSessionID!="6666666666" &&(action=="2"||action=="3"))
		{
			if(confirm("该笔业务已经上报过了,是否从反馈错误表中删除该条记录?")){
				PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TraceNumber="+sTraceNumber,"_self","");
				alert("该条记录已从反馈错误表中删除!");
				return;
			}
		}
		//没有信息跟踪编号,不能重新上报
		if((typeof(sTraceNumber) == "undefined" || sTraceNumber.length == 0)&&action=="2")
		{
			alert("信息跟踪编号不存在,无法进行重报!");
			return;
		}
		if(action=="2"){
			if(confirm("确定重新上报?")){
				sWhere = "and TRACENUMBER = '"+sTraceNumber+"'";
				sReturn = PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TableName="+sDBTableName+"&TraceNumber="+sTraceNumber+"&Where="+sWhere+"&Action="+action,"_self","");
				if(sReturn == "Success"){
					alert("设置重报标志成功!");
				}else{
					alert("设置重报标志失败!");
				}
			}
		}else if(action=="3"){
			if(confirm("确定暂不上报?")){
				sWhere = "and TRACENUMBER = '"+sTraceNumber+"'";
				sReturn = PopPage("/ErrorManage/UpdateSessionIDAction.jsp?TableName="+sDBTableName+"&TraceNumber="+sTraceNumber+"&Where="+sWhere+"&Action="+action,"_self","");
				if(sReturn == "Success"){
					alert("设置暂不上报标志成功!");
				}else{
					alert("设置暂不上报标志失败!");
				}
			}
		}else if(action=="4"){
			if(confirm("确定反馈补报?")){
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
					alert("设置补报标志成功!");
				}else{
					alert("设置补报标志失败!");
				}
			}
		}
		reloadSelf();
	}
	
	
	
</script>