package com.amarsoft.app.datax.bcr.bizcollect;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.message.*;
import com.amarsoft.app.datax.bcr.validate.*;
import com.amarsoft.are.ARE;
import com.amarsoft.are.log.Log;
import com.amarsoft.are.util.xml.Document;
import com.amarsoft.are.util.xml.Element;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;

public class ValidateHandler
    implements Handler
{

    public ValidateHandler()
    {
        database = "bcr";
        rulesFile = null;
        totalRecordNumber = 0;
        correctRecordNumber = 0;
        errorRecordNumber = 0;
        errorRelativedRecordNumber = 0;
        logger = null;
        connection = null;
        errorRecord = null;
        errorBusiness = null;
    }

    public final String getDatabase()
    {
        return database;
    }

    public final void setDatabase(String s)
    {
        database = s;
    }

    public final int getCorrectRecordNumber()
    {
        return correctRecordNumber;
    }

    public final int getErrorRecordNumber()
    {
        return errorRecordNumber;
    }

    public final int getTotalRecordNumber()
    {
        return totalRecordNumber;
    }

    public void messageStart(Message message)
        throws BCRException
    {
        if(errorRecord == null)
        {
            errorRecord = new DBErrorRecord();
            errorRecord.open();
        }
        errorRecord.clearMessageError(message.getType());
    }

    public void handleHeader(Message message, Record record)
        throws BCRException
    {
    }

    public void handleRecord(Message message, Record record)
        throws BCRException
    {
        if(null == record || record.getId().equalsIgnoreCase("header") || record.getId().equalsIgnoreCase("tail"))
            return;
        totalRecordNumber++;
        String s = validate(message, record);
        String s1 = record.getMainBusinessNo();
        if(s != null)
        {
            errorBusiness.add(s1);
            logger.trace((new StringBuilder()).append("Record validate not pass: ").append(s1).toString());
            errorRecordNumber++;
        } else
        if(errorBusiness.contains(s1))
        {
            logger.trace((new StringBuilder()).append("Record has relatived error: ").append(s1).toString());
            errorRelativedRecordNumber++;
        } else
        {
            correctRecordNumber++;
        }
    }

    public void handleFooter(Message message, Record record)
        throws BCRException
    {
    }

    public void messageEnd(Message message)
        throws BCRException
    {
    }

    public void start(MessageSet messageset)
        throws BCRException
    {
        logger = ARE.getLog();
        try
        {
            connection = ARE.getDBConnection(database);
            int i = ARE.getProperty("connection.ecr.isolation", -1);
            if(i != -1)
            {
                logger.debug((new StringBuilder()).append("JDBC transactionIsolation set to ").append(i).toString());
                connection.setTransactionIsolation(i);
            }
            connection.setAutoCommit(false);
        }
        catch(SQLException sqlexception)
        {
            logger.debug(sqlexception);
            throw new BCRException("\u6570\u636E\u5E93\u8FDE\u63A5\u5931\u8D25\uFF01", sqlexception);
        }
        errorBusiness = new TreeSet();
        errorRecord = new DBErrorRecord();
        ((DBErrorRecord)errorRecord).setDatabase(database);
        errorRecord.open();
    }

    public void end(MessageSet messageset)
        throws BCRException
    {
        if(errorRecord != null)
        {
            errorRecord.close();
            errorRecord = null;
        }
        if(connection != null)
        {
            try
            {
                connection.close();
            }
            catch(SQLException sqlexception)
            {
                logger.debug(sqlexception);
            }
            connection = null;
        }
    }

    private String validate(Message message, Record record)
        throws BCRException
    {
        if(checkRules == null || checkRules.length == 0)
            return null;
        Segment asegment[] = null;
        Object obj = null;
        asegment = record.getAllSegments();
        StringBuffer stringbuffer = new StringBuffer();
        for(int i = 0; i < asegment.length; i++)
        {
            Segment segment = asegment[i];
            for(int j = 0; j < checkRules.length; j++)
            {
                if(checkRules[j].getmessageType() != message.getType() || checkRules[j].getRecordType() != record.getType() || !checkRules[j].getSegmentFlag().equals(segment.getSegmentFlag()))
                    continue;
                checkRules[j].setConnection(connection);
                if(!checkRules[j].validate(message, segment, record))
                {
                    stringbuffer.append(checkRules[j].getErrorCode());
                    errorRecord.writeError(checkRules[j], segment);
                }
            }

        }

        if(stringbuffer.length() > 0)
            return stringbuffer.toString();
        else
            return null;
    }

    public void loadRulesFromXMLFile(String s)
        throws BCRException
    {
        Document document = null;
        try
        {
            document = new Document(s);
        }
        catch(Exception exception)
        {
            throw new BCRException("Build Document error", exception);
        }
        Element element = document.getRootElement();
        Element element1 = element.getChild("rulemap");
        if(element1 == null)
            throw new BCRException((new StringBuilder()).append("No rulemap  define--").append(s).toString());
        Element element2 = element1.getChild("rulelist");
        if(element2 == null)
            throw new BCRException((new StringBuilder()).append("No rulelist define--").append(s).toString());
        List list = element2.getChildren("rule");
        checkRules = new ValidateRule[list.size()];
        try
        {
            for(int i = 0; i < list.size(); i++)
                checkRules[i] = ValidateRule.buildRule((Element)list.get(i));

        }
        catch(BCRException ecrexception)
        {
            throw new BCRException((new StringBuilder()).append("").append(ecrexception.getMessage()).append(" @rulefile :").append(s).toString());
        }
    }

    public final String getRulesFile()
    {
        return rulesFile;
    }

    public final void setRulesFile(String s)
    {
        rulesFile = s;
    }

    public final int getErrorRelativedRecordNumber()
    {
        return errorRelativedRecordNumber;
    }

    private String database;
    private String rulesFile;
    private int totalRecordNumber;
    private int correctRecordNumber;
    private int errorRecordNumber;
    private int errorRelativedRecordNumber;
    private Log logger;
    private Connection connection;
    private ValidateRule checkRules[];
    private ErrorRecord errorRecord;
    private Set errorBusiness;
}
