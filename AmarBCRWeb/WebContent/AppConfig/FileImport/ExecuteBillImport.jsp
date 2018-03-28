
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin.jspf" %>
<%@page import="com.amarsoft.awe.common.attachment.*"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.amarsoft.are.jbo.*"%>
<%@page import="com.amarsoft.app.als.dataimport.ExcelImportManager"%>
<%@page import="java.util.Date,com.amarsoft.app.als.credit.common.action.*"%>
<%@page import="jxl.*"%>
<script type="text/javascript">
<%!
//�����ൺ��Ʊ�ݵ��빦����ALS7.4.1�м����Ӧģ��
//add by hzcheng
//modify by lyin 2014-01-20
public static boolean dateCheck(String data){
	try {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        dateFormat.setLenient(false);
        Date d = dateFormat.parse(data);
        return true;
	}catch (Exception e) {
		e.printStackTrace();
		return false;
	}
}

public static String dateConvert(String data){
	try {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        dateFormat.setLenient(false);
        Date d = dateFormat.parse(data);
        return dateFormat.format(d);
	}catch (Exception e) {
		e.printStackTrace();
	}
	return data;
}

%>
<%
    File file = null;
    FileInputStream inputStream = null;
	boolean Flag = true;
    try{
    	
        AmarsoftUpload myAmarsoftUpload = new AmarsoftUpload();
        myAmarsoftUpload.initialize(pageContext);
        myAmarsoftUpload.upload();

        String sBillType = (String)myAmarsoftUpload.getRequest().getParameter("BillType");
        if(sBillType==null||"".equals(sBillType))throw new Exception("����BillType��ʧ�������Ƿ���˲���");
        String sObjectNo = (String)myAmarsoftUpload.getRequest().getParameter("ObjectNo");
    	String sObjectType = (String)myAmarsoftUpload.getRequest().getParameter("ObjectType");
        
        String filePathName = myAmarsoftUpload.getFiles().getFile(0).getFilePathName();
        String fileName = myAmarsoftUpload.getFiles().getFile(0).getFileName();
       
        String sFileSavePath = CurConfig.getConfigure("FileSavePath");
        if(sFileSavePath==null)throw new Exception("����als7.xml�������ļ����·��FileSavePath");
        
        //�������Ŀ¼
        String excelSaveDirectory = sFileSavePath+"/excelimport";
        File saveDic = new File(excelSaveDirectory);//���û�и�Ŀ¼���򴴽�
        if(!saveDic.exists())saveDic.mkdirs();
        
        //���ļ�
        out.println("document.writeln('�ļ��ϴ���...<br/>');");
        out.flush();
       	String sFileFullPath = excelSaveDirectory+"/"+System.currentTimeMillis()+fileName;
		
        myAmarsoftUpload.getFiles().getFile(0).saveAs(sFileFullPath);
        
        
        file = new File(sFileFullPath);
        //�����ļ�
        out.println("document.writeln('�ļ��ϴ���ɣ����ڽ���...������رմ���<br/>');");

        out.flush();
        String pattern = "[\r\n]+";
        inputStream = new FileInputStream(file);
        Workbook wb = Workbook.getWorkbook(inputStream); //�õ�������
        Sheet sheet = wb.getSheet(0);
        int iRowCount = 0;

        try
        {
        	iRowCount = Integer.parseInt(sheet.getCell("B1").getContents().replaceAll(pattern, ""));
        }catch(Exception ex)
        {
        	out.println("document.writeln('EXCEL�б���¼����󣬱���¼��������Ҫ���б������ͬ��<br/>');");
        	ex.printStackTrace();
       		throw ex;
        }
        
        JBOTransaction tx = JBOFactory.getFactory().createTransaction();
        
        if("1".equals(sBillType))//���гжһ�Ʊ����
        {
        	for(int i = 3 ; i <= 2+iRowCount; i ++){
        		String sBillSum = sheet.getCell("A"+i).getContents().replaceAll(pattern, "");
        		String sWRITEDATE = sheet.getCell("B"+i).getContents().replaceAll(pattern, "");
        		String sMATURITY = sheet.getCell("C"+i).getContents().replaceAll(pattern, "");
        		String sACCEPTOR = sheet.getCell("D"+i).getContents().replaceAll(pattern, "");
        		String sGATHERINGNAME = sheet.getCell("E"+i).getContents().replaceAll(pattern, "");
        		String sDeductAccNo = sheet.getCell("F"+i).getContents().replaceAll(pattern, "");
        		try{
        			Double.parseDouble(sBillSum);
        		}catch(Exception ex){
        			out.println("document.writeln('��"+(i-2)+"�����ݡ�Ʊ�ݽ�����<br/>');");
        			Flag = false;
        		}
        		
        		//У�鿪ʼ
        		if(!this.dateCheck(sWRITEDATE)){
        			out.println("document.writeln('��"+(i-2)+"�����ݡ���Ʊ�ա�δ����YYYY/MM/DD��ʽ��д��<br/>');");
        			Flag = false;
        		}else{
        			sWRITEDATE = this.dateConvert(sWRITEDATE);
        		}
        		
        		if(!this.dateCheck(sMATURITY)){
        			out.println("document.writeln('��"+(i-2)+"�����ݡ������ա�δ����YYYY/MM/DD��ʽ��д��<br/>');");
        			Flag = false;
        		}else{
        			sMATURITY = this.dateConvert(sMATURITY);
        		}
        		
        		if(sMATURITY!=null && sMATURITY.compareTo(sWRITEDATE) < 0){
    	    		out.println("document.writeln('��"+(i-2)+"�����ݡ������ա�����С�ڡ���Ʊ�ա������飡<br/>');");
        			Flag = false;
    	    	}
        		
        		if(Flag){
        			BizObjectManager bom = com.amarsoft.are.jbo.JBOFactory.getFactory().getManager("jbo.app.BILL_INFO");
					BizObject boBb = bom.newObject();
					boBb.setAttributeValue("ObjectType",sObjectType);
					boBb.setAttributeValue("ObjectNo",sObjectNo);
					boBb.setAttributeValue("BillSum",sBillSum);
					boBb.setAttributeValue("BILLTYPE","BA");
					boBb.setAttributeValue("WRITEDATE",sWRITEDATE);
					boBb.setAttributeValue("MATURITY",sMATURITY);
					boBb.setAttributeValue("Acceptor",sACCEPTOR);
					boBb.setAttributeValue("GATHERINGNAME",sGATHERINGNAME);
					boBb.setAttributeValue("DeductAccNo",sDeductAccNo);
					boBb.setAttributeValue("InputUserID",CurUser.getUserID());
					boBb.setAttributeValue("InputOrgID",CurUser.getOrgID());
					boBb.setAttributeValue("InputDate",StringFunction.getToday());
					boBb.setAttributeValue("UpdateDate",StringFunction.getToday());
					tx.join(bom);
					bom.saveObject(boBb);
        		}
        	}
        }
        else if("2".equals(sBillType)) //(����)���гжһ�Ʊ���ֵ���
        {
        	BizObjectManager boam = com.amarsoft.are.jbo.JBOFactory.getFactory().getManager("jbo.app.BUSINESS_APPLY");
        	BizObject boba = boam.createQuery("SerialNo=:SerialNo").setParameter("SerialNo",sObjectNo).getSingleResult();
        	String sProductID = "",sCurrency = "";
        	if(boba ==  null) 
        	{
        		out.println("document.writeln('δȡ����Ӧ������Ϣ��<br/>');");
    			Flag = false;
        	}
        	else
        	{
        		sProductID = boba.getAttribute("BusinessType").getString();
        		sCurrency = boba.getAttribute("BusinessCurrency").getString();
        	}
        	
        	for(int i = 3 ; i <= 2+iRowCount; i ++)
        	{
        		String sBankFlag = sheet.getCell("A"+i).getContents().replaceAll(pattern, ""); //�Ƿ���Ʊ��*
        		String sBillNo = sheet.getCell("B"+i).getContents().replaceAll(pattern, ""); //Ʊ�ݺ���*
        		String sBillSum = sheet.getCell("C"+i).getContents().replaceAll(pattern, "");//Ʊ����*
        		String sWRITEDATE = sheet.getCell("D"+i).getContents().replaceAll(pattern, "");//Ʊ��ǩ����*
        		String sMATURITY = sheet.getCell("E"+i).getContents().replaceAll(pattern, "");//Ʊ�ݵ�����*
        		String sFinishDate = sheet.getCell("F"+i).getContents().replaceAll(pattern, "");//��������*
        		String sBeginDate = sheet.getCell("G"+i).getContents().replaceAll(pattern, "");//Ʊ�ݲ�ѯ�ظ�����*
        		String sACCEPTORREGION = sheet.getCell("H"+i).getContents().replaceAll(pattern, "");//Ʊ����Դ*
        		String sEndorseTimes = sheet.getCell("I"+i).getContents().replaceAll(pattern, "");//��������*
        		String sRate = sheet.getCell("J"+i).getContents().replaceAll(pattern, "");//����������(��)*
        		String sACCEPTORID = sheet.getCell("K"+i).getContents().replaceAll(pattern, "");//�ж����к�*
        		String sDeductAccNo = sheet.getCell("L"+i).getContents().replaceAll(pattern, "");//�ſ��˺�*

				//У�鿪ʼ
        		if("��".equals(sBankFlag))
        		{
        			sBankFlag = "2";
        		}
        		else if("��".equals(sBankFlag))
        		{
        			sBankFlag = "1";
        		}
        		else
        		{
        			out.println("document.writeln('��"+(i-2)+"�����ݡ��Ƿ���Ʊ�ݡ��������飡<br/>');");
        			Flag = false;
        		}
        		
        		try
        		{
        			Double.parseDouble(sBillSum);
        		}
        		catch(Exception ex)
        		{
        			out.println("document.writeln('��"+(i-2)+"�����ݡ�Ʊ�ݽ�����<br/>');");
        			Flag = false;
        		}
        		
        		if(!this.dateCheck(sWRITEDATE))
        		{
        			out.println("document.writeln('��"+(i-2)+"�����ݡ�Ʊ��ǩ���ա�δ����YYYY/MM/DD��ʽ��д��<br/>');");
        			Flag = false;
        		}
        		else
        		{
        			sWRITEDATE = this.dateConvert(sWRITEDATE);
        		}
        		
        		if(!this.dateCheck(sMATURITY))
        		{
        			out.println("document.writeln('��"+(i-2)+"�����ݡ�Ʊ�ݵ����ա�δ����YYYY/MM/DD��ʽ��д��<br/>');");
        			Flag = false;
        		}
        		else
        		{
        			sMATURITY = this.dateConvert(sMATURITY);
        		}
        		
        		if(!this.dateCheck(sFinishDate))
        		{
        			out.println("document.writeln('��"+(i-2)+"�����ݡ��������ڡ�δ����YYYY/MM/DD��ʽ��д��<br/>');");
        			Flag = false;
        		}
        		else
        		{
        			sFinishDate = this.dateConvert(sFinishDate);
        		}
        		
        		if(!this.dateCheck(sBeginDate))
        		{
        			out.println("document.writeln('��"+(i-2)+"�����ݡ�Ʊ�ݲ�ѯ�ظ����ڡ�δ����YYYY/MM/DD��ʽ��д��<br/>');");
        			Flag = false;
        		}
        		else
        		{
        			sBeginDate = this.dateConvert(sBeginDate);
        		}
        		

        		if("ͬ��".equals(sACCEPTORREGION))
        		{
        			sACCEPTORREGION = "0";
        		}
        		else if("���".equals(sACCEPTORREGION))
        		{
        			sACCEPTORREGION = "1";
        		}
        		else
        		{
        			out.println("document.writeln('��"+(i-2)+"�����ݡ�Ʊ����Դ���������飡<br/>');");
        			Flag = false;
        		}
        		
        		
        		try
        		{
        			Integer.parseInt(sEndorseTimes);
        		}
        		catch(Exception ex)
        		{
        			out.println("document.writeln('��"+(i-2)+"�����ݡ���������������<br/>');");
        			Flag = false;
        		}
        		
        		try
        		{
        			Double.parseDouble(sRate);
        		}
        		catch(Exception ex)
        		{
        			out.println("document.writeln('��"+(i-2)+"�����ݡ�����������(��)������<br/>');");
        			Flag = false;
        		}
        		
        		if(sMATURITY!=null && sMATURITY.compareTo(sFinishDate) < 0){
					out.println("document.writeln('��"+(i-2)+"�����ݡ�Ʊ�ݵ����ա�����С�ڡ��������ڡ������飡<br/>');");
					Flag = false;
		    	}
		    	
		    	if(sWRITEDATE != null && sWRITEDATE.compareTo(sFinishDate) > 0)
		    	{
		    		out.println("document.writeln('��"+(i-2)+"�����ݡ�Ʊ��ǩ���ա����ܴ��ڡ��������ڡ������飡<br/>');");
					Flag = false;
		    	}
		    	
		    	BizObjectManager manager = com.amarsoft.are.jbo.JBOFactory.getFactory().getManager("jbo.app.BILL_INFO");
		    	int iCount=manager.createQuery("BillNo=:BillNo and FinishDate is not null and FinishDate <> ' ' and ObjectType = :ObjectType and ObjectNo = :ObjectNo").setParameter("BillNo",sBillNo).setParameter("ObjectType",sObjectType).setParameter("ObjectNo",sObjectNo).getTotalCount();
				if(iCount > 0){
					out.println("document.writeln('��"+(i-2)+"�����ݡ�Ʊ�ݺ�:" + sBillNo + "���Ѵ��ڣ����飡<br/>');");
					Flag = false;
				}
				
				System.out.println("===========Flag==================");
				if(Flag)
        		{
        			
        			String sACCEPTORCUSTOMERID = "",sACCEPTORCUSTOMERNAME = "";
        			BillAction ba = new BillAction();
        			System.out.println("=============================");
        			String sReturn  = ba.getCustomerID();
        			System.out.println("=============================");
        			if(!"false".equals(sReturn))
        			{
        				sACCEPTORCUSTOMERID = sReturn.split("@")[0];
        				sACCEPTORCUSTOMERNAME = sReturn.split("@")[1];
        			}
        			
        			BizObjectManager bom = com.amarsoft.are.jbo.JBOFactory.getFactory().getManager("jbo.app.BILL_INFO");
					BizObject boBb = bom.newObject();
					String sSerialNo1 = DBKeyHelp.getSerialNo("BILL_INFO", "SerialNo",Sqlca);
					boBb.setAttributeValue("SerialNo",sSerialNo1);
					boBb.setAttributeValue("ObjectType",sObjectType);
					boBb.setAttributeValue("ObjectNo",sObjectNo);
					boBb.setAttributeValue("IsLocalBill",sBankFlag);//�Ƿ���Ʊ��
					boBb.setAttributeValue("BillNo",sBillNo);//Ʊ�ݺ���
					boBb.setAttributeValue("BillSum",sBillSum);//Ʊ����
					boBb.setAttributeValue("WRITEDATE",sWRITEDATE);//Ʊ��ǩ����
					boBb.setAttributeValue("MATURITY",sMATURITY);//Ʊ�ݵ�����
					boBb.setAttributeValue("FinishDate",sFinishDate);//��������
					boBb.setAttributeValue("BeginDate",sBeginDate);//Ʊ�ݲ�ѯ�ظ�����
					boBb.setAttributeValue("HolderID",sACCEPTORREGION);//Ʊ����Դ��ͬ�ǡ���أ�
					boBb.setAttributeValue("EndorseTimes",sEndorseTimes);//��������
					boBb.setAttributeValue("Rate",sRate);//����������(��)
					//boBb.setAttributeValue("ACCEPTORAREA",sACCEPTORPROVINCEID);//�ж��˿�����������������
					//boBb.setAttributeValue("ACCEPTORCITY",sACCEPTORCITY);//�ж��˿�����������
					//boBb.setAttributeValue("ACCEPTORSAMPLE",sACCEPTORSAMPLE);
					boBb.setAttributeValue("AcceptorID",sACCEPTORID);//�ж����к�
					//boBb.setAttributeValue("Acceptor",sACCEPTORID);//�ж���������
					//boBb.setAttributeValue("ACCEPTORID",sACCEPTORID);//��Ϣ����
					boBb.setAttributeValue("DeductAccNo",sDeductAccNo);//�ſ��ʺ�
					//boBb.setAttributeValue("ACCEPTORCUSTOMERID",sACCEPTORCUSTOMERID);
					boBb.setAttributeValue("InputUserID",CurUser.getUserID());
					boBb.setAttributeValue("InputOrgID",CurUser.getOrgID());
					boBb.setAttributeValue("InputDate",StringFunction.getToday());
					boBb.setAttributeValue("UpdateDate",StringFunction.getToday());
					
					bom.saveObject(boBb);
        		}
        	}
        	
        }
        else if("3".equals(sBillType))//��ҵ���ӳжһ�Ʊ���ֵ���
        {
        	BizObjectManager boam = com.amarsoft.are.jbo.JBOFactory.getFactory().getManager("jbo.app.BUSINESS_APPLY");
        	BizObject boba = boam.createQuery("SerialNo=:SerialNo").setParameter("SerialNo",sObjectNo).getSingleResult();
        	String sProductID = "",sCurrency = "";
        	if(boba ==  null) 
        	{
        		out.println("document.writeln('δȡ����Ӧ������Ϣ��<br/>');");
    			Flag = false;
        	}
        	else
        	{
        		sProductID = boba.getAttribute("BusinessType").getString();
        		sCurrency = boba.getAttribute("BusinessCurrency").getString();
        	}
        	
        	for(int i = 3 ; i <= 2+iRowCount; i ++)
        	{
        		String sBankFlag = "2"; //�Ƿ���Ʊ��*
        		String sBillNo = sheet.getCell("A"+i).getContents().replaceAll(pattern, ""); //Ʊ�ݺ���*
        		String sBillSum = sheet.getCell("B"+i).getContents().replaceAll(pattern, "");//Ʊ����*
        		String sWRITEDATE = sheet.getCell("C"+i).getContents().replaceAll(pattern, "");//Ʊ��ǩ����*
        		String sMATURITY = sheet.getCell("D"+i).getContents().replaceAll(pattern, "");//Ʊ�ݵ�����*
        		String sFinishDate = sheet.getCell("E"+i).getContents().replaceAll(pattern, "");//��������*
        		String sBeginDate = sheet.getCell("F"+i).getContents().replaceAll(pattern, "");//Ʊ�ݲ�ѯ�ظ�����*
        		String sACCEPTORREGION = sheet.getCell("G"+i).getContents().replaceAll(pattern, "");//Ʊ����Դ*
        		String sEndorseTimes = sheet.getCell("H"+i).getContents().replaceAll(pattern, "");//��������*
        		String sRate = sheet.getCell("I"+i).getContents().replaceAll(pattern, "");//����������(��)*
        		String sASSUREDISCOUNTFLAG = sheet.getCell("J"+i).getContents().replaceAll(pattern, "");//�Ƿ��б�����*
        		String sASSUREDISCOUNTNO = sheet.getCell("K"+i).getContents().replaceAll(pattern, ""); //������Э���*
        		String sACCEPTOR = sheet.getCell("L"+i).getContents().replaceAll(pattern, "");//�ж�������*
        		String sACCEPTORID = sheet.getCell("M"+i).getContents().replaceAll(pattern, "");//�ж����к�*
        		String sDeductAccNo = sheet.getCell("N"+i).getContents().replaceAll(pattern, "");//�ſ��˺�*
        		
				//У�鿪ʼ
        		try
        		{
        			Double.parseDouble(sBillSum);
        		}
        		catch(Exception ex)
        		{
        			out.println("document.writeln('��"+(i-2)+"�����ݡ�Ʊ�ݽ�����<br/>');");
        			Flag = false;
        		}
        		
        		if(!this.dateCheck(sWRITEDATE))
        		{
        			out.println("document.writeln('��"+(i-2)+"�����ݡ�Ʊ��ǩ���ա�δ����YYYY/MM/DD��ʽ��д��<br/>');");
        			Flag = false;
        		}
        		else
        		{
        			sWRITEDATE = this.dateConvert(sWRITEDATE);
        		}
        		
        		if(!this.dateCheck(sMATURITY))
        		{
        			out.println("document.writeln('��"+(i-2)+"�����ݡ�Ʊ�ݵ����ա�δ����YYYY/MM/DD��ʽ��д��<br/>');");
        			Flag = false;
        		}
        		else
        		{
        			sMATURITY = this.dateConvert(sMATURITY);
        		}
        		
        		if(!this.dateCheck(sFinishDate))
        		{
        			out.println("document.writeln('��"+(i-2)+"�����ݡ��������ڡ�δ����YYYY/MM/DD��ʽ��д��<br/>');");
        			Flag = false;
        		}
        		else
        		{
        			sFinishDate = this.dateConvert(sFinishDate);
        		}
        		
        		if(!this.dateCheck(sBeginDate))
        		{
        			out.println("document.writeln('��"+(i-2)+"�����ݡ�Ʊ�ݲ�ѯ�ظ����ڡ�δ����YYYY/MM/DD��ʽ��д��<br/>');");
        			Flag = false;
        		}
        		else
        		{
        			sBeginDate = this.dateConvert(sBeginDate);
        		}
        		
        		//System.out.println("Ʊ����Դ��"+sACCEPTORREGION);
        		if("ͬ��".equals(sACCEPTORREGION))
        		{
        			sACCEPTORREGION = "0";
        		}
        		else if("���".equals(sACCEPTORREGION))
        		{
        			sACCEPTORREGION = "1";
        		}
        		else
        		{
        			out.println("document.writeln('��"+(i-2)+"�����ݡ�Ʊ����Դ���������飡<br/>');");
        			Flag = false;
        		}
        		
        		
        		try
        		{
        			Integer.parseInt(sEndorseTimes);
        		}
        		catch(Exception ex)
        		{
        			out.println("document.writeln('��"+(i-2)+"�����ݡ���������������<br/>');");
        			Flag = false;
        		}
        		
        		try
        		{
        			Double.parseDouble(sRate);
        		}
        		catch(Exception ex)
        		{
        			out.println("document.writeln('��"+(i-2)+"�����ݡ�����������(%)������<br/>');");
        			Flag = false;
        		}
        		
        		if(sMATURITY!=null && sMATURITY.compareTo(sFinishDate) < 0){
					out.println("document.writeln('��"+(i-2)+"�����ݡ�Ʊ�ݵ����ա�����С�ڡ��������ڡ������飡<br/>');");
					Flag = false;
		    	}
		    	
		    	if(sWRITEDATE != null && sWRITEDATE.compareTo(sFinishDate) > 0)
		    	{
		    		out.println("document.writeln('��"+(i-2)+"�����ݡ�Ʊ��ǩ���ա����ܴ��ڡ��������ڡ������飡<br/>');");
					Flag = false;
		    	}
		    	
		    	if("��".equals(sASSUREDISCOUNTFLAG))
        		{
		    		sASSUREDISCOUNTFLAG = "1";
        		}
        		else if("��".equals(sASSUREDISCOUNTFLAG))
        		{
        			sASSUREDISCOUNTFLAG = "2";
        		}
        		else
        		{
        			out.println("document.writeln('��"+(i-2)+"�����ݡ��Ƿ��б��������������飡<br/>');");
        			Flag = false;
        		}
		    	
		    	String sACCEPTORCUSTOMERID = "";
		    	if("1".equals(sASSUREDISCOUNTFLAG) && (sASSUREDISCOUNTNO == null || "".equals(sASSUREDISCOUNTNO)))
		    	{
		    		out.println("document.writeln('��"+(i-2)+"�������б�������δ¼�롾������Э��š������飡<br/>');");
        			Flag = false;
		    	}
		    	BizObjectManager manager = com.amarsoft.are.jbo.JBOFactory.getFactory().getManager("jbo.app.BILL_INFO");
		    	int iCount=manager.createQuery("BillNo=:BillNo and FinishDate is not null and FinishDate <> ' ' and ObjectType = :ObjectType and ObjectNo = :ObjectNo").setParameter("BillNo",sBillNo).setParameter("ObjectType",sObjectType).setParameter("ObjectNo",sObjectNo).getTotalCount();
				if(iCount > 0){
					out.println("document.writeln('��"+(i-2)+"�����ݡ�Ʊ�ݺ�:" + sBillNo + "���Ѵ��ڣ����飡<br/>');");
					Flag = false;
				}
				if(Flag)
        		{
        			//String sACCEPTORSAMPLE = sACCEPTORID.substring(0,3);
        			//String sACCEPTORCITY = "test";//sACCEPTORID.substring(3,7);
        			//String sACCEPTORPROVINCEID = Sqlca.getString("select SortNo from CODE_LIBRARY where CodeNo = 'BankCity' and ItemNo = '"+sACCEPTORCITY+"'");
        			
        			BizObjectManager bom = com.amarsoft.are.jbo.JBOFactory.getFactory().getManager("jbo.app.BILL_INFO");
					BizObject boBb = bom.newObject();
					String sSerialNo2 = DBKeyHelp.getSerialNo("BILL_INFO", "SerialNo",Sqlca);

					boBb.setAttributeValue("SerialNo",sSerialNo2);
					boBb.setAttributeValue("ObjectType",sObjectType);
					boBb.setAttributeValue("ObjectNo",sObjectNo);
					boBb.setAttributeValue("IsLocalBill","2");
					boBb.setAttributeValue("BillNo",sBillNo);
					boBb.setAttributeValue("BillSum",sBillSum);
					boBb.setAttributeValue("WRITEDATE",sWRITEDATE);
					boBb.setAttributeValue("MATURITY",sMATURITY);
					boBb.setAttributeValue("FinishDate",sFinishDate);
					boBb.setAttributeValue("BeginDate",sBeginDate);
					boBb.setAttributeValue("HolderID",sACCEPTORREGION);
					boBb.setAttributeValue("EndorseTimes",sEndorseTimes);
					boBb.setAttributeValue("Rate",sRate);
					//boBb.setAttributeValue("ACCEPTORPROVINCEID",sACCEPTORPROVINCEID);
					//boBb.setAttributeValue("ACCEPTORCITY",sACCEPTORCITY);
					//boBb.setAttributeValue("ACCEPTORSAMPLE",sACCEPTORSAMPLE);
					boBb.setAttributeValue("Acceptor",sACCEPTOR);
					boBb.setAttributeValue("ACCEPTORID",sACCEPTORID);
					boBb.setAttributeValue("DeductAccNo",sDeductAccNo);
					//boBb.setAttributeValue("ACCEPTORCUSTOMERID",sACCEPTORCUSTOMERID);
					boBb.setAttributeValue("ISSAFEGUARD",sASSUREDISCOUNTFLAG);
					boBb.setAttributeValue("SAFEGUARDPROTOCOL",sASSUREDISCOUNTNO);
					boBb.setAttributeValue("InputUserID",CurUser.getUserID());
					boBb.setAttributeValue("InputOrgID",CurUser.getOrgID());
					boBb.setAttributeValue("InputDate",StringFunction.getToday());
					boBb.setAttributeValue("UpdateDate",StringFunction.getToday());
					bom.saveObject(boBb);
        		}
        	}
        }
        
        
        //������ݴ���
        if(Flag)
        {
        	tx.commit();
        	
        	BillSingleCopy BA = new BillSingleCopy();
        	BA.setObjectNo(sObjectNo);
        	BA.setObjectType(sObjectType);
        	if("1".equals(sBillType))
        	{
        		BA.UpdateBusinessSum1();
        	}
        	else
        	{
        	String result=	BA.UpdateBusinessSum();
        	}
        }
        else
        {
        	tx.rollback();
        }
        
        out.println("document.writeln('�ļ��������!<br/>');");
    }catch(Exception e){
    	out.println("document.writeln('�ļ�����������ȷ�ϰ���ģ����д!<br/>');");
    	ARE.getLog().error("�ϴ��������ļ���������",e);
    	Flag = false;
    }finally{
    	if(inputStream!=null){
            inputStream.close();
            inputStream = null;
    	}
    	if(file!=null){
    		if(file.exists()&&file.isFile()){
    			boolean deleteSucess = file.delete();//��ɺ�ɾ���ļ�
    			if(!deleteSucess){
    				ARE.getLog().debug("ɾ���ļ�["+file.getAbsolutePath()+"]ʧ�ܣ����ļ��Ѳ���ʹ�ã��붨�����");
    			}else{
    				ARE.getLog().trace("ɾ���ļ�["+file.getAbsolutePath()+"]�ɹ�");
    			}
    		}
    	}
    	if(Flag)
    	{
    		out.println("top.returnValue='�����ļ��ɹ���';");
       	 	out.println("top.close();");//�ϴ��ļ��ɹ���
    	}
    	else
    	{
    		out.println("top.returnValue='�����ļ�ʧ�ܣ�';");
    	}
    }
%>
</script>
<%@ include file="/Frame/resources/include/include_end.jspf" %>