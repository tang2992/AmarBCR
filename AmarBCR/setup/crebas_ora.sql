DROP TABLE ECR_ERRMAP;
DROP TABLE ECR_ACCEPTANCE;
DROP TABLE ECR_ASSURECONT;
DROP TABLE ECR_BATCHDEL;
DROP TABLE ECR_CODEMAP;
DROP TABLE ECR_CREDITLETTER;
DROP TABLE ECR_CUSTCAPIINFO;
DROP TABLE ECR_CUSTOMERCAPI;
DROP TABLE ECR_CUSTOMERCREDIT;
DROP TABLE ECR_CUSTOMERFACT;
DROP TABLE ECR_CUSTOMERFAMILY;
DROP TABLE ECR_CUSTOMERINFO;
DROP TABLE ECR_CUSTOMERINVEST;
DROP TABLE ECR_CUSTOMERKEEPER;
DROP TABLE ECR_CUSTOMERLAW;
DROP TABLE ECR_CUSTOMERSTOCK;
DROP TABLE ECR_DISCOUNT;
DROP TABLE ECR_ERRHISTORY;
DROP TABLE ECR_ERRRECORD;
DROP TABLE ECR_FACTORING;
DROP TABLE ECR_FEEDBACK;
DROP TABLE ECR_FINADUEBILL;
DROP TABLE ECR_FINAEXTENSION;
DROP TABLE ECR_FINAINFO;
DROP TABLE ECR_FINANCEBS;
DROP TABLE ECR_FINANCEBS_2007;
DROP TABLE ECR_FINANCEBS_IN;
DROP TABLE ECR_FINANCECF;
DROP TABLE ECR_FINANCECF_2007;
DROP TABLE ECR_FINANCEPS;
DROP TABLE ECR_FINANCEPS_2007;
DROP TABLE ECR_FINANCECF_IN;
DROP TABLE ECR_FINARETURN;
DROP TABLE ECR_FLOORFUND;
DROP TABLE ECR_GUARANTEEBILL;
DROP TABLE ECR_GUARANTYCONT;
DROP TABLE ECR_IMPAWNCONT;
DROP TABLE ECR_INTERESTDUE;
DROP TABLE ECR_LOANCARD;
DROP TABLE ECR_LOANCARDNOCHANGE;
DROP TABLE ECR_LOANCONTRACT;
DROP TABLE ECR_LOANDUEBILL;
DROP TABLE ECR_LOANEXTENSION;
DROP TABLE ECR_LOANRETURN;
DROP TABLE ECR_PREPAREDATE;
DROP TABLE ECR_PREPARESTATUS;
DROP TABLE ECR_REPORTSTATUS;
DROP TABLE ECR_RUNSTATUS;
DROP TABLE ECR_SESSION;
DROP TABLE ECR_TRANSFERFILTER;
DROP TABLE BATCH_CTRL;
DROP TABLE ECR_ASSETSDISPOSE;
DROP TABLE ECR_ORGANATTRIBUTE cascade constraints;
DROP TABLE ECR_ORGANCONTACT cascade constraints;
DROP TABLE ECR_ORGANFAMILY cascade constraints;
DROP TABLE ECR_ORGANINFO cascade constraints;
DROP TABLE ECR_ORGANKEEPER cascade constraints;
DROP TABLE ECR_ORGANRELATED cascade constraints;
DROP TABLE ECR_ORGANSTATUS cascade constraints;
DROP TABLE ECR_ORGANSTOCKHOLDER cascade constraints;
DROP TABLE ECR_ORGANSUPERIOR cascade constraints;

CREATE TABLE BATCH_CTRL
(
   BATCHDATE varchar2(10) NOT NULL,
   SERIALNO decimal(22) NOT NULL,
   TASKCODE varchar2(80),
   TARGETCODE varchar2(80),
   UNITCODE varchar2(80) NOT NULL,
   RUNDESC varchar2(120),
   SUCCESSFLAG varchar2(20),
   ERRDESC varchar2(400),
   BEGINDATE varchar2(40),
   ENDDATE varchar2(40),
   RUNTIME varchar2(20),
   FIRSTSTARTDATE varchar2(40) NOT NULL,
   LOGTYPE varchar2(20),
   CONSTRAINT PK_BCTRL PRIMARY KEY (BATCHDATE,SERIALNO)
);

CREATE TABLE ECR_ERRMAP
(
   COLNAME varchar(4) PRIMARY KEY NOT NULL,
   NOTE varchar(800)
);

CREATE TABLE ECR_ACCEPTANCE
(
   ACONTRACTNO varchar2(60) NOT NULL,
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

CREATE TABLE ECR_ASSURECONT
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
   REPORTTYPE varchar2(1),
   CONSTRAINT PK_ECR_ASSURECONT PRIMARY KEY (CONTRACTNO,ASSURECONTNO)
)
;

CREATE TABLE ECR_BATCHDEL
(
   CREATEDATE varchar2(14) NOT NULL,
   CONTRACTNO varchar2(40) NOT NULL,
   DELRESULT varchar2(1),
   LOANCARDNO varchar2(16),
   DELBUSINESSTYPE varchar2(2),
   FINANCEID varchar2(11),
   CONSTRAINT PK_ECR_BATCHDEL PRIMARY KEY (CREATEDATE,CONTRACTNO)
)
;

CREATE TABLE ECR_CODEMAP
(
   COLNAME varchar2(4) NOT NULL,
   CTCODE varchar2(20) NOT NULL,
   PBCODE varchar2(20) NOT NULL,
   NOTE varchar2(200),
   CONSTRAINT PK_ECR_CODEMAP PRIMARY KEY (COLNAME,CTCODE,PBCODE)
)
;

CREATE TABLE ECR_CREDITLETTER
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
   DEPOSITSCALE decimal(3,0),
   CREDITSTATUS varchar2(1),
   LOGOUTDATE varchar2(10),
   BALANCE decimal(24,6),
   BALANCEREPORTDATE varchar2(10)
)
;

CREATE TABLE ECR_CUSTCAPIINFO
(
   CUSTOMERID varchar2(40) PRIMARY KEY NOT NULL,
   CURRENCY varchar2(3),
   REGISTSUM decimal(24,6),
   SUPERNAME varchar2(80),
   SLOANCARDNO varchar2(16),
   SORGCODE varchar2(10),
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

CREATE TABLE ECR_CUSTOMERCAPI
(
   CUSTOMERID varchar2(40) NOT NULL,
   CAPINO varchar2(60) NOT NULL,
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   OCCURDATE varchar2(10),
   SESSIONID varchar2(10),
   CONTRIBNAME varchar2(80),
   CLOANCARDNO varchar2(16),
   CORGCODE varchar2(10),
   CREGISTNO varchar2(20),
   CERTTYPE varchar2(1),
   CERTNO varchar2(18),
   CURRENCY varchar2(3),
   CONTRIBSUM decimal(24,6),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   ERRORCODE varchar2(80),
   CONSTRAINT PK_ECR_CUSTOMERCP PRIMARY KEY (CUSTOMERID,CAPINO)
)
;

CREATE TABLE ECR_CUSTOMERCREDIT
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

CREATE TABLE ECR_CUSTOMERFACT
(
   CUSTOMERID varchar2(40) NOT NULL,
   FACTNO varchar2(60) NOT NULL,
   OCCURDATE varchar2(10),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11),
   LOANCARDNO varchar2(16),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   DESCRIBE varchar2(250),
   CUSTOMERNAME varchar2(80),
   CONSTRAINT PK_ECR_CTOMERFACT PRIMARY KEY (CUSTOMERID,FACTNO)
)
;

CREATE TABLE ECR_CUSTOMERFAMILY
(
   CUSTOMERID varchar2(40) NOT NULL,
   FAMILYCORPNO varchar2(60) NOT NULL,
   INCREMENTFLAG varchar2(1),
   OCCURDATE varchar2(10),
   SESSIONID varchar2(10),
   FAMILYNAME varchar2(30),
   CERTTYPE varchar2(1),
   CERTNO varchar2(18),
   RELATION varchar2(1),
   FAMILYCORPNAME varchar2(80),
   FLOANCARDNO varchar2(16),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   ERRORCODE varchar2(80),
   CONSTRAINT PK_ECR_CTFAMILY PRIMARY KEY (CUSTOMERID,FAMILYCORPNO)
)
;

