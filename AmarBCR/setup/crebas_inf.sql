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
   COLNAME varchar(4) NOT NULL,
   NOTE char(800),
   PRIMARY KEY (COLNAME) CONSTRAINT PK_ECR_ERRMAP
);

CREATE TABLE ECR_ACCEPTANCE
(
   ACONTRACTNO varchar(60) NOT NULL,
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
   PRIMARY KEY (ACCEPTNO) CONSTRAINT pk_ECR_ACCEPTANCE
)
;

CREATE TABLE ECR_ASSURECONT
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
   REPORTTYPE varchar(1),
    PRIMARY KEY (CONTRACTNO,ASSURECONTNO) CONSTRAINT PK_ECR_ASSURECONT
)
;

CREATE TABLE ECR_BATCHDEL
(
   CREATEDATE varchar(14) NOT NULL,
   CONTRACTNO varchar(40) NOT NULL,
   DELRESULT varchar(1),
   LOANCARDNO varchar(16),
   DELBUSINESSTYPE varchar(2),
   FINANCEID varchar(11),
  PRIMARY KEY (CREATEDATE,CONTRACTNO)   CONSTRAINT PK_ECR_BATCHDEL
)
;

CREATE TABLE ECR_CODEMAP
(
   COLNAME varchar(4) NOT NULL,
   CTCODE varchar(20) NOT NULL,
   PBCODE varchar(20) NOT NULL,
   NOTE varchar(200),
   PRIMARY KEY (COLNAME,CTCODE,PBCODE)  CONSTRAINT PK_ECR_CODEMAP
)
;

CREATE TABLE ECR_CREDITLETTER
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
   DEPOSITSCALE decimal(3,0),
   CREDITSTATUS varchar(1),
   LOGOUTDATE varchar(10),
   BALANCE decimal(24,6),
   BALANCEREPORTDATE varchar(10),
   PRIMARY KEY (CREDITLETTERNO)  CONSTRAINT PK_ECR_CREDITLETTER
)
;

CREATE TABLE ECR_CUSTCAPIINFO
(
   CUSTOMERID varchar(40) NOT NULL,
   CURRENCY varchar(3),
   REGISTSUM decimal(24,6),
   SUPERNAME varchar(80),
   SLOANCARDNO varchar(16),
   SORGCODE varchar(10),
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
    PRIMARY KEY  (CUSTOMERID)  CONSTRAINT PK_ECR_CUSTCAPIINFO
)
;

CREATE TABLE ECR_CUSTOMERCAPI
(
   CUSTOMERID varchar(40) NOT NULL,
   CAPINO varchar(60) NOT NULL,
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   OCCURDATE varchar(10),
   SESSIONID varchar(10),
   CONTRIBNAME varchar(80),
   CLOANCARDNO varchar(16),
   CORGCODE varchar(10),
   CREGISTNO varchar(20),
   CERTTYPE varchar(1),
   CERTNO varchar(18),
   CURRENCY varchar(3),
   CONTRIBSUM decimal(24,6),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   ERRORCODE varchar(80),
 PRIMARY KEY (CUSTOMERID,CAPINO)   CONSTRAINT PK_ECR_CUSTOMERCP
)
;

CREATE TABLE ECR_CUSTOMERCREDIT
(
   CCONTRACTNO varchar(60)  NOT NULL,
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
   PRIMARY KEY (CCONTRACTNO)  CONSTRAINT  pk_ECR_CUSTOMERCREDIT
)
;

CREATE TABLE ECR_CUSTOMERFACT
(
   CUSTOMERID varchar(40) NOT NULL,
   FACTNO varchar(60) NOT NULL,
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
   DESCRIBE varchar(250),
   CUSTOMERNAME varchar(80),
   PRIMARY KEY (CUSTOMERID,FACTNO) CONSTRAINT PK_ECR_CTOMERFACT 
)
;

