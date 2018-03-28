package com.amarsoft.app.datax.bcr.bizcollect.mbr;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.message.*;
import com.amarsoft.are.log.Log;
import java.sql.*;

import com.amarsoft.app.datax.bcr.message.Message;

public class MBRGuaranteeChange extends DBMessageBodyReader{
	private String recordSql;
	private String GuaranteeChangeSql;
	private ResultSet rsRecord;
	
	public MBRGuaranteeChange(Message message) 
	{
		super(message);
		GuaranteeChangeSql = null;
		rsRecord = null;
	}
	
	protected boolean fillRecord(Record r) throws BCRException{
		if (recordSql == null)
			return false;
		if (rsRecord == null)
			try{
				rsRecord = executeQuery(recordSql);
			}catch (SQLException e){
				logger.debug(e);
				throw new BCRException(e);
			}
		try{
			if (!rsRecord.next()){
				return false;
			}else{				
				String GBusinessNo = rsRecord.getString("GBusinessNo");
				Segment segC = r.createSegment("C");
				segC.getField(2001).setString(rsRecord.getString("FinanceCode"));
				segC.getField(2002).setString(GBusinessNo);
				segC.getField(2003).setString(rsRecord.getString("NEWGBusinessNo"));
				segC.getField(2004).setDate(rsRecord.getString("UpdateDate"));
				segC.getField(9993).setDate(rsRecord.getString("UpdateDate"));
			}
		}catch (SQLException e){
			logger.debug(e);
			throw new BCRException(e);
		}
		return true;
	}

	public final String getRecordSql()
	{
		return recordSql;
	}

	public final void setRecordSql(String recordSql){
		this.recordSql = recordSql;
		if (recordSql == null)
		{
			GuaranteeChangeSql = null;
			return;
		}
		String GuaranteeChangeTable = "BCR_GUARANTEECHANGE";		
		GuaranteeChangeSql = (new StringBuilder("select * from ")).append(GuaranteeChangeTable).append(" where RecordFlag='40' and GBusinessNo=?").toString();
	}

}