CREATE TABLE ECR_CUSTOMERINFO
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

CREATE TABLE ECR_CUSTOMERINVEST
(
   CUSTOMERID varchar2(40) NOT NULL,
   INVESTNO varchar2(60) NOT NULL,
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   OCCURDATE varchar2(10),
   SESSIONID varchar2(10),
   INVESTCORPNAME varchar2(80),
   ILOANCARDNO varchar2(16),
   IORGCODE varchar2(10),
   CURRENCY1 varchar2(3),
   INVESTSUM1 decimal(24,6),
   CURRENCY2 varchar2(3),
   INVESTSUM2 decimal(24,6),
   CURRENCY3 varchar2(3),
   INVESTSUM3 decimal(24,6),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   ERRORCODE varchar2(80),
   CONSTRAINT PK_ECR_CUSTINVEST PRIMARY KEY (CUSTOMERID,INVESTNO)
)
;

CREATE TABLE ECR_CUSTOMERKEEPER
(
   CUSTOMERID varchar2(40) NOT NULL,
   KEEPERNO varchar2(60) NOT NULL,
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   OCCURDATE varchar2(10),
   SESSIONID varchar2(10),
   KEEPERNAME varchar2(30),
   CERTTYPE varchar2(1),
   CERTNO varchar2(18),
   KEEPERTYPE varchar2(1) NOT NULL,
   SEX varchar2(1),
   BIRTHDATE varchar2(10),
   DEGREE varchar2(2),
   JOBRESUME varchar2(500),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   ERRORCODE varchar2(80),
   CONSTRAINT PK_ECR_CUSTKEEPER PRIMARY KEY (CUSTOMERID,KEEPERNO,KEEPERTYPE)
)
;

CREATE TABLE ECR_CUSTOMERLAW
(
   CUSTOMERID varchar2(40) NOT NULL,
   LAWNO varchar2(60) NOT NULL,
   OCCURDATE varchar2(10),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11),
   LOANCARDNO varchar2(16),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   PLAINTIFFNAME varchar2(80),
   CURRENCY varchar2(3),
   EXECUTESUM decimal(24,6),
   EXECUTEDATE varchar2(10),
   EXECUTERESULT varchar2(100),
   APPELLCAUSE varchar2(300),
   CUSTOMERNAME varchar2(80),
   CONSTRAINT PK_ECR_CUSTOMERLAW PRIMARY KEY (CUSTOMERID,LAWNO)
)
;

CREATE TABLE ECR_CUSTOMERSTOCK
(
   CUSTOMERID varchar2(40) NOT NULL,
   STOCKNO varchar2(10) NOT NULL,
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   OCCURDATE varchar2(10),
   SESSIONID varchar2(10),
   MARKETPLACE varchar2(2),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   ERRORCODE varchar2(80),
   CONSTRAINT PK_ECR_CUSTSTOCK PRIMARY KEY (CUSTOMERID,STOCKNO)
)
;

CREATE TABLE ECR_DISCOUNT
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

CREATE TABLE ECR_ERRHISTORY
(
   SERIALNO decimal(22,0) PRIMARY KEY NOT NULL,
   RECORDTYPE varchar2(2),
   RECORDKEY varchar2(120),
   MESSAGETYPE varchar2(2),
   ERRCODE varchar2(10),
   ERRMSG varchar2(800),
   ERRFIELD varchar2(20),
   FINANCEID varchar2(11),
   MAINBUSINESSNO varchar2(60),
   OCCURDATE varchar2(10),
   CUSTOMERID varchar2(40),
   LOANCARDNO varchar2(16)
)
;


CREATE TABLE ECR_ERRRECORD
(
   FINANCEID varchar2(11) NOT NULL,
   ERRNUMBER decimal(22,0),
   OCCURDATE varchar2(10) NOT NULL,
   OCCURTIME varchar2(10) NOT NULL,
   RECORDTYPE varchar2(2),
   ERRFLAG varchar2(1),
   CONSTRAINT PK_ECR_ERRRECORD PRIMARY KEY (FINANCEID,OCCURDATE,OCCURTIME)
)
;

CREATE TABLE ECR_FACTORING
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

CREATE TABLE ECR_FEEDBACK
(
   TRACENUMBER varchar2(20) NOT NULL,
   RECORDTYPE varchar2(2),
   RECORDKEY varchar2(250),
   MESSAGETYPE varchar2(2),
   ERRCODE varchar2(80),
   ERRMSG varchar2(800),
   RETRYFLAG varchar2(1),
   SESSIONID varchar2(10) NOT NULL,
   FINANCEID varchar2(11),
   MAINBUSINESSNO varchar2(60),
   CUSTOMERID varchar2(40),
   LOANCARDNO varchar2(16),
   CONSTRAINT PK_ECR_FEEDBACK PRIMARY KEY (TRACENUMBER,SESSIONID)
)
;

CREATE TABLE ECR_FINADUEBILL
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

CREATE TABLE ECR_FINAEXTENSION
(
   FDUEBILLNO varchar2(60) NOT NULL,
   OCCURDATE varchar2(10),
   FCONTRACTNO varchar2(60),
   EXTENTIMES varchar2(2) NOT NULL,
   EXTENSUM decimal(24,6),
   EXTENENDDATE varchar2(10),
   EXTENSTARTDATE varchar2(10),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   CONSTRAINT PK_ECR_FISION PRIMARY KEY (FDUEBILLNO,EXTENTIMES)
)
;

CREATE TABLE ECR_FINAINFO
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

CREATE TABLE ECR_FINANCEBS
(
   CUSTOMERID varchar2(40) NOT NULL,
   REPORTYEAR varchar2(4) NOT NULL,
   REPORTTYPE varchar2(2) NOT NULL,
   REPORTSUBTYPE varchar2(1) NOT NULL,
   OCCURDATE varchar2(10),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11),
   LOANCARDNO varchar2(16),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   AUDITFIRM varchar2(80),
   AUDITOR varchar2(30),
   AUDITDATE varchar2(10),
   CUSTOMERNAME varchar2(80),
   M9501 decimal(17,2),
   M9503 decimal(17,2),
   M9505 decimal(17,2),
   M9507 decimal(17,2),
   M9509 decimal(17,2),
   M9511 decimal(17,2),
   M9513 decimal(17,2),
   M9515 decimal(17,2),
   M9517 decimal(17,2),
   M9519 decimal(17,2),
   M9521 decimal(17,2),
   M9523 decimal(17,2),
   M9525 decimal(17,2),
   M9527 decimal(17,2),
   M9529 decimal(17,2),
   M9531 decimal(17,2),
   M9533 decimal(17,2),
   M9535 decimal(17,2),
   M9537 decimal(17,2),
   M9539 decimal(17,2),
   M9541 decimal(17,2),
   M9543 decimal(17,2),
   M9545 decimal(17,2),
   M9547 decimal(17,2),
   M9549 decimal(17,2),
   M9551 decimal(17,2),
   M9553 decimal(17,2),
   M9555 decimal(17,2),
   M9557 decimal(17,2),
   M9559 decimal(17,2),
   M9561 decimal(17,2),
   M9563 decimal(17,2),
   M9565 decimal(17,2),
   M9567 decimal(17,2),
   M9569 decimal(17,2),
   M9571 decimal(17,2),
   M9573 decimal(17,2),
   M9575 decimal(17,2),
   M9577 decimal(17,2),
   M9579 decimal(17,2),
   M9581 decimal(17,2),
   M9583 decimal(17,2),
   M9585 decimal(17,2),
   M9587 decimal(17,2),
   M9589 decimal(17,2),
   M9591 decimal(17,2),
   M9593 decimal(17,2),
   M9595 decimal(17,2),
   M9597 decimal(17,2),
   M9599 decimal(17,2),
   M9601 decimal(17,2),
   M9603 decimal(17,2),
   M9605 decimal(17,2),
   M9607 decimal(17,2),
   M9609 decimal(17,2),
   M9611 decimal(17,2),
   M9613 decimal(17,2),
   M9615 decimal(17,2),
   M9617 decimal(17,2),
   M9619 decimal(17,2),
   M9621 decimal(17,2),
   M9623 decimal(17,2),
   M9625 decimal(17,2),
   M9627 decimal(17,2),
   M9629 decimal(17,2),
   M9631 decimal(17,2),
   M9633 decimal(17,2),
   M9635 decimal(17,2),
   M9637 decimal(17,2),
   M9639 decimal(17,2),
   M9641 decimal(17,2),
   M9643 decimal(17,2),
   M9645 decimal(17,2),
   M9647 decimal(17,2),
   M9649 decimal(17,2),
   M9651 decimal(17,2),
   M9653 decimal(17,2),
   M9655 decimal(17,2),
   M9657 decimal(17,2),
   M9659 decimal(17,2),
   M9661 decimal(17,2),
   M9663 decimal(17,2),
   M9665 decimal(17,2),
   M9667 decimal(17,2),
   M9669 decimal(17,2),
   M9671 decimal(17,2),
   M9673 decimal(17,2),
   CONSTRAINT PK_ECR_FINANCEBS PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)
)
;

