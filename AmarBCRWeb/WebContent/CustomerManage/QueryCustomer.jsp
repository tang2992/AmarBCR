<%@ page contentType="text/html; charset=GBK"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.amarsoft.are.ARE"%>
<%@page import="com.amarsoft.are.lang.DataElement"%>
<%@page import="com.amarsoft.oti.*"%>
<%@page import="com.amarsoft.are.jbo.*"%>
<%@ include file="/IncludeBeginMD.jsp"%><%
	/* Author:   djia  2009.08.03
	 * Tester:
	 * Content: 到核心查询客户开户信息
	 * Input Param:
	 * 		CertID：证件号码
	 * Output param:
	 *      sReturn: 交易结果	 
	 */	 
	OTIManager manager = null;
	OTIConnection conn = null;
	OTITransaction trans = null;
    TXResult result = null;
	String sReturn = "";
	String sCertType = "";
	
	//获得页面参数	
	String sCertID = CurPage.getParameter("CertID"); 		
	//将空值转化为空字符串
	if(sCertID == null) sCertID = "";
	
	try {
		manager = OTIManager.getManager();
		//获取连接
		conn = manager.getConnectionInstance("CoreBankingClient");
		conn.open();
		//获取交易
		ARE.getLog().trace("tradeNo:"+"Q001");
		trans = manager.getTransactionInstance("Q001");
		ARE.getLog().trace("paraWhere="+" CertID = '"+sCertID+"'");
		//trans.initRequestBody("select CertId, CertType from CUSTOMER_INFO where CertID = '"+sCertID+"'","");
		trans.initRequestBody("select R.CertId, R.CertType from jbo.oti.KHBody R where R.CertID = '"+sCertID+"'");
		
		//初始化报文头
		DataElement de	= null;
		BizObject bo = trans.getRequestHeader();
		
		de = bo.getAttribute("TradeNo");
		de.setValue("Q001");
		
		//取证件类型
		TXMessageBody requestBody = trans.getRequestBody();
		bo = requestBody.getObject(0);
		sCertType = bo.getAttribute("CertType").getString();	
		
		//发送交易
		result = conn.executeTransaction(trans);
		ARE.getLog().trace(result.toString());		
	}catch(TXException e){
		e.printStackTrace();
		ARE.getLog().debug(e);
		throw new Exception("错误，请检查与核心的交互连接。");
	}
	
	if(result.getStatus() == 0){
		//成功
		BizObject bore = trans.getResponseHeader();
		int length = 0;		
		for(int j=0; j<bore.getAttributeNumber(); j++){
			length += bore.getAttribute(j).getLength();
			ARE.getLog().trace("反馈字段名："+bore.getAttribute(j).getName()+"  字段值:"+bore.getAttribute(j).getString());
		}
		
		BizObject bo = trans.getRequestHeader();
		TXMessageBody responsBody = trans.getResponseBody();
		if(responsBody != null){
		   ARE.getLog().trace("反馈报文体长度："+responsBody.size());
		   for(int i=0; i<responsBody.size();i++){
			   bo = responsBody.getObject(i);
			   String mfCustomerID = bo.getAttribute("CustomId").getString();
			   Sqlca.executeSQL("update CUSTOMER_INFO  set mfcustomerid ='"+mfCustomerID+"' where CertID = '"+sCertID+"'"+"and CertType = '"+sCertType+"'");
			   sReturn = "0@" + mfCustomerID;
			   for(int j=0; j<bo.getAttributeNumber(); j++){
				   length += bo.getAttribute(j).getLength();
				   ARE.getLog().trace("字段名："+bo.getAttribute(j).getName()+"  字段值:"+bo.getAttribute(j).getString());
			   }
		   }
		}else{
			ARE.getLog().trace("反馈报文体为空");
		}
	}else{
		//失败
		sReturn = "1@"+result.getMessage();
	}
%>
<script type="text/javascript">
	self.returnValue="<%=sReturn%>";
	self.close();
</script>
<%@ include file="/IncludeEnd.jsp"%>