package com.amarsoft.app.datax.bcr.message;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.util.xml.Attribute;
import com.amarsoft.are.util.xml.Element;
import java.util.*;

public class Message
{

	private String version;
	private String readerVersion;
	private int headerLength;
	private String charset;
	private int type;
	private String chineseName;
	private String id;
	private String name;
	protected Record record;
	protected Record header;
	protected Record footer;
	private int recordCount;
	protected Record recordTemplet[];

	public String getCharset()
	{
		return charset;
	}

	public void setCharset(String charset)
	{
		this.charset = charset;
	}

	public Record getFooter()
	{
		if (footer == null)
		{
			Record rec = null;
			for (int i = 0; i < recordTemplet.length; i++)
			{
				if (!recordTemplet[i].getId().equalsIgnoreCase("tail"))
					continue;
				rec = recordTemplet[i];
				break;
			}

			try
			{
				footer = (Record)rec.clone();
				footer.segmentMap.clear();
			}
			catch (CloneNotSupportedException e)
			{
				ARE.getLog().debug(e);
				footer = null;
			}
		}
		return footer;
	}

	public Record getHeader()
	{
		if (header == null)
		{
			Record rec = null;
			for (int i = 0; i < recordTemplet.length; i++)
			{
				if (!recordTemplet[i].getId().equalsIgnoreCase("header"))
					continue;
				rec = recordTemplet[i];
				break;
			}

			try
			{
				header = (Record)rec.clone();
				header.segmentMap.clear();
			}
			catch (CloneNotSupportedException e)
			{
				ARE.getLog().debug(e);
				header = null;
			}
		}
		return header;
	}

	public Record[] getDataRecordArray()
	{
		Vector dataRecords = new Vector();
		Record rec = null;
		for (int i = 0; i < recordTemplet.length; i++)
		{
			rec = recordTemplet[i];
			if (!rec.getId().equalsIgnoreCase("header") && !rec.getId().equalsIgnoreCase("tail"))
				dataRecords.add(rec);
		}

		Record retArr[] = new Record[dataRecords.size()];
		System.arraycopy(((Object) (dataRecords.toArray())), 0, retArr, 0, dataRecords.size());
		return retArr;
	}

	public Record getRecord(int recordType)
	{
		Record rec[] = getDataRecordArray();
		for (int i = 0; i < rec.length; i++)
			if (rec[i].getType() == recordType)
				return rec[i];

		return null;
	}

	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getReaderVersion()
	{
		return readerVersion;
	}

	public void setReaderVersion(String readerVersion)
	{
		this.readerVersion = readerVersion;
	}

	public int getType()
	{
		return type;
	}

	public void setType(int type)
	{
		this.type = type;
	}

	public String getVersion()
	{
		return version;
	}

	public void setVersion(String version)
	{
		this.version = version;
	}

	private Message()
	{
		version = "1.2";
		readerVersion = "1.2";
		charset = "GB18030";
	}

	protected static Message buildMessage(Element xMessage)
		throws BCRException
	{
		Attribute attribute = null;
		Message message = new Message();
		message.setVersion(xMessage.getAttributeValue("version"));
		attribute = xMessage.getAttribute("chineseName");
		if (attribute == null)
			message.chineseName = "";
		else
			message.chineseName = attribute.getValue();
		attribute = xMessage.getAttribute("type");
		if (attribute == null)
			throw new BCRException((new StringBuilder("No type   definition or error in message's attributes  @message type:")).append(message.getType()).toString());
		try
		{
			message.type = Integer.parseInt(attribute.getValue());
		}
		catch (NumberFormatException e)
		{
			ARE.getLog().debug(e);
			throw new BCRException((new StringBuilder("No type   definition or error in message's attributes  @message type:")).append(message.getType()).toString(), e);
		}
		attribute = xMessage.getAttribute("name");
		if (attribute == null)
			throw new BCRException((new StringBuilder("No name   definition  or error in message's attributes  @message type:")).append(message.getType()).toString());
		message.name = attribute.getValue();
		attribute = xMessage.getAttribute("headerLength");
		if (attribute == null)
			throw new BCRException((new StringBuilder("No headerLength   definition  or errorin message's attributes  @message type:")).append(message.getType()).toString());
		try
		{
			message.headerLength = Integer.parseInt(attribute.getValue());
		}
		catch (NumberFormatException e)
		{
			throw new BCRException((new StringBuilder("No headerLength   definition  or errorin message's attributes  @message type:")).append(message.getType()).toString());
		}
		attribute = xMessage.getAttribute("charset");
		if (attribute == null)
			message.charset = "1.1";
		else
			message.charset = attribute.getValue();
		attribute = xMessage.getAttribute("id");
		if (attribute == null)
			throw new BCRException((new StringBuilder("No id   definition  or error in message's attributes  @message type:")).append(message.getType()).toString());
		message.id = attribute.getValue();
		List recordList = xMessage.getChildren("record");
		message.recordTemplet = new Record[recordList.size()];
		try
		{
			for (int i = 0; i < recordList.size(); i++)
				message.recordTemplet[i] = Record.buildRecord((Element)recordList.get(i));

		}
		catch (BCRException exception)
		{
			throw new BCRException((new StringBuilder()).append(exception.getMessage()).append(" @message type:").append(message.getType()).toString());
		}
		return message;
	}

	public String getChineseName()
	{
		return chineseName;
	}

	public int getHeaderLength()
	{
		return headerLength;
	}

	public int getRecordCount()
	{
		return recordCount;
	}

	void setRecordCount(int recordCount)
	{
		this.recordCount = recordCount;
	}
}
