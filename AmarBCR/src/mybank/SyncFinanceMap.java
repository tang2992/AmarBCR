/***********************************************************************
 * Module:  SyncGuarantyDate.java
 * Author:  tzhai
 * Modified: 
 * Purpose: 
 ***********************************************************************/

package mybank;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.task.ExecuteUnit;
import com.amarsoft.task.TaskConstants;

/*
 *    ͬ��orginfo�Ľ��ڻ���
 */
public class SyncFinanceMap extends ExecuteUnit
{
	protected Log logger;
	protected Connection connection=null;
	protected Statement stmt=null;
	
	private PreparedStatement pstmtSelectorg = null;
	private PreparedStatement pstmtInsert = null;
	   
   /*
    * ��ʼ��
    */
   protected void init() throws ECRException
   {
		logger = ARE.getLog();
		//--------------------------------------------------���ݿ����ӳ�ʼ��
		String database = "ecr";//getProperty(PROPERTY_DATABASE);
		try {
			connection = ARE.getDBConnection(database);
			stmt = connection.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_UPDATABLE);
		} catch (SQLException e) {
			throw new ECRException(e);
		}
   }
   
   
   
   public int execute()
   {
		//��ʼ�������ݿ����Ӻ������ļ�����
		try {
			init();
		} catch (ECRException e) {
			logger.fatal("��ʼ��ʧ��",e);
			clearResource();
			return TaskConstants.ES_FAILED;
		}
		try {
			logger.info("��ʼ���»�����Ϣ...");
			syncfinace(); //������ͬ
		} catch (SQLException e) {
			logger.fatal("���»���ʧ�ܣ�",e);
			clearResource();
			return TaskConstants.ES_FAILED;
		}
		
		clearResource();
		return TaskConstants.ES_SUCCESSFUL;
   }
   
   private void syncfinace() throws SQLException{
	   String sqlQueryorg = "select * from org_info where (bankid<>'' and bankid is not null) " +
	   		"and bankid not in(select pbcode from ecr_codemap where colname='6501')";
	    String sqlInsert = "insert into ecr_codemap(colname,ctcode,pbcode,note) values(?,?,?,?)";
	   String ls_orgid="";
	   String ls_bankid="";
	   String ls_colname="6501";
	   String ls_orgname="";
	   logger.debug(sqlQueryorg);
	   logger.debug(sqlInsert);
	   pstmtSelectorg = connection.prepareStatement(sqlQueryorg);
	    pstmtInsert = connection.prepareStatement(sqlInsert);
	   ResultSet rs = stmt.executeQuery(sqlQueryorg);
	   while(rs.next()){
		   ls_orgid = rs.getString("orgid");
		   ls_bankid = rs.getString("bankid");
		   ls_orgname = rs.getString("orgname");;
		   pstmtInsert.setString(1,ls_colname);
		   pstmtInsert.setString(2,ls_orgid);
		   pstmtInsert.setString(3,ls_bankid);
		   pstmtInsert.setString(4,ls_orgname);
		   pstmtInsert.executeUpdate();
	   }
	   rs.close();
	   pstmtInsert.close();
	   pstmtInsert = null;
   }

	/**
	 * ������ͷ����й����д򿪵���Դ�����ݿ����ӡ��ļ����ӵ�
	 *
	 */
	private void clearResource(){
		if(stmt!=null){
			try {
				stmt.close();
			} catch (SQLException e) {
				logger.debug(e);
			}
			stmt = null;
		}
		
		if(pstmtInsert!=null){
			try {
				pstmtInsert.close();
			} catch (SQLException e) {
				logger.debug(e);
			}
			pstmtInsert = null;
		}
		if(pstmtSelectorg!=null){
			try {
				pstmtSelectorg.close();
			} catch (SQLException e) {
				logger.debug(e);
			}
			pstmtSelectorg = null;
		}
		
		
		if(connection!=null){
			try {
				connection.close();
			} catch (SQLException e) {
				logger.debug(e);
			}
			connection = null;
		}
	}
}