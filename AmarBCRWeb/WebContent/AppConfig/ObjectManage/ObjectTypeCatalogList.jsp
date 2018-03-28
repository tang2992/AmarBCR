<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/Frame/resources/include/include_begin_list.jspf"%><%
	ASObjectModel doTemp = new ASObjectModel("AppBizObjectList");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      //设置DW风格 1:Grid 2:Freeform
	dwTemp.ReadOnly = "1"; //设置是否只读 1:只读 0:可写
	dwTemp.setPageSize(20);
	dwTemp.genHTMLObjectWindow("");

	String sButtons[][] = {
		{"true","All","Button","新增","新增一条记录","newRecord()","","","","btn_icon_add"},
		{"true","All","Button","删除","删除所选中的记录","deleteRecord()","","","","btn_icon_delete"},
		{"true","All","Button","配置对象关联","配置对象关联","configObjectRela()","","","",""},
		{"true","All","Button","对象属性列表","查看/修改对象属性列表","viewAndEdit2()","","","",""},
		{"false","All","Button","刷新对象","刷新对象","reloadCache('业务对象')","","","",""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	<%/*[Describe=新增记录;]*/%>
	function newRecord(){
        OpenPage("/AppConfig/ObjectManage/ObjectTypeCatalogInfo.jsp","frameright","");  
	}

    <%/*[Describe=查看及修改详情;]*/%>
	function mySelectRow(){
		var sObjectType = getItemValue(0,getRow(),"ObjectType");
        if(typeof(sObjectType)=="undefined" || sObjectType.length==0){
			OpenPage("/AppMain/Blank.jsp","frameright");
		}else{
	      	OpenPage("/AppConfig/ObjectManage/ObjectTypeCatalogInfo.jsp?ObjectType="+sObjectType,"frameright"); 
		}
	}
    
	<%/*[Describe=删除记录;]*/%>
	function deleteRecord(){
		var sObjectType = getItemValue(0,getRow(),"ObjectType");
        if(typeof(sObjectType)=="undefined" || sObjectType.length==0){
			alert(getMessageText('AWEW1001'));//请选择一条信息！
	      	return ;
		}
		if(confirm("删除该记录将同时删除其关联关系，\n您确定删除吗？")){
			as_delete("myiframe0","");
		}
	}
	
	<%/*[Describe=配置对象关联;]*/%>
	function configObjectRela(){
		var sObjectType = getItemValue(0,getRow(),"ObjectType");
        if(typeof(sObjectType)=="undefined" || sObjectType.length==0){
            alert(getMessageText('AWEW1001'));//请选择一条信息！
        }else{
           sReturn=AsControl.PopView("/AppConfig/ObjectManage/ObjectTypeRelaFrame.jsp","ObjectType="+sObjectType,"");
        }
    }
    <%/*~[Describe=查看及修改对象属性列表;]~*/%>
	function viewAndEdit2(){
		var sObjectType = getItemValue(0,getRow(),"ObjectType");
		if(typeof(sObjectType)=="undefined" || sObjectType.length==0) {
			alert(getMessageText('AWEW1001'));//请选择一条信息！
			return ;
		}
		AsControl.PopComp("/AppConfig/ObjectManage/ObjectTypeAttrList.jsp","ObjectType="+sObjectType,"");
	}

	mySelectRow();
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>