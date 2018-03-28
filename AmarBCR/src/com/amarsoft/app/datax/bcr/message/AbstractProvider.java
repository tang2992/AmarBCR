package com.amarsoft.app.datax.bcr.message;

import com.amarsoft.app.datax.bcr.BCRException;
import java.text.SimpleDateFormat;
import java.util.Date;

public abstract class AbstractProvider
    implements DataProvider
{

    public AbstractProvider()
    {
        reportFinanceCode = "99999999999";
        fileFinanceCode = "99999999999";
        contactPerson = "***";
        contactPhone = "*******";
        reportDate = null;
        retryMessage = false;
        fileSerialNo = "9999";
    }

    public String generateFileName(MessageSet messageSet)
        throws BCRException
    {
        StringBuffer sb = new StringBuffer();
        sb.append("11");
        String mst = messageSet.getType();
        if(mst.equals("51") || mst.equals("32")){
        	sb.append("000000000");
        }else if(mst.equals("15") || mst.equals("16") || mst.equals("17")){
        	sb.append("000");
        }            
        sb.append(getFileFinanceCode());
        if(mst.equals("51") || mst.equals("32")){
            for(; sb.length() < 22; sb.append('0'));
            }else if (mst.equals("15") || mst.equals("16") || mst.equals("17")){
            	for(; sb.length() < 16; sb.append('0'));
            }else{
            	for(; sb.length() < 13; sb.append('0'));
            }            
        Date rd = getReportDate();
        if(rd == null)
            rd = new Date();
        setReportDate(rd);
        sb.append((new SimpleDateFormat("yyMMdd")).format(rd));
        sb.append(mst);
        if(mst.equals("31") || mst.equals("21")){
        	sb.append('1');
        }else if(mst.equals("15") || mst.equals("16") || mst.equals("17")){
        	sb.append('1');
        }else{
        	sb.append(isRetryMessage() ? '2' : '1');
        }            
        sb.append(getFileSerialNo());
        if(mst.equals("51") || mst.equals("32")){
        	for(; sb.length() < 35; sb.insert(32, '0'));
        }else if(mst.equals("15") || mst.equals("16") || mst.equals("17")){
        	for(; sb.length() < 29; sb.insert(26, '0'));
        }else{
        	for(; sb.length() < 26; sb.insert(23, '0'));
        }            
        sb.append("00");
        return sb.toString();
    }

    public void readHeader(Message message, Record header)
        throws BCRException
    {
        int met = message.getType();
        Segment seg;
        Date rd;
        if(met == 7 || met == 8 || met == 32 || met == 33)
        {
            seg = null;
            seg = header.createSegment("A");
            seg.getField(1002).setString(message.getVersion());
            seg.getField(1003).setString(getReportFinanceCode());
            rd = getReportDate();
            if(rd == null)
                rd = new Date();
            setReportDate(rd);
            seg.getField(1004).setDate(new Date());
            if(met == 7 || met == 32)
                seg.getField(1006).setInt(0);
            else
                seg.getField(1006).setInt(1);
            seg.getField(1008).setString(getContactPerson());
            seg.getField(1009).setString(getContactPhone());
            seg.getField(1010).setString("");
            return;
        }else if(met == 81 || met == 82 || met == 83){
        	seg = null;
            seg = header.createSegment("A");
            seg.getField(1002).setString(message.getVersion());
            seg.getField(1003).setString(getReportFinanceCode());
            rd = getReportDate();
            if(rd == null)
                rd = new Date();
            setReportDate(rd);
            seg.getField(1004).setDate(new Date());
            String metstr = Integer.toString(met);
            seg.getField(1005).setString(metstr);
            seg.getField(1006).setString("");
            return;
        }else{
        	seg = null;
            seg = header.createSegment("A");
            seg.getField(8517).setString(message.getVersion());
            seg.getField(6501).setString(getReportFinanceCode());
            rd = getReportDate();
            if(rd == null)
                rd = new Date();
            setReportDate(rd);
            seg.getField(2585).setDate(rd);
            int mt = message.getType();
            seg.getField(8523).setInt(message.getType());
            seg.getField(8515).setString("");
            if(mt == 41 || mt == 51)
                seg.getField(8535).setString("");
        }        
    }

    public void readFooter(Message message, Record footer)
        throws BCRException
    {
        int met = message.getType();
        if(met == 7 || met == 8 || met == 32 || met == 33)
        {
            Segment seg = footer.createSegment("Z");
            Field field = seg.getField(2202);
            field.setInt(message.getRecordCount());
            return;
        } else if(met == 81){
            Segment seg = footer.createSegment("Z");
            Field field = seg.getField(2202);
            field.setInt(message.getRecordCount());
            return;
        }else if(met == 82 || met == 83){
            Segment seg = footer.createSegment("Z");
            Field field = seg.getField(3002);
            field.setInt(message.getRecordCount());
            return;
        }else{
            Segment seg = footer.createSegment("Z");
            Field field = seg.getField(4513);
            field.setInt(message.getRecordCount());
            return;
        }
    }

    public final String getFileSerialNo()
    {
        return fileSerialNo;
    }

    public final void setFileSerialNo(String FileSerialNo)
    {
        fileSerialNo = FileSerialNo;
    }

    public final Date getReportDate()
    {
        return reportDate;
    }

    public final void setReportDate(Date reportDate)
    {
        this.reportDate = reportDate;
    }

    public final String getReportFinanceCode()
    {
        return reportFinanceCode;
    }

    public final void setReportFinanceCode(String reportFinanceCode)
    {
        this.reportFinanceCode = reportFinanceCode;
    }

    public final boolean isRetryMessage()
    {
        return retryMessage;
    }

    public final void setRetryMessage(boolean retryMessage)
    {
        this.retryMessage = retryMessage;
    }

    public final String getFileFinanceCode()
    {
        return fileFinanceCode;
    }

    public final void setFileFinanceCode(String fileFinanceCode)
    {
        this.fileFinanceCode = fileFinanceCode;
    }

    public String getContactPerson()
    {
        return contactPerson;
    }

    public String getContactPhone()
    {
        return contactPhone;
    }

    public void setContactPerson(String contactPerson)
    {
        this.contactPerson = contactPerson;
    }

    public void setContactPhone(String contactPhone)
    {
        this.contactPhone = contactPhone;
    }

    private String reportFinanceCode;
    private String fileFinanceCode;
    private String contactPerson;
    private String contactPhone;
    private Date reportDate;
    private boolean retryMessage;
    private String fileSerialNo;
}
