package com.amarsoft.app.datax.bcr.bizmanage;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.message.DBMessageBodyReader;
import com.amarsoft.app.datax.bcr.message.Message;
import com.amarsoft.app.datax.bcr.message.Record;
import com.amarsoft.app.datax.bcr.message.Segment;
import com.amarsoft.are.ARE;
import com.amarsoft.are.util.DataConvert;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MBRGuaranteeDelete extends DBMessageBodyReader{
	
	  private String recordSql = null;
	  private ResultSet rsRecord = null;
	  private int iCount = 0;

	  public String getRecordSql()
	  {
	    return this.recordSql;
	  }

	  public void setRecordSql(String recordSql) {
	    this.recordSql = recordSql;
	  }

	  public MBRGuaranteeDelete(Message message) {
	    super(message);
	  }

	  protected boolean fillRecord(Record r) throws BCRException {
	    if (this.recordSql == null) return false;
	    if (this.rsRecord == null)
	      try {
	        this.rsRecord = executeQuery(this.recordSql);
	      } catch (SQLException e) {
	        this.logger.debug(e);
	        throw new BCRException(e);
	      }
	    try {
	      if (!(this.rsRecord.next())){
	    	  return false;
	      }{
	    	  this.iCount += 1;
		      Segment segS = r.createSegment("S");
		      	segS.getField(2001).setString(rsRecord.getString("FinanceCode"));
				segS.getField(2002).setString(rsRecord.getString("GBusinessNo"));
				segS.getField(2003).setString(rsRecord.getString("DeleteType"));
				segS.getField(2004).setDate(rsRecord.getString("UpdateDate"));
				segS.getField(9993).setDate(rsRecord.getString("UpdateDate"));
		      return (this.iCount < DataConvert.toInt(ARE.getProperty("deleteNumber")));
	      }	      
	    }
	    catch (SQLException e)
	    {
	      this.logger.debug(e);
	      throw new BCRException(e);
	    }
	  }

}
