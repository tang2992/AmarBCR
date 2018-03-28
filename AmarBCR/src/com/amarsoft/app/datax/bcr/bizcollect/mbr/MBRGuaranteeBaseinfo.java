package com.amarsoft.app.datax.bcr.bizcollect.mbr;

import com.amarsoft.app.datax.bcr.BCRException;
import com.amarsoft.app.datax.bcr.message.*;
import com.amarsoft.are.log.Log;
import java.sql.*;

import com.amarsoft.app.datax.bcr.message.Message;

public class MBRGuaranteeBaseinfo extends DBMessageBodyReader{
	private String recordSql;
	private String GuaranteeContSql;
	private PreparedStatement psGuaranteeCont;
	private String InsuredsSql;
	private PreparedStatement psInsureds;
	private String CreditorInfoSql;
	private PreparedStatement psCreditorInfo;
	private String CounterGuarantorSql;
	private PreparedStatement psCounterGuarantor;
	private String GuaranteeDutySql;
	private PreparedStatement psGuaranteeDuty;
	private String CompensatoryInfoSql;
	private PreparedStatement psCompensatoryInfo;
	private String CompensatoryDetailSql;
	private PreparedStatement psCompensatoryDetail;
	private String RecoveryDetailSql;
	private PreparedStatement psRecoveryDetail;
	private String PremiumInfoSql;
	private PreparedStatement psPremiumInfo;
	private String PremiumDetailSql;
	private PreparedStatement psPremiumDetail;
	private ResultSet rsRecord;
	private String dataFilter;
	
	public MBRGuaranteeBaseinfo(Message message) 
	{
		super(message);
		GuaranteeContSql = null;
		psGuaranteeCont = null;
		InsuredsSql = null;
		psInsureds = null;
		CreditorInfoSql = null;
		psCreditorInfo = null;
		CounterGuarantorSql = null;
		psCounterGuarantor = null;
		GuaranteeDutySql = null;
		psGuaranteeDuty = null;
		CompensatoryInfoSql = null;
		psCompensatoryInfo = null;
		CompensatoryDetailSql = null;
		psCompensatoryDetail = null;		
		RecoveryDetailSql = null;
		psRecoveryDetail = null;
		PremiumInfoSql = null;
		psPremiumInfo = null;
		PremiumDetailSql = null;
		psPremiumDetail = null;
		rsRecord = null;
	}
	
	protected boolean fillRecord(Record r) throws BCRException{
		if (recordSql == null)
			
			
			return false;
		if (rsRecord == null)
			try{
				rsRecord = executeQuery(recordSql);
			}catch (SQLException e){
				logger.debug(e);
				throw new BCRException(e);
			}
		try{
			if (!rsRecord.next()){
				return false;
			}else{
				String sessionId = rsRecord.getString("SessionID");
				String GBusinessNo = rsRecord.getString("GBusinessNo");
				String GContractNo = rsRecord.getString("GContractNo");
				Segment segB = r.createSegment("B");
				segB.getField(1104).setString(rsRecord.getString("FinanceId"));
				segB.getField(1105).setString(GBusinessNo);
				segB.getField(1106).setString(GContractNo);
				segB.getField(1107).setString(rsRecord.getString("InsuredType"));
				segB.getField(1108).setString(rsRecord.getString("InsuredName"));
				segB.getField(1109).setString(rsRecord.getString("CertType"));
				segB.getField(1110).setString(rsRecord.getString("CertId"));
				segB.getField(1111).setDate(rsRecord.getString("GatherDate"));
				segB.getField(1112).setString(rsRecord.getString("Attribute1"));
				segB.getField(9993).setDate(rsRecord.getString("OccurDate"));
								
				if (GuaranteeContSql != null)
					fillSegmentD(r, sessionId, GBusinessNo);
				if (InsuredsSql != null)
					fillSegmentE(r, sessionId, GBusinessNo);
				if (CreditorInfoSql != null)
					fillSegmentF(r, sessionId, GBusinessNo, GContractNo);
				if (CounterGuarantorSql != null)
					fillSegmentG(r, sessionId, GBusinessNo);
				if (GuaranteeDutySql != null)
					fillSegmentH(r, sessionId, GBusinessNo);
				if (CompensatoryInfoSql != null)
					fillSegmentI(r, sessionId, GBusinessNo);
				if (CompensatoryDetailSql != null)
					fillSegmentJ(r, sessionId, GBusinessNo);
				if (RecoveryDetailSql != null)
					fillSegmentK(r, sessionId, GBusinessNo);
				if (PremiumInfoSql != null)
					fillSegmentL(r, sessionId, GBusinessNo);
				if (PremiumDetailSql != null)
					fillSegmentM(r, sessionId, GBusinessNo);	
				
				int i = r.getLength();
				segB.getField(1101).setInt(i);
			}
		}catch (SQLException e){
			logger.debug(e);
			throw new BCRException(e);
		}
		return true;
	}
	
