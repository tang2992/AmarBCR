// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   MessageSet.java

package com.amarsoft.app.datax.ecr.message;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.util.xml.*;
import java.util.List;

// Referenced classes of package com.amarsoft.app.datax.ecr.message:
//			Message, DataProvider, Handler, MessageBodyReader, 
//			Record, Segment, Field

public class MessageSet
{

	private Handler handler;
	private Message currentMessage;
	private Record currentHeader;
	private Record currentFooter;
	private MessageBodyReader currentBodyReader;
	private Record currentRecord;
	private String fileName;
	private String type;
	private String name;
	private String dataType;
	private String direction;
	private String chineseName;
	private String description;
	private Message messages[];
	Log logger;

	private MessageSet(int messageCount)
	{
		currentHeader = null;
		currentFooter = null;
		currentBodyReader = null;
		currentRecord = null;
		logger = ARE.getLog();
		messages = new Message[messageCount];
	}

	public static MessageSet createMessageSetFromXml(String defineFile)
		throws ECRException
	{
		Document doc = null;
		Attribute attribute = null;
		try
		{
			doc = new Document(defineFile);
		}
		catch (Exception e)
		{
			throw new ECRException("Build Document error", e);
		}
		Element xRoot = doc.getRootElement();
		Element xMessageList = xRoot.getChild("messageList");
		if (xMessageList == null)
			throw new ECRException((new StringBuilder("No message list define--")).append(defineFile).toString());
		List l = xMessageList.getChildren("message");
		if (l.size() == 0)
			throw new ECRException((new StringBuilder("No message  definition or error in messageList's attributes ")).append(defineFile).toString());
		MessageSet messageSet = new MessageSet(l.size());
		attribute = xMessageList.getAttribute("type");
		if (attribute == null)
			throw new ECRException((new StringBuilder("No TYPE  definition or error in messageList's attributes ")).append(defineFile).toString());
		messageSet.type = attribute.getValue();
		attribute = xMessageList.getAttribute("name");
		if (attribute == null)
			throw new ECRException((new StringBuilder("No NAME  definition or error in messageList's attributes ")).append(defineFile).toString());
		messageSet.name = attribute.getValue();
		attribute = xMessageList.getAttribute("direction");
		if (attribute == null)
			throw new ECRException((new StringBuilder("No direction   definition  or error in messageList's attributes ")).append(defineFile).toString());
		messageSet.direction = attribute.getValue();
		attribute = xMessageList.getAttribute("chineseName");
		if (attribute == null)
			messageSet.chineseName = "";
		else
			messageSet.chineseName = attribute.getValue();
		attribute = xMessageList.getAttribute("description");
		if (attribute == null)
			messageSet.description = "";
		else
			messageSet.description = attribute.getValue();
		try
		{
			for (int i = 0; i < l.size(); i++)
			{
				Element xMessage = (Element)l.get(i);
				messageSet.messages[i] = Message.buildMessage(xMessage);
			}

		}
		catch (ECRException exception)
		{
			throw new ECRException((new StringBuilder()).append(exception.getMessage()).append(" @messageSet name:").append(messageSet.getName()).toString());
		}
		return messageSet;
	}

	public void setHandler(Handler handler)
	{
		this.handler = handler;
	}

	public Handler getHandler()
	{
		return handler;
	}

	public void parse(DataProvider provider)
		throws ECRException
	{
		fileName = provider.generateFileName(this);
		trace(11);
		handler.start(this);
		for (int i = 0; i < messages.length; i++)
		{
			currentMessage = messages[i];
			trace(21);
			handler.messageStart(currentMessage);
			currentHeader = currentMessage.getHeader();
			provider.readHeader(currentMessage, currentHeader);
			trace(31);
			handler.handleHeader(currentMessage, currentHeader);
			currentBodyReader = provider.getMessageBodyReader(currentMessage);
			currentBodyReader.open();
			int recordCount = 0;
			while ((currentRecord = currentBodyReader.read()) != null) 
			{
				recordCount++;
				currentMessage.setRecordCount(recordCount);
				trace(32);
				handler.handleRecord(currentMessage, currentRecord);
			}
			currentBodyReader.close();
			currentFooter = currentMessage.getFooter();
			provider.readFooter(currentMessage, currentFooter);
			trace(33);
			handler.handleFooter(currentMessage, currentFooter);
			handler.messageEnd(currentMessage);
			trace(22);
		}

		handler.end(this);
		trace(12);
	}

