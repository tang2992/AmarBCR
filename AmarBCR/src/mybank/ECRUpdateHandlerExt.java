package mybank;

import com.amarsoft.app.datax.ecr.prepare.dataimport.ECRUpdateHandler;
import com.amarsoft.are.dpx.recordset.Field;
import com.amarsoft.are.dpx.recordset.Record;

public class ECRUpdateHandlerExt extends ECRUpdateHandler {

	/**
	 * 重写match，导入信贷机构信息时，计算“客户类型”
	 */
	public boolean match(Record curRecord, Record dbRecord) {
		Field curf = curRecord.getField("CustomerType");// 当前值是"2"
		Field dbf = dbRecord.getField("CustomerType");//  可能是"1"/"2"/"3"/""
		if(dbf.getString()!=null&&!curf.getString().equals(dbf.getString())){
			curf.setValue("3");
		}
		return super.match(curRecord, dbRecord);
	}
	 
}