	private void fillSegmentM(Record r, String sessionId, String GBusinessNo)
			throws BCRException, SQLException{
			if (psPremiumDetail == null)
				psPremiumDetail = prepareStatement(PremiumDetailSql);
			psPremiumDetail.setString(1, sessionId);
			psPremiumDetail.setString(2, GBusinessNo);
			ResultSet rs = psPremiumDetail.executeQuery();
			while (rs.next())
			{
				Segment seg = r.createSegment("M");
				seg.getField(2102).setDate(rs.getString("PayableDate"));
				seg.getField(2103).setInt(rs.getInt("PayableSum"));
				seg.getField(2104).setDate(rs.getString("PaidDate"));
				seg.getField(2105).setInt(rs.getInt("UnpaidSum"));
				seg.getField(2106).setString(rs.getString("PeriodPremiumState"));
				seg.getField(2107).setString(rs.getString("Attribute1"));
			}
			rs.close();
		}
	
	private void fillSegmentL(Record r, String sessionId, String GBusinessNo)
			throws BCRException, SQLException{
			if (psPremiumInfo == null)
				psPremiumInfo = prepareStatement(PremiumInfoSql);
			psPremiumInfo.setString(1, sessionId);
			psPremiumInfo.setString(2, GBusinessNo);
			ResultSet rs = psPremiumInfo.executeQuery();
			if (rs.next())
			{
				Segment seg = r.createSegment("L");
				seg.getField(2002).setString(rs.getString("PayType"));
				seg.getField(2003).setDate(rs.getString("BillingDate"));
				seg.getField(2004).setInt(rs.getInt("PremiumSum"));
				seg.getField(2005).setString(rs.getString("PremiumMode"));
				seg.getField(2006).setString(rs.getString("PremiumFrequency"));
				seg.getField(2007).setDate(rs.getString("ChargingStartDate"));
				seg.getField(2008).setString(rs.getString("PremiumState"));
				seg.getField(2009).setDate(rs.getString("ChargingEndDate"));
				seg.getField(2010).setInt(rs.getInt("PremiumBalance"));
				seg.getField(2011).setInt(rs.getInt("UnpaidSum"));
				seg.getField(2012).setString(rs.getString("Attribute1"));
			}
			rs.close();
		}
	
	private void fillSegmentK(Record r, String sessionId, String GBusinessNo)
			throws BCRException, SQLException{
			if (psRecoveryDetail == null)
				psRecoveryDetail = prepareStatement(RecoveryDetailSql);
			psRecoveryDetail.setString(1, sessionId);
			psRecoveryDetail.setString(2, GBusinessNo);
			ResultSet rs = psRecoveryDetail.executeQuery();
			while (rs.next())
			{
				Segment seg = r.createSegment("K");
				seg.getField(1902).setDate(rs.getString("RecoveryDate"));
				seg.getField(1903).setInt(rs.getInt("RecoverySum"));
			}
			rs.close();
		}
	
