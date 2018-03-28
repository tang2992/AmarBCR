--==============================================================
-- DBMS name:      IBM DB2 UDB 8.x Common Server
-- Created on:     2009-8-5 17:43:47
--==============================================================


drop table ECR_ALSDATACHECK;

drop table ECR_ECRDATACHECK;

drop table ECR_PBCDATACHECK;

drop table ECR_PBC_ACCEPTANCE;

drop table ECR_PBC_ASSURECONT;

drop table ECR_PBC_CREDITLETTER;

drop table ECR_PBC_CUSTOMERCREDIT;

drop table ECR_PBC_DISCOUNT;

drop table ECR_PBC_FACTORING;

drop table ECR_PBC_FINADUEBILL;

drop table ECR_PBC_FINAINFO;

drop table ECR_PBC_FLOORFUND;

drop table ECR_PBC_GUARANTEEBILL;

drop table ECR_PBC_GUARANTYCONT;

drop table ECR_PBC_IMPAWNCONT;

drop table ECR_PBC_INTERESTDUE;

drop table ECR_PBC_LOANCONTRACT;

drop table ECR_PBC_LOANDUEBILL;

drop table ECR_TEMP_BC;

drop table ECR_TEMP_BD;

drop table ECR_TEMP_GC;

drop table ecr_exteriorcheck;

drop table ecr_interiorcheck;

--==============================================================
-- Table: ECR_ALSDATACHECK
--==============================================================
create table ECR_ALSDATACHECK
(
   LOANCARDNO           VARCHAR(16)            not null,
   CUSTOMERNAME         VARCHAR(80),
   LOANCONTRACTNUM      INTEGER,
   LOANDUEBILLNUM       INTEGER,
   FACTORINGNUM         INTEGER,
   DISCOUNTNUM          INTEGER,
   FINAINFONUM          INTEGER,
   FINADUEBILLNUM       INTEGER,
   CREDITLETTERNUM      INTEGER,
   GUARANTEEBILLNUM     INTEGER,
   ACCEPTNUM            INTEGER,
   CUSTOMERCREDITNUM    INTEGER,
   ASSURECONTNUM        INTEGER,
   GUARANTYCONTNUM      INTEGER,
   IMPAWNCONTNUM        INTEGER,
   FLOORFUNDNUM         INTEGER,
   LOANSUM              NUMERIC(24,6),
   FACTORINGOUTSUM      NUMERIC(24,6),
   DISCOUNTOUTSUM       NUMERIC(24,6),
   FINAOUTSUM           NUMERIC(24,6),
   CREDITLETTEROUTSUM   NUMERIC(24,6),
   GUARANTEEBILLOUTSUM  NUMERIC(24,6),
   ACCEPTOUTSUM         NUMERIC(24,6),
   CUSTOMERCREDITOUTSUM NUMERIC(24,6),
   ASSURECONTOUTSUM     NUMERIC(24,6),
   GUARANTYCONTOUTSUM   NUMERIC(24,6),
   IMPAWNCONTOUTSUM     NUMERIC(24,6),
   FLOORFUNDOUTSUM      NUMERIC(24,6),
   LOANBALANCE          NUMERIC(24,6),
   FACTORINGBALANCE     NUMERIC(24,6),
   DISCOUNTBALANCE      NUMERIC(24,6),
   FINABALANCE          NUMERIC(24,6),
   CREDITLETTERBALANCE  NUMERIC(24,6),
   GUARANTEEBILLBALANCE NUMERIC(24,6),
   ACCEPTBALANCE        NUMERIC(24,6),
   ASSURECONTBALANCE    NUMERIC(24,6),
   GUARANTYCONTBALANCE  NUMERIC(24,6),
   IMPAWNCONTBALANCE    NUMERIC(24,6),
   FLOORFUNDBALANCE     NUMERIC(24,6),
   INTERESTBALANCE1     NUMERIC(24,6),
   INTERESTBALANCE2     NUMERIC(24,6),
   STATUS               VARCHAR(2),
   CORPID               VARCHAR(10),
   OCCURDATE            VARCHAR(10),
   OLDFINANCEID         VARCHAR(59),
   INCREMENTFLAG        VARCHAR(1),
   constraint P_Key_1 primary key (LOANCARDNO)
);

--==============================================================
-- Table: ECR_ECRDATACHECK
--==============================================================
create table ECR_ECRDATACHECK
(
   LOANCARDNO           VARCHAR(16)            not null,
   CUSTOMERNAME         VARCHAR(80),
   LOANCONTRACTNUM      INTEGER,
   LOANDUEBILLNUM       INTEGER,
   FACTORINGNUM         INTEGER,
   DISCOUNTNUM          INTEGER,
   FINAINFONUM          INTEGER,
   FINADUEBILLNUM       INTEGER,
   CREDITLETTERNUM      INTEGER,
   GUARANTEEBILLNUM     INTEGER,
   ACCEPTNUM            INTEGER,
   CUSTOMERCREDITNUM    INTEGER,
   ASSURECONTNUM        INTEGER,
   GUARANTYCONTNUM      INTEGER,
   IMPAWNCONTNUM        INTEGER,
   FLOORFUNDNUM         INTEGER,
   LOANSUM              NUMERIC(24,6),
   FACTORINGOUTSUM      NUMERIC(24,6),
   DISCOUNTOUTSUM       NUMERIC(24,6),
   FINAOUTSUM           NUMERIC(24,6),
   CREDITLETTEROUTSUM   NUMERIC(24,6),
   GUARANTEEBILLOUTSUM  NUMERIC(24,6),
   ACCEPTOUTSUM         NUMERIC(24,6),
   CUSTOMERCREDITOUTSUM NUMERIC(24,6),
   ASSURECONTOUTSUM     NUMERIC(24,6),
   GUARANTYCONTOUTSUM   NUMERIC(24,6),
   IMPAWNCONTOUTSUM     NUMERIC(24,6),
   FLOORFUNDOUTSUM      NUMERIC(24,6),
   LOANBALANCE          NUMERIC(24,6),
   FACTORINGBALANCE     NUMERIC(24,6),
   DISCOUNTBALANCE      NUMERIC(24,6),
   FINABALANCE          NUMERIC(24,6),
   CREDITLETTERBALANCE  NUMERIC(24,6),
   GUARANTEEBILLBALANCE NUMERIC(24,6),
   ACCEPTBALANCE        NUMERIC(24,6),
   ASSURECONTBALANCE    NUMERIC(24,6),
   GUARANTYCONTBALANCE  NUMERIC(24,6),
   IMPAWNCONTBALANCE    NUMERIC(24,6),
   FLOORFUNDBALANCE     NUMERIC(24,6),
   INTERESTBALANCE1     NUMERIC(24,6),
   INTERESTBALANCE2     NUMERIC(24,6),
   STATUS               VARCHAR(2),
   CORPID               VARCHAR(10),
   OCCURDATE            VARCHAR(10),
   OLDFINANCEID         VARCHAR(59),
   INCREMENTFLAG        VARCHAR(1),
   constraint P_Key_1 primary key (LOANCARDNO)
);

