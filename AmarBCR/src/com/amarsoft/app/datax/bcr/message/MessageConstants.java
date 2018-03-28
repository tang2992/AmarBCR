package com.amarsoft.app.datax.bcr.message;


public class MessageConstants
{

	public static final String SET_TYPE_CUSTOMER_INFO = "11";
	public static final String SET_TYPE_BUSINESS_INFO = "12";
	public static final String SET_TYPE_ASSETS_SAVING = "14";
	public static final String SET_TYPE_FEEDBACK = "50";
	public static final String SET_TYPE_BATCH_DELETE = "31";
	public static final String SET_TYPE_BATCH_DELETE_RESULT = "35";
	public static final String SET_TYPE_LOANCARD_INQUIRE = "21";
	public static final String SET_TYPE_LOANCARD_INQUIRE_RESULT = "22";
	public static final String SET_TYPE_ORGANIZATION_INFO = "51";
	public static final String SET_TYPE_DELETE_ORGANIZATION = "32";
	public static final String SET_TYPE_FEEDBACK_ORGANIZATION = "36";
	public static final int SET_DATA_TYPE_NORMAL = 1;
	public static final int SET_DATA_TYPE_RETRY = 2;
	public static final int SET_DIRECTION_ORIGIN = 0;
	public static final int SET_DIRECTION_RESPONSE = 1;
	public static final int MESSAGE_TYPE_UNKNOWN = 0;
	public static final int MESSAGE_TYPE_CUSTOMER_BASE = 1;
	public static final int MESSAGE_TYPE_CUSTOMER_CAPTIAL = 2;
	public static final int MESSAGE_TYPE_CUSTOMER_FINANCE = 3;
	public static final int MESSAGE_TYPE_CUSTOMER_ATTENTION = 4;
	public static final int MESSAGE_TYPE_LOAN = 11;
	public static final int MESSAGE_TYPE_FACTORING = 12;
	public static final int MESSAGE_TYPE_BILL_DISCOUNT = 13;
	public static final int MESSAGE_TYPE_TRADE_FINANCES = 14;
	public static final int MESSAGE_TYPE_LETTER_OF_CREDIT = 15;
	public static final int MESSAGE_TYPE_LETTER_OF_GUARANTEE = 16;
	public static final int MESSAGE_TYPE_BANK_ACCEPTANCE = 17;
	public static final int MESSAGE_TYPE_PUBLICLY_GIVE = 18;
	public static final int MESSAGE_TYPE_GUARANTEE_INFO = 19;
	public static final int MESSAGE_TYPE_ADVANCE_PAY = 20;
	public static final int MESSAGE_TYPE_LACK_OF_INTEREST = 21;
	public static final int MESSAGE_TYPE_ASSETS_SAVING = 61;
	public static final int MESSAGE_TYPE_LOANCARD_INQUIRE = 41;
	public static final int MESSAGE_TYPE_LOANCARD_INQUIRE_RESULT = 42;
	public static final int MESSAGE_TYPE_BUSINESS_RESPONSE = 50;
	public static final int MESSAGE_TYPE_BATCH_DELETE = 51;
	public static final int MESSAGE_TYPE_BATCH_DELETE_RESPONSE = 52;
	public static final int MESSAGE_TYPE_ORGANIZATION_INFO = 7;
	public static final int MESSAGE_TYPE_ORGANIZATION_FAMILYMEMBER = 8;
	public static final int MESSAGE_TYPE_DELETE_ORGANIZATION = 32;
	public static final int MESSAGE_TYPE_DELETE_FAMILYMEMBER = 33;
	public static final int MESSAGE_TYPE_FEEDBACK_ORGANIZATION = 36;
	public static final int MESSAGE_TYPE_FEEDBACK_ORGANDELETE = 37;
	public static final int RECORD_TYPE_CUSTOMER_INFO = 1;
	public static final int RECORD_TYPE_CUSTOMER_CAPITALINFO = 2;
	public static final int RECORD_TYPE_FINANCE_REP_1_INFO = 3;
	public static final int RECORD_TYPE_FINANCE_REP_2_INFO = 4;
	public static final int RECORD_TYPE_FINANCE_REP_3_INFO = 5;
	public static final int RECORD_TYPE_FINANCE_REP_4_INFO = 43;
	public static final int RECORD_TYPE_FINANCE_REP_5_INFO = 44;
	public static final int RECORD_TYPE_FINANCE_REP_6_INFO = 45;
	public static final int RECORD_TYPE_FINANCE_REP_7_INFO = 46;
	public static final int RECORD_TYPE_FINANCE_REP_8_INFO = 47;
	public static final int RECORD_TYPE_CUSTOMER_LAW = 6;
	public static final int RECORD_TYPE_CUSTOMER_FACT = 7;
	public static final int RECORD_TYPE_LOAN_CONTRACT = 8;
	public static final int RECORD_TYPE_LOAN_DUEBILL = 9;
	public static final int RECORD_TYPE_LOAN_RETURN = 10;
	public static final int RECORD_TYPE_LOAN_EXTENSION = 11;
	public static final int RECORD_TYPE_FACORING_INFO = 12;
	public static final int RECORD_TYPE_DISCOUNT_INFO = 13;
	public static final int RECORD_TYPE_FINANCING_CONTRACT = 14;
	public static final int RECORD_TYPE_FINANCING_DUEBILL = 15;
	public static final int RECORD_TYPE_FINANCING_RETURN = 16;
	public static final int RECORD_TYPE_FINANCING_EXTENSION = 17;
	public static final int RECORD_TYPE_CREDITLETTER_INFO = 18;
	public static final int RECORD_TYPE_GUARANTEEBILL_INFO = 19;
	public static final int RECORD_TYPE_ACCEPTANCE_INFO = 20;
	public static final int RECORD_TYPE_PUBLIC_CREDIT_INFO = 21;
	public static final int RECORD_TYPE_ASSURE_CONTRACT = 22;
	public static final int RECORD_TYPE_GUARANTY_CONTRACT = 23;
	public static final int RECORD_TYPE_IMPAWN_CONTRACT = 24;
	public static final int RECORD_TYPE_ASSURE_CONTRACT_FOR_NATURALPERSON = 32;
	public static final int RECORD_TYPE_GUARANTY_CONTRACT_FOR_NATURALPERSON = 33;
	public static final int RECORD_TYPE_IMPAWN_CONTRACT_FOR_NATURALPERSON = 34;
	public static final int RECORD_TYPE_FLOOR_FOUND = 25;
	public static final int RECORD_TYPE_BACK_INTEREST = 26;
	public static final int RECORD_TYPE_CAPITAL_DEAL = 51;
	public static final int RECORD_TYPE_LOANCARD_INQUIRE = 8001;
	public static final int RECORD_TYPE_LOANCARD_INQUIRE_RESULT = 8002;
	public static final int RECORD_TYPE_FEEDBACK = 8003;
	public static final int RECORD_TYPE_BATCH_DELETE = 8004;
	public static final int RECORD_TYPE_BATCH_DELETE_RESULT = 8005;
	public static final int RECORD_TYPE_ORGANIZATION_INFO = 71;
	public static final int RECORD_TYPE_ORGANIZATION_FAMILYMEMBER = 72;
	public static final int RECORD_TYPE_DELETE_ORGANIZATION = 73;
	public static final int RECORD_TYPE_DELETE_FAMILYMEMBER = 74;
	public static final int RECORD_TYPE_FEEDBACK_ORGANIZATION = 75;
	public static final int RECORD_TYPE_FEEDBACK_ORGANDELETE = 76;
	public static final int RECORD_TYPE_FEEDBACK_FAMILY = 77;
	public static final int RECORD_TYPE_FEEDBACK_FAMILYDELETE = 78;
	public static final byte FIELD_DATA_TYPE_CHAR = 1;
	public static final byte FIELD_DATA_TYPE_INT = 2;
	public static final byte FIELD_DATA_TYPE_DOUBLE = 3;
	public static final byte FIELD_DATA_TYPE_DATE = 4;
	public static final byte FIELD_DATA_TYPE_DATETIME = 5;
	public static final byte FIELD_DATA_OPERATION_TYPE_NEW = 1;
	public static final byte FIELD_DATA_OPERATION_TYPE_CHANGE = 2;
	public static final byte FIELD_DATA_OPERATION_TYPE_UPDATE = 3;
	public static final byte FIELD_DATA_OPERATION_TYPE_DELETE = 4;
	public static final String FIELD_DATA_CURRENCY_RMB = "rmb";
	public static final String BIZID_CHANGE_FINANCEID = "1";
	public static final String BIZID_CHANGE_CONTRACTNO = "2";
	public static final String BIZID_CHANGE_DUEBILLNO = "3";
	public static final String RECORD_INCREMENTFLAG_NEW = "1";
	public static final String RECORD_INCREMENTFLAG_UPDATE = "2";
	public static final String RECORD_INCREMENTFLAG_MODIFY = "3";
	public static final String RECORD_INCREMENTFLAG_DELETE = "4";
	public static final String RECORD_INCREMENTFLAG_TRANSFERED = "8";
	public static final String RECORD_INCREMENTFLAG_CLOSED = "6";
	public static final String RECORD_INCREMENTFLAG_LOADED = "9";
	public static final String 记录状态_草稿 = "0";
	public static final String 记录状态_确定 = "10";
	public static final String 记录状态_复核通过 = "20";
	public static final String 记录状态_复核退回 = "15";
	public static final String 记录状态_请求上报 = "30";
	public static final String 记录状态_请求通过 = "40";
	public static final String 记录状态_请求拒绝 = "35";
	public static final String 记录状态_上报完成 = "50";
	public static final String 记录状态_入库完成 = "60";
	public static final String 记录状态_入库失败 = "55";
	public static final String FIELD_DATA_RECORD_TRACK_SERIAL_NO = "00000000000000000000";
	public static final String SEGMENT_DATA_SEGMENT_FLAG_A = "A";
	public static final String SEGMENT_DATA_SEGMENT_FLAG_Z = "Z";
	public static final String SEGMENT_DATA_SEGMENT_FLAG_BASE = "B";
	public static final String SEGMENT_DATA_SEGMENT_FLAG_CHANGESE = "C";
	public static final String SEGMENT_DATA_SEGMENT_FLAG_D = "D";
	public static final String SEGMENT_DATA_SEGMENT_FLAG_E = "E";
	public static final String SEGMENT_DATA_SEGMENT_FLAG_F = "F";
	public static final String SEGMENT_DATA_SEGMENT_FLAG_G = "G";
	public static final String SEGMENT_DATA_SEGMENT_FLAG_H = "H";
	public static final String SEGMENT_DATA_SEGMENT_FLAG_I = "I";
	public static final byte FIELD_TYPE_N = 0;
	public static final byte FIELD_TYPE_AN = 1;
	public static final byte FIELD_TYPE_ANC = 2;
	public static final String FIELD_TYPE_M = "M";
	public static final String FIELD_TYPE_C = "C";
	public static final String FIELD_TYPE_O = "O";
	public static final String MESSAGE_RULE_TYPE_DATE = "D";
	public static final String MESSAGE_RULE_TYPE_NUMBER = "N";
	public static final String MESSAGE_RULE_TYPE_DATE_LIST = "DL";
	public static final String MESSAGE_RULE_TYPE_DATE_EQUAL = "DE";
	public static final String MESSAGE_RULE_TYPE_DATE_RANGE = "DR";
	public static final String MESSAGE_RULE_TYPE_DATE_RANGE_NOT_EQUALS = "DRNE";
	public static final String MESSAGE_RULE_TYPE_DATE_NULL = "NA";
	public static final String MESSAGE_RULE_TYPE_ID = "ID";
	public static final String MESSAGE_RULE_TYPE_SEGMENT_COUNT = "SN";
	public static final String MESSAGE_RULE_TYPE_SEGMENT_REPEAT = "SD";
	public static final String MESSAGE_RULE_TYPE_SEGMENT_POSITION = "SP";
	public static final String MESSAGE_RULE_TYPE_CHAR = "S";
	public static final String MESSAGE_RULE_TYPE_DATA_LENGTH = "DS";
	public static final String MESSAGE_RULE_TYPE_ORG_CODE = "ZD";
	public static final String MESSAGE_RULE_TYPE_DATA_VALUE_LARGE = "DVL";
	public static final String MESSAGE_RULE_TYPE_POST_CODE = "PC";
	public static final String MESSAGE_RULE_TYPE_DKK = "DKK";
	public static final String MESSAGE_RULE_TYPE_FI = "FI";
	public static final String MESSAGE_RULE_TYPE_DC = "DC";
	public static final String MESSAGE_RULE_TYPE_MONEY = "M";
	public static final String MESSAGE_RULE_TYPE_AN = "AN";
	public static final String MESSAGE_RULE_TYPE_ANC = "ANC";
	public static final String MESSAGE_RULE_TYPE_EMAIL = "EMAIL";
	public static final String MESSAGE_RULE_TYPE_DIC = "DIC";
	public static final String MESSAGE_RULE_TYPE_DJ = "DJ";
	public static final String MESSAGE_RULE_TYPE_AP = "AP";
	public static final String MESSAGE_RULE_TYPE_CT = "CT";
	public static final String MESSAGE_RULE_TYPE_LR = "LR";
	public static final String DATE_FORMAT_AMARSOFT = "yyyy/MM/dd";
	public static final String DATE_FORMAT_ECRSHORT = "yy/MM/dd";
	public static final String DATE_FORMAT_ECRLONG = "yyyyMMdd";
	public static final String 删除业务种类_贷款 = "01";
	public static final String 删除业务种类_保理 = "02";
	public static final String 删除业务种类_贴现 = "03";
	public static final String 删除业务种类_贸易融资 = "04";
	public static final String 删除业务种类_信用证 = "05";
	public static final String 删除业务种类_保函 = "06";
	public static final String 删除业务种类_承兑汇票 = "07";
	public static final String 删除业务种类_公开授信 = "08";
	public static final String 删除业务种类_垫款 = "09";
	public static final String 删除业务种类_欠息 = "10";
	public static final String 信贷业务种类_贷款 = "1";
	public static final String 信贷业务种类_保理 = "2";
	public static final String 信贷业务种类_贴现 = "3";
	public static final String 信贷业务种类_贸易融资 = "4";
	public static final String 信贷业务种类_信用证 = "5";
	public static final String 信贷业务种类_保函 = "6";
	public static final String 信贷业务种类_承兑汇票 = "7";
	public static final String 信贷业务种类_公开授信 = "8";
	public static final String ECR_BOOLEAN_YES = "1";
	public static final String ECR_BOOLEAN_NO = "2";
	public static final String RESCIND_MAXGUARANTY_SPLIT = "┄";
	public static final String RESCIND_MAXGUARANTY_LOANCARDNO = "0000000000000000";
	public static final String RESCIND_MAXGUARANTY_CONTRACTNO = "QBZHT";

