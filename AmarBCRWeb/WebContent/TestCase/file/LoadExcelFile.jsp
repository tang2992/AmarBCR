<%@page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%@ 
 page import="com.amarsoft.awe.common.attachment.*,java.io.File" %><%@
 page import="org.apache.poi.poifs.filesystem.*,org.apache.poi.hssf.usermodel.*" %><%
	/*
  		Content: ��ѡ���Excel�ļ����뵽���ݿ����
	*/
	//�������
	String sValueStr = ""; 
			
	AmarsoftUpload myAmarsoftUpload = new AmarsoftUpload();
	myAmarsoftUpload.initialize(pageContext);
	myAmarsoftUpload.upload(); 		
	String sFileName = (String)myAmarsoftUpload.getRequest().getParameter("FileName");
			
   	try{
		System.out.println("------FileName------"+sFileName);
		//��������ļ��Ƿ���� 
		File checkFile = new File(sFileName); 
		if(sFileName.indexOf(".xls")<0){
%>
		<script type="text/javascript">
		    alert("��ǰ��ѡ���ļ�����Excel�ļ���������ѡ��");
		    self.close();
		</script>
<%
		}else{
			if(checkFile.exists()){
				//�趨FileINputStream��ȡExcel�� 
				FileInputStream finput = new FileInputStream(sFileName);
				POIFSFileSystem fs = new POIFSFileSystem(finput);
				HSSFWorkbook wb = new HSSFWorkbook(fs);
				HSSFSheet sheet = wb.getSheetAt(0);
				//��ȡ��һ��������������Ϊsheet 
				finput.close();
				HSSFRow row = null;
				//����һ�� 
				HSSFCell cell = null;
				//����һ������� 
				short i = 0;
				short j = 0;
				int iCount = 0;

				for (i = 0;i <= sheet.getLastRowNum();i++){
					//�ڵ�����һ������ǰ���ʼ���ñ���
					sValueStr = "";
					row = sheet.getRow(i);
					for (j = 0;j < row.getLastCellNum();j++){
						cell = row.getCell(j);
						//�жϴ����ĸ�ʽ 
						switch ( cell.getCellType() ){
							case HSSFCell.CELL_TYPE_NUMERIC:
								sValueStr += cell.getNumericCellValue() + ",";								
								break;
							case HSSFCell.CELL_TYPE_STRING:
								sValueStr += "'" + cell.getStringCellValue() +"',";
								break;
							case HSSFCell.CELL_TYPE_FORMULA: 
								//������ʽ����������ֵ
								//��Ҫ������ʽ���ݣ�����cell.getCellFormula()
								sValueStr += cell.getNumericCellValue() + ",";						 
								break;
							default:
								sValueStr += "'�����ĸ�ʽ'" + ",";
								break;
						}							
					}
					
					//��õ����ܼ�¼��
					iCount = i + 1; 
					
					if(sValueStr.length() > 0)
						sValueStr = sValueStr.substring(0,sValueStr.length()-1);
					Sqlca.executeSQL("insert into TEST_FILE values("+sValueStr+")"); 
					System.out.println("���������ݿ�"+iCount+"����¼"); 
				}
				//�ͷ���Դ
				finput.close();
				fs = null;
				wb = null;
				sheet = null;
				row = null;
				cell = null;
			}
		}
		myAmarsoftUpload = null;
	}catch(Exception e){
      	out.println("An error occurs : " + e.toString());
		//�ͷ���Դ
      	myAmarsoftUpload = null;
   	}
%>
<script type="text/javascript">
    alert("�ϴ��ɹ���");
    self.close();
</script>
<%@ include file="/IncludeEnd.jsp"%>