--==============================================================
-- Table: ECR_PBCDATACHECK
--==============================================================
create table ECR_PBCDATACHECK
(
   LOANCARDNO           VARCHAR(16)            not null,
   CUSTOMERNAME         VARCHAR(80),
   LOANCONTRACTNUM      INTEGER,
   LOANDUEBILLNUM       INTEGER,
   FACTORINGNUM         INTEGER,
   DISCOUNTNUM          INTEGER,
   FINAINFONUM          INTEGER,
   FINADUEBILLNUM       INTEGER,
   CREDITLETTERNUM      INTEGER,
   GUARANTEEBILLNUM     INTEGER,
   ACCEPTNUM            INTEGER,
   CUSTOMERCREDITNUM    INTEGER,
   ASSURECONTNUM        INTEGER,
   GUARANTYCONTNUM      INTEGER,
   IMPAWNCONTNUM        INTEGER,
   FLOORFUNDNUM         INTEGER,
   LOANSUM              NUMERIC(24,6),
   FACTORINGOUTSUM      NUMERIC(24,6),
   DISCOUNTOUTSUM       NUMERIC(24,6),
   FINAOUTSUM           NUMERIC(24,6),
   CREDITLETTEROUTSUM   NUMERIC(24,6),
   GUARANTEEBILLOUTSUM  NUMERIC(24,6),
   ACCEPTOUTSUM         NUMERIC(24,6),
   CUSTOMERCREDITOUTSUM NUMERIC(24,6),
   ASSURECONTOUTSUM     NUMERIC(24,6),
   GUARANTYCONTOUTSUM   NUMERIC(24,6),
   IMPAWNCONTOUTSUM     NUMERIC(24,6),
   FLOORFUNDOUTSUM      NUMERIC(24,6),
   LOANBALANCE          NUMERIC(24,6),
   FACTORINGBALANCE     NUMERIC(24,6),
   DISCOUNTBALANCE      NUMERIC(24,6),
   FINABALANCE          NUMERIC(24,6),
   CREDITLETTERBALANCE  NUMERIC(24,6),
   GUARANTEEBILLBALANCE NUMERIC(24,6),
   ACCEPTBALANCE        NUMERIC(24,6),
   ASSURECONTBALANCE    NUMERIC(24,6),
   GUARANTYCONTBALANCE  NUMERIC(24,6),
   IMPAWNCONTBALANCE    NUMERIC(24,6),
   FLOORFUNDBALANCE     NUMERIC(24,6),
   INTERESTBALANCE1     NUMERIC(24,6),
   INTERESTBALANCE2     NUMERIC(24,6),
   STATUS               VARCHAR(2),
   CORPID               VARCHAR(10),
   OCCURDATE            VARCHAR(10),
   OLDFINANCEID         VARCHAR(59),
   INCREMENTFLAG        VARCHAR(1),
   constraint P_Key_1 primary key (LOANCARDNO)
);

--==============================================================
-- Table: ECR_PBC_ACCEPTANCE
--==============================================================
create table ECR_PBC_ACCEPTANCE
(
   OPERATIONID          VARCHAR(20)            not null,
   ACONTRACTNO          VARCHAR(60),
   ACCEPTNO             VARCHAR(20),
   REMITTERNAME         VARCHAR(80),
   ACCEPDATE            VARCHAR(10),
   ACCEPENDDATE         VARCHAR(10),
   ACCEPPAYDATE         VARCHAR(10),
   BAILSCALE            NUMERIC(3),
   POSTATECODE          VARCHAR(5),
   CREDITNO             VARCHAR(60),
   GuarantyFlag         VARCHAR(5),
   FLOORFLAG            VARCHAR(5),
   CLASSIFY5            VARCHAR(5),
   CURRENCY             VARCHAR(5),
   BUSINESSSUM          NUMERIC(24,6),
   BUSINESSSUMTORMB     NUMERIC(24,6),
   BUSINESSSUMTOUSD     NUMERIC(24,6),
   FINANCECODE          VARCHAR(14)            not null,
   LOANCARDNO           VARCHAR(16)            not null,
   OPROCCURDATE         VARCHAR(10),
   LOADDATE             VARCHAR(10),
   FILEID               VARCHAR(16),
   constraint P_Key_1 primary key (OPERATIONID)
);

--==============================================================
-- Table: ECR_PBC_ASSURECONT
--==============================================================
create table ECR_PBC_ASSURECONT
(
   OPERATIONID          VARCHAR(20)            not null,
   GUARANTORNAME        VARCHAR(80),
   ASSUREKINDCODE       VARCHAR(5),
   VOUCHNO              VARCHAR(60),
   CONTRACTNO           VARCHAR(60),
   LOANKINDCODE         VARCHAR(5),
   MAINLOANCARDCODE     VARCHAR(60),
   COPERATIONID         NUMERIC(20),
   CONTRACTSIGNDATE     VARCHAR(10),
   CURRENCY             VARCHAR(5),
   VOUCHSUM             NUMERIC(24,6),
   VOUCHSUMTORMB        NUMERIC(24,6),
   VOUCHSUMTOUSD        NUMERIC(24,6),
   AVAILABLESTATUS      VARCHAR(5),
   FINANCECODE          VARCHAR(14)            not null,
   LOANCARDNO           VARCHAR(16)            not null,
   OPROCCURDATE         VARCHAR(10),
   LOADDATE             VARCHAR(10),
   FILEID               VARCHAR(16),
   constraint P_Key_1 primary key (OPERATIONID)
);

--==============================================================
-- Table: ECR_PBC_CREDITLETTER
--==============================================================
create table ECR_PBC_CREDITLETTER
(
   OPERATIONID          VARCHAR(20)            not null,
   CREDITLETTERNO       VARCHAR(60),
   BORROWERNAME         VARCHAR(80),
   CREATEDATE           VARCHAR(10),
   AVAILABTERM          VARCHAR(10),
   PAYTERM              VARCHAR(5),
   DEPOSITSCALE         NUMERIC(3),
   CREDITSTATUS         VARCHAR(5),
   LOGOUTDATE           VARCHAR(10),
   BALANCE              NUMERIC(24,6),
   BALANCETORMB         NUMERIC(24,6),
   BALANCETOUSD         NUMERIC(24,6),
   BALANCEREPORTDATE    VARCHAR(10),
   CREDITNO             VARCHAR(60),
   GuarantyFlag         VARCHAR(5),
   FLOORFLAG            VARCHAR(5),
   CLASSIFY5            VARCHAR(5),
   CURRENCY             VARCHAR(5),
   BUSINESSSUM          NUMERIC(24,6),
   BUSINESSSUMTORMB     NUMERIC(24,6),
   BUSINESSSUMTOUSD     NUMERIC(24,6),
   FINANCECODE          VARCHAR(14)            not null,
   LOANCARDNO           VARCHAR(16)            not null,
   OPROCCURDATE         VARCHAR(10),
   LOADDATE             VARCHAR(10),
   FILEID               VARCHAR(16),
   constraint P_Key_1 primary key (OPERATIONID)
);