	public MessageConstants()
	{
	}

	public static final String getMessageName(int messageType)
	{
		String messName = null;
		switch (messageType)
		{
		case 1: // '\001'
			messName = "借款人概况";
			break;

		case 2: // '\002'
			messName = "借款人资本构成";
			break;

		case 3: // '\003'
			messName = "借款人财务报表";
			break;

		case 4: // '\004'
			messName = "借款人关注信息";
			break;

		case 11: // '\013'
			messName = "贷款业务";
			break;

		case 12: // '\f'
			messName = "保理业务";
			break;

		case 13: // '\r'
			messName = "票据贴现";
			break;

		case 14: // '\016'
			messName = "贸易融资";
			break;

		case 15: // '\017'
			messName = "信用证业务";
			break;

		case 16: // '\020'
			messName = "保函业务";
			break;

		case 17: // '\021'
			messName = "银行承兑汇票";
			break;

		case 18: // '\022'
			messName = "公开授信";
			break;

		case 19: // '\023'
			messName = "担保信息";
			break;

		case 20: // '\024'
			messName = "垫款信息";
			break;

		case 21: // '\025'
			messName = "欠息信息";
			break;

		case 61: // '='
			messName = "资产保全剥离";
			break;

		case 41: // ')'
			messName = "贷款卡数据批量下载请求";
			break;

		case 42: // '*'
			messName = "贷款卡数据批量下载结果";
			break;

		case 50: // '2'
			messName = "反馈";
			break;

		case 51: // '3'
			messName = "批量信贷业务数据删除请求";
			break;

		case 52: // '4'
			messName = "批量信贷业务数据删除结果";
			break;

		case 7: // '\007'
			messName = "机构基本信息";
			break;

		case 8: // '\b'
			messName = "机构家族成员信息";
			break;

		case 32: // ' '
			messName = "机构基本信息删除请求";
			break;

		case 33: // '!'
			messName = "家庭成员信息删除请求";
			break;

		case 5: // '\005'
		case 6: // '\006'
		case 9: // '\t'
		case 10: // '\n'
		case 22: // '\026'
		case 23: // '\027'
		case 24: // '\030'
		case 25: // '\031'
		case 26: // '\032'
		case 27: // '\033'
		case 28: // '\034'
		case 29: // '\035'
		case 30: // '\036'
		case 31: // '\037'
		case 34: // '"'
		case 35: // '#'
		case 36: // '$'
		case 37: // '%'
		case 38: // '&'
		case 39: // '\''
		case 40: // '('
		case 43: // '+'
		case 44: // ','
		case 45: // '-'
		case 46: // '.'
		case 47: // '/'
		case 48: // '0'
		case 49: // '1'
		case 53: // '5'
		case 54: // '6'
		case 55: // '7'
		case 56: // '8'
		case 57: // '9'
		case 58: // ':'
		case 59: // ';'
		case 60: // '<'
		default:
			messName = "未知";
			break;
		}
		return messName;
	}

	public static final String getIncrementFlagDescribe(String incrementFlag)
	{
		String oper = "其他";
		if (incrementFlag.equals("1"))
			oper = "新增";
		else
		if (incrementFlag.equals("2"))
			oper = "变更";
		else
		if (incrementFlag.equals("3"))
			oper = "修改";
		else
		if (incrementFlag.equals("4"))
			oper = "删除";
		else
		if (incrementFlag.equals("8"))
			oper = "迁移";
		else
		if (incrementFlag.equals("9"))
			oper = "入库";
		return oper;
	}

	public static final String getRecordOprateDescribe(String incrementFlag)
	{
		return getIncrementFlagDescribe(incrementFlag);
	}
}
