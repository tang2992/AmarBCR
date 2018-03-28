package com.amarsoft.app.datax.bcr.bizcollect;

import com.amarsoft.app.datax.bcr.BCRException;

import com.amarsoft.app.datax.bcr.bizcollect.mbr.MBRGuaranteeBaseinfo;
import com.amarsoft.app.datax.bcr.bizmanage.MBRGuaranteeChange;
import com.amarsoft.app.datax.bcr.bizmanage.MBRGuaranteeDelete;
import com.amarsoft.app.datax.bcr.message.*;

public class SimpleHISProvider extends AbstractProvider
{

	private String dataFilter;

	public SimpleHISProvider()
	{
		dataFilter = null;
	}

	public SimpleHISProvider(String filter)
	{
		dataFilter = null;
		dataFilter = filter;
	}

	public MessageBodyReader getMessageBodyReader(Message message)
		throws BCRException
	{
		String where = dataFilter != null ? (new StringBuilder("where ")).append(dataFilter).toString() : "";
		int type = message.getType();
		switch (type)
		{
		case 81: 
		{
			MBRGuaranteeBaseinfo mbr = new MBRGuaranteeBaseinfo(message);
			mbr.setRecordSql((new StringBuilder("select * from HIS_GUARANTEEINFO ")).append(where).toString());
			return mbr;
		}
			
			
        case 82:
        {
        	MBRGuaranteeChange mbrc = new MBRGuaranteeChange(message);
			mbrc.setRecordSql((new StringBuilder("select * from BCR_GUARANTEECHANGE ")).append(where).append(" and (RecordFlag='").append("40").append("')").toString());
			return mbrc;
        }
			
			
        case 83: 
        {
        	MBRGuaranteeDelete mbrs = new MBRGuaranteeDelete(message);
        	mbrs.setRecordSql((new StringBuilder("select * from BCR_GUARANTEEDELETE ")).append(where).append(" and (RecordFlag='").append("40").append("')").toString());
			return mbrs;
        }

		}
		return new DummyMessageBodyReader(message);
	}

	public final String getDataFilter()
	{
		return dataFilter;
	}

	public final void setDataFilter(String dataFilter)
	{
		this.dataFilter = dataFilter;
	}
}
