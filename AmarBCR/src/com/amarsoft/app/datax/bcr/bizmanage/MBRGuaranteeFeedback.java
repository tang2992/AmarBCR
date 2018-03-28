package com.amarsoft.app.datax.bcr.bizmanage;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.message.*;
import java.io.BufferedReader;

public class MBRGuaranteeFeedback extends TextMessageBodyReader
{

	public MBRGuaranteeFeedback(Message message, BufferedReader reader)
	{
		super(message, reader);
	}

	public MBRGuaranteeFeedback(Message message)
	{
		super(message);
	}

	protected void fillRecord(byte data[], Record record)
		throws BCRException
	{
		String messageFile = message.getHeader().getFirstSegment("A").getField(2305).getString();
		int messageType = 0;
		int RecordType=0;
		Segment seg = record.createSegment("B");
		if (messageFile.substring(22, 24).equals("15")){
			messageType=15;
			RecordType=811;
		}else if(messageFile.substring(22, 24).equals("16")){
			messageType=16;
			RecordType=821;
		}else if(messageFile.substring(22, 24).equals("17")){
			messageType=17;
			RecordType=831;
		}		
		String backRecord = new String(data);
		int backRecordLength = backRecord.getBytes().length;
		String ErrorFinanceCode = backRecord.substring(0, 11);
		String UpdateDate = backRecord.substring(14, 22);
		String errorRecord = "";
		int errorRownum = 0;
		errorRownum = Integer.parseInt(backRecord.substring(22, 32));
		String errorMsg = "";
		
		if(messageType==15){
			int idx = backRecord.indexOf("B");
			errorRecord = backRecord.substring(idx-6);
			errorMsg = backRecord.substring(36, idx-6);
		}else if(messageType==16){
			int idx = backRecord.indexOf("C");
			errorRecord = backRecord.substring(idx-6);
			errorMsg = backRecord.substring(36, idx-6);
		}else if(messageType==17){
			int idx = backRecord.indexOf("S");
			errorRecord = backRecord.substring(idx-6);
			errorMsg = backRecord.substring(36, idx-6);
		}
		
		seg.getField(2401).setString(ErrorFinanceCode);
		seg.getField(2402).setDate(UpdateDate);
		seg.getField(2403).setInt(errorRownum);
		seg.getField(2404).setInt(backRecordLength);
		seg.getField(2405).setString(errorMsg);
		seg.getField(2406).setString(errorRecord);
		seg.getField(2409).setInt(RecordType);
	}
}