CREATE TABLE ECR_FINANCEBS_2007
(
   CUSTOMERID varchar2(40) NOT NULL,
   REPORTYEAR char(4) NOT NULL,
   REPORTTYPE char(2) NOT NULL,
   REPORTSUBTYPE char(1) NOT NULL,
   OCCURDATE varchar2(10),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11),
   LOANCARDNO varchar2(16),
   CUSTOMERNAME varchar2(80),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   AUDITFIRM varchar2(80),
   AUDITOR varchar2(30),
   AUDITDATE varchar2(10),
   M9100 decimal(17,2),
   M9101 decimal(17,2),
   M9102 decimal(17,2),
   M9103 decimal(17,2),
   M9104 decimal(17,2),
   M9105 decimal(17,2),
   M9106 decimal(17,2),
   M9107 decimal(17,2),
   M9108 decimal(17,2),
   M9109 decimal(17,2),
   M9110 decimal(17,2),
   M9111 decimal(17,2),
   M9112 decimal(17,2),
   M9113 decimal(17,2),
   M9114 decimal(17,2),
   M9115 decimal(17,2),
   M9116 decimal(17,2),
   M9117 decimal(17,2),
   M9118 decimal(17,2),
   M9119 decimal(17,2),
   M9120 decimal(17,2),
   M9121 decimal(17,2),
   M9122 decimal(17,2),
   M9123 decimal(17,2),
   M9124 decimal(17,2),
   M9125 decimal(17,2),
   M9126 decimal(17,2),
   M9127 decimal(17,2),
   M9128 decimal(17,2),
   M9129 decimal(17,2),
   M9130 decimal(17,2),
   M9131 decimal(17,2),
   M9132 decimal(17,2),
   M9133 decimal(17,2),
   M9134 decimal(17,2),
   M9135 decimal(17,2),
   M9136 decimal(17,2),
   M9137 decimal(17,2),
   M9138 decimal(17,2),
   M9139 decimal(17,2),
   M9140 decimal(17,2),
   M9141 decimal(17,2),
   M9142 decimal(17,2),
   M9143 decimal(17,2),
   M9144 decimal(17,2),
   M9145 decimal(17,2),
   M9146 decimal(17,2),
   M9147 decimal(17,2),
   M9148 decimal(17,2),
   M9149 decimal(17,2),
   M9150 decimal(17,2),
   M9151 decimal(17,2),
   M9152 decimal(17,2),
   M9153 decimal(17,2),
   M9154 decimal(17,2),
   M9155 decimal(17,2),
   M9156 decimal(17,2),
   M9157 decimal(17,2),
   M9158 decimal(17,2),
   M9159 decimal(17,2),
   CONSTRAINT PK_ECR_FINANCEBS07 PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)
)
;

CREATE TABLE ECR_FINANCEBS_IN
(
   CUSTOMERID varchar2(40) NOT NULL,
   REPORTYEAR char(4) NOT NULL,
   REPORTTYPE char(2) NOT NULL,
   REPORTSUBTYPE char(1) NOT NULL,
   OCCURDATE varchar2(10),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11),
   LOANCARDNO varchar2(16),
   INCREMENTFLAG varchar2(1),
   CUSTOMERNAME varchar2(80),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   AUDITFIRM varchar2(80),
   AUDITOR varchar2(30),
   AUDITDATE varchar2(10),
   M9271 decimal(17,2),
   M9272 decimal(17,2),
   M9273 decimal(17,2),
   M9274 decimal(17,2),
   M9275 decimal(17,2),
   M9276 decimal(17,2),
   M9277 decimal(17,2),
   M9278 decimal(17,2),
   M9279 decimal(17,2),
   M9280 decimal(17,2),
   M9281 decimal(17,2),
   M9282 decimal(17,2),
   M9283 decimal(17,2),
   M9284 decimal(17,2),
   M9285 decimal(17,2),
   M9286 decimal(17,2),
   M9287 decimal(17,2),
   M9288 decimal(17,2),
   M9289 decimal(17,2),
   M9290 decimal(17,2),
   M9291 decimal(17,2),
   M9292 decimal(17,2),
   M9293 decimal(17,2),
   M9294 decimal(17,2),
   M9295 decimal(17,2),
   M9296 decimal(17,2),
   M9297 decimal(17,2),
   M9298 decimal(17,2),
   M9299 decimal(17,2),
   M9300 decimal(17,2),
   M9301 decimal(17,2),
   M9302 decimal(17,2),
   M9303 decimal(17,2),
   M9304 decimal(17,2),
   M9305 decimal(17,2),
   M9306 decimal(17,2),
   M9307 decimal(17,2),
   M9308 decimal(17,2),
   M9309 decimal(17,2),
   M9310 decimal(17,2),
   M9311 decimal(17,2),
   M9312 decimal(17,2),
   M9313 decimal(17,2),
   M9314 decimal(17,2),
   M9315 decimal(17,2),
   M9316 decimal(17,2),
   M9317 decimal(17,2),
   M9318 decimal(17,2),
   M9319 decimal(17,2),
   M9320 decimal(17,2),
   CONSTRAINT PK_ECR_FINANCEBSIN PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)
)
;

CREATE TABLE ECR_FINANCECF
(
   CUSTOMERID varchar2(40) NOT NULL,
   REPORTYEAR varchar2(4) NOT NULL,
   REPORTTYPE varchar2(2) NOT NULL,
   REPORTSUBTYPE varchar2(1) NOT NULL,
   OCCURDATE varchar2(10),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11),
   LOANCARDNO varchar2(16),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   AUDITFIRM varchar2(80),
   AUDITOR varchar2(30),
   AUDITDATE varchar2(10),
   CUSTOMERNAME varchar2(80),
   M9795 decimal(17,2),
   M9797 decimal(17,2),
   M9799 decimal(17,2),
   M9823 decimal(17,2),
   M9803 decimal(17,2),
   M9805 decimal(17,2),
   M9807 decimal(17,2),
   M9809 decimal(17,2),
   M9831 decimal(17,2),
   M9813 decimal(17,2),
   M9815 decimal(17,2),
   M9817 decimal(17,2),
   M9819 decimal(17,2),
   M9821 decimal(17,2),
   M9917 decimal(17,2),
   M9825 decimal(17,2),
   M9827 decimal(17,2),
   M9829 decimal(17,2),
   M9919 decimal(17,2),
   M9833 decimal(17,2),
   M9835 decimal(17,2),
   M9837 decimal(17,2),
   M9839 decimal(17,2),
   M9921 decimal(17,2),
   M9843 decimal(17,2),
   M9845 decimal(17,2),
   M9847 decimal(17,2),
   M9923 decimal(17,2),
   M9851 decimal(17,2),
   M9853 decimal(17,2),
   M9855 decimal(17,2),
   M9857 decimal(17,2),
   M9859 decimal(17,2),
   M9861 decimal(17,2),
   M9863 decimal(17,2),
   M9865 decimal(17,2),
   M9867 decimal(17,2),
   M9869 decimal(17,2),
   M9871 decimal(17,2),
   M9873 decimal(17,2),
   M9925 decimal(17,2),
   M9877 decimal(17,2),
   M9879 decimal(17,2),
   M9881 decimal(17,2),
   M9883 decimal(17,2),
   M9885 decimal(17,2),
   M9915 decimal(17,2),
   M1813 decimal(17,2),
   M9891 decimal(17,2),
   M9893 decimal(17,2),
   M9895 decimal(17,2),
   M9897 decimal(17,2),
   M9899 decimal(17,2),
   M9901 decimal(17,2),
   M9903 decimal(17,2),
   M9905 decimal(17,2),
   M1855 decimal(17,2),
   CONSTRAINT PK_ECR_FINANCECF PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)
)
;

