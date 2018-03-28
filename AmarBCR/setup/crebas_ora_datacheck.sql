DROP TABLE BANK_ACCEPTANCE;
DROP TABLE BANK_ASSURECONT;
DROP TABLE BANK_CREDITLETTER;
DROP TABLE BANK_CUSTOMERCREDIT;
DROP TABLE BANK_CUSTOMERINFO;
DROP TABLE BANK_DISCOUNT;
DROP TABLE BANK_FACTORING;
DROP TABLE BANK_FINADUEBILL;
DROP TABLE BANK_FINAINFO;
DROP TABLE BANK_FLOORFUND;
DROP TABLE BANK_GUARANTEEBILL;
DROP TABLE BANK_GUARANTYCONT;
DROP TABLE BANK_IMPAWNCONT;
DROP TABLE BANK_INTERESTDUE;
DROP TABLE BANK_LOANCONTRACT;
DROP TABLE BANK_LOANDUEBILL;
DROP TABLE TEMP_CUSTOMERINFO;
DROP TABLE ECR_ALSDATACHECK;

CREATE TABLE ECR_ALSDATACHECK
(
   LOANCARDNO varchar2(40) PRIMARY KEY NOT NULL,
   CUSTOMERNAME varchar2(80),
   LOANCONTRACTNUM decimal(22,0),
   LOANDUEBILLNUM decimal(22,0),
   FACTORINGNUM decimal(22,0),
   DISCOUNTNUM decimal(22,0),
   FINAINFONUM decimal(22,0),
   FINADUEBILLNUM decimal(22,0),
   CREDITLETTERNUM decimal(22,0),
   GUARANTEEBILLNUM decimal(22,0),
   ACCEPTNUM decimal(22,0),
   CUSTOMERCREDITNUM decimal(22,0),
   ASSURECONTNUM decimal(22,0),
   GUARANTYCONTNUM decimal(22,0),
   IMPAWNCONTNUM decimal(22,0),
   FLOORFUNDNUM decimal(22,0),
   LOANSUM decimal(24,6),
   FACTORINGOUTSUM decimal(24,6),
   DISCOUNTOUTSUM decimal(24,6),
   FINAOUTSUM decimal(24,6),
   CREDITLETTEROUTSUM decimal(24,6),
   GUARANTEEBILLOUTSUM decimal(24,6),
   ACCEPTOUTSUM decimal(24,6),
   CUSTOMERCREDITOUTSUM decimal(24,6),
   ASSURECONTOUTSUM decimal(24,6),
   GUARANTYCONTOUTSUM decimal(24,6),
   IMPAWNCONTOUTSUM decimal(24,6),
   FLOORFUNDOUTSUM decimal(24,6),
   LOANBALANCE decimal(24,6),
   FACTORINGBALANCE decimal(24,6),
   DISCOUNTBALANCE decimal(24,6),
   FINABALANCE decimal(24,6),
   CREDITLETTERBALANCE decimal(24,6),
   GUARANTEEBILLBALANCE decimal(24,6),
   ACCEPTBALANCE decimal(24,6),
   ASSURECONTBALANCE decimal(24,6),
   GUARANTYCONTBALANCE decimal(24,6),
   IMPAWNCONTBALANCE decimal(24,6),
   FLOORFUNDBALANCE decimal(24,6),
   INTERESTBALANCE1 decimal(24,6),
   INTERESTBALANCE2 decimal(24,6),
   STATUS varchar2(2),
   CORPID varchar2(20),
   OCCURDATE varchar2(10),
   OLDFINANCEID varchar2(59),
   INCREMENTFLAG varchar2(1)
)
;
CREATE TABLE TEMP_CUSTOMERINFO
(
   CUSTOMERID varchar2(40) PRIMARY KEY NOT NULL,
   COUNTRYCODE varchar2(3),
   CHINANAME varchar2(80),
   FOREIGNNAME varchar2(80),
   ORGANIZATIONCODE varchar2(10),
   SETUPDATE varchar2(10),
   REGISTTYPE varchar2(3),
   REGISTDATE varchar2(10),
   REGISTENDDATE varchar2(10),
   COUNTRYTAXNO varchar2(20),
   LOCATIONTAXNO varchar2(20),
   ATTRIBUTE varchar2(2),
   INDUSTRYTYPE varchar2(5),
   EMPLOYEENUMBER decimal(7),
   REGIONCODE varchar2(6),
   CUSTOMERCHARACTER varchar2(1),
   TEL varchar2(35),
   ADDR varchar2(80),
   FAX varchar2(35),
   EMAIL varchar2(30),
   WEBSITE varchar2(30),
   ADDRESS varchar2(80),
   POSTNO varchar2(6),
   MAINPRODUCT varchar2(100),
   LOCALEAREA decimal(8),
   LOCALEDROIT varchar2(1),
   GROUPFLAG varchar2(1),
   INOUTFLAG varchar2(1),
   MARKETFLAG varchar2(1),
   FINANCECONTACT varchar2(35),
   REGISTNO varchar2(20),
   OCCURDATE varchar2(10),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11),
   LOANCARDNO varchar2(16),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80)
)
;

