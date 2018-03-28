<%@page import="com.amarsoft.awe.control.model.Parameter"%>
<%@page import="com.amarsoft.app.als.dataimport.xlsimport.ExcelImportManager"%>
<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin.jspf" %>
<%@page import="com.amarsoft.awe.common.attachment.AmarsoftUpload"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.amarsoft.are.jbo.*"%>

<%
    File file = null;
    FileInputStream inputStream = null;
    String sMessage="";
    String sHtml=""; 
    String sPathTemp="";
    try{
        AmarsoftUpload myAmarsoftUpload = new AmarsoftUpload();
        myAmarsoftUpload.initialize(pageContext);
        myAmarsoftUpload.upload();
        Vector<Parameter> vlst=CurPage.parameterList;
		String sParmameName="",sParmameValue="";
        Enumeration  em=   myAmarsoftUpload.getRequest().getParameterNames();
        while(em.hasMoreElements())
        {
        	sParmameName=(String)em.nextElement(); 
        	sParmameValue= (String)myAmarsoftUpload.getRequest().getParameter(sParmameName);
        	 
        	Parameter p=new Parameter();
        	p.setName(sParmameName); 
        	p.setValue(sParmameValue);
        	vlst.add(p);
        	CurPage.setAttribute(sParmameName,sParmameValue);
        }
        String sObjectNo = (String)myAmarsoftUpload.getRequest().getParameter("ObjectNo");
    	String sObjectType = (String)myAmarsoftUpload.getRequest().getParameter("ObjectType");
    	String specialCustomerType = (String)myAmarsoftUpload.getRequest().getParameter("SpecialCustomerType");
    	
    	CurPage.setAttribute("ObjectNo",sObjectNo);
    	CurPage.setAttribute("ObjectType",sObjectType);
    	CurPage.setAttribute("SpecialCustomerType",specialCustomerType);
    	
        String clazz = (String)myAmarsoftUpload.getRequest().getParameter("clazz");
        if(clazz==null||"".equals(clazz))throw new Exception("����clazz��ʧ�������Ƿ���˲���");

        BizObjectManager manager0 = JBOFactory.getFactory().getManager(clazz);
        ExcelImportManager manager = (ExcelImportManager)manager0;
        
        String filePathName = myAmarsoftUpload.getFiles().getFile(0).getFilePathName();
        String fileName = myAmarsoftUpload.getFiles().getFile(0).getFileName();
        CurPage.setAttribute("FileName",fileName);
        
        String sFileSavePath = CurConfig.getConfigure("FileSavePath");
        if(sFileSavePath==null)throw new Exception("����als7.xml�������ļ����·��FileSavePath");
        
        //�������Ŀ¼
        String excelSaveDirectory = sFileSavePath+"/excelimport";
        File saveDic = new File(excelSaveDirectory);//���û�и�Ŀ¼���򴴽�
        sPathTemp=saveDic.getAbsolutePath();
        if(!saveDic.exists())saveDic.mkdirs();
        //���ļ�
       // out.println("document.writeln('�ļ��ϴ���...<br/>');");
        out.flush();
        String sFileFullPath = excelSaveDirectory+"/"+System.currentTimeMillis()+fileName;
        myAmarsoftUpload.getFiles().getFile(0).saveAs(sFileFullPath);
        file = new File(sFileFullPath);
        
        //�����ļ�
        //out.println("document.writeln('�ļ��ϴ���ɣ����ڽ���...<br/>');");
        out.flush();
        inputStream = new FileInputStream(file);
        manager.setCurPage(CurPage);
        manager.setCurUser(CurUser);
        manager.setInputStream(inputStream);
        manager.setSheetIndex(0);
        manager.executeImport();
       // out.println("document.writeln('�ļ��������!<br/>');");
        //out.println("alert(getMessageText('AWEW1013'));");//�ϴ��ļ��ɹ���
      //  out.println("top.returnValue=true;");
        sMessage=manager.getLog();
    }catch(Exception e){
    	ARE.getLog().error("�ϴ��������ļ���������",e);
        //out.println("top.returnValue=false;");
        sMessage="�����ļ���ʽ����ȷ:"+e.getMessage()+"<br>"+sPathTemp; 
        //out.println("alert(getMessageText('AWEW1010'));");//�ϴ��ļ�ʧ�ܣ�
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
       // out.println("top.close();");//�ϴ��ļ��ɹ���
    }
    String[][] sButtons = {
            {"true","All","Button","����","","top.close()","","","",""}, 
    };
%>
<table align="left">
   
  <tr>
    <td><%=sMessage %></td> 
  </tr>
  <tr>
    <td><%@ include file="/Frame/resources/include/ui/include_buttonset.jspf" %></td> 
  </tr>
  
</table>

<script type="text/javascript">
	if(!parent.hideMessage) parent.hideMessage();
</script>
<%@ include file="/Frame/resources/include/include_end.jspf" %>