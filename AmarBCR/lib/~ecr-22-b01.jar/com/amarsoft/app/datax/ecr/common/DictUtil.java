// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   DictUtil.java

package com.amarsoft.app.datax.ecr.common;

import com.amarsoft.are.ARE;
import com.amarsoft.are.io.FileTool;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.util.Property;
import com.amarsoft.are.util.xml.Document;
import com.amarsoft.are.util.xml.Element;
import java.io.File;
import java.util.*;

public class DictUtil
{

	private static SortedMap items = null;

	public DictUtil()
	{
	}

	public static void init(String dictFile)
	{
		if (items != null)
			return;
		items = new TreeMap();
		File f = FileTool.findFile(dictFile);
		Document doc = null;
		if (f == null)
		{
			ARE.getLog().debug((new StringBuilder("Load Dictionary faild,file not exists--")).append(dictFile).toString());
			return;
		}
		try
		{
			doc = new Document(f);
		}
		catch (Exception e)
		{
			ARE.getLog().debug("Load Dictionary faild!", e);
			return;
		}
		Element xRoot = doc.getRootElement();
		for (Iterator xItems = xRoot.getChildren("item").iterator(); xItems.hasNext();)
		{
			Element xItem = (Element)xItems.next();
			String type = xItem.getAttributeValue("type");
			if (type != null)
			{
				Iterator xProps = xItem.getChildren("property").iterator();
				SortedMap item = new TreeMap();
				while (xProps.hasNext()) 
				{
					Element xProp = (Element)xProps.next();
					String n = xProp.getAttributeValue("code");
					if (n != null)
					{
						String v = xProp.getAttributeValue("notes");
						item.put(n, v);
					}
				}
				items.put(type, item);
			}
		}

	}

	public static List getPropertyList(String itemType)
	{
		SortedMap item = (SortedMap)items.get(itemType);
		ArrayList l = new ArrayList();
		if (item == null)
			return l;
		String n;
		for (Iterator it = item.keySet().iterator(); it.hasNext(); l.add(new Property(n, item.get(n))))
			n = (String)it.next();

		return l;
	}

	public static String getPropertyNotes(String itemType, String code)
	{
		SortedMap item = (SortedMap)items.get(itemType);
		if (item == null)
			return null;
		else
			return (String)item.get(code);
	}

}