CREATE TABLE ECR_FINANCECF_2007
(
   CUSTOMERID varchar2(40) NOT NULL,
   REPORTYEAR char(4) NOT NULL,
   REPORTTYPE char(2) NOT NULL,
   REPORTSUBTYPE char(1) NOT NULL,
   OCCURDATE varchar2(10),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11),
   LOANCARDNO varchar2(16),
   CUSTOMERNAME varchar2(80),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   AUDITFIRM varchar2(80),
   AUDITOR varchar2(30),
   AUDITDATE varchar2(10),
   M9199 decimal(17,2),
   M9200 decimal(17,2),
   M9201 decimal(17,2),
   M9202 decimal(17,2),
   M9203 decimal(17,2),
   M9204 decimal(17,2),
   M9205 decimal(17,2),
   M9206 decimal(17,2),
   M9207 decimal(17,2),
   M9208 decimal(17,2),
   M9209 decimal(17,2),
   M9210 decimal(17,2),
   M9211 decimal(17,2),
   M9212 decimal(17,2),
   M9213 decimal(17,2),
   M9214 decimal(17,2),
   M9215 decimal(17,2),
   M9216 decimal(17,2),
   M9217 decimal(17,2),
   M9218 decimal(17,2),
   M9219 decimal(17,2),
   M9220 decimal(17,2),
   M9221 decimal(17,2),
   M9222 decimal(17,2),
   M9223 decimal(17,2),
   M9224 decimal(17,2),
   M9225 decimal(17,2),
   M9226 decimal(17,2),
   M9227 decimal(17,2),
   M9228 decimal(17,2),
   M9229 decimal(17,2),
   M9230 decimal(17,2),
   M9231 decimal(17,2),
   M9232 decimal(17,2),
   M9233 decimal(17,2),
   M9234 decimal(17,2),
   M9235 decimal(17,2),
   M9236 decimal(17,2),
   M9237 decimal(17,2),
   M9238 decimal(17,2),
   M9239 decimal(17,2),
   M9240 decimal(17,2),
   M9241 decimal(17,2),
   M9242 decimal(17,2),
   M9243 decimal(17,2),
   M9244 decimal(17,2),
   M9245 decimal(17,2),
   M9246 decimal(17,2),
   M9247 decimal(17,2),
   M9248 decimal(17,2),
   M9249 decimal(17,2),
   M9250 decimal(17,2),
   M9251 decimal(17,2),
   M9252 decimal(17,2),
   M9253 decimal(17,2),
   M9254 decimal(17,2),
   M9255 decimal(17,2),
   M9256 decimal(17,2),
   M9257 decimal(17,2),
   M9258 decimal(17,2),
   M9259 decimal(17,2),
   M9260 decimal(17,2),
   M9261 decimal(17,2),
   CONSTRAINT PK_ECR_FINANCECF07 PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)
)
;

CREATE TABLE ECR_FINANCEPS
(
   CUSTOMERID varchar2(40) NOT NULL,
   REPORTYEAR varchar2(4) NOT NULL,
   REPORTTYPE varchar2(2) NOT NULL,
   REPORTSUBTYPE varchar2(1) NOT NULL,
   OCCURDATE varchar2(10),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11),
   LOANCARDNO varchar2(16),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   AUDITFIRM varchar2(80),
   AUDITOR varchar2(30),
   AUDITDATE varchar2(10),
   CUSTOMERNAME varchar2(80),
   M9675 decimal(17,2),
   M9677 decimal(17,2),
   M9679 decimal(17,2),
   M9681 decimal(17,2),
   M9683 decimal(17,2),
   M9685 decimal(17,2),
   M9687 decimal(17,2),
   M9689 decimal(17,2),
   M9693 decimal(17,2),
   M9691 decimal(17,2),
   M9695 decimal(17,2),
   M9697 decimal(17,2),
   M9699 decimal(17,2),
   M9701 decimal(17,2),
   M9703 decimal(17,2),
   M9705 decimal(17,2),
   M9707 decimal(17,2),
   M9709 decimal(17,2),
   M9907 decimal(17,2),
   M9711 decimal(17,2),
   M9713 decimal(17,2),
   M9715 decimal(17,2),
   M9717 decimal(17,2),
   M9719 decimal(17,2),
   M9721 decimal(17,2),
   M9723 decimal(17,2),
   M9725 decimal(17,2),
   M9727 decimal(17,2),
   M9729 decimal(17,2),
   M9909 decimal(17,2),
   M9731 decimal(17,2),
   M9733 decimal(17,2),
   M9735 decimal(17,2),
   M9737 decimal(17,2),
   M9739 decimal(17,2),
   M9741 decimal(17,2),
   M9743 decimal(17,2),
   M9745 decimal(17,2),
   M9747 decimal(17,2),
   M9749 decimal(17,2),
   M9751 decimal(17,2),
   M9753 decimal(17,2),
   M9755 decimal(17,2),
   M9757 decimal(17,2),
   M9759 decimal(17,2),
   M9761 decimal(17,2),
   M9763 decimal(17,2),
   M9765 decimal(17,2),
   M9767 decimal(17,2),
   M9769 decimal(17,2),
   M9771 decimal(17,2),
   M9773 decimal(17,2),
   M9775 decimal(17,2),
   M9777 decimal(17,2),
   M9779 decimal(17,2),
   M9911 decimal(17,2),
   M9781 decimal(17,2),
   M9783 decimal(17,2),
   M9785 decimal(17,2),
   M9787 decimal(17,2),
   M9789 decimal(17,2),
   M9913 decimal(17,2),
   M9791 decimal(17,2),
   M9793 decimal(17,2),
   CONSTRAINT PK_ECR_FINANCEPS PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)
)
;

CREATE TABLE ECR_FINANCEPS_2007
(
   CUSTOMERID varchar2(40) NOT NULL,
   REPORTYEAR char(4) NOT NULL,
   REPORTTYPE char(2) NOT NULL,
   REPORTSUBTYPE char(1) NOT NULL,
   OCCURDATE varchar2(10),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11),
   LOANCARDNO varchar2(16),
   CUSTOMERNAME varchar2(80),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   AUDITFIRM varchar2(80),
   AUDITOR varchar2(30),
   AUDITDATE varchar2(10),
   M9170 decimal(17,2),
   M9171 decimal(17,2),
   M9172 decimal(17,2),
   M9173 decimal(17,2),
   M9174 decimal(17,2),
   M9175 decimal(17,2),
   M9176 decimal(17,2),
   M9177 decimal(17,2),
   M9178 decimal(17,2),
   M9179 decimal(17,2),
   M9180 decimal(17,2),
   M9181 decimal(17,2),
   M9182 decimal(17,2),
   M9183 decimal(17,2),
   M9184 decimal(17,2),
   M9185 decimal(17,2),
   M9186 decimal(17,2),
   M9187 decimal(17,2),
   M9188 decimal(17,2),
   CONSTRAINT PK_ECR_FINANCEPS07 PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)
)
;

CREATE TABLE ECR_FINANCECF_IN
(
   CUSTOMERID varchar2(40) NOT NULL,
   REPORTYEAR char(4) NOT NULL,
   REPORTTYPE char(2) NOT NULL,
   REPORTSUBTYPE char(1) NOT NULL,
   OCCURDATE varchar2(10),
   OLDFINANCEID varchar2(59),
   FINANCEID varchar2(11),
   LOANCARDNO varchar2(16),
   CUSTOMERNAME varchar2(80),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   AUDITFIRM varchar2(80),
   AUDITOR varchar2(30),
   AUDITDATE varchar2(10),
   M9330 decimal(17,2),
   M9331 decimal(17,2),
   M9332 decimal(17,2),
   M9333 decimal(17,2),
   M9334 decimal(17,2),
   M9335 decimal(17,2),
   M9336 decimal(17,2),
   M9337 decimal(17,2),
   M9338 decimal(17,2),
   M9339 decimal(17,2),
   M9340 decimal(17,2),
   M9341 decimal(17,2),
   M9342 decimal(17,2),
   M9343 decimal(17,2),
   M9344 decimal(17,2),
   M9345 decimal(17,2),
   M9346 decimal(17,2),
   M9347 decimal(17,2),
   M9348 decimal(17,2),
   M9349 decimal(17,2),
   M9350 decimal(17,2),
   M9351 decimal(17,2),
   M9352 decimal(17,2),
   M9353 decimal(17,2),
   M9354 decimal(17,2),
   M9355 decimal(17,2),
   M9356 decimal(17,2),
   M9357 decimal(17,2),
   M9358 decimal(17,2),
   M9359 decimal(17,2),
   M9360 decimal(17,2),
   M9361 decimal(17,2),
   M9362 decimal(17,2),
   M9363 decimal(17,2),
   M9364 decimal(17,2),
   M9365 decimal(17,2),
   M9366 decimal(17,2),
   M9367 decimal(17,2),
   CONSTRAINT PK_ECR_FINANCECFIN PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)
)
;