CREATE TABLE BANK_ACCEPTANCE
(
   ACONTRACTNO varchar2(60),
   ACCEPTNO varchar2(20) PRIMARY KEY NOT NULL,
   CUSTOMERID varchar2(40),
   OCCURDATE varchar2(10),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11),
   CREDITNO varchar2(60),
   LOANCARDNO varchar2(16),
   CUSTOMERNAME varchar2(80),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   GUARANTYFLAG varchar2(1),
   FLOORFLAG varchar2(1),
   CLASSIFY5 varchar2(1),
   CURRENCY varchar2(3),
   ACCEPDATE varchar2(10),
   ACCEPSUM decimal(24,6),
   ACCEPENDDATE varchar2(10),
   ACCEPPAYDATE varchar2(10),
   ASSURESCALE decimal(3,0),
   DRAFTSTATUS varchar2(1)
)
;

CREATE TABLE BANK_ASSURECONT
(
   CONTRACTNO varchar2(60) NOT NULL,
   ASSURECONTNO varchar2(60) NOT NULL,
   BUSINESSTYPE varchar2(1),
   ASSURERNAME varchar2(80),
   ALOANCARDNO varchar2(16) NOT NULL,
   OCCURDATE varchar2(10),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   CUSTOMERID varchar2(40),
   ASSURECURRENCY varchar2(3),
   ASSURESUM decimal(24,6),
   CREATEDATE varchar2(10),
   ASSUREFORM varchar2(1),
   AVAILABSTATUS varchar2(1),
   CERTTYPE varchar2(20),
   CERTID varchar2(20),
   REPORTTYPE varchar2(20),
   CONSTRAINT PK_BANK_ASSURECONT PRIMARY KEY (CONTRACTNO,ASSURECONTNO)
)
;

CREATE TABLE BANK_CREDITLETTER
(
   CREDITLETTERNO varchar2(60) PRIMARY KEY NOT NULL,
   CUSTOMERID varchar2(40),
   OCCURDATE varchar2(10),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11),
   CREDITNO varchar2(60),
   LOANCARDNO varchar2(16),
   CUSTOMERNAME varchar2(80),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   GUARANTYFLAG varchar2(1),
   FLOORFLAG varchar2(1),
   CLASSIFY5 varchar2(1),
   CURRENCY varchar2(3),
   CREATESUM decimal(24,6),
   CREATEDATE varchar2(10),
   AVAILABTERM varchar2(10),
   PAYTERM varchar2(1),
   DEPOSITSCALE decimal(3),
   CREDITSTATUS varchar2(1),
   LOGOUTDATE varchar2(10),
   BALANCE decimal(24,6),
   BALANCEREPORTDATE varchar2(10)
)
;

CREATE TABLE BANK_CUSTOMERCREDIT
(
   CCONTRACTNO varchar2(60) PRIMARY KEY NOT NULL,
   CUSTOMERID varchar2(40),
   OCCURDATE varchar2(10),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11),
   CREDITNO varchar2(60),
   LOANCARDNO varchar2(16),
   CUSTOMERNAME varchar2(80),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   CURRENCY varchar2(3),
   CREDITLIMIT decimal(24,6),
   CREDITSTARTDATE varchar2(10),
   CREDITENDDATE varchar2(10),
   CREDITLOGOUTDATE varchar2(10),
   CREDITLOGOUTCAUSE varchar2(2)
)
;

CREATE TABLE BANK_CUSTOMERINFO
(
   CHINANAME varchar2(80),
   ORGANIZATIONCODE varchar2(20),
   LOANCARDNO varchar2(16) PRIMARY KEY NOT NULL,
   STATUS varchar2(1)
)
;

CREATE TABLE BANK_DISCOUNT
(
   BILLNO varchar2(60) PRIMARY KEY NOT NULL,
   CUSTOMERID varchar2(40),
   OCCURDATE varchar2(10),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11),
   CREDITNO varchar2(60),
   LOANCARDNO varchar2(16),
   CUSTOMERNAME varchar2(80),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   CLASSIFY4 varchar2(2),
   CLASSIFY5 varchar2(1),
   BILLTYPE varchar2(1),
   ACCEPTERNAME varchar2(80),
   ALOANCARDNO varchar2(16),
   CURRENCY varchar2(3),
   DISCOUNTSUM decimal(24,6),
   DISCOUNTDATE varchar2(10),
   ACCEPTMATURITY varchar2(10),
   BILLSUM decimal(24,6),
   BILLSTATUS varchar2(1)
)
;