--==============================================================
-- Table: ECR_PBC_CUSTOMERCREDIT
--==============================================================
create table ECR_PBC_CUSTOMERCREDIT
(
   OPERATIONID          VARCHAR(20)            not null,
   CREDITAGREEMENTCODE  VARCHAR(60),
   BORROWERNAME         VARCHAR(80),
   STARTDATE            VARCHAR(10),
   ENDDATE              VARCHAR(10),
   LIMITATIONPAUSEINUREDATE VARCHAR(10),
   LIMITATIONPAUSECODE  VARCHAR(5),
   CURRENCY             VARCHAR(5),
   BUSINESSSUM          NUMERIC(24,6),
   BUSINESSSUMTORMB     NUMERIC(24,6),
   BUSINESSSUMTOUSD     NUMERIC(24,6),
   FINANCECODE          VARCHAR(14)            not null,
   LOANCARDNO           VARCHAR(16)            not null,
   OPROCCURDATE         VARCHAR(10),
   LOADDATE             VARCHAR(10),
   FILEID               VARCHAR(16),
   constraint P_Key_1 primary key (OPERATIONID)
);

--==============================================================
-- Table: ECR_PBC_DISCOUNT
--==============================================================
create table ECR_PBC_DISCOUNT
(
   OPERATIONID          VARCHAR(20)            not null,
   BILLNO               VARCHAR(60),
   CREDITNO             VARCHAR(60),
   BILLKIND             VARCHAR(5),
   DISCOUNTPROPOSERNAME VARCHAR(80),
   ACCEPTERNAME         VARCHAR(80),
   ALOANCARDNO          VARCHAR(16),
   ACCEPTERORGANCODE    VARCHAR(10),
   ACCEPTLASTDATE       VARCHAR(10),
   BILLSUM              NUMERIC(24,6),
   BILLSUMTORMB         NUMERIC(24,6),
   BILLSUMTOUSD         NUMERIC(24,6),
   DISCOUNTDATE         VARCHAR(10),
   BILLSTATUS           VARCHAR(5),
   CLASSIFY4            VARCHAR(5),
   CLASSIFY5            VARCHAR(5),
   CURRENCY             VARCHAR(5),
   BUSINESSSUM          NUMERIC(24,6),
   BUSINESSSUMTORMB     NUMERIC(24,6),
   BUSINESSSUMTOUSD     NUMERIC(24,6),
   FINANCECODE          VARCHAR(14)            not null,
   LOANCARDNO           VARCHAR(16)            not null,
   OPROCCURDATE         VARCHAR(10),
   LOADDATE             VARCHAR(10),
   FILEID               VARCHAR(16),
   constraint P_Key_1 primary key (OPERATIONID)
);

--==============================================================
-- Table: ECR_PBC_FACTORING
--==============================================================
create table ECR_PBC_FACTORING
(
   OPERATIONID          VARCHAR(20)            not null,
   FACTORINGNO          VARCHAR(60),
   CREDITNO             VARCHAR(60),
   FACTORINGSTATUS      VARCHAR(5),
   BORROWERNAME         VARCHAR(80),
   BUSINESSDATE         VARCHAR(10),
   BALANCECHANGEDATE    VARCHAR(10),
   GUARANTEEFLAG        VARCHAR(5),
   FLOORFLAG            VARCHAR(5),
   BUSINESSTYPE         VARCHAR(40),
   BALANCE              NUMERIC(24,6),
   BALANCETORMB         NUMERIC(24,6),
   BALANCETOUSD         NUMERIC(24,6),
   CLASSIFY5            VARCHAR(5),
   CLASSIFY4            VARCHAR(5),
   CURRENCY             VARCHAR(5),
   BUSINESSSUM          NUMERIC(24,6),
   BUSINESSSUMTORMB     NUMERIC(24,6),
   BUSINESSSUMTOUSD     NUMERIC(24,6),
   FINANCECODE          VARCHAR(14)            not null,
   LOANCARDNO           VARCHAR(16)            not null,
   OPROCCURDATE         VARCHAR(10),
   LOADDATE             VARCHAR(10),
   FILEID               VARCHAR(16),
   constraint P_Key_1 primary key (OPERATIONID)
);

--==============================================================
-- Table: ECR_PBC_FINADUEBILL
--==============================================================
create table ECR_PBC_FINADUEBILL
(
   OPERATIONID          VARCHAR(20)            not null,
   FDUEBILLNO           VARCHAR(60),
   FCONTRACTNO          VARCHAR(60),
   FCONTRACTID          NUMERIC(20),
   PUTOUTDATE           VARCHAR(10),
   PUTOUTENDDATE        VARCHAR(10),
   EXTENFLAG            VARCHAR(5),
   BUSINESSTYPE         VARCHAR(40),
   BALANCE              NUMERIC(24,6),
   BALANCETORMB         NUMERIC(24,6),
   BALANCETOUSD         NUMERIC(24,6),
   CLASSIFY5            VARCHAR(5),
   CLASSIFY4            VARCHAR(5),
   CURRENCY             VARCHAR(5),
   BUSINESSSUM          NUMERIC(24,6),
   BUSINESSSUMTORMB     NUMERIC(24,6),
   BUSINESSSUMTOUSD     NUMERIC(24,6),
   FINANCECODE          VARCHAR(14)            not null,
   LOANCARDNO           VARCHAR(16)            not null,
   OPROCCURDATE         VARCHAR(10),
   LOADDATE             VARCHAR(10),
   FILEID               VARCHAR(16),
   constraint P_Key_1 primary key (OPERATIONID)
);

--==============================================================
-- Table: ECR_PBC_FINAINFO
--==============================================================
create table ECR_PBC_FINAINFO
(
   OPERATIONID          VARCHAR(20)            not null,
   FINANCINGAGREEMENTCODE VARCHAR(60),
   CREDITNO             VARCHAR(60),
   BORROWERNAME         VARCHAR(80),
   STARTDATE            VARCHAR(10),
   ENDDATE              VARCHAR(10),
   GUARANTEEFLAG        VARCHAR(5),
   AVAILABLESTATUS      VARCHAR(5),
   FINANCECODE          VARCHAR(14)            not null,
   LOANCARDNO           VARCHAR(16)            not null,
   OPROCCURDATE         VARCHAR(10),
   LOADDATE             VARCHAR(10),
   FILEID               VARCHAR(16),
   constraint P_Key_1 primary key (OPERATIONID)
);