CREATE TABLE ECR_FINARETURN
(
   FDUEBILLNO varchar2(40) NOT NULL,
   OCCURDATE varchar2(10),
   FCONTRACTNO varchar2(40),
   RETURNTIMES decimal(22,0) NOT NULL,
   RETURNMODE varchar2(2),
   RETURNSUM decimal(24,6),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   RETURNDATE varchar2(10),
   CONSTRAINT PK_ECR_FINARETURN PRIMARY KEY (FDUEBILLNO,RETURNTIMES)
)
;

CREATE TABLE ECR_FLOORFUND
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

CREATE TABLE ECR_GUARANTEEBILL
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

CREATE TABLE ECR_GUARANTYCONT
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
   CONSTRAINT PK_ECR_GUCONT PRIMARY KEY (CONTRACTNO,GUARANTYCONTNO,GUARANTYSERIALNO)
)
;

CREATE TABLE ECR_IMPAWNCONT
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
   CONSTRAINT PK_ECR_IMPAWNCONT PRIMARY KEY (CONTRACTNO,IMPAWNCONTNO,IMPAWSERIALNO)
)
;

CREATE TABLE ECR_INTERESTDUE
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
   CONSTRAINT PK_ECR_INTERESTDUE PRIMARY KEY (CUSTOMERID,INTERESTTYPE,CURRENCY,FINANCEID)
)
;

CREATE TABLE ECR_LOANCARD
(
   OCCURDATE varchar2(10),
   LOANCARDNO varchar2(60) PRIMARY KEY NOT NULL,
   LOANCARDPASSWORD varchar2(6),
   STATUS decimal(22,0),
   COUNTRYCODE varchar2(3),
   CHINESENAME varchar2(80),
   ENGLISHNAME varchar2(80),
   ORGANIZATIONCODE varchar2(10),
   LICENCECODE varchar2(20),
   REGISTERDATE varchar2(10),
   KIND decimal(22,0),
   AREACODE varchar2(6),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80)
)
;

CREATE TABLE ECR_LOANCARDNOCHANGE
(
   CUSTOMERID varchar2(40) NOT NULL,
   OLDLOANCARDNO varchar2(16) NOT NULL,
   NEWLOANCARDNO varchar2(16) NOT NULL,
   CUSTOMERNAME varchar2(80),
   FINANCEID varchar(11) NOT NULL,
   ISPROCESSED varchar2(1),
   ISREADY varchar2(1),
   INPUTDATE varchar2(10),
   CONSTRAINT LOANCARDCHANGE PRIMARY KEY (CUSTOMERID,OLDLOANCARDNO,NEWLOANCARDNO,FINANCEID)
)
;

CREATE TABLE ECR_LOANCONTRACT
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

CREATE TABLE ECR_LOANDUEBILL
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

CREATE TABLE ECR_LOANEXTENSION
(
   LDUEBILLNO varchar2(60) NOT NULL,
   OCCURDATE varchar2(10),
   LCONTRACTNO varchar2(60),
   UPDATEDATE varchar2(10),
   EXTENTIMES varchar2(2) NOT NULL,
   EXTENSUM decimal(24,6),
   EXTENSTARTDATE varchar2(10),
   EXTENENDDATE varchar2(10),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   CONSTRAINT PK_ECR_LTENSION PRIMARY KEY (LDUEBILLNO,EXTENTIMES)
)
;

CREATE TABLE ECR_LOANRETURN
(
   LDUEBILLNO varchar2(60) NOT NULL,
   OCCURDATE varchar2(10),
   LCONTRACTNO varchar2(60),
   RETURNDATE varchar2(10),
   RETURNTIMES decimal(22,0) NOT NULL,
   RETURNMODE varchar2(2),
   RETURNSUM decimal(24,6),
   INCREMENTFLAG varchar2(1),
   MODFLAG varchar2(1),
   TRACENUMBER varchar2(20),
   RECORDFLAG varchar2(20),
   SESSIONID varchar2(10),
   ERRORCODE varchar2(80),
   CONSTRAINT PK_ECR_LOANRETURN PRIMARY KEY (LDUEBILLNO,RETURNTIMES)
)
;

CREATE TABLE ECR_PREPAREDATE
(
   LASTPREPAREDATE varchar2(10) PRIMARY KEY NOT NULL
)
;

CREATE TABLE ECR_PREPARESTATUS
(
   LASTPREPAREDATE date PRIMARY KEY NOT NULL,
   RUNSTATUS varchar2(1)
)
;

CREATE TABLE ECR_REPORTSTATUS
(
   SESSIONID varchar2(10) PRIMARY KEY NOT NULL,
   MESSAGETYPE varchar2(2),
   RETRYTYPE varchar2(1),
   RECORDNUMBER decimal(22,0),
   FEEDBACKNUMBER decimal(22,0),
   FEEDBACKDATE varchar2(20)
)
;

CREATE TABLE ECR_RUNSTATUS
(
   RUNRESULT varchar2(1),
   RUNSTATUS varchar2(3)
)
;
CREATE TABLE ECR_SESSION
(
   SESSIONID varchar2(10) PRIMARY KEY NOT NULL,
   STATUS decimal(22,0),
   DATATYPE decimal(22,0),
   MESSAGESETTYPE varchar2(2),
   CREATETIME date,
   PREVIOUSSESSIONID varchar2(10),
   FINANCEID varchar2(11),
   NOTE varchar2(200)
)
;

CREATE TABLE ECR_TRANSFERFILTER
(
   MAINBUSINESSNO varchar2(60) NOT NULL,
   RECORDSCOPE varchar2(60) NOT NULL,
   FILTERCAUSE varchar2(1) NOT NULL,
   UPDATETIME date,
   OPERATOR varchar2(10),
   NOTE varchar2(60),
   CONSTRAINT PK_ECR_TFILTER PRIMARY KEY (MAINBUSINESSNO,RECORDSCOPE,FILTERCAUSE)
)
;

CREATE TABLE ECR_ASSETSDISPOSE
(
  BUSINESSNO VARCHAR2(60) NOT NULL,			--ҵ����
  FINANCEID  VARCHAR2(11),					--���ڻ�������
  OLDFINANCEID  VARCHAR2(59),
  CUSTOMERID     VARCHAR2(40),				--�ͻ����
  CUSTOMERNAME  VARCHAR2(80),				--���������
  LOANCARDNO      VARCHAR2(16),				--�������
  ORGANIZATIONCODE  VARCHAR2(11),			--��֯��������
  BUSINESSREGISTRYNO VARCHAR2(20),			--����ע��ǼǺ�
  BALANCE decimal(24,6),					--���
  DISPOSEDATE VARCHAR2(10),					--��������
  DISPOSETYPE VARCHAR2(1),					--��Ҫ�ʲ����÷�ʽ
  RECOVERYAMOUNT decimal(24,6),				--�ѻ��ս��
  OCCURDATE      VARCHAR2(10),
  INCREMENTFLAG  VARCHAR2(1),
  MODFLAG        VARCHAR2(1),
  TRACENUMBER    VARCHAR2(20),
  RECORDFLAG     VARCHAR2(20),
  SESSIONID      VARCHAR2(10),
  ERRORCODE      VARCHAR2(80),
  CONSTRAINT PK_ECR_ASSETSDISPOSE PRIMARY KEY (BUSINESSNO)
);
/*==============================================================*/
/* Table: ECR_ORGANATTRIBUTE                                    */
/*==============================================================*/
create table ECR_ORGANATTRIBUTE  (
   CIFCustomerId      VARCHAR2(40)                    not null,
   ChineseName        VARCHAR2(80),
   EnglishName        VARCHAR2(80),
   RegisterAdd        VARCHAR2(80),
   RegisterCountry    VARCHAR2(3),
   RegisterAreaCode   VARCHAR2(6),
   RegisterDate       VARCHAR2(10),
   RegisterDueDate    VARCHAR2(10),
   BusinessScope      VARCHAR2(400),
   CapitalCurrency    VARCHAR2(3),
   CapitalFund        NUMBER(10,2),
   OrgType            VARCHAR2(1),
   OrgTypeSub         VARCHAR2(2),
   Industry           VARCHAR2(5),
   OrgNature          VARCHAR2(2),
   UpdateDate         VARCHAR2(10),
   Attribute1         VARCHAR2(40),
   OccurDate          VARCHAR2(10),
   IncrementFlag      VARCHAR2(1),
   Modflag            VARCHAR2(1),
   TraceNumber        VARCHAR2(20),
   RecordFlag         VARCHAR2(20),
   SessionId          VARCHAR2(10),
   ErrorCode          VARCHAR2(80),
   constraint PK_ECR_ORGANATTRIBUTE primary key (CIFCustomerId)
);