	private void fillSegmentJ(Record r, String sessionId, String GBusinessNo)
			throws BCRException, SQLException{
			if (psCompensatoryDetail == null)
				psCompensatoryDetail = prepareStatement(CompensatoryDetailSql);
			psCompensatoryDetail.setString(1, sessionId);
			psCompensatoryDetail.setString(2, GBusinessNo);
			ResultSet rs = psCompensatoryDetail.executeQuery();
			while (rs.next())
			{
				Segment seg = r.createSegment("J");
				seg.getField(1802).setDate(rs.getString("CompensatorDate"));
				seg.getField(1803).setInt(rs.getInt("CompensatorySum"));
			}
			rs.close();
		}
	
	private void fillSegmentI(Record r, String sessionId, String GBusinessNo)
			throws BCRException, SQLException{
			if (psCompensatoryInfo == null)
				psCompensatoryInfo = prepareStatement(CompensatoryInfoSql);
			psCompensatoryInfo.setString(1, sessionId);
			psCompensatoryInfo.setString(2, GBusinessNo);
			ResultSet rs = psCompensatoryInfo.executeQuery();
			if (rs.next())
			{
				Segment seg = r.createSegment("I");
				seg.getField(1702).setDate(rs.getString("BillingDate"));
				seg.getField(1703).setString(rs.getString("RecoveryFlag"));
				seg.getField(1704).setDate(rs.getString("LastCDate"));
				seg.getField(1705).setInt(rs.getInt("CSum"));
				seg.getField(1706).setInt(rs.getInt("OwnCSum"));
				seg.getField(1707).setDate(rs.getString("LastRecoveryDate"));
				seg.getField(1708).setInt(rs.getInt("CBalance"));
				seg.getField(1709).setInt(rs.getInt("OwnCBalance"));
				seg.getField(1710).setInt(rs.getInt("RecoverySum"));
				seg.getField(1711).setInt(rs.getInt("LossSum"));
				seg.getField(1712).setString(rs.getString("Attribute1"));
				//System.out.print(rs.getString("LastCDate"));
			}
			rs.close();
		}
	
	private void fillSegmentH(Record r, String sessionId, String GBusinessNo)
			throws BCRException, SQLException{
			if (psGuaranteeDuty == null)
				psGuaranteeDuty = prepareStatement(GuaranteeDutySql);
			psGuaranteeDuty.setString(1, sessionId);
			psGuaranteeDuty.setString(2, GBusinessNo);
			ResultSet rs = psGuaranteeDuty.executeQuery();
			if (rs.next())
			{
				Segment seg = r.createSegment("H");
				seg.getField(1602).setString(rs.getString("GContractFlag"));
				seg.getField(1603).setDate(rs.getString("GContractEndDate"));
				seg.getField(1604).setInt(rs.getInt("GContractBalance"));
				seg.getField(1605).setDate(rs.getString("BalanceChangeDate"));
			}
			rs.close();
		}
	
	private void fillSegmentG(Record r, String sessionId, String GBusinessNo)
			throws BCRException, SQLException{
			if (psCounterGuarantor == null)
				psCounterGuarantor = prepareStatement(CounterGuarantorSql);
			psCounterGuarantor.setString(1, sessionId);
			psCounterGuarantor.setString(2, GBusinessNo);
			ResultSet rs = psCounterGuarantor.executeQuery();
			while (rs.next())
			{
				Segment seg = r.createSegment("G");
				seg.getField(1502).setString(rs.getString("CounterGType"));
				seg.getField(1503).setString(rs.getString("CounterGName"));
				seg.getField(1504).setString(rs.getString("CertType"));
				seg.getField(1505).setString(rs.getString("CertId"));
				seg.getField(1506).setInt(rs.getInt("CounterGSum"));
				seg.getField(1507).setString(rs.getString("CounterGFlag"));
			}
			rs.close();
		}
	