--==============================================================
-- Table: ECR_PBC_FLOORFUND
--==============================================================
create table ECR_PBC_FLOORFUND
(
   OPERATIONID          VARCHAR(20)            not null,
   FLOORFUNDNO          VARCHAR(60),
   BUSINESSNO           VARCHAR(60),
   COPERATIONID         NUMERIC(20),
   BORROWERNAME         VARCHAR(80),
   FLOORDATE            VARCHAR(10),
   BALANCEOCCURDATE     VARCHAR(10),
   RETURNMODE           VARCHAR(5),
   BUSINESSTYPE         VARCHAR(40),
   BALANCE              NUMERIC(24,6),
   BALANCETORMB         NUMERIC(24,6),
   BALANCETOUSD         NUMERIC(24,6),
   CLASSIFY5            VARCHAR(5),
   CLASSIFY4            VARCHAR(5),
   CURRENCY             VARCHAR(5),
   BUSINESSSUM          NUMERIC(24,6),
   BUSINESSSUMTORMB     NUMERIC(24,6),
   BUSINESSSUMTOUSD     NUMERIC(24,6),
   FINANCECODE          VARCHAR(14)            not null,
   LOANCARDNO           VARCHAR(16)            not null,
   OPROCCURDATE         VARCHAR(10),
   LOADDATE             VARCHAR(10),
   FILEID               VARCHAR(16),
   constraint P_Key_1 primary key (OPERATIONID)
);

--==============================================================
-- Table: ECR_PBC_GUARANTEEBILL
--==============================================================
create table ECR_PBC_GUARANTEEBILL
(
   OPERATIONID          VARCHAR(20)            not null,
   GUARANTEEBILLNO      VARCHAR(60),
   BORROWERNAME         VARCHAR(80),
   GUARANTEETYPE        VARCHAR(5),
   GUARANTEESTATUS      VARCHAR(5),
   STARTDATE            VARCHAR(10),
   ENDDATE              VARCHAR(10),
   ASSURESCALE          NUMERIC(3),
   BALANCE              NUMERIC(24,6),
   BALANCETORMB         NUMERIC(24,6),
   BALANCETOUSD         NUMERIC(24,6),
   BALANCEOCCURDATE     VARCHAR(10),
   CREDITNO             VARCHAR(60),
   GuarantyFlag         VARCHAR(5),
   FLOORFLAG            VARCHAR(5),
   CLASSIFY5            VARCHAR(5),
   CURRENCY             VARCHAR(5),
   BUSINESSSUM          NUMERIC(24,6),
   BUSINESSSUMTORMB     NUMERIC(24,6),
   BUSINESSSUMTOUSD     NUMERIC(24,6),
   FINANCECODE          VARCHAR(14)            not null,
   LOANCARDNO           VARCHAR(16)            not null,
   OPROCCURDATE         VARCHAR(10),
   LOADDATE             VARCHAR(10),
   FILEID               VARCHAR(16),
   constraint P_Key_1 primary key (OPERATIONID)
);

--==============================================================
-- Table: ECR_PBC_GUARANTYCONT
--==============================================================
create table ECR_PBC_GUARANTYCONT
(
   OPERATIONID          VARCHAR(20)            not null,
   PLEDGESERIAL         NUMERIC(2),
   PLEDGERNAME          VARCHAR(80),
   EVALUATECURRENCY     VARCHAR(5),
   EVALUATEPLEDGESUM    NUMERIC(24,6),
   EVALUATEDATE         VARCHAR(10),
   EVALUATEORGANNAME    VARCHAR(80),
   EVALUATEORGANCODE    VARCHAR(10),
   PLEDGEKINDCODE       VARCHAR(5),
   REGISTERORGANNAME    VARCHAR(80),
   REGISTERDATE         VARCHAR(10),
   PLEDGEEXPLAIN        VARCHAR(400),
   VOUCHNO              VARCHAR(60),
   CONTRACTNO           VARCHAR(60),
   LOANKINDCODE         VARCHAR(5),
   MAINLOANCARDCODE     VARCHAR(60),
   COPERATIONID         NUMERIC(20),
   CONTRACTSIGNDATE     VARCHAR(10),
   CURRENCY             VARCHAR(5),
   VOUCHSUM             NUMERIC(24,6),
   VOUCHSUMTORMB        NUMERIC(24,6),
   VOUCHSUMTOUSD        NUMERIC(24,6),
   AVAILABLESTATUS      VARCHAR(5),
   FINANCECODE          VARCHAR(14)            not null,
   LOANCARDNO           VARCHAR(16)            not null,
   OPROCCURDATE         VARCHAR(10),
   LOADDATE             VARCHAR(10),
   FILEID               VARCHAR(16),
   constraint P_Key_1 primary key (OPERATIONID)
);

--==============================================================
-- Table: ECR_PBC_IMPAWNCONT
--==============================================================
create table ECR_PBC_IMPAWNCONT
(
   OPERATIONID          VARCHAR(20)            not null,
   IMPAWNSERIAL         NUMERIC(2),
   IMPAWNERNAME         VARCHAR(80),
   EVALUATECURRENCY     VARCHAR(5),
   EVALUATESUM          NUMERIC(24,6),
   IMPAWNKINDCODE       VARCHAR(5),
   VOUCHNO              VARCHAR(60),
   CONTRACTNO           VARCHAR(60),
   LOANKINDCODE         VARCHAR(5),
   MAINLOANCARDCODE     VARCHAR(60),
   COPERATIONID         NUMERIC(20),
   CONTRACTSIGNDATE     VARCHAR(10),
   CURRENCY             VARCHAR(5),
   VOUCHSUM             NUMERIC(24,6),
   VOUCHSUMTORMB        NUMERIC(24,6),
   VOUCHSUMTOUSD        NUMERIC(24,6),
   AVAILABLESTATUS      VARCHAR(5),
   FINANCECODE          VARCHAR(14)            not null,
   LOANCARDNO           VARCHAR(16)            not null,
   OPROCCURDATE         VARCHAR(10),
   LOADDATE             VARCHAR(10),
   FILEID               VARCHAR(16),
   constraint P_Key_1 primary key (OPERATIONID)
);

--==============================================================
-- Table: ECR_PBC_INTERESTDUE
--==============================================================
create table ECR_PBC_INTERESTDUE
(
   OPERATIONID          VARCHAR(20)            not null,
   BORROWERNAME         VARCHAR(80),
   OWEKINDCODE          VARCHAR(5),
   BALANCECHANGEDATE    VARCHAR(10),
   CURRENCY             VARCHAR(5),
   BUSINESSSUM          NUMERIC(24,6),
   BUSINESSSUMTORMB     NUMERIC(24,6),
   BUSINESSSUMTOUSD     NUMERIC(24,6),
   FINANCECODE          VARCHAR(14)            not null,
   LOANCARDNO           VARCHAR(16)            not null,
   OPROCCURDATE         VARCHAR(10),
   LOADDATE             VARCHAR(10),
   FILEID               VARCHAR(16),
   constraint P_Key_1 primary key (OPERATIONID)
);

