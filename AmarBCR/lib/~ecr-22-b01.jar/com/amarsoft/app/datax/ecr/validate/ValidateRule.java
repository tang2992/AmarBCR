// Decompiled by Jad v1.5.8e2. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://kpdus.tripod.com/jad.html
// Decompiler options: packimports(3) fieldsfirst ansi space 
// Source File Name:   ValidateRule.java

package com.amarsoft.app.datax.ecr.validate;

import com.amarsoft.app.datax.ecr.ECRException;
import com.amarsoft.app.datax.ecr.message.*;
import com.amarsoft.app.datax.ecr.validate.validator.ANCChecker;
import com.amarsoft.app.datax.ecr.validate.validator.ANChecker;
import com.amarsoft.app.datax.ecr.validate.validator.AbstractFieldChecker;
import com.amarsoft.app.datax.ecr.validate.validator.AccountPermitNoChecker;
import com.amarsoft.app.datax.ecr.validate.validator.CreditCodeChecker;
import com.amarsoft.app.datax.ecr.validate.validator.DICChecker;
import com.amarsoft.app.datax.ecr.validate.validator.DKKChecker;
import com.amarsoft.app.datax.ecr.validate.validator.DataCheckerJudge;
import com.amarsoft.app.datax.ecr.validate.validator.DataEqualChecker;
import com.amarsoft.app.datax.ecr.validate.validator.DataListChecker;
import com.amarsoft.app.datax.ecr.validate.validator.DataRangeChecker;
import com.amarsoft.app.datax.ecr.validate.validator.DataRangeNotEqualsChecker;
import com.amarsoft.app.datax.ecr.validate.validator.DateTimeChecker;
import com.amarsoft.app.datax.ecr.validate.validator.DuplicateSegmentChecker;
import com.amarsoft.app.datax.ecr.validate.validator.EmailChecker;
import com.amarsoft.app.datax.ecr.validate.validator.FinanceChecker;
import com.amarsoft.app.datax.ecr.validate.validator.LengthRangeChecker;
import com.amarsoft.app.datax.ecr.validate.validator.LogicChecker;
import com.amarsoft.app.datax.ecr.validate.validator.MoneyChecker;
import com.amarsoft.app.datax.ecr.validate.validator.NullChecker;
import com.amarsoft.app.datax.ecr.validate.validator.NumberChecker;
import com.amarsoft.app.datax.ecr.validate.validator.OrganizeIDChecker;
import com.amarsoft.app.datax.ecr.validate.validator.PersonIDChecker;
import com.amarsoft.app.datax.ecr.validate.validator.PostCodeChecker;
import com.amarsoft.app.datax.ecr.validate.validator.SegmentNumberChecker;
import com.amarsoft.app.datax.ecr.validate.validator.SegmentPositionChecker;
import com.amarsoft.app.datax.ecr.validate.validator.StringChecker;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.util.xml.Element;
import java.sql.Connection;
import java.util.List;
import java.util.regex.Pattern;

// Referenced classes of package com.amarsoft.app.datax.ecr.validate:
//			ParseAttribute

public class ValidateRule
{

	protected String name;
	protected int messageType;
	protected int recordType;
	protected String segmentFlag;
	protected String checkType;
	protected String checkedFieldName;
	protected String dataStartValue;
	protected String dataEndValue;
	protected String dataList;
	protected boolean reverseCheck;
	protected int iterateLength;
	protected String orderInList;
	protected String Level;
	protected String compareWay;
	protected int checkedStartPosition;
	protected int checkedEndPosition;
	protected String errorCode;
	protected String errorMsg;
	protected ValidateRule precondition[];
	protected Message ruleMessage;
	protected Segment ruleSegment;
	protected Record ruleRecord;
	private Connection connection;

