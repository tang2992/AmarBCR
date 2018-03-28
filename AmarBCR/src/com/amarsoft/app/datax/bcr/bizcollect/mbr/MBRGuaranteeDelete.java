package com.amarsoft.app.datax.bcr.bizcollect.mbr;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.message.*;
import java.sql.*;

import com.amarsoft.app.datax.bcr.message.Message;

public class MBRGuaranteeDelete extends DBMessageBodyReader{
	private String recordSql;
	private String GuaranteeDeleteSql;
	private ResultSet rsRecord;
	
	public MBRGuaranteeDelete(Message message) 
	{
		super(message);
		GuaranteeDeleteSql = null;
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
				Segment segS = r.createSegment("S");
				segS.getField(2001).setString(rsRecord.getString("FinanceCode"));
				segS.getField(2002).setString(GBusinessNo);
				segS.getField(2003).setString(rsRecord.getString("DeleteTypes"));
				segS.getField(2004).setDate(rsRecord.getString("UpdateDate"));
				segS.getField(9993).setDate(this.rsRecord.getString("UpdateDate"));
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
			GuaranteeDeleteSql = null;
			return;
		}
		String GuaranteeDeleteTable = "BCR_GUARANTEEDELETE";		
		GuaranteeDeleteSql = (new StringBuilder("select * from ")).append(GuaranteeDeleteTable).append(" where RecordFlag='40' and GBusinessNo=?").toString();
	}

}

