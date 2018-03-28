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
   LOANCARDNO varchar(40) NOT NULL,
   CUSTOMERNAME varchar(80),
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
   STATUS varchar(2),
   CORPID varchar(20),
   OCCURDATE varchar(10),
   OLDFINANCEID varchar(59),
   INCREMENTFLAG varchar(1),
   PRIMARY KEY (LOANCARDNO) CONSTRAINT PK_ECR_ALSDATACHECK 
)
;
CREATE TABLE TEMP_CUSTOMERINFO
(
   CUSTOMERID varchar(40) NOT NULL,
   COUNTRYCODE varchar(3),
   CHINANAME varchar(80),
   FOREIGNNAME varchar(80),
   ORGANIZATIONCODE varchar(10),
   SETUPDATE varchar(10),
   REGISTTYPE varchar(3),
   REGISTDATE varchar(10),
   REGISTENDDATE varchar(10),
   COUNTRYTAXNO varchar(20),
   LOCATIONTAXNO varchar(20),
   ATTRIBUTE varchar(2),
   INDUSTRYTYPE varchar(5),
   EMPLOYEENUMBER decimal(7),
   REGIONCODE varchar(6),
   CUSTOMERCHARACTER varchar(1),
   TEL varchar(35),
   ADDR varchar(80),
   FAX varchar(35),
   EMAIL varchar(30),
   WEBSITE varchar(30),
   ADDRESS varchar(80),
   POSTNO varchar(6),
   MAINPRODUCT varchar(100),
   LOCALEAREA decimal(8),
   LOCALEDROIT varchar(1),
   GROUPFLAG varchar(1),
   INOUTFLAG varchar(1),
   MARKETFLAG varchar(1),
   FINANCECONTACT varchar(35),
   REGISTNO varchar(20),
   OCCURDATE varchar(10),
   OLDFINANCEID varchar(59),
   FINANCEID varchar(11),
   LOANCARDNO varchar(16),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   PRIMARY KEY (CUSTOMERID) CONSTRAINT PK_TEMP_CUSTOMERINFO
)
;

CREATE TABLE BANK_ACCEPTANCE
(
   ACONTRACTNO varchar(60),
   ACCEPTNO varchar(20) NOT NULL,
   CUSTOMERID varchar(40),
   OCCURDATE varchar(10),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   OLDFINANCEID varchar(59),
   FINANCEID varchar(11),
   CREDITNO varchar(60),
   LOANCARDNO varchar(16),
   CUSTOMERNAME varchar(80),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   GUARANTYFLAG varchar(1),
   FLOORFLAG varchar(1),
   CLASSIFY5 varchar(1),
   CURRENCY varchar(3),
   ACCEPDATE varchar(10),
   ACCEPSUM decimal(24,6),
   ACCEPENDDATE varchar(10),
   ACCEPPAYDATE varchar(10),
   ASSURESCALE decimal(3,0),
   DRAFTSTATUS varchar(1),
   PRIMARY KEY (ACCEPTNO) CONSTRAINT PK_BANK_ACCEPTANCE
)
;

CREATE TABLE BANK_ASSURECONT
(
   CONTRACTNO varchar(60) NOT NULL,
   ASSURECONTNO varchar(60) NOT NULL,
   BUSINESSTYPE varchar(1),
   ASSURERNAME varchar(80),
   ALOANCARDNO varchar(16) NOT NULL,
   OCCURDATE varchar(10),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   CUSTOMERID varchar(40),
   ASSURECURRENCY varchar(3),
   ASSURESUM decimal(24,6),
   CREATEDATE varchar(10),
   ASSUREFORM varchar(1),
   AVAILABSTATUS varchar(1),
   CERTTYPE varchar(20),
   CERTID varchar(20),
   REPORTTYPE varchar(20),
   PRIMARY KEY (CONTRACTNO,ASSURECONTNO) CONSTRAINT PK_BANK_ASSURECONT 
)
;