	private void fillSegmentF(Record r, String sessionId, String GBusinessNo, String GContractNo)
			throws BCRException, SQLException{
			if (psCreditorInfo == null)
				psCreditorInfo = prepareStatement(CreditorInfoSql);
			psCreditorInfo.setString(1, sessionId);
			psCreditorInfo.setString(2, GBusinessNo);
			ResultSet rs = psCreditorInfo.executeQuery();
			while (rs.next())
			{
				Segment seg = r.createSegment("F");
				seg.getField(1402).setString(rs.getString("CreditorType"));
				seg.getField(1403).setString(rs.getString("CreditorName"));
				seg.getField(1404).setString(rs.getString("CertType"));
				seg.getField(1405).setString(rs.getString("CertId"));
				seg.getField(1406).setString(rs.getString("GContractNo"));
				seg.getField(1407).setString(rs.getString("GBusinessNo"));
				seg.getField(1408).setString(rs.getString("Way"));
				seg.getField(1409).setString(rs.getString("ContractFlag"));
			}
			rs.close();
		}
	
	private void fillSegmentE(Record r, String sessionId, String GBusinessNo)
			throws BCRException, SQLException{
			if (psInsureds == null)
				psInsureds = prepareStatement(InsuredsSql);
			psInsureds.setString(1, sessionId);
			psInsureds.setString(2, GBusinessNo);
			ResultSet rs = psInsureds.executeQuery();
			while (rs.next())
			{
				Segment seg = r.createSegment("E");
				seg.getField(1302).setString(rs.getString("InsuredType"));
				seg.getField(1303).setString(rs.getString("InsuredName"));
				seg.getField(1304).setString(rs.getString("CertType"));
				seg.getField(1305).setString(rs.getString("CertId"));
				seg.getField(1306).setString(rs.getString("InsuredState"));
			}
			rs.close();
		}	
	
	private void fillSegmentD(Record r, String sessionId, String GBusinessNo)
			throws BCRException, SQLException{
			if (psGuaranteeCont == null)
				psGuaranteeCont = prepareStatement(GuaranteeContSql);
			psGuaranteeCont.setString(1, sessionId);
			psGuaranteeCont.setString(2, GBusinessNo);
			ResultSet rs = psGuaranteeCont.executeQuery();
			if (rs.next())
			{
				Segment seg = r.createSegment("D");
				seg.getField(1202).setString(rs.getString("BusinessType"));
				seg.getField(1203).setString(rs.getString("GuarantyType"));
				seg.getField(1204).setInt(rs.getInt("GuarantySum"));
				seg.getField(1205).setDate(rs.getString("GStartDate"));
				seg.getField(1206).setDate(rs.getString("GEndDate"));
				seg.getField(1207).setInt(rs.getInt("DepositScale"));
				seg.getField(1208).setString(rs.getString("CounterType"));
				seg.getField(1209).setInt(rs.getInt("Compensation"));
				seg.getField(1210).setString(rs.getString("Rate"));
				seg.getField(1211).setString(rs.getString("AnnualRate"));
				seg.getField(1212).setString(rs.getString("Attribute1"));
			}
			rs.close();
		}	
	
	public String getDataFilter()
	{
		return dataFilter;
	}

	public void setDataFilter(String dataFilter)
	{
		this.dataFilter = dataFilter;
	}

	public final String getRecordSql()
	{
		return recordSql;
	}