comment on table ECR_ORGANATTRIBUTE is
'�������� ����������Ϣ�ɼ�����C�� 0��1';

comment on column ECR_ORGANATTRIBUTE.CIFCustomerId is
'�ͻ���';

comment on column ECR_ORGANATTRIBUTE.ChineseName is
'������������';

comment on column ECR_ORGANATTRIBUTE.EnglishName is
'����Ӣ������';

comment on column ECR_ORGANATTRIBUTE.RegisterAdd is
'ע�ᣨ�Ǽǣ���ַ';

comment on column ECR_ORGANATTRIBUTE.RegisterCountry is
'����';

comment on column ECR_ORGANATTRIBUTE.RegisterAreaCode is
'ע�ᣨ�Ǽǣ�����������';

comment on column ECR_ORGANATTRIBUTE.RegisterDate is
'��������';

comment on column ECR_ORGANATTRIBUTE.RegisterDueDate is
'֤�鵽����';

comment on column ECR_ORGANATTRIBUTE.BusinessScope is
'��Ӫ��ҵ�񣩷�Χ';

comment on column ECR_ORGANATTRIBUTE.CapitalCurrency is
'ע���ʱ�����';

comment on column ECR_ORGANATTRIBUTE.CapitalFund is
'ע���ʱ�����Ԫ��';

comment on column ECR_ORGANATTRIBUTE.OrgType is
'��֯�������';

comment on column ECR_ORGANATTRIBUTE.OrgTypeSub is
'��֯�������ϸ��';

comment on column ECR_ORGANATTRIBUTE.Industry is
'������ҵ����';

comment on column ECR_ORGANATTRIBUTE.OrgNature is
'��������';

comment on column ECR_ORGANATTRIBUTE.UpdateDate is
'��Ϣ��������';

comment on column ECR_ORGANATTRIBUTE.Attribute1 is
'Ԥ���ֶ�';

comment on column ECR_ORGANATTRIBUTE.OccurDate is
'��������';

comment on column ECR_ORGANATTRIBUTE.IncrementFlag is
'������־';

comment on column ECR_ORGANATTRIBUTE.Modflag is
'�޸ı�־';

comment on column ECR_ORGANATTRIBUTE.TraceNumber is
'���ٱ��';

comment on column ECR_ORGANATTRIBUTE.RecordFlag is
'��¼��־';

comment on column ECR_ORGANATTRIBUTE.SessionId is
'�����ڴ�';

comment on column ECR_ORGANATTRIBUTE.ErrorCode is
'�������';

/*==============================================================*/
/* Table: ECR_ORGANCONTACT                                      */
/*==============================================================*/
create table ECR_ORGANCONTACT  (
   CIFCustomerId      VARCHAR2(40)                    not null,
   OfficeAdd          VARCHAR2(80),
   OfficeContact      VARCHAR2(35),
   FinanceContact     VARCHAR2(35),
   UpdateDate         VARCHAR2(10),
   Attribute1         VARCHAR2(40),
   OccurDate          VARCHAR2(10),
   IncrementFlag      VARCHAR2(1),
   Modflag            VARCHAR2(1),
   TraceNumber        VARCHAR2(20),
   RecordFlag         VARCHAR2(20),
   SessionId          VARCHAR2(10),
   ErrorCode          VARCHAR2(80),
   constraint PK_ECR_ORGANCONTACT primary key (CIFCustomerId)
);

comment on table ECR_ORGANCONTACT is
'�������� ����������Ϣ�ɼ�����E�� 0��1';

comment on column ECR_ORGANCONTACT.CIFCustomerId is
'�ͻ���';

comment on column ECR_ORGANCONTACT.OfficeAdd is
'�칫����������Ӫ����ַ';

comment on column ECR_ORGANCONTACT.OfficeContact is
'��ϵ�绰';

comment on column ECR_ORGANCONTACT.FinanceContact is
'������ϵ�绰';

comment on column ECR_ORGANCONTACT.UpdateDate is
'��Ϣ��������';

comment on column ECR_ORGANCONTACT.Attribute1 is
'Ԥ���ֶ�';

comment on column ECR_ORGANCONTACT.OccurDate is
'��������';

comment on column ECR_ORGANCONTACT.IncrementFlag is
'������־';

comment on column ECR_ORGANCONTACT.Modflag is
'�޸ı�־';

comment on column ECR_ORGANCONTACT.TraceNumber is
'���ٱ��';

comment on column ECR_ORGANCONTACT.RecordFlag is
'��¼��־';

comment on column ECR_ORGANCONTACT.SessionId is
'�����ڴ�';

comment on column ECR_ORGANCONTACT.ErrorCode is
'�������';

/*==============================================================*/
/* Table: ECR_ORGANFAMILY                                       */
/*==============================================================*/
create table ECR_ORGANFAMILY  (
   CIFCustomerId      VARCHAR2(40)                    not null,
   ManagerName        VARCHAR2(80),
   ManagerCertType    VARCHAR2(2)                     not null,
   ManagerCertId      VARCHAR2(20)                    not null,
   MemberRelaType     VARCHAR2(1)                     not null,
   MemberName         VARCHAR2(80),
   MemberCertType     VARCHAR2(2)                     not null,
   MemberCertId       VARCHAR2(20)                    not null,
   UpdateDate         VARCHAR2(10),
   Attribute1         VARCHAR2(40),
   OccurDate          VARCHAR2(10),
   IncrementFlag      VARCHAR2(1),
   Modflag            VARCHAR2(1),
   TraceNumber        VARCHAR2(20),
   RecordFlag         VARCHAR2(20),
   SessionId          VARCHAR2(10),
   ErrorCode          VARCHAR2(80),
   FinanceId          VARCHAR2(11),
   OldFinanceId       VARCHAR2(11),
   LoancardNo         VARCHAR2(16),
   constraint PK_ECR_ORGANFAMILY primary key (CIFCustomerId, ManagerCertType, ManagerCertId, MemberRelaType, MemberCertType, MemberCertId)
);

comment on table ECR_ORGANFAMILY is
'���������ԱB��1��1';

comment on column ECR_ORGANFAMILY.CIFCustomerId is
'�ͻ���';

comment on column ECR_ORGANFAMILY.ManagerName is
'��Ҫ��ϵ������';

comment on column ECR_ORGANFAMILY.ManagerCertType is
'��Ҫ��ϵ��֤������';

comment on column ECR_ORGANFAMILY.ManagerCertId is
'֤������';

comment on column ECR_ORGANFAMILY.MemberRelaType is
'�����ϵ';

comment on column ECR_ORGANFAMILY.MemberName is
'�����Ա����';

comment on column ECR_ORGANFAMILY.MemberCertType is
'�����Ա֤������';

comment on column ECR_ORGANFAMILY.MemberCertId is
'֤������';

comment on column ECR_ORGANFAMILY.UpdateDate is
'��Ϣ��������';

comment on column ECR_ORGANFAMILY.Attribute1 is
'Ԥ���ֶ�';