CREATE TABLE BANK_CREDITLETTER
(
   CREDITLETTERNO varchar(60)  NOT NULL,    
   CUSTOMERID varchar(40),
   OCCURDATE varchar(10),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   OLDFINANCEID varchar(59),
   FINANCEID varchar(11),
   CREDITNO varchar(60),
   LOANCARDNO varchar(16),
   CUSTOMERNAME varchar(80),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   GUARANTYFLAG varchar(1),
   FLOORFLAG varchar(1),
   CLASSIFY5 varchar(1),
   CURRENCY varchar(3),
   CREATESUM decimal(24,6),
   CREATEDATE varchar(10),
   AVAILABTERM varchar(10),
   PAYTERM varchar(1),
   DEPOSITSCALE decimal(3),
   CREDITSTATUS varchar(1),
   LOGOUTDATE varchar(10),
   BALANCE decimal(24,6),
   BALANCEREPORTDATE varchar(10),
   PRIMARY KEY (CREDITLETTERNO) CONSTRAINT PK_BANK_CREDITLETTER
)
;

CREATE TABLE BANK_CUSTOMERCREDIT
(
   CCONTRACTNO varchar(60) NOT NULL,
   CUSTOMERID varchar(40),
   OCCURDATE varchar(10),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   OLDFINANCEID varchar(59),
   FINANCEID varchar(11),
   CREDITNO varchar(60),
   LOANCARDNO varchar(16),
   CUSTOMERNAME varchar(80),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   CURRENCY varchar(3),
   CREDITLIMIT decimal(24,6),
   CREDITSTARTDATE varchar(10),
   CREDITENDDATE varchar(10),
   CREDITLOGOUTDATE varchar(10),
   CREDITLOGOUTCAUSE varchar(2),
   PRIMARY KEY (CCONTRACTNO) CONSTRAINT PK_BANK_CUSTOMERCREDIT
)
;

CREATE TABLE BANK_CUSTOMERINFO
(
   CHINANAME varchar(80),
   ORGANIZATIONCODE varchar(20),
   LOANCARDNO varchar(16) NOT NULL,
   STATUS varchar(1),
   PRIMARY KEY (LOANCARDNO) CONSTRAINT PK_BANK_CUSTOMERINFO
)
;

CREATE TABLE BANK_DISCOUNT
(
   BILLNO varchar(60) NOT NULL,
   CUSTOMERID varchar(40),
   OCCURDATE varchar(10),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   OLDFINANCEID varchar(59),
   FINANCEID varchar(11),
   CREDITNO varchar(60),
   LOANCARDNO varchar(16),
   CUSTOMERNAME varchar(80),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   CLASSIFY4 varchar(2),
   CLASSIFY5 varchar(1),
   BILLTYPE varchar(1),
   ACCEPTERNAME varchar(80),
   ALOANCARDNO varchar(16),
   CURRENCY varchar(3),
   DISCOUNTSUM decimal(24,6),
   DISCOUNTDATE varchar(10),
   ACCEPTMATURITY varchar(10),
   BILLSUM decimal(24,6),
   BILLSTATUS varchar(1),
   PRIMARY KEY (BILLNO) CONSTRAINT PK_BANK_DISCOUNT
)
;

CREATE TABLE BANK_FACTORING
(
   FACTORINGNO varchar(40) NOT NULL,
   CUSTOMERID varchar(40),
   OCCURDATE varchar(10),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   OLDFINANCEID varchar(59),
   FINANCEID varchar(11),
   CREDITNO varchar(60),
   LOANCARDNO varchar(16),
   CUSTOMERNAME varchar(80),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   CLASSIFY4 varchar(2),
   CLASSIFY5 varchar(1),
   FACTORINGTYPE varchar(1),
   FACTORINGSTATUS varchar(1),
   CURRENCY varchar(3),
   BUSINESSSUM decimal(24,6),
   BUSINESSDATE varchar(10),
   BALANCE decimal(24,6),
   BALANCECHANGEDATE varchar(10),
   GUARANTYFLAG varchar(1),
   FLOORFLAG varchar(1),
   PRIMARY KEY (FACTORINGNO) CONSTRAINT PK_BANK_FACTORING
)
;