CREATE TABLE ECR_CUSTOMERFAMILY
(
   CUSTOMERID varchar(40) NOT NULL,
   FAMILYCORPNO varchar(60) NOT NULL,
   INCREMENTFLAG varchar(1),
   OCCURDATE varchar(10),
   SESSIONID varchar(10),
   FAMILYNAME varchar(30),
   CERTTYPE varchar(1),
   CERTNO varchar(18),
   RELATION varchar(1),
   FAMILYCORPNAME varchar(80),
   FLOANCARDNO varchar(16),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   ERRORCODE varchar(80),
   PRIMARY KEY (CUSTOMERID,FAMILYCORPNO)  CONSTRAINT PK_ECR_CTFAMILY
)
;

CREATE TABLE ECR_CUSTOMERINFO
(
   CUSTOMERID varchar(40)  NOT NULL,
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
      PRIMARY KEY (CUSTOMERID)  CONSTRAINT PK_ECR_CUSTOMERINFO
)
;

CREATE TABLE ECR_CUSTOMERINVEST
(
   CUSTOMERID varchar(40) NOT NULL,
   INVESTNO varchar(60) NOT NULL,
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   OCCURDATE varchar(10),
   SESSIONID varchar(10),
   INVESTCORPNAME varchar(80),
   ILOANCARDNO varchar(16),
   IORGCODE varchar(10),
   CURRENCY1 varchar(3),
   INVESTSUM1 decimal(24,6),
   CURRENCY2 varchar(3),
   INVESTSUM2 decimal(24,6),
   CURRENCY3 varchar(3),
   INVESTSUM3 decimal(24,6),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   ERRORCODE varchar(80),
    PRIMARY KEY (CUSTOMERID,INVESTNO) CONSTRAINT PK_ECR_CUSTINVEST
)
;

CREATE TABLE ECR_CUSTOMERKEEPER
(
   CUSTOMERID varchar(40) NOT NULL,
   KEEPERNO varchar(60) NOT NULL,
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   OCCURDATE varchar(10),
   SESSIONID varchar(10),
   KEEPERNAME varchar(30),
   CERTTYPE varchar(1),
   CERTNO varchar(18),
   KEEPERTYPE varchar(1) NOT NULL,
   SEX varchar(1),
   BIRTHDATE varchar(10),
   DEGREE varchar(2),
   JOBRESUME char(500),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   ERRORCODE varchar(80),
  PRIMARY KEY (CUSTOMERID,KEEPERNO,KEEPERTYPE) CONSTRAINT PK_ECR_CUSTKEEPER 
)
;

CREATE TABLE ECR_CUSTOMERLAW
(
   CUSTOMERID varchar(40) NOT NULL,
   LAWNO varchar(60) NOT NULL,
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
   PLAINTIFFNAME varchar(80),
   CURRENCY varchar(3),
   EXECUTESUM decimal(24,6),
   EXECUTEDATE varchar(10),
   EXECUTERESULT varchar(100),
   APPELLCAUSE char(300),
   CUSTOMERNAME varchar(80),
   PRIMARY KEY (CUSTOMERID,LAWNO)   CONSTRAINT PK_ECR_CUSTOMERLAW
)
;

CREATE TABLE ECR_CUSTOMERSTOCK
(
   CUSTOMERID varchar(40) NOT NULL,
   STOCKNO varchar(10) NOT NULL,
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   OCCURDATE varchar(10),
   SESSIONID varchar(10),
   MARKETPLACE varchar(2),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   ERRORCODE varchar(80),
   PRIMARY KEY (CUSTOMERID,STOCKNO)  CONSTRAINT PK_ECR_CUSTSTOCK 
)
;

CREATE TABLE ECR_DISCOUNT
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
    PRIMARY KEY (BILLNO)  CONSTRAINT PK_ECR_DISCOUNT
)
;

CREATE TABLE ECR_ERRHISTORY
(
   SERIALNO decimal(22,0)  NOT NULL,
   RECORDTYPE varchar(2),
   RECORDKEY varchar(120),
   MESSAGETYPE varchar(2),
   ERRCODE varchar(10),
   ERRMSG char(800),
   ERRFIELD varchar(20),
   FINANCEID varchar(11),
   MAINBUSINESSNO varchar(60),
   OCCURDATE varchar(10),
   CUSTOMERID varchar(40),
   LOANCARDNO varchar(16),
   PRIMARY KEY (SERIALNO)  CONSTRAINT PK_ECR_ERRHISTORY
)
;


