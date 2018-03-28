package mybank;

import com.amarsoft.app.datax.ecr.prepare.dataimport.ECRUpdateHandler;
import com.amarsoft.are.dpx.recordset.Field;
import com.amarsoft.are.dpx.recordset.Record;

public class ECRUpdateHandlerExt extends ECRUpdateHandler {

	/**
	 * ��дmatch�������Ŵ�������Ϣʱ�����㡰�ͻ����͡�
	 */
	public boolean match(Record curRecord, Record dbRecord) {
		Field curf = curRecord.getField("CustomerType");// ��ǰֵ��"2"
		Field dbf = dbRecord.getField("CustomerType");//  ������"1"/"2"/"3"/""
		if(dbf.getString()!=null&&!curf.getString().equals(dbf.getString())){
			curf.setValue("3");
		}
		return super.match(curRecord, dbRecord);
	}
	 
}
