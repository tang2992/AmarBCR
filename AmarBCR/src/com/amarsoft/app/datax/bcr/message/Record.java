package com.amarsoft.app.datax.bcr.message;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.common.RecordDBReflector;
import com.amarsoft.are.ARE;
import com.amarsoft.are.dpx.recordset.Field;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.metadata.DefaultColumnMetaData;
import com.amarsoft.are.util.xml.Attribute;
import com.amarsoft.are.util.xml.Element;
import java.util.*;


public class Record
	implements Cloneable
{

	private String id;
	private int type;
	private String name;
	private String chineseName;
	private String mainBusinessSegment;
	private int mainBusinessField;
	private String briefFields[];
	Map segmentMap;
	private Segment segmentTemplets[];

	public Segment createSegment(String segmentFlag)
		throws BCRException
	{
		Segment cloneSegment = null;
		Segment segment = getSegmentTemplet(segmentFlag);
		if (segment == null)
			throw new BCRException((new StringBuilder("can not create the segment ,segment flag: ")).append(segmentFlag).toString());
		Vector segList = (Vector)segmentMap.get(segment.getSegmentFlag());
		if (segList == null)
		{
			segList = new Vector();
			segmentMap.put(segment.getSegmentFlag(), segList);
		}
		if (segment.isUnique() && segList.size() > 0)
			cloneSegment = (Segment)segList.get(0);
		else
			try
			{
				cloneSegment = (Segment)segment.clone();
				segList.add(cloneSegment);
			}
			catch (CloneNotSupportedException e)
			{
				ARE.getLog().debug(e);
				throw new BCRException((new StringBuilder("error when clone segment ")).append(segment.getName()).toString());
			}
		cloneSegment.clear();
		return cloneSegment;
	}

	public Segment getSegmentTemplet(String segmentFlag)
	{
		Segment outputSegment = null;
		for (int i = 0; i < segmentTemplets.length; i++)
		{
			Segment segment = segmentTemplets[i];
			if (!segment.getSegmentFlag().equalsIgnoreCase(segmentFlag))
				continue;
			outputSegment = segment;
			break;
		}

		return outputSegment;
	}

	public Segment[] getSegments(String segmentFlag)
	{
		Vector segList = (Vector)segmentMap.get(segmentFlag);
		if (segList == null)
			return new Segment[0];
		else
			return (Segment[])segList.toArray(new Segment[0]);
	}

	public Segment getFirstSegment(String segmentFlag)
		throws BCRException
	{
		Vector segList = (Vector)segmentMap.get(segmentFlag);
		if (segList == null)
			throw new BCRException((new StringBuilder("can not find the segment '")).append(segmentFlag).append("'").toString());
		else
			return (Segment)segList.get(0);
	}

	public Segment getLastSegment(String segmentFlag)
		throws BCRException
	{
		Vector segList = (Vector)segmentMap.get(segmentFlag);
		if (segList == null)
			throw new BCRException((new StringBuilder("can not find the segment '")).append(segmentFlag).append("'").toString());
		else
			return (Segment)segList.get(segList.size() - 1);
	}

	public Segment[] getAllSegments()
	{
		Vector segmentVictor = new Vector();
		for (int i = 0; i < segmentTemplets.length; i++)
		{
			Segment segment = segmentTemplets[i];
			Vector segList = (Vector)segmentMap.get(segment.getSegmentFlag());
			if (segList != null)
				if (id.equals("header") || id.equals("tail"))
					segmentVictor.add(segList.get(0));
				else
					segmentVictor.addAll(segList);
		}

		return (Segment[])segmentVictor.toArray(new Segment[0]);
	}

	public int getLength()
	{
		int length = 0;
		for (int i = 0; i < segmentTemplets.length; i++)
		{
			Segment segment = segmentTemplets[i];
			Vector segList = (Vector)segmentMap.get(segment.getSegmentFlag());
			if (segList != null)
			{
				for (int j = 0; j < segList.size(); j++)
					length += ((Segment)segList.get(j)).getSegmentLength();

			}
		}

		return length;
	}

	public String getChineseName()
	{
		return chineseName;
	}

	public String getId()
	{
		return id;
	}

	public String getName()
	{
		return name;
	}

	protected static Record buildRecord(Element xRecord)
		throws BCRException
	{
		Record record = new Record();
		Attribute attribute = null;
		attribute = xRecord.getAttribute("id");
		if (attribute == null)
			throw new BCRException("No id   definition  or errorin record's attributes ");
		record.id = attribute.getValue();
		attribute = xRecord.getAttribute("type");
		if (attribute == null)
			throw new BCRException("No type   definition  or error in record's attributes ");
		try
		{
			record.type = Integer.parseInt(attribute.getValue());
		}
		catch (NumberFormatException e)
		{
			e.printStackTrace();
			throw new BCRException("No type   definition  or error in record's attributes ");
		}
		attribute = xRecord.getAttribute("name");
		if (attribute == null)
			record.name = "";
		else
			record.name = attribute.getValue();
		attribute = xRecord.getAttribute("chineseName");
		if (attribute == null)
			record.chineseName = "";
		else
			record.chineseName = attribute.getValue();
		record.setMainBusinessField(xRecord.getAttributeValue("mainBusinessNo"));
		record.setBriefFields(xRecord.getAttributeValue("briefFields"));
		List l = xRecord.getChildren("segment");
		record.segmentTemplets = new Segment[l.size()];
		try
		{
			for (int i = 0; i < l.size(); i++)
				record.segmentTemplets[i] = Segment.buildSegment((Element)l.get(i));

		}
		catch (BCRException exception)
		{
			throw new BCRException((new StringBuilder()).append(exception.getMessage()).append(" @record name:").append(record.getName()).toString());
		}
		record.segmentMap = new TreeMap();
		return record;
	}

	private Record()
	{
		mainBusinessSegment = "B";
		mainBusinessField = 7501;
		briefFields = null;
		segmentMap = null;
	}

	public Object clone()
		throws CloneNotSupportedException
	{
		Record cloneRecord = (Record)super.clone();
		cloneRecord.id = id;
		cloneRecord.name = name;
		cloneRecord.chineseName = chineseName;
		cloneRecord.segmentMap = new HashMap();
		cloneRecord.segmentMap.putAll(segmentMap);
		cloneRecord.segmentTemplets = segmentTemplets;
		cloneRecord.mainBusinessSegment = mainBusinessSegment;
		cloneRecord.briefFields = briefFields;
		return cloneRecord;
	}

	public int getType()
	{
		return type;
	}

	public Segment[] getSegmentTemplets()
	{
		return segmentTemplets;
	}

	public String toString()
	{
		StringBuffer sb = new StringBuffer("");
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append((new StringBuilder("<record id=\"")).append(id).append("\" type=\"").append(type).append("\"").toString());
		sb = sb.append((new StringBuilder(" name=\"")).append(name).append("\" chineseName=\"").append(chineseName).append("\"").toString());
		sb = sb.append("\n");
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append(">");
		if (segmentMap.size() > 0)
		{
			for (int i = 0; i < segmentTemplets.length; i++)
			{
				Segment segment = segmentTemplets[i];
				Vector segList = (Vector)segmentMap.get(segment.getSegmentFlag());
				if (segList != null)
				{
					for (int j = 0; j < segList.size(); j++)
					{
						Segment dataSegment = (Segment)segList.get(j);
						sb = sb.append("\n");
						sb = sb.append(dataSegment.toString());
					}

				}
			}

		}
		sb = sb.append("\n");
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append("</record>");
		return sb.toString();
	}

	public String getMainBusinessNo()
	{
		Segment seg = null;
		com.amarsoft.app.datax.bcr.message.Field fld = null;
		String nullBusinessNo = "MAIN_BUSINESS_NO_NOT_ALLOW_NULL";
		try
		{
			seg = getFirstSegment(mainBusinessSegment);
		}
		catch (BCRException e)
		{
			ARE.getLog().warn((new StringBuilder("获取主业务号Segment[")).append(mainBusinessSegment).append("]出错!").toString(), e);
			seg = null;
		}
		if (seg == null)
			return nullBusinessNo;
		fld = seg.getField(mainBusinessField);
		if (fld == null)
			return nullBusinessNo;
		String bizNo = fld.getString();
		if (bizNo == null || bizNo.trim().length() == 0)
			bizNo = nullBusinessNo;
		return bizNo.trim();
	}

	private void setMainBusinessField(String mainBizField)
	{
		if (mainBizField == null)
		{
			mainBusinessSegment = "Undefine";
			mainBusinessField = 0;
			return;
		}
		String s[] = mainBizField.split("\\.");
		if (s.length < 1)
		{
			mainBusinessSegment = "Undefined";
			mainBusinessField = 0;
			return;
		}
		mainBusinessSegment = s[0];
		try
		{
			mainBusinessField = Integer.parseInt(s[1]);
		}
		catch (NumberFormatException e)
		{
			ARE.getLog().debug(e);
			mainBusinessField = 0;
		}
	}

	public Field[] getBrief()
		throws BCRException
	{
		Field bf[] = new Field[briefFields.length];
		for (int i = 0; i < briefFields.length; i++)
		{
			String s[] = briefFields[i].split("\\.");
			if (s.length < 2)
			{
				ARE.getLog().debug((new StringBuilder("记录简要描述定义有误：")).append(briefFields[i]).toString());
				throw new BCRException((new StringBuilder("记录简要描述定义有误：")).append(briefFields[i]).toString());
			}
			Segment seg = getFirstSegment(s[0].trim());
			if (seg == null)
			{
				ARE.getLog().debug((new StringBuilder("记录录简要描述定义中段没找到：")).append(s[0]).toString());
				throw new BCRException((new StringBuilder("记录录简要描述定义中段没找到：")).append(s[0]).toString());
			}
			int f = 0;
			try
			{
				f = Integer.parseInt(s[1].trim());
			}
			catch (NumberFormatException e)
			{
				ARE.getLog().debug((new StringBuilder("记录录简要描述段定义中字段ID有误：")).append(s[1]).toString(), e);
				throw new BCRException((new StringBuilder("记录录简要描述段定义中字段ID有误：")).append(s[1]).toString());
			}
			com.amarsoft.app.datax.bcr.message.Field fld = seg.getField(f);
			if (fld == null)
			{
				ARE.getLog().debug((new StringBuilder("记录录简要描述段定义中字段没找到：")).append(f).toString());
				throw new BCRException((new StringBuilder("记录录简要描述段定义中字段没找到：")).append(f).toString());
			}
			DefaultColumnMetaData col = new DefaultColumnMetaData(i + 1);
			col.setName(fld.getName());
			col.setLabel(fld.getChineseName());
			switch (fld.getDataType())
			{
			case 4: // '\004'
			case 5: // '\005'
				col.setType(91);
				bf[i] = new Field(col);
				bf[i].setValue(fld.getDate());
				break;

			case 2: // '\002'
				col.setType(4);
				bf[i] = new Field(col);
				bf[i].setValue(fld.getInt());
				break;

			case 3: // '\003'
				col.setType(8);
				bf[i] = new Field(col);
				bf[i].setValue(fld.getDouble());
				break;

			default:
				col.setType(1);
				bf[i] = new Field(col);
				bf[i].setValue(fld.getString());
				break;
			}
		}

		return bf;
	}

	private void setBriefFields(String briefDefineString)
	{
		if (briefDefineString == null)
			briefDefineString = "B.2501";
		briefFields = briefDefineString.split(",");
	}
}