comment on column ECR_ORGANFAMILY.OccurDate is
'��������';

comment on column ECR_ORGANFAMILY.IncrementFlag is
'������־';

comment on column ECR_ORGANFAMILY.Modflag is
'�޸ı�־';

comment on column ECR_ORGANFAMILY.TraceNumber is
'���ٱ��';

comment on column ECR_ORGANFAMILY.RecordFlag is
'��¼��־';

comment on column ECR_ORGANFAMILY.SessionId is
'�����ڴ�';

comment on column ECR_ORGANFAMILY.ErrorCode is
'�������';

comment on column ECR_ORGANFAMILY.FinanceId is
'�����д���(���ڻ�������)';

comment on column ECR_ORGANFAMILY.OldFinanceId is
'ԭ���ڻ�������';

comment on column ECR_ORGANFAMILY.LoancardNo is
'�������';

/*==============================================================*/
/* Table: ECR_ORGANINFO                                         */
/*==============================================================*/
create table ECR_ORGANINFO  (
   CIFCustomerId      VARCHAR2(40)                    not null,
   MFCustomerId       VARCHAR2(40),
   LSCustomerId       VARCHAR2(40),
   FinanceId          VARCHAR2(11),
   OldFinanceId       VARCHAR2(11),
   CustomerType       VARCHAR2(1),
   CreditCode         VARCHAR2(18),
   CorpId             VARCHAR2(10),
   RegisterType       VARCHAR2(2),
   RegisterNo         VARCHAR2(20),
   NationalTaxNo      VARCHAR2(20),
   LocalTaxNo         VARCHAR2(20),
   AccountPermitNo    VARCHAR2(20),
   LoancardNo         VARCHAR2(16),
   GatherDate         VARCHAR2(10),
   Attribute1         VARCHAR2(40),
   OccurDate          VARCHAR2(10),
   IncrementFlag      VARCHAR2(1),
   Modflag            VARCHAR2(1),
   TraceNumber        VARCHAR2(20),
   RecordFlag         VARCHAR2(20),
   SessionId          VARCHAR2(10),
   ErrorCode          VARCHAR2(80),
   constraint PK_ECR_ORGANINFO primary key (CIFCustomerId)
);

comment on table ECR_ORGANINFO is
'����������Ϣ  ����������Ϣ�ɼ�����B��1:1';

comment on column ECR_ORGANINFO.CIFCustomerId is
'�ͻ���';

comment on column ECR_ORGANINFO.MFCustomerId is
'���Ŀͻ���';

comment on column ECR_ORGANINFO.LSCustomerId is
'�Ŵ��ͻ���';

comment on column ECR_ORGANINFO.FinanceId is
'�����д���(���ڻ�������)';

comment on column ECR_ORGANINFO.OldFinanceId is
'ԭ���ڻ�������';

comment on column ECR_ORGANINFO.CustomerType is
'�ͻ�����';

comment on column ECR_ORGANINFO.CreditCode is
'�������ô��� ';

comment on column ECR_ORGANINFO.CorpId is
'��֯��������';

comment on column ECR_ORGANINFO.RegisterType is
'�Ǽ�ע�������';

comment on column ECR_ORGANINFO.RegisterNo is
'�Ǽ�ע�����';

comment on column ECR_ORGANINFO.NationalTaxNo is
'��˰��ʶ��ţ���˰��';

comment on column ECR_ORGANINFO.LocalTaxNo is
'��˰��ʶ��ţ���˰��';

comment on column ECR_ORGANINFO.AccountPermitNo is
'�������֤��׼��';

comment on column ECR_ORGANINFO.LoancardNo is
'�������';

comment on column ECR_ORGANINFO.GatherDate is
'������ȡ����';

comment on column ECR_ORGANINFO.Attribute1 is
'Ԥ���ֶ�';

comment on column ECR_ORGANINFO.OccurDate is
'��������';

comment on column ECR_ORGANINFO.IncrementFlag is
'������־';

comment on column ECR_ORGANINFO.Modflag is
'�޸ı�־';

comment on column ECR_ORGANINFO.TraceNumber is
'���ٱ��';

comment on column ECR_ORGANINFO.RecordFlag is
'��¼��־';

comment on column ECR_ORGANINFO.SessionId is
'�����ڴ�';

comment on column ECR_ORGANINFO.ErrorCode is
'�������';

/*==============================================================*/
/* Table: ECR_ORGANKEEPER                                       */
/*==============================================================*/
create table ECR_ORGANKEEPER  (
   CIFCustomerId      VARCHAR2(40)                    not null,
   ManagerType        VARCHAR2(1)                     not null,
   ManagerName        VARCHAR2(80),
   CertType           VARCHAR2(2),
   CertId             VARCHAR2(20),
   UpdateDate         VARCHAR2(10),
   Attribute1         VARCHAR2(40),
   OccurDate          VARCHAR2(10),
   IncrementFlag      VARCHAR2(1),
   Modflag            VARCHAR2(1),
   TraceNumber        VARCHAR2(20),
   RecordFlag         VARCHAR2(20),
   SessionId          VARCHAR2(10),
   ErrorCode          VARCHAR2(80),
   constraint PK_ECR_ORGANKEEPER primary key (CIFCustomerId, ManagerType)
);

comment on table ECR_ORGANKEEPER is
'�����߹ܼ���Ҫ��ϵ�� ����������Ϣ�ɼ�����F�� 0��n';

comment on column ECR_ORGANKEEPER.CIFCustomerId is
'�ͻ���';

comment on column ECR_ORGANKEEPER.ManagerType is
'��ϵ������';

comment on column ECR_ORGANKEEPER.ManagerName is
'����';

comment on column ECR_ORGANKEEPER.CertType is
'֤������';

comment on column ECR_ORGANKEEPER.CertId is
'֤������';

comment on column ECR_ORGANKEEPER.UpdateDate is
'��Ϣ��������';

comment on column ECR_ORGANKEEPER.Attribute1 is
'Ԥ���ֶ�';

comment on column ECR_ORGANKEEPER.OccurDate is
'��������';

comment on column ECR_ORGANKEEPER.IncrementFlag is
'������־';

comment on column ECR_ORGANKEEPER.Modflag is
'�޸ı�־';

comment on column ECR_ORGANKEEPER.TraceNumber is
'���ٱ��';

comment on column ECR_ORGANKEEPER.RecordFlag is
'��¼��־';

comment on column ECR_ORGANKEEPER.SessionId is
'�����ڴ�';

comment on column ECR_ORGANKEEPER.ErrorCode is
'�������';

/*==============================================================*/
/* Table: ECR_ORGANRELATED                                      */
/*==============================================================*/
create table ECR_ORGANRELATED  (
   CIFCustomerId      VARCHAR2(40)                    not null,
   RelationShip       VARCHAR2(2)                     not null,
   RelativeEntName    VARCHAR2(80)                    not null,
   RegisterType       VARCHAR2(2),
   RegisterNo         VARCHAR2(20),
   CorpId             VARCHAR2(10),
   CreditCode         VARCHAR2(18),
   UpdateDate         VARCHAR2(10),
   Attribute1         VARCHAR2(40),
   OccurDate          VARCHAR2(10),
   IncrementFlag      VARCHAR2(1),
   Modflag            VARCHAR2(1),
   TraceNumber        VARCHAR2(20),
   RecordFlag         VARCHAR2(20),
   SessionId          VARCHAR2(10),
   ErrorCode          VARCHAR2(80),
   constraint PK_ECR_ORGANRELATED primary key (CIFCustomerId, RelationShip, RelativeEntName)
);

comment on table ECR_ORGANRELATED is
'������Ҫ������ҵ ����������Ϣ�ɼ�����H�� 0��n';

comment on column ECR_ORGANRELATED.CIFCustomerId is
'�ͻ���';

comment on column ECR_ORGANRELATED.RelationShip is
'��������';

comment on column ECR_ORGANRELATED.RelativeEntName is
'������ҵ����';

comment on column ECR_ORGANRELATED.RegisterType is
'�Ǽ�ע�������';

comment on column ECR_ORGANRELATED.RegisterNo is
'�Ǽ�ע�����';

comment on column ECR_ORGANRELATED.CorpId is
'��֯��������';

comment on column ECR_ORGANRELATED.CreditCode is
'�������ô���';

