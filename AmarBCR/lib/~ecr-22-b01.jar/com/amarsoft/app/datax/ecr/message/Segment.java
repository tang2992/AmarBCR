// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   Segment.java

package com.amarsoft.app.datax.ecr.message;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.util.xml.Attribute;
import com.amarsoft.are.util.xml.Element;
import java.util.List;

// Referenced classes of package com.amarsoft.app.datax.ecr.message:
//			Field

public class Segment
	implements Cloneable
{

	private String segmentFlag;
	private String id;
	private String chineseName;
	private String name;
	private int segmentLength;
	private boolean optional;
	private boolean unique;
	protected boolean fieldValidate;
	private Field fields[];

	protected static Segment buildSegment(Element xSegment)
		throws ECRException
	{
		Segment segment = new Segment();
		Attribute attribute = null;
		attribute = xSegment.getAttribute("segmentFlag");
		if (attribute == null)
			throw new ECRException("No segmentflag   definition  or errorin segment's attributes ");
		segment.segmentFlag = attribute.getValue();
		attribute = xSegment.getAttribute("id");
		if (attribute == null)
			segment.id = "";
		else
			segment.id = attribute.getValue();
		attribute = xSegment.getAttribute("chineseName");
		if (attribute == null)
			segment.chineseName = "";
		else
			segment.chineseName = attribute.getValue();
		attribute = xSegment.getAttribute("name");
		if (attribute == null)
			segment.name = "";
		else
			segment.name = attribute.getValue();
		attribute = xSegment.getAttribute("segmentLength");
		if (attribute == null)
			throw new ECRException((new StringBuilder("No segmentlength   definition  or errorin segment's attributes  @ segmentFlag:")).append(segment.segmentFlag).toString());
		try
		{
			segment.segmentLength = Integer.parseInt(attribute.getValue());
		}
		catch (NumberFormatException e)
		{
			ARE.getLog().debug(e);
			throw new ECRException((new StringBuilder("No segmentlength   definition  or errorin segment's attributes  @ segmentFlag:")).append(segment.segmentFlag).toString(), e);
		}
		attribute = xSegment.getAttribute("optional");
		if (attribute == null)
			throw new ECRException((new StringBuilder("No optional   define  or error in segment's attributes  @ segmentFlag:")).append(segment.segmentFlag).toString());
		segment.optional = attribute.getValue(false);
		attribute = xSegment.getAttribute("unique");
		if (attribute == null)
			throw new ECRException((new StringBuilder("No unique   definition  or errorin segment's attributes  @ segmentFlag:")).append(segment.segmentFlag).toString());
		segment.unique = attribute.getValue(true);
		List l = xSegment.getChildren("field");
		segment.fields = new Field[l.size()];
		try
		{
			for (int i = 0; i < l.size(); i++)
				segment.fields[i] = Field.buildField((Element)l.get(i), segment);

		}
		catch (ECRException exception)
		{
			throw new ECRException((new StringBuilder()).append(exception.getMessage()).append(" @segment segmentFlag:").append(segment.getSegmentFlag()).toString());
		}
		return segment;
	}

	public Segment()
	{
		fieldValidate = true;
	}

	public boolean validate()
	{
		return fieldValidate;
	}

	public void clear()
	{
		for (int i = 0; i < fields.length; i++)
		{
			Field field = fields[i];
			if (field != null)
				field.clear();
		}

	}

	public Field[] getFields()
	{
		return fields;
	}

	public String getName()
	{
		return name;
	}

	public boolean isOptional()
	{
		return optional;
	}

	public int getSegmentLength()
	{
		return segmentLength;
	}

	public boolean isUnique()
	{
		return unique;
	}

	public Field getField(String fieldName)
	{
		Field f = null;
		for (int i = 0; i < fields.length; i++)
		{
			if (!fields[i].getName().equalsIgnoreCase(fieldName))
				continue;
			f = fields[i];
			break;
		}

		return f;
	}

	public Field getField(int fId)
	{
		Field f = null;
		String fieldId = "";
		fieldId = (new StringBuilder()).append(fId).toString();
		for (int i = 0; i < fields.length; i++)
		{
			if (!fields[i].getId().equalsIgnoreCase(fieldId))
				continue;
			f = fields[i];
			break;
		}

		return f;
	}

	public int getFieldNumber()
	{
		return fields.length;
	}

	public Object clone()
		throws CloneNotSupportedException
	{
		Segment seg = (Segment)super.clone();
		seg.fields = new Field[fields.length];
		seg.segmentFlag = segmentFlag;
		seg.id = id;
		seg.chineseName = chineseName;
		seg.name = name;
		seg.segmentLength = segmentLength;
		seg.optional = optional;
		seg.unique = unique;
		for (int i = 0; i < seg.fields.length; i++)
		{
			seg.fields[i] = (Field)fields[i].clone();
			seg.fields[i].setSegment(seg);
		}

		return seg;
	}

	public String getChineseName()
	{
		return chineseName;
	}

	public String getId()
	{
		return id;
	}

	public String getSegmentFlag()
	{
		return segmentFlag;
	}

	public void setSegmentLength(int segmentLength)
	{
		this.segmentLength = segmentLength;
	}

	public String toString()
	{
		StringBuffer sb = new StringBuffer("");
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append((new StringBuilder("<segment segmentFlag=\"")).append(segmentFlag).append("\" id=\"").append(id).append("\"").toString());
		sb = sb.append("\n");
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append((new StringBuilder(" segmentLength=\"")).append(segmentLength).append("\" optional=\"").append(optional).append("\"").toString());
		sb = sb.append("\n");
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append((new StringBuilder(" unique=\"")).append(unique).append("\"").toString());
		sb = sb.append(">");
		for (int i = 0; i < fields.length; i++)
		{
			Field field = fields[i];
			if (field != null)
			{
				sb.append("\n");
				sb.append(field.toString());
			}
		}

		sb = sb.append("\n");
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append('\t');
		sb = sb.append("</segment>");
		return sb.toString();
	}
}