CREATE TABLE ECR_ERRRECORD
(
   FINANCEID varchar(11) NOT NULL,
   ERRNUMBER decimal(22,0),
   OCCURDATE varchar(10) NOT NULL,
   OCCURTIME varchar(10) NOT NULL,
   RECORDTYPE varchar(2),
   ERRFLAG varchar(1),
 PRIMARY KEY (FINANCEID,OCCURDATE,OCCURTIME)   CONSTRAINT PK_ECR_ERRRECORD 
)
;

CREATE TABLE ECR_FACTORING
(
   FACTORINGNO varchar(40)  NOT NULL,
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
   PRIMARY KEY (FACTORINGNO) CONSTRAINT  PK_ECR_FACTORING
)
;

CREATE TABLE ECR_FEEDBACK
(
   TRACENUMBER varchar(20) NOT NULL,
   RECORDTYPE varchar(2),
   RECORDKEY varchar(250),
   MESSAGETYPE varchar(2),
   ERRCODE varchar(80),
   ERRMSG char(800),
   RETRYFLAG varchar(1),
   SESSIONID varchar(10) NOT NULL,
   FINANCEID varchar(11),
   MAINBUSINESSNO varchar(60),
   CUSTOMERID varchar(40),
   LOANCARDNO varchar(16),
  PRIMARY KEY (TRACENUMBER,SESSIONID)  CONSTRAINT PK_ECR_FEEDBACK 
)
;

CREATE TABLE ECR_FINADUEBILL
(
   FDUEBILLNO varchar(40)  NOT NULL,
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
    PRIMARY KEY (FDUEBILLNO)  CONSTRAINT PK_ECR_FINADUEBILL
)
;

CREATE TABLE ECR_FINAEXTENSION
(
   FDUEBILLNO varchar(60) NOT NULL,
   OCCURDATE varchar(10),
   FCONTRACTNO varchar(60),
   EXTENTIMES varchar(2) NOT NULL,
   EXTENSUM decimal(24,6),
   EXTENENDDATE varchar(10),
   EXTENSTARTDATE varchar(10),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
    PRIMARY KEY (FDUEBILLNO,EXTENTIMES) CONSTRAINT PK_ECR_FISION
)
;

CREATE TABLE ECR_FINAINFO
(
   FCONTRACTNO varchar(60)  NOT NULL,
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
    PRIMARY KEY (FCONTRACTNO) CONSTRAINT PK_ECR_FINAINFO
)
;

CREATE TABLE ECR_FINANCEBS
(
   CUSTOMERID varchar(40) NOT NULL,
   REPORTYEAR varchar(4) NOT NULL,
   REPORTTYPE varchar(2) NOT NULL,
   REPORTSUBTYPE varchar(1) NOT NULL,
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
   AUDITFIRM varchar(80),
   AUDITOR varchar(30),
   AUDITDATE varchar(10),
   CUSTOMERNAME varchar(80),
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
 PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)   CONSTRAINT PK_ECR_FINANCEBS 
)
;

CREATE TABLE ECR_FINANCEBS_2007
(
   CUSTOMERID varchar(40) NOT NULL,
   REPORTYEAR char(4) NOT NULL,
   REPORTTYPE char(2) NOT NULL,
   REPORTSUBTYPE char(1) NOT NULL,
   OCCURDATE varchar(10),
   OLDFINANCEID varchar(59),
   FINANCEID varchar(11),
   LOANCARDNO varchar(16),
   CUSTOMERNAME varchar(80),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   AUDITFIRM varchar(80),
   AUDITOR varchar(30),
   AUDITDATE varchar(10),
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
   PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)  CONSTRAINT PK_ECR_FINANCEBS07 
)
;