--==============================================================
-- Table: ECR_PBC_LOANCONTRACT
--==============================================================
create table ECR_PBC_LOANCONTRACT
(
   OPERATIONID          VARCHAR(20)            not null,
   LCONTRACTNO          VARCHAR(60),
   BANKCORPSFLAG        VARCHAR(5),
   CREDITNO             VARCHAR(60),
   BORROWERNAME         VARCHAR(80),
   STARTDATE            VARCHAR(10),
   ENDDATE              VARCHAR(10),
   GUARANTEEFLAG        VARCHAR(5),
   AVAILABLESTATUS      VARCHAR(5),
   FINANCECODE          VARCHAR(14)            not null,
   LOANCARDNO           VARCHAR(16)            not null,
   OPROCCURDATE         VARCHAR(10),
   LOADDATE             VARCHAR(10),
   FILEID               VARCHAR(16),
   constraint P_Key_1 primary key (OPERATIONID)
);

--==============================================================
-- Table: ECR_PBC_LOANDUEBILL
--==============================================================
create table ECR_PBC_LOANDUEBILL
(
   OPERATIONID          VARCHAR(20)            not null,
   LDUEBILLNO           VARCHAR(60),
   LCONTRACTID          NUMERIC(20),
   LCONTRACTNO          VARCHAR(60),
   PUTOUTDATE           VARCHAR(10),
   PUTOUTENDDATE        VARCHAR(10),
   FORM                 VARCHAR(5),
   LOANCHARACTER        VARCHAR(5),
   WAY                  VARCHAR(5),
   KIND                 VARCHAR(5),
   EXTENFLAG            VARCHAR(5),
   BUSINESSTYPE         VARCHAR(40),
   BALANCE              NUMERIC(24,6),
   BALANCETORMB         NUMERIC(24,6),
   BALANCETOUSD         NUMERIC(24,6),
   CLASSIFY5            VARCHAR(5),
   CLASSIFY4            VARCHAR(5),
   CURRENCY             VARCHAR(5),
   BUSINESSSUM          NUMERIC(24,6),
   BUSINESSSUMTORMB     NUMERIC(24,6),
   BUSINESSSUMTOUSD     NUMERIC(24,6),
   FINANCECODE          VARCHAR(14)            not null,
   LOANCARDNO           VARCHAR(16)            not null,
   OPROCCURDATE         VARCHAR(10),
   LOADDATE             VARCHAR(10),
   FILEID               VARCHAR(16),
   constraint P_Key_1 primary key (OPERATIONID)
);

--==============================================================
-- Table: ECR_TEMP_BC
--==============================================================
create table ECR_TEMP_BC
(
   LOANCARDNO           VARCHAR(16)            not null,
   CONTRACTNO           VARCHAR(60)            not null,
   OCCURDATE            VARCHAR(10),
   OLDFINANCEID         VARCHAR(59),
   INCREMENTFLAG        VARCHAR(1),
   CUSTOMERID           VARCHAR(40),
   CUSTOMERNAME         VARCHAR(80),
   BUSINESSTYPE         VARCHAR(40),
   PBTYPE               VARCHAR(2),
   FINISHDATE           VARCHAR(10),
   ACTUALPUTOUTDATE     VARCHAR(10),
   ACTUALMATURITY       VARCHAR(10),
   ACTUALPUTOUTSUM      NUMERIC(24,6),
   BALANCE              NUMERIC(24,6),
   INTERESTBALANCE1     NUMERIC(24,6),
   INTERESTBALANCE2     NUMERIC(24,6),
   MANAGEORGID          VARCHAR(40),
   constraint P_Identifier_1 primary key (LOANCARDNO, CONTRACTNO)
);

--==============================================================
-- Table: ECR_TEMP_BD
--==============================================================
create table ECR_TEMP_BD
(
   LOANCARDNO           VARCHAR(16)            not null,
   DUEBILLNO            VARCHAR(40)            not null,
   OCCURDATE            VARCHAR(10),
   OLDFINANCEID         VARCHAR(59),
   INCREMENTFLAG        VARCHAR(1),
   CUSTOMERID           VARCHAR(40),
   CONTRACTNO           VARCHAR(40),
   CUSTOMERNAME         VARCHAR(80),
   BUSINESSTYPE         VARCHAR(40),
   PBTYPE               VARCHAR(2),
   FINISHDATE           VARCHAR(10),
   ACTUALPUTOUTDATE     VARCHAR(10),
   ACTUALMATURITY       VARCHAR(10),
   BUSINESSSUM          NUMERIC(24,6),
   BALANCE              NUMERIC(24,6),
   INTERESTBALANCE1     NUMERIC(24,6),
   INTERESTBALANCE2     NUMERIC(24,6),
   MANAGEORGID          VARCHAR(40),
   BUSINESSSTATUS       VARCHAR(20),
   constraint P_Identifier_1 primary key (LOANCARDNO, DUEBILLNO)
);

--==============================================================
-- Table: ECR_TEMP_GC
--==============================================================
create table ECR_TEMP_GC
(
   LOANCARDNO           VARCHAR(16)            not null,
   GCONTRACTNO          VARCHAR(40)            not null,
   OCCURDATE            VARCHAR(10),
   OLDFINANCEID         VARCHAR(59),
   INCREMENTFLAG        VARCHAR(1),
   CONTRACTSTATUS       VARCHAR(3),
   GUARANTYVALUE        NUMERIC(24,6),
   GUARANTYTYPE         VARCHAR(2),
   GUARANTYBALANCE      NUMERIC(24,6),
   constraint P_Identifier_1 primary key (LOANCARDNO, GCONTRACTNO)
);

--==============================================================
-- Table: ecr_exteriorcheck
--==============================================================
create table ecr_exteriorcheck
(
   loancardno           VARCHAR(16)            not null,
   occurdate            VARCHAR(10)            not null,
   businesstype         VARCHAR(20)            not null,
   customername         VARCHAR(80),
   pbcnum               NUMERIC(10),
   loannum              NUMERIC(10),
   pbcbusinesssum       NUMERIC(24,6),
   loanbusinesssum      NUMERIC(24,6),
   pbcbalance           NUMERIC(24,6),
   loanbalance          NUMERIC(24,6),
   status1              VARCHAR(10),
   status2              VARCHAR(10),
   remark               VARCHAR(200),
   constraint P_Identifier_1 primary key (loancardno, occurdate, businesstype)
);