CREATE TABLE BANK_FACTORING
(
   FACTORINGNO varchar2(40) PRIMARY KEY NOT NULL,
   CUSTOMERID varchar2(40),
   OCCURDATE varchar2(10),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11),
   CREDITNO varchar2(60),
   LOANCARDNO varchar2(16),
   CUSTOMERNAME varchar2(80),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   CLASSIFY4 varchar2(2),
   CLASSIFY5 varchar2(1),
   FACTORINGTYPE varchar2(1),
   FACTORINGSTATUS varchar2(1),
   CURRENCY varchar2(3),
   BUSINESSSUM decimal(24,6),
   BUSINESSDATE varchar2(10),
   BALANCE decimal(24,6),
   BALANCECHANGEDATE varchar2(10),
   GUARANTYFLAG varchar2(1),
   FLOORFLAG varchar2(1)
)
;

CREATE TABLE BANK_FINADUEBILL
(
   FDUEBILLNO varchar2(40) PRIMARY KEY NOT NULL,
   FCONTRACTNO varchar2(40),
   OCCURDATE varchar2(10),
   CURRENCY varchar2(3),
   PUTOUTAMOUNT decimal(24,6),
   BALANCE decimal(24,6),
   PUTOUTDATE varchar2(10),
   PUTOUTENDDATE varchar2(10),
   BUSINESSTYPE varchar2(2),
   KIND varchar2(2),
   EXTENFLAG varchar2(1),
   CLASSIFY4 varchar2(2),
   CLASSIFY5 varchar2(1),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   RETURNMODE varchar2(2)
)
;

CREATE TABLE BANK_FINAINFO
(
   FCONTRACTNO varchar2(60) PRIMARY KEY NOT NULL,
   CUSTOMERID varchar2(40),
   OCCURDATE varchar2(10),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11),
   CREDITNO varchar2(60),
   LOANCARDNO varchar2(16),
   CUSTOMERNAME varchar2(80),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   STARTDATE varchar2(10),
   ENDDATE varchar2(10),
   BANKFLAG varchar2(1),
   GUARANTYFLAG varchar2(1),
   AVAILABSTATUS varchar2(1),
   CURRENCY varchar2(3),
   BUSINESSSUM decimal(24,6),
   AVAILABBALANCE decimal(24,6),
   RECYCLE varchar2(1)
)
;

CREATE TABLE BANK_FLOORFUND
(
   FLOORFUNDNO varchar2(60) PRIMARY KEY NOT NULL,
   CUSTOMERID varchar2(40),
   OCCURDATE varchar2(10),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11),
   CREDITNO varchar2(60),
   LOANCARDNO varchar2(16),
   CUSTOMERNAME varchar2(80),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   CLASSIFY4 varchar2(2),
   CLASSIFY5 varchar2(1),
   FLOORTYPE varchar2(1),
   BUSINESSNO varchar2(60),
   CURRENCY varchar2(3),
   FLOORSUM decimal(24,6),
   FLOORDATE varchar2(10),
   FLOORBALANCE decimal(24,6),
   BALANCEOCCURDATE varchar2(10),
   RETURNMODE varchar2(2)
)
;

CREATE TABLE BANK_GUARANTEEBILL
(
   GUARANTEEBILLNO varchar2(60) PRIMARY KEY NOT NULL,
   CUSTOMERID varchar2(40),
   OCCURDATE varchar2(10),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11),
   CREDITNO varchar2(60),
   LOANCARDNO varchar2(16),
   CUSTOMERNAME varchar2(80),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   GUARANTYFLAG varchar2(1),
   FLOORFLAG varchar2(1),
   CLASSIFY5 varchar2(1),
   GUARANTEETYPE varchar2(1),
   GUARANTEESTATUS varchar2(1),
   CURRENCY varchar2(3),
   GUARANTEESUM decimal(24,6),
   CREATEDATE varchar2(10),
   ENDDATE varchar2(10),
   DEPOSITSCALE decimal(3,0),
   BALANCE decimal(24,6),
   BALANCEOCCURDATE varchar2(10)
)
;