CREATE TABLE ECR_FINANCEBS_IN
(
   CUSTOMERID varchar(40) NOT NULL,
   REPORTYEAR char(4) NOT NULL,
   REPORTTYPE char(2) NOT NULL,
   REPORTSUBTYPE char(1) NOT NULL,
   OCCURDATE varchar(10),
   OLDFINANCEID varchar(59),
   FINANCEID varchar(11),
   LOANCARDNO varchar(16),
   INCREMENTFLAG varchar(1),
   CUSTOMERNAME varchar(80),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   AUDITFIRM varchar(80),
   AUDITOR varchar(30),
   AUDITDATE varchar(10),
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
   PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)   CONSTRAINT PK_ECR_FINANCEBSIN 
)
;

CREATE TABLE ECR_FINANCECF
(
   CUSTOMERID varchar(40) NOT NULL,
   REPORTYEAR varchar(4) NOT NULL,
   REPORTTYPE varchar(2) NOT NULL,
   REPORTSUBTYPE varchar(1) NOT NULL,
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
   AUDITFIRM varchar(80),
   AUDITOR varchar(30),
   AUDITDATE varchar(10),
   CUSTOMERNAME varchar(80),
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
 PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)    CONSTRAINT PK_ECR_FINANCECF
)
;

CREATE TABLE ECR_FINANCECF_2007
(
   CUSTOMERID varchar(40) NOT NULL,
   REPORTYEAR char(4) NOT NULL,
   REPORTTYPE char(2) NOT NULL,
   REPORTSUBTYPE char(1) NOT NULL,
   OCCURDATE varchar(10),
   OLDFINANCEID varchar(59),
   FINANCEID varchar(11),
   LOANCARDNO varchar(16),
   CUSTOMERNAME varchar(80),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   AUDITFIRM varchar(80),
   AUDITOR varchar(30),
   AUDITDATE varchar(10),
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
 PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)    CONSTRAINT PK_ECR_FINANCECF07
)
;

CREATE TABLE ECR_FINANCEPS
(
   CUSTOMERID varchar(40) NOT NULL,
   REPORTYEAR varchar(4) NOT NULL,
   REPORTTYPE varchar(2) NOT NULL,
   REPORTSUBTYPE varchar(1) NOT NULL,
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
   AUDITFIRM varchar(80),
   AUDITOR varchar(30),
   AUDITDATE varchar(10),
   CUSTOMERNAME varchar(80),
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
   PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)  CONSTRAINT PK_ECR_FINANCEPS
)
;

CREATE TABLE ECR_FINANCEPS_2007
(
   CUSTOMERID varchar(40) NOT NULL,
   REPORTYEAR char(4) NOT NULL,
   REPORTTYPE char(2) NOT NULL,
   REPORTSUBTYPE char(1) NOT NULL,
   OCCURDATE varchar(10),
   OLDFINANCEID varchar(59),
   FINANCEID varchar(11),
   LOANCARDNO varchar(16),
   CUSTOMERNAME varchar(80),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   AUDITFIRM varchar(80),
   AUDITOR varchar(30),
   AUDITDATE varchar(10),
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
   PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE) CONSTRAINT PK_ECR_FINANCEPS07 
)
;

CREATE TABLE ECR_FINANCECF_IN
(
   CUSTOMERID varchar(40) NOT NULL,
   REPORTYEAR char(4) NOT NULL,
   REPORTTYPE char(2) NOT NULL,
   REPORTSUBTYPE char(1) NOT NULL,
   OCCURDATE varchar(10),
   OLDFINANCEID varchar(59),
   FINANCEID varchar(11),
   LOANCARDNO varchar(16),
   CUSTOMERNAME varchar(80),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   AUDITFIRM varchar(80),
   AUDITOR varchar(30),
   AUDITDATE varchar(10),
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
   PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)  CONSTRAINT PK_ECR_FINANCECFIN
)
;