--==============================================================
-- Table: ecr_interiorcheck
--==============================================================
create table ecr_interiorcheck
(
   loancardno           VARCHAR(16)            not null,
   occurdate            VARCHAR(10)            not null,
   businesstype         VARCHAR(20)            not null,
   customername         VARCHAR(80),
   ecrnum               NUMERIC(10),
   loannum              NUMERIC(10),
   ecrbusinesssum       NUMERIC(24,6),
   loanbusinesssum      NUMERIC(24,6),
   ecrbalance           NUMERIC(24,6),
   loanbalance          NUMERIC(24,6),
   status1              VARCHAR(10),
   status2              VARCHAR(10),
   remark               VARCHAR(200),
   constraint P_Identifier_1 primary key (loancardno, occurdate, businesstype)
);


create table TEMP_CUSTOMERINFO  (
   CustomerID           VARCHAR(40)                     not null,
   CountryCode          VARCHAR(3),
   ChinaName            VARCHAR(80),
   ForeignName          VARCHAR(80),
   OrganizationCode     VARCHAR(10),
   SetupDate            VARCHAR(10),
   RegistType           VARCHAR(3),
   RegistDate           VARCHAR(10),
   RegistEndDate        VARCHAR(10),
   CountryTaxNo         VARCHAR(20),
   LocationTaxNo        VARCHAR(20),
   Attribute            VARCHAR(2),
   IndustryType         VARCHAR(5),
   EmployeeNumber       NUMERIC(7),
   RegionCode           VARCHAR(6),
   CustomerCharacter    VARCHAR(1),
   Tel                  VARCHAR(35),
   Addr                 VARCHAR(80),
   Fax                  VARCHAR(35),
   Email                VARCHAR(30),
   WebSite              VARCHAR(30),
   Address              VARCHAR(80),
   PostNo               VARCHAR(6),
   MainProduct          VARCHAR(100),
   LocaleArea           NUMERIC(8),
   LocaleDroit          VARCHAR(1),
   GroupFlag            VARCHAR(1),
   InOutFlag            VARCHAR(1),
   MarketFlag           VARCHAR(1),
   FinanceContact       VARCHAR(35),
   RegistNo             VARCHAR(20),
   OccurDate            VARCHAR(10),
   OldFinanceID         VARCHAR(59),
   FinanceID            VARCHAR(11),
   LoanCardNo           VARCHAR(16),
   IncrementFlag        VARCHAR(1),
   ModFlag              VARCHAR(1),
   TraceNumber          VARCHAR(20),
   RecordFlag           VARCHAR(20),
   SessionID            VARCHAR(10),
   ErrorCode            VARCHAR(80),
   constraint PK_T_CUSTOMERINFO primary key (CustomerID)
);

create table BANK_CUSTOMERINFO  (
   ChinaName            VARCHAR(80),
   OrganizationCode     VARCHAR(20),
   LoanCardNo           VARCHAR(16)                   not null,
   Status               VARCHAR(1),
   constraint PK_BANK_CINFO primary key (LoanCardNo)
);

create table BANK_LOANCONTRACT  (
   LContractNo          VARCHAR(60)                     not null,
   CustomerID           VARCHAR(40),
   OccurDate            VARCHAR(10),
   IncrementFlag        VARCHAR(1),
   ModFlag              VARCHAR(1),
   TraceNumber          VARCHAR(20),
   RecordFlag           VARCHAR(20),
   OldFinanceID         VARCHAR(59),
   FinanceID            VARCHAR(11),
   CreditNo             VARCHAR(60),
   LoanCardNo           VARCHAR(16),
   CustomerName         VARCHAR(80),
   SessionID            VARCHAR(10),
   ErrorCode            VARCHAR(80),
   StartDate            VARCHAR(10),
   EndDate              VARCHAR(10),
   BankFlag             VARCHAR(1),
   GuarantyFlag         VARCHAR(1),
   AvailabStatus        VARCHAR(1),
   Currency             VARCHAR(3),
   BusinessSum          DECIMAL(24,6),
   AvailabBalance       DECIMAL(24,6),
   Recycle              VARCHAR(1),
   constraint PK_BANK_LCONTRACT primary key (LContractNo)
);

create table BANK_LOANDUEBILL  (
   LDuebillNo           VARCHAR(60)                     not null,
   LContractNo          VARCHAR(60),
   OccurDate            VARCHAR(10),
   Currency             VARCHAR(3),
   PutoutAmount         DECIMAL(24,6),
   ReturnMode           VARCHAR(2),
   Balance              DECIMAL(24,6),
   PutoutDate           VARCHAR(10),
   PutoutEndDate        VARCHAR(10),
   BusinessType         VARCHAR(2),
   Form                 VARCHAR(1),
   LoanCharacter        VARCHAR(1),
   Way                  VARCHAR(5),
   Kind                 VARCHAR(2),
   ExtenFlag            VARCHAR(1),
   Classify4            VARCHAR(2),
   Classify5            VARCHAR(1),
   IncrementFlag        VARCHAR(1),
   ModFlag              VARCHAR(1),
   TraceNumber          VARCHAR(20),
   RecordFlag           VARCHAR(20),
   SessionID            VARCHAR(10),
   ErrorCode            VARCHAR(80),
   constraint PK_BANK_LDUEBILL primary key (LDuebillNo)
);

create table BANK_FACTORING  (
   FactoringNo          VARCHAR(40)                     not null,
   CustomerID           VARCHAR(40),
   OccurDate            VARCHAR(10),
   IncrementFlag        VARCHAR(1),
   ModFlag              VARCHAR(1),
   TraceNumber          VARCHAR(20),
   RecordFlag           VARCHAR(20),
   OldFinanceID         VARCHAR(59),
   FinanceID            VARCHAR(11),
   CreditNo             VARCHAR(60),
   LoanCardNo           VARCHAR(16),
   CustomerName         VARCHAR(80),
   SessionID            VARCHAR(10),
   ErrorCode            VARCHAR(80),
   Classify4            VARCHAR(2),
   Classify5            VARCHAR(1),
   FactoringType        VARCHAR(1),
   FactoringStatus      VARCHAR(1),
   Currency             VARCHAR(3),
   BusinessSum          DECIMAL(24,6),
   BusinessDate         VARCHAR(10),
   Balance              DECIMAL(24,6),
   BalanceChangeDate    VARCHAR(10),
   GuarantyFlag         VARCHAR(1),
   FloorFlag            VARCHAR(1),
   constraint PK_BANK_FACTORING primary key (FactoringNo)
);