CREATE TABLE BANK_GUARANTYCONT
(
   CONTRACTNO varchar2(60) NOT NULL,
   GUARANTYCONTNO varchar2(60) NOT NULL,
   GUARANTYSERIALNO varchar2(40) NOT NULL,
   OCCURDATE varchar2(10),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   CUSTOMERID varchar2(40),
   GUARANTYNO varchar2(2),
   BUSINESSTYPE varchar2(1),
   PLEDGORNAME varchar2(80),
   GLOANCARDNO varchar2(16),
   EVALUATECURRENCY varchar2(3),
   EVALUATESUM decimal(24,6),
   EVALUATEDATE varchar2(10),
   EVALUATEOFFICE varchar2(80),
   EVALUATEOFFICEID varchar2(10),
   GUARANTYTYPE varchar2(1),
   CREATEDATE varchar2(10),
   GUARANTYCURRENCY varchar2(3),
   GUARANTYSUM decimal(24,6),
   REGISTORGNAME varchar2(80),
   REGISTDATE varchar2(10),
   GUARANTYEXPLAIN varchar2(400),
   AVAILABSTATUS varchar2(1),
   CERTTYPE varchar2(20),
   CERTID varchar2(20),
   REPORTTYPE varchar2(20),
   CONSTRAINT PK_BANK_GUARANTYCONT PRIMARY KEY (CONTRACTNO,GUARANTYCONTNO,GUARANTYSERIALNO)
)
;

CREATE TABLE BANK_IMPAWNCONT
(
   CONTRACTNO varchar2(60) NOT NULL,
   IMPAWNCONTNO varchar2(60) NOT NULL,
   IMPAWSERIALNO varchar2(60) NOT NULL,
   OCCURDATE varchar2(10),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   CUSTOMERID varchar2(40),
   IMPAWNO varchar2(2),
   BUSINESSTYPE varchar2(1),
   IMPAWNNAME varchar2(80),
   ILOANCARDNO varchar2(16),
   VALUECURRENCY varchar2(3),
   VALUESUM decimal(24,6),
   CREATEDATE varchar2(10),
   IMPAWNTYPE varchar2(1),
   IMPAWNCURRENCY varchar2(3),
   IMPAWNSUM decimal(24,6),
   AVAILABSTATUS varchar2(1),
   CERTTYPE varchar2(20),
   CERTID varchar2(20),
   REPORTTYPE varchar2(20),
   CONSTRAINT PK_BANK_IMPAWNCONT PRIMARY KEY (CONTRACTNO,IMPAWNCONTNO,IMPAWSERIALNO)
)
;

CREATE TABLE BANK_INTERESTDUE
(
   CUSTOMERID varchar2(40) NOT NULL,
   INTERESTTYPE varchar2(1) NOT NULL,
   CURRENCY varchar2(3) NOT NULL,
   OCCURDATE varchar2(10),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11) NOT NULL,
   LOANCARDNO varchar2(16),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   INTERESTBALANCE decimal(24,6),
   CHANGEDATE varchar2(10),
   CONSTRAINT PK_BANK_INTERESTDUE PRIMARY KEY (CUSTOMERID,INTERESTTYPE,CURRENCY,FINANCEID)
)
;

CREATE TABLE BANK_LOANCONTRACT
(
   LCONTRACTNO varchar2(60) PRIMARY KEY NOT NULL,
   CUSTOMERID varchar2(40),
   OCCURDATE varchar2(10),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11),
   CREDITNO varchar2(60),
   LOANCARDNO varchar2(16),
   CUSTOMERNAME varchar2(80),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   STARTDATE varchar2(10),
   ENDDATE varchar2(10),
   BANKFLAG varchar2(1),
   GUARANTYFLAG varchar2(1),
   AVAILABSTATUS varchar2(1),
   CURRENCY varchar2(3),
   BUSINESSSUM decimal(24,6),
   AVAILABBALANCE decimal(24,6),
   RECYCLE varchar2(1)
)
;

CREATE TABLE BANK_LOANDUEBILL
(
   LDUEBILLNO varchar2(60) PRIMARY KEY NOT NULL,
   LCONTRACTNO varchar2(60),
   OCCURDATE varchar2(10),
   CURRENCY varchar2(3),
   PUTOUTAMOUNT decimal(24,6),
   RETURNMODE varchar2(2),
   BALANCE decimal(24,6),
   PUTOUTDATE varchar2(10),
   PUTOUTENDDATE varchar2(10),
   BUSINESSTYPE varchar2(2),
   FORM varchar2(1),
   LOANCHARACTER varchar2(1),
   WAY varchar2(5),
   KIND varchar2(2),
   EXTENFLAG varchar2(1),
   CLASSIFY4 varchar2(2),
   CLASSIFY5 varchar2(1),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80)
)
;