	public final void setRecordSql(String recordSql){
		this.recordSql = recordSql;
		if (recordSql == null)
		{
			GuaranteeContSql = null;
			InsuredsSql = null;
			CreditorInfoSql = null;
			CounterGuarantorSql = null;
			GuaranteeDutySql = null;
			CompensatoryInfoSql = null;
			CompensatoryDetailSql = null;		
			RecoveryDetailSql = null;
			PremiumInfoSql = null;
			PremiumDetailSql = null;
			return;
		}
		String s = recordSql.toUpperCase();
		String GuaranteeContTable = null;
		String InsuredsTable = null;
		String CreditorInfoable = null;
		String CounterGuarantorTable = null;
		String GuaranteeDutyTable = null;
		String CompensatoryInfoTable = null;
		String CompensatoryDetailTable = null;
		String RecoveryDetailTable = null;
		String PremiumInfoTable = null;
		String PremiumDetailTable = null;
		if (s.indexOf("BCR_GUARANTEEINFO") > 0){
			GuaranteeContTable = "BCR_GUARANTEECONT";
			InsuredsTable = "BCR_INSUREDS";
			CreditorInfoable = "BCR_CREDITORINFO";
			CounterGuarantorTable = "BCR_COUNTERGUARANTOR";
			GuaranteeDutyTable = "BCR_GUARANTEEDUTY";
			CompensatoryInfoTable = "BCR_COMPENSATORYINFO";
			CompensatoryDetailTable = "BCR_COMPENSATORYDETAIL";
			RecoveryDetailTable = "BCR_RECOVERYDETAIL";
			PremiumInfoTable = "BCR_PREMIUMINFO";
			PremiumDetailTable = "BCR_PREMIUMDETAIL";
		}else{
			GuaranteeContTable = "HIS_GUARANTEECONT";
			InsuredsTable = "HIS_INSUREDS";
			CreditorInfoable = "HIS_CREDITORINFO";
			CounterGuarantorTable = "HIS_COUNTERGUARANTOR";
			GuaranteeDutyTable = "HIS_GUARANTEEDUTY";
			CompensatoryInfoTable = "HIS_COMPENSATORYINFO";
			CompensatoryDetailTable = "HIS_COMPENSATORYDETAIL";
			RecoveryDetailTable = "HIS_RECOVERYDETAIL";
			PremiumInfoTable = "HIS_PREMIUMINFO";
			PremiumDetailTable = "HIS_PREMIUMDETAIL";
		}
		
		GuaranteeContSql = (new StringBuilder("select * from ")).append(GuaranteeContTable).append(" where SessionID=? and GBusinessNo=?").append(dataFilter != null ? (new StringBuilder(" and ")).append(dataFilter).toString() : "").toString();
		InsuredsSql = (new StringBuilder("select * from ")).append(InsuredsTable).append(" where SessionID=? and GBusinessNo=?").append(dataFilter != null ? (new StringBuilder(" and ")).append(dataFilter).toString() : "").toString();
		CreditorInfoSql = (new StringBuilder("select * from ")).append(CreditorInfoable).append(" where SessionID=? and GBusinessNo=? ").append(dataFilter != null ? (new StringBuilder(" and ")).append(dataFilter).toString() : "").toString();
		CounterGuarantorSql = (new StringBuilder("select * from ")).append(CounterGuarantorTable).append(" where SessionID=? and GBusinessNo=? ").append(dataFilter != null ? (new StringBuilder(" and ")).append(dataFilter).toString() : "").toString();
		GuaranteeDutySql = (new StringBuilder("select * from ")).append(GuaranteeDutyTable).append(" where SessionID=? and GBusinessNo=?").append(dataFilter != null ? (new StringBuilder(" and ")).append(dataFilter).toString() : "").toString();
		CompensatoryInfoSql = (new StringBuilder("select * from ")).append(CompensatoryInfoTable).append(" where SessionID=? and GBusinessNo=?").append(dataFilter != null ? (new StringBuilder(" and ")).append(dataFilter).toString() : "").toString();
		CompensatoryDetailSql = (new StringBuilder("select * from ")).append(CompensatoryDetailTable).append(" where SessionID=? and GBusinessNo=?").append(dataFilter != null ? (new StringBuilder(" and ")).append(dataFilter).toString() : "").toString();		
		RecoveryDetailSql = (new StringBuilder("select * from ")).append(RecoveryDetailTable).append(" where SessionID=? and GBusinessNo=?").append(dataFilter != null ? (new StringBuilder(" and ")).append(dataFilter).toString() : "").toString();
		PremiumInfoSql = (new StringBuilder("select * from ")).append(PremiumInfoTable).append(" where SessionID=? and GBusinessNo=?").append(dataFilter != null ? (new StringBuilder(" and ")).append(dataFilter).toString() : "").toString();
		PremiumDetailSql = (new StringBuilder("select * from ")).append(PremiumDetailTable).append(" where SessionID=? and GBusinessNo=?").append(dataFilter != null ? (new StringBuilder(" and ")).append(dataFilter).toString() : "").toString();	
	}
	

}