create table BANK_DISCOUNT  (
   BillNo               VARCHAR(60)                     not null,
   CustomerID           VARCHAR(40),
   OccurDate            VARCHAR(10),
   IncrementFlag        VARCHAR(1),
   ModFlag              VARCHAR(1),
   TraceNumber          VARCHAR(20),
   RecordFlag           VARCHAR(20),
   OldFinanceID         VARCHAR(59),
   FinanceID            VARCHAR(11),
   CreditNo             VARCHAR(60),
   LoanCardNo           VARCHAR(16),
   CustomerName         VARCHAR(80),
   SessionID            VARCHAR(10),
   ErrorCode            VARCHAR(80),
   Classify4            VARCHAR(2),
   Classify5            VARCHAR(1),
   BillType             VARCHAR(1),
   AccepterName         VARCHAR(80),
   ALoanCardNo          VARCHAR(16),
   Currency             VARCHAR(3),
   DiscountSum          DECIMAL(24,6),
   DiscountDate         VARCHAR(10),
   AcceptMaturity       VARCHAR(10),
   BillSum              DECIMAL(24,6),
   BillStatus           VARCHAR(1),
   constraint PK_BANK_DISCOUNT primary key (BillNo)
);

create table BANK_FINAINFO  (
   FContractNo          VARCHAR(60)                     not null,
   CustomerID           VARCHAR(40),
   OccurDate            VARCHAR(10),
   IncrementFlag        VARCHAR(1),
   ModFlag              VARCHAR(1),
   TraceNumber          VARCHAR(20),
   RecordFlag           VARCHAR(20),
   OldFinanceID         VARCHAR(59),
   FinanceID            VARCHAR(11),
   CreditNo             VARCHAR(60),
   LoanCardNo           VARCHAR(16),
   CustomerName         VARCHAR(80),
   SessionID            VARCHAR(10),
   ErrorCode            VARCHAR(80),
   StartDate            VARCHAR(10),
   EndDate              VARCHAR(10),
   BankFlag             VARCHAR(1),
   GuarantyFlag         VARCHAR(1),
   AvailabStatus        VARCHAR(1),
   Currency             VARCHAR(3),
   BusinessSum          DECIMAL(24,6),
   AvailabBalance       DECIMAL(24,6),
   Recycle              VARCHAR(1),
   constraint PK_BANK_FINAINFO primary key (FContractNo)
);

create table BANK_FINADUEBILL  (
   FDuebillNo           VARCHAR(40)                     not null,
   FContractNo          VARCHAR(40),
   OccurDate            VARCHAR(10),
   Currency             VARCHAR(3),
   PutoutAmount         DECIMAL(24,6),
   Balance              DECIMAL(24,6),
   PutoutDate           VARCHAR(10),
   PutoutEndDate        VARCHAR(10),
   BusinessType         VARCHAR(2),
   Kind                 VARCHAR(2),
   ExtenFlag            VARCHAR(1),
   Classify4            VARCHAR(2),
   Classify5            VARCHAR(1),
   IncrementFlag        VARCHAR(1),
   ModFlag              VARCHAR(1),
   TraceNumber          VARCHAR(20),
   RecordFlag           VARCHAR(20),
   SessionID            VARCHAR(10),
   ErrorCode            VARCHAR(80),
   ReturnMode           VARCHAR(2),
   constraint PK_BANK_FDUEBILL primary key (FDuebillNo)
);

create table BANK_CREDITLETTER  (
   CreditLetterNo       VARCHAR(60)                     not null,
   CustomerID           VARCHAR(40),
   OccurDate            VARCHAR(10),
   IncrementFlag        VARCHAR(1),
   ModFlag              VARCHAR(1),
   TraceNumber          VARCHAR(20),
   RecordFlag           VARCHAR(20),
   OldFinanceID         VARCHAR(59),
   FinanceID            VARCHAR(11),
   CreditNo             VARCHAR(60),
   LoanCardNo           VARCHAR(16),
   CustomerName         VARCHAR(80),
   SessionID            VARCHAR(10),
   ErrorCode            VARCHAR(80),
   GuarantyFlag         VARCHAR(1),
   FloorFlag            VARCHAR(1),
   Classify5            VARCHAR(1),
   Currency             VARCHAR(3),
   CreateSum            DECIMAL(24,6),
   CreateDate           VARCHAR(10),
   AvailabTerm          VARCHAR(10),
   PayTerm              VARCHAR(1),
   DepositScale         NUMERIC(3),
   CreditStatus         VARCHAR(1),
   LogOutDate           VARCHAR(10),
   Balance              DECIMAL(24,6),
   BalanceReportDate    VARCHAR(10),
   constraint PK_B_CREDITLETTER primary key (CreditLetterNo)
);

create table BANK_GUARANTEEBILL  (
   GuaranteeBillNo      VARCHAR(60)                     not null,
   CustomerID           VARCHAR(40),
   OccurDate            VARCHAR(10),
   IncrementFlag        VARCHAR(1),
   ModFlag              VARCHAR(1),
   TraceNumber          VARCHAR(20),
   RecordFlag           VARCHAR(20),
   OldFinanceID         VARCHAR(59),
   FinanceID            VARCHAR(11),
   CreditNo             VARCHAR(60),
   LoanCardNo           VARCHAR(16),
   CustomerName         VARCHAR(80),
   SessionID            VARCHAR(10),
   ErrorCode            VARCHAR(80),
   GuarantyFlag         VARCHAR(1),
   FloorFlag            VARCHAR(1),
   Classify5            VARCHAR(1),
   GuaranteeType        VARCHAR(1),
   GuaranteeStatus      VARCHAR(1),
   Currency             VARCHAR(3),
   GuaranteeSum         DECIMAL(24,6),
   CreateDate           VARCHAR(10),
   EndDate              VARCHAR(10),
   DepositScale         NUMERIC(3),
   Balance              DECIMAL(24,6),
   BalanceOccurDate     VARCHAR(10),
   constraint PK_BANK_GBILL primary key (GuaranteeBillNo)
);

create table BANK_ACCEPTANCE  (
   AContractNo          VARCHAR(60),
   AcceptNo             VARCHAR(20)                     not null,
   CustomerID           VARCHAR(40),
   OccurDate            VARCHAR(10),
   IncrementFlag        VARCHAR(1),
   ModFlag              VARCHAR(1),
   TraceNumber          VARCHAR(20),
   RecordFlag           VARCHAR(20),
   OldFinanceID         VARCHAR(59),
   FinanceID            VARCHAR(11),
   CreditNo             VARCHAR(60),
   LoanCardNo           VARCHAR(16),
   CustomerName         VARCHAR(80),
   SessionID            VARCHAR(10),
   ErrorCode            VARCHAR(80),
   GuarantyFlag         VARCHAR(1),
   FloorFlag            VARCHAR(1),
   Classify5            VARCHAR(1),
   Currency             VARCHAR(3),
   AccepDate            VARCHAR(10),
   AccepSum             DECIMAL(24,6),
   AccepEndDate         VARCHAR(10),
   AccepPayDate         VARCHAR(10),
   AssureScale          NUMERIC(3),
   DraftStatus          VARCHAR(1),
   constraint PK_BANK_ACCEPTANCE primary key (AcceptNo)
);