	public String getFileName()
	{
		return fileName;
	}

	public String getDataType()
	{
		return dataType;
	}

	public String getDirection()
	{
		return direction;
	}

	public String getType()
	{
		return type;
	}

	public String getChineseName()
	{
		return chineseName;
	}

	public String getDescription()
	{
		return description;
	}

	public String getName()
	{
		return name;
	}

	public Message[] getMessages()
	{
		return messages;
	}

	public Message getMessageByType(int messageType)
	{
		Message message = null;
		Message msgs[] = getMessages();
		for (int i = 0; i < msgs.length; i++)
		{
			if (messageType != msgs[i].getType())
				continue;
			message = msgs[i];
			break;
		}

		return message;
	}

	private void trace(int traceStep)
	{
		if (!logger.isTraceEnabled())
			return;
		String info = null;
		StringBuffer sb = null;
		Record rec = null;
		switch (traceStep)
		{
		case 11: // '\013'
			info = (new StringBuilder("MessageSet Start: ")).append(getName()).append("/").append(getChineseName()).append("[").append(fileName).append("]").toString();
			break;

		case 12: // '\f'
			info = (new StringBuilder("MessageSet End: ")).append(getName()).append("/").append(getChineseName()).toString();
			break;

		case 21: // '\025'
			info = (new StringBuilder("Message Start : ")).append(currentMessage.getName()).append("/").append(currentMessage.getChineseName()).toString();
			break;

		case 22: // '\026'
			info = (new StringBuilder("Message End : ")).append(currentMessage.getName()).append("[Total Parsed Record : ").append(currentMessage.getRecordCount()).append("]").toString();
			break;

		case 31: // '\037'
			sb = new StringBuffer("Header: ");
			sb.append(currentHeader.getName()).append('/').append(currentHeader.getChineseName()).append('\n');
			rec = currentHeader;
			break;

		case 32: // ' '
			sb = new StringBuffer("Record: ");
			sb.append(currentRecord.getName()).append('/').append(currentRecord.getChineseName()).append("\n").append("RecordKey=");
			try
			{
				sb.append(currentRecord.getBrief());
			}
			catch (ECRException e)
			{
				sb.append("GET RECORD KEY ERROR");
			}
			sb.append("; MainBusinessNo=").append(currentRecord.getMainBusinessNo()).append("\n");
			rec = currentRecord;
			break;

		case 33: // '!'
			sb = new StringBuffer("Footer: ");
			sb.append(currentFooter.getName()).append('/').append(currentFooter.getChineseName()).append('\n');
			rec = currentFooter;
			break;
		}
		if (sb != null)
		{
			Segment seg[] = rec.getAllSegments();
			for (int i = 0; i < seg.length; i++)
			{
				sb.append("[Segment ").append(seg[i].getName()).append("-->");
				Field fd[] = seg[i].getFields();
				for (int j = 0; j < fd.length; j++)
				{
					sb.append(fd[j].getName()).append("=");
					try
					{
						sb.append(fd[j].getTextValue().trim());
					}
					catch (ECRException e)
					{
						sb.append("NA");
					}
					sb.append(j != fd.length - 1 ? '|' : ']');
				}

				if (i != seg.length - 1)
					sb.append('\n');
			}

			info = sb.toString();
		}
		logger.trace(info);
	}
}
