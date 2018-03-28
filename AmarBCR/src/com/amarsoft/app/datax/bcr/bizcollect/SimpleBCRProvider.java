package com.amarsoft.app.datax.bcr.bizcollect;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.bizcollect.mbr.MBRGuaranteeBaseinfo;
import com.amarsoft.app.datax.bcr.bizcollect.mbr.MBRGuaranteeChange;
import com.amarsoft.app.datax.bcr.bizcollect.mbr.MBRGuaranteeDelete;
import com.amarsoft.app.datax.bcr.message.*;


public class SimpleBCRProvider extends AbstractProvider
{

    public SimpleBCRProvider()
    {
        dataFilter = null;
    }

    public SimpleBCRProvider(String s)
    {
        dataFilter = null;
        dataFilter = s;
    }

    public MessageBodyReader getMessageBodyReader(Message message)
        throws BCRException
    {
        String s = dataFilter != null ? (new StringBuilder()).append("where ").append(dataFilter).toString() : "";
        int i = message.getType();
        switch(i)
        {            
        case 81: 
			MBRGuaranteeBaseinfo mbr = new MBRGuaranteeBaseinfo(message);
			mbr.setRecordSql((new StringBuilder("select * from BCR_GUARANTEEINFO ")).append(s).toString());
			return mbr;
			
        case 82: // '\007'
			MBRGuaranteeChange mbrc = new MBRGuaranteeChange(message);
			mbrc.setRecordSql((new StringBuilder("select * from BCR_GUARANTEECHANGE ")).append(s).append(" and (RecordFlag='").append("40").append("')").toString());
			return mbrc;
			
        case 83: // '\007'
			MBRGuaranteeDelete mbrd = new MBRGuaranteeDelete(message);
			mbrd.setRecordSql((new StringBuilder("select * from BCR_GUARANTEEDELETE ")).append(s).append(" and (RecordFlag='").append("40").append("')").toString());
			return mbrd;
			
        case 5: // '\005'
        case 6: // '\006'
        case 9: // '\t'
        case 10: // '\n'
        case 22: // '\026'
        case 23: // '\027'
        case 24: // '\030'
        case 25: // '\031'
        case 26: // '\032'
        case 27: // '\033'
        case 28: // '\034'
        case 29: // '\035'
        case 30: // '\036'
        case 31: // '\037'
        case 32: // ' '
        case 33: // '!'
        case 34: // '"'
        case 35: // '#'
        case 36: // '$'
        case 37: // '%'
        case 38: // '&'
        case 39: // '\''
        case 40: // '('
        case 41: // ')'
        case 42: // '*'
        case 43: // '+'
        case 44: // ','
        case 45: // '-'
        case 46: // '.'
        case 47: // '/'
        case 48: // '0'
        case 49: // '1'
        case 50: // '2'
        case 51: // '3'
        case 52: // '4'
        case 53: // '5'
        case 54: // '6'
        case 55: // '7'
        case 56: // '8'
        case 57: // '9'
        case 58: // ':'
        case 59: // ';'
        case 60: // '<'
        default:
            return new DummyMessageBodyReader(message);
        }
    }

    public final String getDataFilter()
    {
        return dataFilter;
    }

    public final void setDataFilter(String s)
    {
        dataFilter = s;
    }

    private String dataFilter;
}