CREATE TABLE ECR_FINARETURN
(
   FDUEBILLNO varchar(40) NOT NULL,
   OCCURDATE varchar(10),
   FCONTRACTNO varchar(40),
   RETURNTIMES decimal(22,0) NOT NULL,
   RETURNMODE varchar(2),
   RETURNSUM decimal(24,6),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   RETURNDATE varchar(10),
  PRIMARY KEY (FDUEBILLNO,RETURNTIMES)   CONSTRAINT PK_ECR_FINARETURN
)
;

CREATE TABLE ECR_FLOORFUND
(
   FLOORFUNDNO varchar(60)  NOT NULL,
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
   PRIMARY KEY (FLOORFUNDNO)   CONSTRAINT PK_ECR_FLOORFUND
)
;

CREATE TABLE ECR_GUARANTEEBILL
(
   GUARANTEEBILLNO varchar(60)  NOT NULL,
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
   PRIMARY KEY (GUARANTEEBILLNO)   CONSTRAINT PK_ECR_GUARANTEEBILL
)
;

CREATE TABLE ECR_GUARANTYCONT
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
    PRIMARY KEY (CONTRACTNO,GUARANTYCONTNO,GUARANTYSERIALNO) CONSTRAINT PK_ECR_GUCONT
)
;

CREATE TABLE ECR_IMPAWNCONT
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
    PRIMARY KEY (CONTRACTNO,IMPAWNCONTNO,IMPAWSERIALNO)  CONSTRAINT PK_ECR_IMPAWNCONT
)
;

CREATE TABLE ECR_INTERESTDUE
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
   PRIMARY KEY (CUSTOMERID,INTERESTTYPE,CURRENCY,FINANCEID)   CONSTRAINT PK_ECR_INTERESTDUE
)
;

CREATE TABLE ECR_LOANCARD
(
   OCCURDATE varchar(10),
   LOANCARDNO varchar(60)  NOT NULL,
   LOANCARDPASSWORD varchar(6),
   STATUS decimal(22,0),
   COUNTRYCODE varchar(3),
   CHINESENAME varchar(80),
   ENGLISHNAME varchar(80),
   ORGANIZATIONCODE varchar(10),
   LICENCECODE varchar(20),
   REGISTERDATE varchar(10),
   KIND decimal(22,0),
   AREACODE varchar(6),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
     PRIMARY KEY (LOANCARDNO)   CONSTRAINT PK_ECR_LOANCARD
)
;

CREATE TABLE ECR_LOANCARDNOCHANGE
(
   CUSTOMERID varchar(40) NOT NULL,
   OLDLOANCARDNO varchar(16) NOT NULL,
   NEWLOANCARDNO varchar(16) NOT NULL,
   CUSTOMERNAME varchar(80),
   FINANCEID varchar(11) NOT NULL,
   ISPROCESSED varchar(1),
   ISREADY varchar(1),
   INPUTDATE varchar(10),
    PRIMARY KEY (CUSTOMERID,OLDLOANCARDNO,NEWLOANCARDNO,FINANCEID) CONSTRAINT LOANCARDCHANGE
)
;

CREATE TABLE ECR_LOANCONTRACT
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
   PRIMARY KEY  (LCONTRACTNO)  CONSTRAINT   PK_ECR_LOANCONTRACT
)
;

CREATE TABLE ECR_LOANDUEBILL
(
   LDUEBILLNO varchar(60)  NOT NULL,
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
   PRIMARY KEY  (LDUEBILLNO)  CONSTRAINT   PK_ECR_LOANDUEBILL
)
;

CREATE TABLE ECR_LOANEXTENSION
(
   LDUEBILLNO varchar(60) NOT NULL,
   OCCURDATE varchar(10),
   LCONTRACTNO varchar(60),
   UPDATEDATE varchar(10),
   EXTENTIMES varchar(2) NOT NULL,
   EXTENSUM decimal(24,6),
   EXTENSTARTDATE varchar(10),
   EXTENENDDATE varchar(10),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   PRIMARY KEY (LDUEBILLNO,EXTENTIMES)  CONSTRAINT PK_ECR_LTENSION
)
;