	public ValidateRule()
	{
		name = null;
		messageType = 0;
		recordType = 0;
		segmentFlag = null;
		checkType = null;
		checkedFieldName = null;
		dataStartValue = null;
		dataEndValue = null;
		dataList = null;
		reverseCheck = true;
		iterateLength = 0;
		orderInList = null;
		Level = null;
		compareWay = null;
		errorCode = "";
		errorMsg = "";
		precondition = null;
		ruleMessage = null;
		ruleSegment = null;
		ruleRecord = null;
		connection = null;
	}

	public static ValidateRule createValidateRule(Message message, Segment segm, Record record, int messageType, int recordType, String fieldName, String errorCode, String ErrorMsg, 
			String name)
	{
		ValidateRule validateRule = null;
		validateRule = new ValidateRule();
		validateRule.ruleMessage = message;
		validateRule.ruleSegment = segm;
		validateRule.ruleRecord = record;
		validateRule.messageType = messageType;
		validateRule.recordType = recordType;
		validateRule.checkedFieldName = fieldName;
		validateRule.errorCode = errorCode;
		validateRule.errorMsg = ErrorMsg;
		validateRule.name = name;
		return validateRule;
	}

	public static ValidateRule buildRule(Element xRule)
		throws ECRException
	{
		ValidateRule r = new ValidateRule();
		r.name = xRule.getAttributeValue("name");
		r.messageType = Integer.parseInt(xRule.getAttributeValue("messageType"));
		r.recordType = Integer.parseInt(xRule.getAttributeValue("recordType"));
		r.segmentFlag = xRule.getAttributeValue("segmentFlag");
		r.checkType = xRule.getAttributeValue("checkType");
		r.checkedFieldName = xRule.getAttributeValue("checkedFieldName");
		r.dataStartValue = xRule.getAttributeValue("dataStartValue");
		r.dataEndValue = xRule.getAttributeValue("dataEndValue");
		r.dataList = xRule.getAttributeValue("dataList");
		r.Level = xRule.getAttributeValue("Level");
		String s = xRule.getAttributeValue("reverseCheck");
		r.reverseCheck = s != null && s.equalsIgnoreCase("true");
		s = xRule.getAttributeValue("iterateLength");
		if (s == null)
			r.iterateLength = 0;
		else
			try
			{
				r.iterateLength = Integer.parseInt(s);
			}
			catch (Exception e)
			{
				ARE.getLog().error((new StringBuilder("Parse")).append(s).append("to iterateLength error.").toString(), e);
			}
		r.orderInList = xRule.getAttributeValue("orderInList");
		r.compareWay = xRule.getAttributeValue("compareWay");
		try
		{
			r.checkedStartPosition = Integer.parseInt(xRule.getAttributeValue("checkedStartPosition"));
		}
		catch (Exception e)
		{
			r.checkedStartPosition = -1;
		}
		try
		{
			r.checkedEndPosition = Integer.parseInt(xRule.getAttributeValue("checkedEndPosition"));
		}
		catch (Exception e)
		{
			r.checkedEndPosition = -1;
		}
		r.errorCode = xRule.getAttributeValue("errorCode");
		r.errorMsg = xRule.getAttributeValue("errorMsg");
		r.dataList = xRule.getAttributeValue("dataList");
		Element xPrecondition = xRule.getChild("precondition");
		if (xPrecondition != null)
			r.precondition = loadRules(xPrecondition);
		return r;
	}

	private static ValidateRule[] loadRules(Element xCheckRules)
		throws ECRException
	{
		List l = xCheckRules.getChildren("rule");
		ValidateRule r[] = new ValidateRule[l.size()];
		for (int i = 0; i < l.size(); i++)
			r[i] = buildRule((Element)l.get(i));

		return r;
	}