CREATE TABLE BANK_FINADUEBILL
(
   FDUEBILLNO varchar(40) NOT NULL,
   FCONTRACTNO varchar(40),
   OCCURDATE varchar(10),
   CURRENCY varchar(3),
   PUTOUTAMOUNT decimal(24,6),
   BALANCE decimal(24,6),
   PUTOUTDATE varchar(10),
   PUTOUTENDDATE varchar(10),
   BUSINESSTYPE varchar(2),
   KIND varchar(2),
   EXTENFLAG varchar(1),
   CLASSIFY4 varchar(2),
   CLASSIFY5 varchar(1),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   RETURNMODE varchar(2),
   PRIMARY KEY (FDUEBILLNO) CONSTRAINT PK_BANK_FINADUEBILL
)
;

CREATE TABLE BANK_FINAINFO
(
   FCONTRACTNO varchar(60) NOT NULL,
   CUSTOMERID varchar(40),
   OCCURDATE varchar(10),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   OLDFINANCEID varchar(59),
   FINANCEID varchar(11),
   CREDITNO varchar(60),
   LOANCARDNO varchar(16),
   CUSTOMERNAME varchar(80),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   STARTDATE varchar(10),
   ENDDATE varchar(10),
   BANKFLAG varchar(1),
   GUARANTYFLAG varchar(1),
   AVAILABSTATUS varchar(1),
   CURRENCY varchar(3),
   BUSINESSSUM decimal(24,6),
   AVAILABBALANCE decimal(24,6),
   RECYCLE varchar(1),
   PRIMARY KEY (FCONTRACTNO) CONSTRAINT PK_BANK_FINAINFO
)
;

CREATE TABLE BANK_FLOORFUND
(
   FLOORFUNDNO varchar(60) NOT NULL,
   CUSTOMERID varchar(40),
   OCCURDATE varchar(10),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   OLDFINANCEID varchar(59),
   FINANCEID varchar(11),
   CREDITNO varchar(60),
   LOANCARDNO varchar(16),
   CUSTOMERNAME varchar(80),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   CLASSIFY4 varchar(2),
   CLASSIFY5 varchar(1),
   FLOORTYPE varchar(1),
   BUSINESSNO varchar(60),
   CURRENCY varchar(3),
   FLOORSUM decimal(24,6),
   FLOORDATE varchar(10),
   FLOORBALANCE decimal(24,6),
   BALANCEOCCURDATE varchar(10),
   RETURNMODE varchar(2),
   PRIMARY KEY (FLOORFUNDNO) CONSTRAINT PK_BANK_FLOORFUND
)
;

CREATE TABLE BANK_GUARANTEEBILL
(
   GUARANTEEBILLNO varchar(60) NOT NULL,
   CUSTOMERID varchar(40),
   OCCURDATE varchar(10),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   OLDFINANCEID varchar(59),
   FINANCEID varchar(11),
   CREDITNO varchar(60),
   LOANCARDNO varchar(16),
   CUSTOMERNAME varchar(80),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   GUARANTYFLAG varchar(1),
   FLOORFLAG varchar(1),
   CLASSIFY5 varchar(1),
   GUARANTEETYPE varchar(1),
   GUARANTEESTATUS varchar(1),
   CURRENCY varchar(3),
   GUARANTEESUM decimal(24,6),
   CREATEDATE varchar(10),
   ENDDATE varchar(10),
   DEPOSITSCALE decimal(3,0),
   BALANCE decimal(24,6),
   BALANCEOCCURDATE varchar(10),
   PRIMARY KEY (GUARANTEEBILLNO) CONSTRAINT PK_BANK_GUARANTEEBILL
)
;

CREATE TABLE BANK_GUARANTYCONT
(
   CONTRACTNO varchar(60) NOT NULL,
   GUARANTYCONTNO varchar(60) NOT NULL,
   GUARANTYSERIALNO varchar(40) NOT NULL,
   OCCURDATE varchar(10),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   CUSTOMERID varchar(40),
   GUARANTYNO varchar(2),
   BUSINESSTYPE varchar(1),
   PLEDGORNAME varchar(80),
   GLOANCARDNO varchar(16),
   EVALUATECURRENCY varchar(3),
   EVALUATESUM decimal(24,6),
   EVALUATEDATE varchar(10),
   EVALUATEOFFICE varchar(80),
   EVALUATEOFFICEID varchar(10),
   GUARANTYTYPE varchar(1),
   CREATEDATE varchar(10),
   GUARANTYCURRENCY varchar(3),
   GUARANTYSUM decimal(24,6),
   REGISTORGNAME varchar(80),
   REGISTDATE varchar(10),
   GUARANTYEXPLAIN char(400),
   AVAILABSTATUS varchar(1),
   CERTTYPE varchar(20),
   CERTID varchar(20),
   REPORTTYPE varchar(20),
    PRIMARY KEY (CONTRACTNO,GUARANTYCONTNO,GUARANTYSERIALNO) CONSTRAINT PK_BANK_GUARANTYCONT
)
;