create table BANK_CUSTOMERCREDIT  (
   CContractNO          VARCHAR(60)                     not null,
   CustomerID           VARCHAR(40),
   OccurDate            VARCHAR(10),
   IncrementFlag        VARCHAR(1),
   ModFlag              VARCHAR(1),
   TraceNumber          VARCHAR(20),
   RecordFlag           VARCHAR(20),
   OldFinanceID         VARCHAR(59),
   FinanceID            VARCHAR(11),
   CreditNo             VARCHAR(60),
   LoanCardNo           VARCHAR(16),
   CustomerName         VARCHAR(80),
   SessionID            VARCHAR(10),
   ErrorCode            VARCHAR(80),
   Currency             VARCHAR(3),
   CreditLimit          DECIMAL(24,6),
   CreditStartDate      VARCHAR(10),
   CreditEndDate        VARCHAR(10),
   CreditLogoutDate     VARCHAR(10),
   CreditLogoutCause    VARCHAR(2),
   constraint PK_BANK_CCREDIT primary key (CContractNO)
);

create table BANK_FLOORFUND  (
   FloorFundNo          VARCHAR(60)                     not null,
   CustomerID           VARCHAR(40),
   OccurDate            VARCHAR(10),
   IncrementFlag        VARCHAR(1),
   ModFlag              VARCHAR(1),
   TraceNumber          VARCHAR(20),
   RecordFlag           VARCHAR(20),
   OldFinanceID         VARCHAR(59),
   FinanceID            VARCHAR(11),
   CreditNo             VARCHAR(60),
   LoanCardNo           VARCHAR(16),
   CustomerName         VARCHAR(80),
   SessionID            VARCHAR(10),
   ErrorCode            VARCHAR(80),
   Classify4            VARCHAR(2),
   Classify5            VARCHAR(1),
   FloorType            VARCHAR(1),
   BusinessNo           VARCHAR(60),
   Currency             VARCHAR(3),
   FloorSum             DECIMAL(24,6),
   FloorDate            VARCHAR(10),
   FloorBalance         DECIMAL(24,6),
   BalanceOccurDate     VARCHAR(10),
   ReturnMode           VARCHAR(2),
   constraint PK_BANK_FLOORFUND primary key (FloorFundNo)
);

create table BANK_INTERESTDUE  (
   CustomerID           VARCHAR(40)                     not null,
   InterestType         VARCHAR(1)                      not null,
   Currency             VARCHAR(3)                      not null,
   OccurDate            VARCHAR(10),
   OldFinanceID         VARCHAR(59),
   FinanceID            VARCHAR(11)                      not null,
   LoanCardNo           VARCHAR(16),
   IncrementFlag        VARCHAR(1),
   ModFlag              VARCHAR(1),
   TraceNumber          VARCHAR(20),
   RecordFlag           VARCHAR(20),
   SessionID            VARCHAR(10),
   ErrorCode            VARCHAR(80),
   InterestBalance      DECIMAL(24,6),
   ChangeDate           VARCHAR(10),
   constraint PK_B_INTERESTDUE primary key (CustomerID, InterestType, Currency,FinanceID)
);
create table BANK_ASSURECONT  (
   ContractNo           VARCHAR(60)                     not null,
   AssureContNo         VARCHAR(60)                     not null,
   BusinessType         VARCHAR(1),
   AssurerName          VARCHAR(80),
   ALoanCardNo          VARCHAR(16)                     not null,
   OccurDate            VARCHAR(10),
   IncrementFlag        VARCHAR(1),
   ModFlag              VARCHAR(1),
   TraceNumber          VARCHAR(20),
   RecordFlag           VARCHAR(20),
   SessionID            VARCHAR(10),
   ErrorCode            VARCHAR(80),
   Customerid           VARCHAR(40),
   AssureCurrency       VARCHAR(3),
   AssureSum            DECIMAL(24,6),
   CreateDate           VARCHAR(10),
   AssureForm           VARCHAR(1),
   AvailabStatus        VARCHAR(1),
   constraint PK_BANK_ASSURECONT primary key (ContractNo, AssureContNo, ALoanCardNo)
);

create table BANK_GUARANTYCONT  (
   ContractNo           VARCHAR(60)                     not null,
   GuarantyContNo       VARCHAR(60)                     not null,
   GuarantySerialNo     VARCHAR(40)                     not null,
   OccurDate            VARCHAR(10),
   IncrementFlag        VARCHAR(1),
   ModFlag              VARCHAR(1),
   TraceNumber          VARCHAR(20),
   RecordFlag           VARCHAR(20),
   SessionID            VARCHAR(10),
   ErrorCode            VARCHAR(80),
   Customerid           VARCHAR(40),
   GuarantyNo           INTEGER,
   BusinessType         VARCHAR(1),
   PledgorName          VARCHAR(80),
   GLoanCardNo          VARCHAR(16),
   EvaluateCurrency     VARCHAR(3),
   EvaluateSum          DECIMAL(24,6),
   EvaluateDate         VARCHAR(10),
   EvaluateOffice       VARCHAR(80),
   EvaluateOfficeID     VARCHAR(10),
   GuarantyType         VARCHAR(1),
   CreateDate           VARCHAR(10),
   GuarantyCurrency     VARCHAR(3),
   GuarantySum          DECIMAL(24,6),
   RegistOrgName        VARCHAR(80),
   RegistDate           VARCHAR(10),
   GuarantyExplain      VARCHAR(400),
   AvailabStatus        VARCHAR(1),
   constraint PK_BANK_GCONT primary key (ContractNo, GuarantyContNo, GuarantySerialNo)
);

create table BANK_IMPAWNCONT  (
   ContractNo           VARCHAR(60)                     not null,
   ImpawnContNo         VARCHAR(60)                     not null,
   ImpawSerialNo        VARCHAR(60)                     not null,
   OccurDate            VARCHAR(10),
   IncrementFlag        VARCHAR(1),
   ModFlag              VARCHAR(1),
   TraceNumber          VARCHAR(20),
   RecordFlag           VARCHAR(20),
   SessionID            VARCHAR(10),
   ErrorCode            VARCHAR(80),
   Customerid           VARCHAR(40),
   ImpawNo              INTEGER,
   BusinessType         VARCHAR(1),
   ImpawnName           VARCHAR(80),
   ILoanCardNo          VARCHAR(16),
   ValueCurrency        VARCHAR(3),
   ValueSum             DECIMAL(24,6),
   CreateDate           VARCHAR(10),
   ImpawnType           VARCHAR(1),
   ImpawnCurrency       VARCHAR(3),
   ImpawnSum            DECIMAL(24,6),
   AvailabStatus        VARCHAR(1),
   constraint PK_BANK_IMPAWNCONT primary key (ContractNo, ImpawnContNo, ImpawSerialNo)
);