	public boolean validate(Message message, Segment segment, Record record)
	{
		ruleMessage = message;
		ruleSegment = segment;
		ruleRecord = record;
		boolean validateResult = true;
		if (precondition != null && precondition.length > 0)
		{
			boolean pass = true;
			for (int i = 0; i < precondition.length; i++)
			{
				pass = precondition[i].validate(message, segment, record);
				if (!pass)
					break;
			}

			if (!pass)
				return true;
		}
		if (getCheckedValue().indexOf("#") >= 0)
		{
			boolean checkOk = Pattern.matches("[#]+$", getCheckedValue());
			if (checkOk)
				return true;
		}
		AbstractFieldChecker checker = null;
		if (checkType == null)
			return validateResult = true;
		if (checkType.equalsIgnoreCase("D"))
			checker = new DateTimeChecker();
		else
		if (checkType.equalsIgnoreCase("N"))
			checker = new NumberChecker();
		else
		if (checkType.equalsIgnoreCase("DL"))
			checker = new DataListChecker();
		else
		if (checkType.equalsIgnoreCase("DE"))
			checker = new DataEqualChecker();
		else
		if (checkType.equalsIgnoreCase("DR"))
			checker = new DataRangeChecker();
		else
		if (checkType.equalsIgnoreCase("DRNE"))
			checker = new DataRangeNotEqualsChecker();
		else
		if (checkType.equalsIgnoreCase("NA"))
			checker = new NullChecker();
		else
		if (checkType.equalsIgnoreCase("ID"))
			checker = new PersonIDChecker();
		else
		if (checkType.equalsIgnoreCase("PC"))
			checker = new PostCodeChecker();
		else
		if (checkType.equalsIgnoreCase("SN"))
			checker = new SegmentNumberChecker();
		else
		if (checkType.equalsIgnoreCase("SD"))
			checker = new DuplicateSegmentChecker();
		else
		if (checkType.equalsIgnoreCase("SP"))
			checker = new SegmentPositionChecker();
		else
		if (checkType.equalsIgnoreCase("S"))
			checker = new StringChecker();
		else
		if (checkType.equalsIgnoreCase("ZD"))
			checker = new OrganizeIDChecker();
		else
		if (checkType.equalsIgnoreCase("DKK"))
			checker = new DKKChecker();
		else
		if (checkType.equalsIgnoreCase("M"))
			checker = new MoneyChecker();
		else
		if (checkType.equalsIgnoreCase("AN"))
			checker = new ANChecker();
		else
		if (checkType.equalsIgnoreCase("ANC"))
			checker = new ANCChecker();
		else
		if (checkType.equalsIgnoreCase("EMAIL"))
			checker = new EmailChecker();
		else
		if (checkType.equalsIgnoreCase("DIC"))
			checker = new DICChecker();
		else
		if (checkType.equalsIgnoreCase("DJ"))
			checker = new DataCheckerJudge();
		else
		if (checkType.equalsIgnoreCase("FI"))
			checker = new FinanceChecker();
		else
		if (checkType.equalsIgnoreCase("AP"))
			checker = new AccountPermitNoChecker();
		else
		if (checkType.equalsIgnoreCase("CT"))
			checker = new CreditCodeChecker();
		else
		if (checkType.equalsIgnoreCase("LR"))
			checker = new LengthRangeChecker();
		else
			checker = new LogicChecker(connection);
		if (checker != null)
		{
			checker.init(this);
			validateResult = checker.getCheckResult();
			validateResult = reverseCheck ? !validateResult : validateResult;
		} else
		{
			validateResult = true;
		}
		return validateResult;
	}

	public String getName()
	{
		return name;
	}

	public String getCheckType()
	{
		return checkType;
	}

	public int getmessageType()
	{
		return messageType;
	}

	public int getrecordType()
	{
		return recordType;
	}

	public String getCheckedFieldName()
	{
		return checkedFieldName;
	}

	public String getCheckedValue()
	{
		String realValue = ParseAttribute.getCheckedValue(this, checkedFieldName);
		if (checkedStartPosition >= 0 && checkedEndPosition > checkedStartPosition)
			realValue = realValue.substring(checkedStartPosition, checkedEndPosition);
		return realValue;
	}

	public String getDataStartValue()
	{
		String realValue = ParseAttribute.getRealValue(this, dataStartValue);
		return realValue;
	}