CREATE TABLE BANK_IMPAWNCONT
(
   CONTRACTNO varchar(60) NOT NULL,
   IMPAWNCONTNO varchar(60) NOT NULL,
   IMPAWSERIALNO varchar(60) NOT NULL,
   OCCURDATE varchar(10),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   CUSTOMERID varchar(40),
   IMPAWNO varchar(2),
   BUSINESSTYPE varchar(1),
   IMPAWNNAME varchar(80),
   ILOANCARDNO varchar(16),
   VALUECURRENCY varchar(3),
   VALUESUM decimal(24,6),
   CREATEDATE varchar(10),
   IMPAWNTYPE varchar(1),
   IMPAWNCURRENCY varchar(3),
   IMPAWNSUM decimal(24,6),
   AVAILABSTATUS varchar(1),
   CERTTYPE varchar(20),
   CERTID varchar(20),
   REPORTTYPE varchar(20),
    PRIMARY KEY (CONTRACTNO,IMPAWNCONTNO,IMPAWSERIALNO) CONSTRAINT PK_BANK_IMPAWNCONT
)
;

CREATE TABLE BANK_INTERESTDUE
(
   CUSTOMERID varchar(40) NOT NULL,
   INTERESTTYPE varchar(1) NOT NULL,
   CURRENCY varchar(3) NOT NULL,
   OCCURDATE varchar(10),
   OLDFINANCEID varchar(59),
   FINANCEID varchar(11) NOT NULL,
   LOANCARDNO varchar(16),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   INTERESTBALANCE decimal(24,6),
   CHANGEDATE varchar(10),
    PRIMARY KEY (CUSTOMERID,INTERESTTYPE,CURRENCY,FINANCEID) CONSTRAINT PK_BANK_INTERESTDUE
)
;

CREATE TABLE BANK_LOANCONTRACT
(
   LCONTRACTNO varchar(60) NOT NULL,
   CUSTOMERID varchar(40),
   OCCURDATE varchar(10),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   OLDFINANCEID varchar(59),
   FINANCEID varchar(11),
   CREDITNO varchar(60),
   LOANCARDNO varchar(16),
   CUSTOMERNAME varchar(80),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   STARTDATE varchar(10),
   ENDDATE varchar(10),
   BANKFLAG varchar(1),
   GUARANTYFLAG varchar(1),
   AVAILABSTATUS varchar(1),
   CURRENCY varchar(3),
   BUSINESSSUM decimal(24,6),
   AVAILABBALANCE decimal(24,6),
   RECYCLE varchar(1),
    PRIMARY KEY (LCONTRACTNO) CONSTRAINT PK_BANK_LOANCONTRACT
)
;

CREATE TABLE BANK_LOANDUEBILL
(
   LDUEBILLNO varchar(60) NOT NULL,
   LCONTRACTNO varchar(60),
   OCCURDATE varchar(10),
   CURRENCY varchar(3),
   PUTOUTAMOUNT decimal(24,6),
   RETURNMODE varchar(2),
   BALANCE decimal(24,6),
   PUTOUTDATE varchar(10),
   PUTOUTENDDATE varchar(10),
   BUSINESSTYPE varchar(2),
   FORM varchar(1),
   LOANCHARACTER varchar(1),
   WAY varchar(5),
   KIND varchar(2),
   EXTENFLAG varchar(1),
   CLASSIFY4 varchar(2),
   CLASSIFY5 varchar(1),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   PRIMARY KEY (LDUEBILLNO) CONSTRAINT PK_BANK_LOANDUEBILL
)
;