CREATE TABLE ECR_LOANRETURN
(
   LDUEBILLNO varchar(60) NOT NULL,
   OCCURDATE varchar(10),
   LCONTRACTNO varchar(60),
   RETURNDATE varchar(10),
   RETURNTIMES decimal(22,0) NOT NULL,
   RETURNMODE varchar(2),
   RETURNSUM decimal(24,6),
   INCREMENTFLAG varchar(1),
   MODFLAG varchar(1),
   TRACENUMBER varchar(20),
   RECORDFLAG varchar(20),
   SESSIONID varchar(10),
   ERRORCODE varchar(80),
   PRIMARY KEY (LDUEBILLNO,RETURNTIMES)   CONSTRAINT PK_ECR_LOANRETURN
)
;

CREATE TABLE ECR_PREPAREDATE
(
   LASTPREPAREDATE varchar(10) NOT NULL,
   PRIMARY KEY (LASTPREPAREDATE)  CONSTRAINT PK_ECR_PREPAREDATE
)
;

CREATE TABLE ECR_PREPARESTATUS
(
   LASTPREPAREDATE date  NOT NULL,
   RUNSTATUS varchar(1),
   PRIMARY KEY (LASTPREPAREDATE)  CONSTRAINT PK_ECR_PREPARESTATUS
)
;

CREATE TABLE ECR_REPORTSTATUS
(
   SESSIONID varchar(10)  NOT NULL,
   MESSAGETYPE varchar(2),
   RETRYTYPE varchar(1),
   RECORDNUMBER decimal(22,0),
   FEEDBACKNUMBER decimal(22,0),
   FEEDBACKDATE varchar(20),
   PRIMARY KEY (SESSIONID)  CONSTRAINT PK_ECR_REPORTSTATUS
)
;

CREATE TABLE ECR_RUNSTATUS
(
   RUNRESULT varchar(1),
   RUNSTATUS varchar(3)
)
;
CREATE TABLE ECR_SESSION
(
   SESSIONID varchar(10)  NOT NULL,
   STATUS decimal(22,0),
   DATATYPE decimal(22,0),
   MESSAGESETTYPE varchar(2),
   CREATETIME date,
   PREVIOUSSESSIONID varchar(10),
   FINANCEID varchar(11),
   NOTE varchar(200),
   PRIMARY KEY (SESSIONID)  CONSTRAINT PK_ECR_SESSION
)
;

CREATE TABLE ECR_TRANSFERFILTER
(
   MAINBUSINESSNO varchar(60) NOT NULL,
   RECORDSCOPE varchar(60) NOT NULL,
   FILTERCAUSE varchar(1) NOT NULL,
   UPDATETIME date,
   OPERATOR varchar(10),
   NOTE varchar(60),
  PRIMARY KEY (MAINBUSINESSNO,RECORDSCOPE,FILTERCAUSE)   CONSTRAINT PK_ECR_TFILTER 
)
;

CREATE TABLE ECR_ASSETSDISPOSE
(
  BUSINESSNO varchar(60) NOT NULL,			--业务编号
  FINANCEID  varchar(11),					--金融机构代码
  OLDFINANCEID  varchar(59),
  CUSTOMERID     varchar(40),				--客户编号
  CUSTOMERNAME  varchar(80),				--借款人名称
  LOANCARDNO      varchar(16),				--贷款卡编码
  ORGANIZATIONCODE  varchar(11),			--组织机构代码
  BUSINESSREGISTRYNO varchar(20),			--工商注册登记号
  BALANCE decimal(24,6),					--余额
  DISPOSEDATE varchar(10),					--处置日期
  DISPOSETYPE varchar(1),					--主要资产处置方式
  RECOVERYAMOUNT decimal(24,6),				--已回收金额
  OCCURDATE      varchar(10),
  INCREMENTFLAG  varchar(1),
  MODFLAG        varchar(1),
  TRACENUMBER    varchar(20),
  RECORDFLAG     varchar(20),
  SESSIONID      varchar(10),
  ERRORCODE      varchar(80),
  PRIMARY KEY (BUSINESSNO)   CONSTRAINT PK_ECR_ASSETSDISPOSE 
);