	public String getDataEndValue()
	{
		String realValue = ParseAttribute.getRealValue(this, dataEndValue);
		return realValue;
	}

	public String getDataList()
	{
		String realValue = ParseAttribute.getRealValue(this, dataList);
		return realValue;
	}

	public String getCompareWay()
	{
		String realValue = ParseAttribute.getRealValue(this, compareWay);
		return realValue;
	}

	public String getStrictLevel()
	{
		String realValue = ParseAttribute.getRealValue(this, Level);
		return realValue;
	}

	public boolean getReverseCheck()
	{
		return reverseCheck;
	}

	public String getErrorMsg()
	{
		return errorMsg;
	}

	public Message getMessage()
	{
		return ruleMessage;
	}

	public Segment getSegment()
	{
		return ruleSegment;
	}

	public Record getRecord()
	{
		return ruleRecord;
	}

	public int getCheckedEndPosition()
	{
		return checkedEndPosition;
	}

	public int getCheckedStartPosition()
	{
		return checkedStartPosition;
	}

	public int getIterateLength()
	{
		return iterateLength;
	}

	public String getOrderInList()
	{
		return orderInList;
	}

	public String getErrorCode()
	{
		return errorCode;
	}

	public void setErrorCode(String errorCode)
	{
		this.errorCode = errorCode;
	}

	public String getLevel()
	{
		return Level;
	}

	public void setLevel(String level)
	{
		Level = level;
	}

	public int getMessageType()
	{
		return messageType;
	}

	public void setMessageType(int messageType)
	{
		this.messageType = messageType;
	}

	public ValidateRule[] getPrecondition()
	{
		return precondition;
	}

	public void setPrecondition(ValidateRule precondition[])
	{
		this.precondition = precondition;
	}

	public int getRecordType()
	{
		return recordType;
	}

	public void setRecordType(int recordType)
	{
		this.recordType = recordType;
	}

	public Message getRuleMessage()
	{
		return ruleMessage;
	}

	public void setRuleMessage(Message ruleMessage)
	{
		this.ruleMessage = ruleMessage;
	}

	public Record getRuleRecord()
	{
		return ruleRecord;
	}

	public void setRuleRecord(Record ruleRecord)
	{
		this.ruleRecord = ruleRecord;
	}

	public Segment getRuleSegment()
	{
		return ruleSegment;
	}

	public void setRuleSegment(Segment ruleSegment)
	{
		this.ruleSegment = ruleSegment;
	}

	public String getSegmentFlag()
	{
		return segmentFlag;
	}

	public void setSegmentFlag(String segmentFlag)
	{
		this.segmentFlag = segmentFlag;
	}

	public void setCheckedEndPosition(int checkedEndPosition)
	{
		this.checkedEndPosition = checkedEndPosition;
	}

	public void setCheckedFieldName(String checkedFieldName)
	{
		this.checkedFieldName = checkedFieldName;
	}

	public void setCheckedStartPosition(int checkedStartPosition)
	{
		this.checkedStartPosition = checkedStartPosition;
	}

	public void setCheckType(String checkType)
	{
		this.checkType = checkType;
	}

	public void setCompareWay(String compareWay)
	{
		this.compareWay = compareWay;
	}

	public void setDataEndValue(String dataEndValue)
	{
		this.dataEndValue = dataEndValue;
	}

	public void setDataList(String dataList)
	{
		this.dataList = dataList;
	}

	public void setDataStartValue(String dataStartValue)
	{
		this.dataStartValue = dataStartValue;
	}

	public void setErrorMsg(String errorMsg)
	{
		this.errorMsg = errorMsg;
	}

	public void setIterateLength(int iterateLength)
	{
		this.iterateLength = iterateLength;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public void setOrderInList(String orderInList)
	{
		this.orderInList = orderInList;
	}

	public void setReverseCheck(boolean reverseCheck)
	{
		this.reverseCheck = reverseCheck;
	}

	public void setConnection(Connection conn)
	{
		connection = conn;
	}
}