comment on column ECR_ORGANRELATED.UpdateDate is
'��Ϣ��������';

comment on column ECR_ORGANRELATED.Attribute1 is
'Ԥ���ֶ�';

comment on column ECR_ORGANRELATED.OccurDate is
'��������';

comment on column ECR_ORGANRELATED.IncrementFlag is
'������־';

comment on column ECR_ORGANRELATED.Modflag is
'�޸ı�־';

comment on column ECR_ORGANRELATED.TraceNumber is
'���ٱ��';

comment on column ECR_ORGANRELATED.RecordFlag is
'��¼��־';

comment on column ECR_ORGANRELATED.SessionId is
'�����ڴ�';

comment on column ECR_ORGANRELATED.ErrorCode is
'�������';

/*==============================================================*/
/* Table: ECR_ORGANSTATUS                                       */
/*==============================================================*/
create table ECR_ORGANSTATUS  (
   CIFCustomerId      VARCHAR2(40)                    not null,
   AccountStatus      VARCHAR2(1),
   Scope              VARCHAR2(1),
   OrgStatus          VARCHAR2(1),
   UpdateDate         VARCHAR2(10),
   Attribute1         VARCHAR2(40),
   OccurDate          VARCHAR2(10),
   IncrementFlag      VARCHAR2(1),
   Modflag            VARCHAR2(1),
   TraceNumber        VARCHAR2(20),
   RecordFlag         VARCHAR2(20),
   SessionId          VARCHAR2(10),
   ErrorCode          VARCHAR2(80),
   constraint PK_ECR_ORGANSTATUS primary key (CIFCustomerId)
);

comment on table ECR_ORGANSTATUS is
'����״̬ ����������Ϣ�ɼ�����D�� 0��1';

comment on column ECR_ORGANSTATUS.CIFCustomerId is
'�ͻ���';

comment on column ECR_ORGANSTATUS.AccountStatus is
'������״̬';

comment on column ECR_ORGANSTATUS.Scope is
'��ҵ��ģ';

comment on column ECR_ORGANSTATUS.OrgStatus is
'����״̬';

comment on column ECR_ORGANSTATUS.UpdateDate is
'��Ϣ��������';

comment on column ECR_ORGANSTATUS.Attribute1 is
'Ԥ���ֶ�';

comment on column ECR_ORGANSTATUS.OccurDate is
'��������';

comment on column ECR_ORGANSTATUS.IncrementFlag is
'������־';

comment on column ECR_ORGANSTATUS.Modflag is
'�޸ı�־';

comment on column ECR_ORGANSTATUS.TraceNumber is
'���ٱ��';

comment on column ECR_ORGANSTATUS.RecordFlag is
'��¼��־';

comment on column ECR_ORGANSTATUS.SessionId is
'�����ڴ�';

comment on column ECR_ORGANSTATUS.ErrorCode is
'�������';

/*==============================================================*/
/* Table: ECR_ORGANSTOCKHOLDER                                  */
/*==============================================================*/
create table ECR_ORGANSTOCKHOLDER  (
   CIFCustomerId      VARCHAR2(40)                    not null,
   StockHolderType    VARCHAR2(1)                     not null,
   StockHolderName    VARCHAR2(80)                    not null,
   CertType           VARCHAR2(2),
   CertId             VARCHAR2(20),
   CorpId             VARCHAR2(10),
   CreditCode         VARCHAR2(18),
   StockHodingRatio   NUMBER(10,2),
   UpdateDate         VARCHAR2(10),
   Attribute1         VARCHAR2(40),
   OccurDate          VARCHAR2(10),
   IncrementFlag      VARCHAR2(1),
   Modflag            VARCHAR2(1),
   TraceNumber        VARCHAR2(20),
   RecordFlag         VARCHAR2(20),
   SessionId          VARCHAR2(10),
   ErrorCode          VARCHAR2(80),
   constraint PK_ECR_ORGANSTOCKHOLDER primary key (CIFCustomerId, StockHolderType, StockHolderName)
);

comment on table ECR_ORGANSTOCKHOLDER is
'������Ҫ�ɶ� ����������Ϣ�ɼ�����G�� 0��n';

comment on column ECR_ORGANSTOCKHOLDER.CIFCustomerId is
'�ͻ���';

comment on column ECR_ORGANSTOCKHOLDER.StockHolderType is
'�ɶ�����';

comment on column ECR_ORGANSTOCKHOLDER.StockHolderName is
'�ɶ�����';

comment on column ECR_ORGANSTOCKHOLDER.CertType is
'֤������/�Ǽ�ע�������';

comment on column ECR_ORGANSTOCKHOLDER.CertId is
'֤������/�Ǽ�ע�����';

comment on column ECR_ORGANSTOCKHOLDER.CorpId is
'��֯��������';

comment on column ECR_ORGANSTOCKHOLDER.CreditCode is
'�������ô���';

comment on column ECR_ORGANSTOCKHOLDER.StockHodingRatio is
'�ֹɱ���';

comment on column ECR_ORGANSTOCKHOLDER.UpdateDate is
'��Ϣ��������';

comment on column ECR_ORGANSTOCKHOLDER.Attribute1 is
'Ԥ���ֶ�';

comment on column ECR_ORGANSTOCKHOLDER.OccurDate is
'��������';

comment on column ECR_ORGANSTOCKHOLDER.IncrementFlag is
'������־';

comment on column ECR_ORGANSTOCKHOLDER.Modflag is
'�޸ı�־';

comment on column ECR_ORGANSTOCKHOLDER.TraceNumber is
'���ٱ��';

comment on column ECR_ORGANSTOCKHOLDER.RecordFlag is
'��¼��־';

comment on column ECR_ORGANSTOCKHOLDER.SessionId is
'�����ڴ�';

comment on column ECR_ORGANSTOCKHOLDER.ErrorCode is
'�������';

/*==============================================================*/
/* Table: ECR_ORGANSUPERIOR                                     */
/*==============================================================*/
create table ECR_ORGANSUPERIOR  (
   CIFCustomerId      VARCHAR2(40)                    not null,
   SuperiorName       VARCHAR2(80),
   RegisterType       VARCHAR2(2),
   RegisterNo         VARCHAR2(20),
   CorpId             VARCHAR2(10),
   CreditCode         VARCHAR2(18),
   UpdateDate         VARCHAR2(10),
   Attribute1         VARCHAR2(40),
   OccurDate          VARCHAR2(10),
   IncrementFlag      VARCHAR2(1),
   Modflag            VARCHAR2(1),
   TraceNumber        VARCHAR2(20),
   RecordFlag         VARCHAR2(20),
   SessionId          VARCHAR2(10),
   ErrorCode          VARCHAR2(80),
   constraint PK_ECR_ORGANSUPERIOR primary key (CIFCustomerId)
);

comment on table ECR_ORGANSUPERIOR is
'�����ϼ�����(���ܲ���) ����������Ϣ�ɼ�����I�� 0��1';

comment on column ECR_ORGANSUPERIOR.CIFCustomerId is
'�ͻ���';

comment on column ECR_ORGANSUPERIOR.SuperiorName is
'�ϼ���������';

comment on column ECR_ORGANSUPERIOR.RegisterType is
'�Ǽ�ע�������';

comment on column ECR_ORGANSUPERIOR.RegisterNo is
'�Ǽ�ע���';

comment on column ECR_ORGANSUPERIOR.CorpId is
'��֯��������';

comment on column ECR_ORGANSUPERIOR.CreditCode is
'�������ô���';

comment on column ECR_ORGANSUPERIOR.UpdateDate is
'��Ϣ��������';

comment on column ECR_ORGANSUPERIOR.Attribute1 is
'Ԥ���ֶ�';

comment on column ECR_ORGANSUPERIOR.OccurDate is
'��������';

comment on column ECR_ORGANSUPERIOR.IncrementFlag is
'������־';

comment on column ECR_ORGANSUPERIOR.Modflag is
'�޸ı�־';

comment on column ECR_ORGANSUPERIOR.TraceNumber is
'���ٱ��';

comment on column ECR_ORGANSUPERIOR.RecordFlag is
'��¼��־';

comment on column ECR_ORGANSUPERIOR.SessionId is
'�����ڴ�';

comment on column ECR_ORGANSUPERIOR.ErrorCode is
'�������';
