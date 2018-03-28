/*==============================================================*/
/* DBMS name:      ORACLE Version 10g                           */
/* Created on:     2009-7-29 14:44:05                           */
/*==============================================================*/


drop table ECR_ALSDATACHECK cascade constraints;

drop table ECR_PBCDATACHECK cascade constraints;

drop table ECR_PBC_ACCEPTANCE cascade constraints;

drop table ECR_PBC_ASSURECONT cascade constraints;

drop table ECR_PBC_CREDITLETTER cascade constraints;

drop table ECR_PBC_CUSTOMERCREDIT cascade constraints;

drop table ECR_PBC_DISCOUNT cascade constraints;

drop table ECR_PBC_FACTORING cascade constraints;

drop table ECR_PBC_FINADUEBILL cascade constraints;

drop table ECR_PBC_FINAINFO cascade constraints;

drop table ECR_PBC_FLOORFUND cascade constraints;

drop table ECR_PBC_GUARANTEEBILL cascade constraints;

drop table ECR_PBC_GUARANTYCONT cascade constraints;

drop table ECR_PBC_IMPAWNCONT cascade constraints;

drop table ECR_PBC_INTERESTDUE cascade constraints;

drop table ECR_PBC_LOANCONTRACT cascade constraints;

drop table ECR_PBC_LOANDUEBILL cascade constraints;

drop table ECR_TEMP_BC cascade constraints;

drop table ECR_TEMP_BD cascade constraints;

drop table ECR_TEMP_GC cascade constraints;

drop table ecr_exteriorcheck cascade constraints;

drop table ecr_interiorcheck cascade constraints;

/*==============================================================*/
/* Table: ECR_ALSDATACHECK                                      */
/*==============================================================*/
create table ECR_ALSDATACHECK  (
   LOANCARDNO           VARCHAR2(16)                    not null,
   OCCURDATE            VARCHAR2(10)                    not null,
   CUSTOMERNAME         VARCHAR2(80),
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
   LOANSUM              NUMBER(24,6),
   FACTORINGOUTSUM      NUMBER(24,6),
   DISCOUNTOUTSUM       NUMBER(24,6),
   FINAOUTSUM           NUMBER(24,6),
   CREDITLETTEROUTSUM   NUMBER(24,6),
   GUARANTEEBILLOUTSUM  NUMBER(24,6),
   ACCEPTOUTSUM         NUMBER(24,6),
   CUSTOMERCREDITOUTSUM NUMBER(24,6),
   ASSURECONTOUTSUM     NUMBER(24,6),
   GUARANTYCONTOUTSUM   NUMBER(24,6),
   IMPAWNCONTOUTSUM     NUMBER(24,6),
   FLOORFUNDOUTSUM      NUMBER(24,6),
   LOANBALANCE          NUMBER(24,6),
   FACTORINGBALANCE     NUMBER(24,6),
   DISCOUNTBALANCE      NUMBER(24,6),
   FINABALANCE          NUMBER(24,6),
   CREDITLETTERBALANCE  NUMBER(24,6),
   GUARANTEEBILLBALANCE NUMBER(24,6),
   ACCEPTBALANCE        NUMBER(24,6),
   ASSURECONTBALANCE    NUMBER(24,6),
   GUARANTYCONTBALANCE  NUMBER(24,6),
   IMPAWNCONTBALANCE    NUMBER(24,6),
   FLOORFUNDBALANCE     NUMBER(24,6),
   INTERESTBALANCE1     NUMBER(24,6),
   INTERESTBALANCE2     NUMBER(24,6),
   STATUS               VARCHAR2(2),
   CORPID               VARCHAR2(10),
   OLDFINANCEID         VARCHAR2(59),
   INCREMENTFLAG        VARCHAR2(1),
   constraint PK_ECR_ALSDATACHECK primary key (LOANCARDNO, OCCURDATE)
);

/*==============================================================*/
/* Table: ECR_PBCDATACHECK                                      */
/*==============================================================*/
create table ECR_PBCDATACHECK  (
   LOANCARDNO           VARCHAR2(16)                    not null,
   OCCURDATE            VARCHAR2(10)                    not null,
   CUSTOMERNAME         VARCHAR2(80),
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
   LOANSUM              NUMBER(24,6),
   FACTORINGOUTSUM      NUMBER(24,6),
   DISCOUNTOUTSUM       NUMBER(24,6),
   FINAOUTSUM           NUMBER(24,6),
   CREDITLETTEROUTSUM   NUMBER(24,6),
   GUARANTEEBILLOUTSUM  NUMBER(24,6),
   ACCEPTOUTSUM         NUMBER(24,6),
   CUSTOMERCREDITOUTSUM NUMBER(24,6),
   ASSURECONTOUTSUM     NUMBER(24,6),
   GUARANTYCONTOUTSUM   NUMBER(24,6),
   IMPAWNCONTOUTSUM     NUMBER(24,6),
   FLOORFUNDOUTSUM      NUMBER(24,6),
   LOANBALANCE          NUMBER(24,6),
   FACTORINGBALANCE     NUMBER(24,6),
   DISCOUNTBALANCE      NUMBER(24,6),
   FINABALANCE          NUMBER(24,6),
   CREDITLETTERBALANCE  NUMBER(24,6),
   GUARANTEEBILLBALANCE NUMBER(24,6),
   ACCEPTBALANCE        NUMBER(24,6),
   ASSURECONTBALANCE    NUMBER(24,6),
   GUARANTYCONTBALANCE  NUMBER(24,6),
   IMPAWNCONTBALANCE    NUMBER(24,6),
   FLOORFUNDBALANCE     NUMBER(24,6),
   INTERESTBALANCE1     NUMBER(24,6),
   INTERESTBALANCE2     NUMBER(24,6),
   STATUS               VARCHAR2(2),
   CORPID               VARCHAR2(10),
   OLDFINANCEID         VARCHAR2(59),
   INCREMENTFLAG        VARCHAR2(1),
   constraint PK_ECR_PBCDATACHECK primary key (LOANCARDNO, OCCURDATE)
);

/*==============================================================*/
/* Table: ECR_PBC_ACCEPTANCE                                    */
/*==============================================================*/
create table ECR_PBC_ACCEPTANCE  (
   FINANCECODE          VARCHAR2(14)                    not null,
   ACONTRACTNO          VARCHAR2(60),
   ACCEPTNO             VARCHAR2(20),
   OPROCCURDATE         VARCHAR2(10),
   LOADDATE             VARCHAR2(10),
   OPERATIONID          VARCHAR2(20)                    not null,
   LoanCardno         VARCHAR2(16)                    not null,
   CREDITNO             VARCHAR2(60),
   REMITTERNAME         VARCHAR2(80),
   CURRENCY             VARCHAR2(5),
   BUSINESSSUM          NUMBER(24,6),
   BUSINESSSUMTORMB     NUMBER(24,6),
   BUSINESSSUMTOUSD     NUMBER(24,6),
   ACCEPDATE            VARCHAR2(10),
   ACCEPENDDATE         VARCHAR2(10),
   ACCEPPAYDATE         VARCHAR2(10),
   BAILSCALE            NUMBER(3),
   GuarantyFlag         VARCHAR2(5),
   FLOORFLAG            VARCHAR2(5),
   POSTATECODE          VARCHAR2(5),
   CLASSIFY5            VARCHAR2(5),
   FILEID               VARCHAR2(16),
   constraint PK_ECR_PBC_ACCEPTANCE primary key (OPERATIONID)
);

/*==============================================================*/
/* Table: ECR_PBC_ASSURECONT                                    */
/*==============================================================*/
create table ECR_PBC_ASSURECONT  (
   FINANCECODE          VARCHAR2(14)                    not null,
   VOUCHNO              VARCHAR2(60),
   CONTRACTNO           VARCHAR2(60),
   LOANKINDCODE         VARCHAR2(5),
   LoanCardno         VARCHAR2(16)                    not null,
   MAINLoanCardno     VARCHAR2(60),
   LOADDATE             VARCHAR2(10),
   OPERATIONID          VARCHAR2(20)                    not null,
   COPERATIONID         VARCHAR2(20),
   OPROCCURDATE         VARCHAR2(10),
   GUARANTORNAME        VARCHAR2(80),
   CONTRACTSIGNDATE     VARCHAR2(10),
   CURRENCY             VARCHAR2(5),
   VOUCHSUM             NUMBER(24,6),
   VOUCHSUMTORMB        NUMBER(24,6),
   VOUCHSUMTOUSD        NUMBER(24,6),
   ASSUREKINDCODE       VARCHAR2(5),
   AVAILABLESTATUS      VARCHAR2(5),
   FILEID               VARCHAR2(16),
   constraint PK_ECR_PBC_ASSURECONT primary key (OPERATIONID)
);

/*==============================================================*/
/* Table: ECR_PBC_CREDITLETTER                                  */
/*==============================================================*/
create table ECR_PBC_CREDITLETTER  (
   FINANCECODE          VARCHAR2(14)                    not null,
   CREDITLETTERNO       VARCHAR2(60),
   OPROCCURDATE         VARCHAR2(10),
   LOADDATE             VARCHAR2(10),
   OPERATIONID          VARCHAR2(20)                    not null,
   LoanCardno         VARCHAR2(16)                    not null,
   BORROWERNAME         VARCHAR2(80),
   CREDITNO             VARCHAR2(60),
   CURRENCY             VARCHAR2(5),
   BUSINESSSUM          NUMBER(24,6),
   BUSINESSSUMTORMB     NUMBER(24,6),
   BUSINESSSUMTOUSD     NUMBER(24,6),
   CREATEDATE           VARCHAR2(10),
   AVAILABTERM          VARCHAR2(10),
   PAYTERM              VARCHAR2(5),
   DEPOSITSCALE         NUMBER(3),
   GuarantyFlag         VARCHAR2(5),
   FLOORFLAG            VARCHAR2(5),
   CREDITSTATUS         VARCHAR2(5),
   LOGOUTDATE           VARCHAR2(10),
   BALANCE              NUMBER(24,6),
   BALANCETORMB         NUMBER(24,6),
   BALANCETOUSD         NUMBER(24,6),
   BALANCEREPORTDATE    VARCHAR2(10),
   CLASSIFY5            VARCHAR2(5),
   FILEID               VARCHAR2(16),
   constraint PK_ECR_PBC_CREDITLETTER primary key (OPERATIONID)
);

/*==============================================================*/
/* Table: ECR_PBC_CUSTOMERCREDIT                                */
/*==============================================================*/
create table ECR_PBC_CUSTOMERCREDIT  (
   FINANCECODE          VARCHAR2(14)                    not null,
   CREDITAGREEMENTCODE  VARCHAR2(60),
   LOADDATE             VARCHAR2(10),
   OPERATIONID          VARCHAR2(20)                    not null,
   OPROCCURDATE         VARCHAR2(10),
   LoanCardno         VARCHAR2(16)                    not null,
   BORROWERNAME         VARCHAR2(80),
   CURRENCY             VARCHAR2(5),
   BUSINESSSUM          NUMBER(24,6),
   BUSINESSSUMTORMB     NUMBER(24,6),
   BUSINESSSUMTOUSD     NUMBER(24,6),
   STARTDATE            VARCHAR2(10),
   ENDDATE              VARCHAR2(10),
   LIMITATIONPAUSEINUREDATE VARCHAR2(10),
   LIMITATIONPAUSECODE  VARCHAR2(5),
   FILEID               VARCHAR2(16),
   constraint PK_ECR_PBC_CUSTOMERCREDIT primary key (OPERATIONID)
);

/*==============================================================*/
/* Table: ECR_PBC_DISCOUNT                                      */
/*==============================================================*/
create table ECR_PBC_DISCOUNT  (
   BILLNO               VARCHAR2(60),
   FINANCECODE          VARCHAR2(14)                    not null,
   LOADDATE             VARCHAR2(10),
   OPERATIONID          VARCHAR2(20)                    not null,
   OPROCCURDATE         VARCHAR2(10),
   LoanCardno         VARCHAR2(16)                    not null,
   CREDITNO             VARCHAR2(60),
   BILLKIND             VARCHAR2(5),
   DISCOUNTPROPOSERNAME VARCHAR2(80),
   ACCEPTERNAME         VARCHAR2(80),
   ALOANCARDNO          VARCHAR2(16),
   ACCEPTERORGANCODE    VARCHAR2(10),
   CURRENCY             VARCHAR2(5),
   BUSINESSSUM          NUMBER(24,6),
   BUSINESSSUMTORMB     NUMBER(24,6),
   BUSINESSSUMTOUSD     NUMBER(24,6),
   DISCOUNTDATE         VARCHAR2(10),
   ACCEPTLASTDATE       VARCHAR2(10),
   BILLSUM              NUMBER(24,6),
   BILLSUMTORMB         NUMBER(24,6),
   BILLSUMTOUSD         NUMBER(24,6),
   BILLSTATUS           VARCHAR2(5),
   CLASSIFY5            VARCHAR2(5),
   CLASSIFY4            VARCHAR2(5),
   FILEID               VARCHAR2(16),
   constraint PK_ECR_PBC_DISCOUNT primary key (OPERATIONID)
);

/*==============================================================*/
/* Table: ECR_PBC_FACTORING                                     */
/*==============================================================*/
create table ECR_PBC_FACTORING  (
   FINANCECODE          VARCHAR2(14)                    not null,
   FACTORINGNO          VARCHAR2(60),
   LOADDATE             VARCHAR2(10),
   OPROCCURDATE         VARCHAR2(10),
   OPERATIONID          VARCHAR2(20)                    not null,
   LoanCardno         VARCHAR2(16)                    not null,
   CREDITNO             VARCHAR2(60),
   BUSINESSTYPE         VARCHAR2(40),
   FACTORINGSTATUS      VARCHAR2(5),
   BORROWERNAME         VARCHAR2(80),
   CURRENCY             VARCHAR2(5),
   BUSINESSSUM          NUMBER(24,6),
   BUSINESSSUMTORMB     NUMBER(24,6),
   BUSINESSSUMTOUSD     NUMBER(24,6),
   BUSINESSDATE         VARCHAR2(10),
   BALANCE              NUMBER(24,6),
   BALANCETORMB         NUMBER(24,6),
   BALANCETOUSD         NUMBER(24,6),
   BALANCECHANGEDATE    VARCHAR2(10),
   GUARANTEEFLAG        VARCHAR2(5),
   FLOORFLAG            VARCHAR2(5),
   CLASSIFY4            VARCHAR2(5),
   CLASSIFY5            VARCHAR2(5),
   FILEID               VARCHAR2(16),
   constraint PK_ECR_PBC_FACTORING primary key (OPERATIONID)
);

/*==============================================================*/
/* Table: ECR_PBC_FINADUEBILL                                   */
/*==============================================================*/
create table ECR_PBC_FINADUEBILL  (
   FINANCECODE          VARCHAR2(14)                    not null,
   FCONTRACTNO          VARCHAR2(60),
   FDUEBILLNO           VARCHAR2(60),
   LoanCardno         VARCHAR2(16)                    not null,
   LOADDATE             VARCHAR2(10),
   OPERATIONID          VARCHAR2(20)                    not null,
   FCONTRACTID          VARCHAR2(20),
   BUSINESSTYPE         VARCHAR2(40),
   OPROCCURDATE         VARCHAR2(10),
   CURRENCY             VARCHAR2(5),
   BUSINESSSUM          NUMBER(24,6),
   BUSINESSSUMTORMB     NUMBER(24,6),
   BUSINESSSUMTOUSD     NUMBER(24,6),
   BALANCE              NUMBER(24,6),
   BALANCETORMB         NUMBER(24,6),
   BALANCETOUSD         NUMBER(24,6),
   PUTOUTDATE           VARCHAR2(10),
   PUTOUTENDDATE        VARCHAR2(10),
   EXTENFLAG            VARCHAR2(5),
   CLASSIFY5            VARCHAR2(5),
   CLASSIFY4            VARCHAR2(5),
   FILEID               VARCHAR2(16),
   constraint PK_ECR_PBC_FINADUEBILL primary key (OPERATIONID)
);

/*==============================================================*/
/* Table: ECR_PBC_FINAINFO                                      */
/*==============================================================*/
create table ECR_PBC_FINAINFO  (
   FINANCECODE          VARCHAR2(14)                    not null,
   FINANCINGAGREEMENTCODE VARCHAR2(60),
   LOADDATE             VARCHAR2(10),
   OPERATIONID          VARCHAR2(20)                    not null,
   OPROCCURDATE         VARCHAR2(10),
   BORROWERNAME         VARCHAR2(80),
   LoanCardno         VARCHAR2(16)                    not null,
   CREDITNO             VARCHAR2(60),
   STARTDATE            VARCHAR2(10),
   ENDDATE              VARCHAR2(10),
   AVAILABLESTATUS      VARCHAR2(5),
   GUARANTEEFLAG        VARCHAR2(5),
   FILEID               VARCHAR2(16),
   constraint PK_ECR_PBC_FINAINFO primary key (OPERATIONID)
);

/*==============================================================*/
/* Table: ECR_PBC_FLOORFUND                                     */
/*==============================================================*/
create table ECR_PBC_FLOORFUND  (
   FINANCECODE          VARCHAR2(14)                    not null,
   BUSINESSNO           VARCHAR2(60),
   FLOORFUNDNO          VARCHAR2(60),
   OPROCCURDATE         VARCHAR2(10),
   LOADDATE             VARCHAR2(10),
   OPERATIONID          VARCHAR2(20)                    not null,
   COPERATIONID         VARCHAR2(20),
   LoanCardno         VARCHAR2(16)                    not null,
   BORROWERNAME         VARCHAR2(80),
   BUSINESSTYPE         VARCHAR2(40),
   CURRENCY             VARCHAR2(5),
   BUSINESSSUM          NUMBER(24,6),
   BUSINESSSUMTORMB     NUMBER(24,6),
   BUSINESSSUMTOUSD     NUMBER(24,6),
   FLOORDATE            VARCHAR2(10),
   BALANCE              NUMBER(24,6),
   BALANCETORMB         NUMBER(24,6),
   BALANCETOUSD         NUMBER(24,6),
   BALANCEOCCURDATE     VARCHAR2(10),
   RETURNMODE           VARCHAR2(5),
   CLASSIFY4            VARCHAR2(5),
   CLASSIFY5            VARCHAR2(5),
   FILEID               VARCHAR2(16),
   constraint PK_ECR_PBC_FLOORFUND primary key (OPERATIONID)
);

/*==============================================================*/
/* Table: ECR_PBC_GUARANTEEBILL                                  */
/*==============================================================*/
create table ECR_PBC_GUARANTEEBILL  (
   FINANCECODE          VARCHAR2(14)                    not null,
   GUARANTEEBILLNO      VARCHAR2(60),
   LOADDATE             VARCHAR2(10),
   OPROCCURDATE         VARCHAR2(10),
   OPERATIONID          VARCHAR2(20)                    not null,
   BORROWERNAME         VARCHAR2(80),
   CREDITNO             VARCHAR2(60),
   LoanCardno         VARCHAR2(16)                    not null,
   GUARANTEETYPE        VARCHAR2(5),
   GUARANTEESTATUS      VARCHAR2(5),
   CURRENCY             VARCHAR2(5),
   BUSINESSSUM          NUMBER(24,6),
   BUSINESSSUMTORMB     NUMBER(24,6),
   BUSINESSSUMTOUSD     NUMBER(24,6),
   STARTDATE            VARCHAR2(10),
   ENDDATE              VARCHAR2(10),
   ASSURESCALE          NUMBER(3),
   FLOORFLAG            VARCHAR2(5),
   GuarantyFlag         VARCHAR2(5),
   BALANCE              NUMBER(24,6),
   BALANCETOUSD         NUMBER(24,6),
   BALANCETORMB         NUMBER(24,6),
   BALANCEOCCURDATE     VARCHAR2(10),
   CLASSIFY5            VARCHAR2(5),
   FILEID               VARCHAR2(16),
   constraint PK_ECR_PBC_GUARANTEEBILL primary key (OPERATIONID)
);

/*==============================================================*/
/* Table: ECR_PBC_GUARANTYCONT                                  */
/*==============================================================*/
create table ECR_PBC_GUARANTYCONT  (
   FINANCECODE          VARCHAR2(14)                    not null,
   VOUCHNO              VARCHAR2(60),
   CONTRACTNO           VARCHAR2(60),
   PLEDGESERIAL         NUMBER(2),
   PLEDGERNAME          VARCHAR2(80),
   LOANKINDCODE         VARCHAR2(5),
   LOADDATE             VARCHAR2(10),
   OPERATIONID          VARCHAR2(20)                    not null,
   COPERATIONID         VARCHAR2(20),
   OPROCCURDATE         VARCHAR2(10),
   LoanCardno         VARCHAR2(16)                    not null,
   MAINLoanCardno     VARCHAR2(60),
   EVALUATECURRENCY     VARCHAR2(5),
   EVALUATEPLEDGESUM    NUMBER(24,6),
   EVALUATEDATE         VARCHAR2(10),
   EVALUATEORGANNAME    VARCHAR2(80),
   EVALUATEORGANCODE    VARCHAR2(10),
   CONTRACTSIGNDATE     VARCHAR2(10),
   PLEDGEKINDCODE       VARCHAR2(5),
   CURRENCY             VARCHAR2(5),
   VOUCHSUM             NUMBER(24,6),
   VOUCHSUMTORMB        NUMBER(24,6),
   VOUCHSUMTOUSD        NUMBER(24,6),
   REGISTERORGANNAME    VARCHAR2(80),
   REGISTERDATE         VARCHAR2(10),
   PLEDGEEXPLAIN        VARCHAR2(400),
   AVAILABLESTATUS      VARCHAR2(5),
   FILEID               VARCHAR2(16),
   constraint PK_ECR_PBC_GUARANTYCONT primary key (OPERATIONID)
);

/*==============================================================*/
/* Table: ECR_PBC_IMPAWNCONT                                    */
/*==============================================================*/
create table ECR_PBC_IMPAWNCONT  (
   FINANCECODE          VARCHAR2(14)                    not null,
   VOUCHNO              VARCHAR2(60),
   CONTRACTNO           VARCHAR2(60),
   IMPAWNSERIAL         NUMBER(2),
   LOANKINDCODE         VARCHAR2(5),
   MAINLoanCardno     VARCHAR2(60),
   LOADDATE             VARCHAR2(10),
   LoanCardno         VARCHAR2(16)                    not null,
   OPERATIONID          VARCHAR2(20)                    not null,
   COPERATIONID         VARCHAR2(20),
   OPROCCURDATE         VARCHAR2(10),
   IMPAWNERNAME         VARCHAR2(80),
   EVALUATECURRENCY     VARCHAR2(5),
   EVALUATESUM          NUMBER(24,6),
   CONTRACTSIGNDATE     VARCHAR2(10),
   IMPAWNKINDCODE       VARCHAR2(5),
   CURRENCY             VARCHAR2(5),
   VOUCHSUM             NUMBER(24,6),
   VOUCHSUMTORMB        NUMBER(24,6),
   VOUCHSUMTOUSD        NUMBER(24,6),
   AVAILABLESTATUS      VARCHAR2(5),
   FILEID               VARCHAR2(16),
   constraint PK_ECR_PBC_IMPAWNCONT primary key (OPERATIONID)
);

/*==============================================================*/
/* Table: ECR_PBC_INTERESTDUE                                   */
/*==============================================================*/
create table ECR_PBC_INTERESTDUE  (
   FINANCECODE          VARCHAR2(14)                    not null,
   LoanCardno         VARCHAR2(16)                    not null,
   BORROWERNAME         VARCHAR2(80),
   OPROCCURDATE         VARCHAR2(10),
   LOADDATE             VARCHAR2(10),
   OPERATIONID          VARCHAR2(20)                    not null,
   CURRENCY             VARCHAR2(5),
   BUSINESSSUM          NUMBER(24,6),
   BUSINESSSUMTORMB     NUMBER(24,6),
   BUSINESSSUMTOUSD     NUMBER(24,6),
   OWEKINDCODE          VARCHAR2(5),
   BALANCECHANGEDATE    VARCHAR2(10),
   FILEID               VARCHAR2(16),
   constraint PK_ECR_PBC_INTERESTDUE primary key (OPERATIONID)
);

/*==============================================================*/
/* Table: ECR_PBC_LOANCONTRACT                                  */
/*==============================================================*/
create table ECR_PBC_LOANCONTRACT  (
   FINANCECODE          VARCHAR2(14)                    not null,
   LCONTRACTNO          VARCHAR2(60),
   LOADDATE             VARCHAR2(20),
   OPERATIONID          VARCHAR2(20)                    not null,
   OPROCCURDATE         VARCHAR2(10),
   LoanCardno         VARCHAR2(16)                    not null,
   CREDITNO             VARCHAR2(60),
   BORROWERNAME         VARCHAR2(80),
   STARTDATE            VARCHAR2(20),
   ENDDATE              VARCHAR2(20),
   BANKCORPSFLAG        VARCHAR2(5),
   GUARANTEEFLAG        VARCHAR2(5),
   AVAILABLESTATUS      VARCHAR2(5),
   FILEID               VARCHAR2(16),
   constraint PK_ECR_PBC_LOANCONTRACT primary key (OPERATIONID)
);

/*==============================================================*/
/* Table: ECR_PBC_LOANDUEBILL                                   */
/*==============================================================*/
create table ECR_PBC_LOANDUEBILL  (
   FINANCECODE          VARCHAR2(14)                    not null,
   LCONTRACTNO          VARCHAR2(60),
   LDUEBILLNO           VARCHAR2(60),
   LoanCardno         VARCHAR2(16)                    not null,
   LOADDATE             VARCHAR2(10),
   LCONTRACTID          VARCHAR2(20),
   OPERATIONID          VARCHAR2(20)                    not null,
   OPROCCURDATE         VARCHAR2(10),
   CURRENCY             VARCHAR2(5),
   BUSINESSSUM          NUMBER(24,6),
   BUSINESSSUMTORMB     NUMBER(24,6),
   BUSINESSSUMTOUSD     NUMBER(24,6),
   BALANCE              NUMBER(24,6),
   BALANCETOUSD         NUMBER(24,6),
   BALANCETORMB         NUMBER(24,6),
   PUTOUTDATE           VARCHAR2(10),
   PUTOUTENDDATE        VARCHAR2(10),
   BUSINESSTYPE         VARCHAR2(40),
   FORM                 VARCHAR2(5),
   LOANCHARACTER        VARCHAR2(5),
   WAY                  VARCHAR2(5),
   KIND                 VARCHAR2(5),
   EXTENFLAG            VARCHAR2(5),
   CLASSIFY5            VARCHAR2(5),
   CLASSIFY4            VARCHAR2(5),
   FILEID               VARCHAR2(16),
   constraint PK_ECR_PBC_LOANDUEBILL primary key (OPERATIONID)
);


create table TEMP_CUSTOMERINFO  (
   CustomerID           VARCHAR2(40)                     not null,
   CountryCode          VARCHAR2(3),
   ChinaName            VARCHAR2(80),
   ForeignName          VARCHAR2(80),
   OrganizationCode     VARCHAR2(10),
   SetupDate            VARCHAR2(10),
   RegistType           VARCHAR2(3),
   RegistDate           VARCHAR2(10),
   RegistEndDate        VARCHAR2(10),
   CountryTaxNo         VARCHAR2(20),
   LocationTaxNo        VARCHAR2(20),
   Attribute            VARCHAR2(2),
   IndustryType         VARCHAR2(5),
   EmployeeNumber       NUMBER(7),
   RegionCode           VARCHAR2(6),
   CustomerCharacter    VARCHAR2(1),
   Tel                  VARCHAR2(35),
   Addr                 VARCHAR2(80),
   Fax                  VARCHAR2(35),
   Email                VARCHAR2(30),
   WebSite              VARCHAR2(30),
   Address              VARCHAR2(80),
   PostNo               VARCHAR2(6),
   MainProduct          VARCHAR2(100),
   LocaleArea           NUMBER(8),
   LocaleDroit          VARCHAR2(1),
   GroupFlag            VARCHAR2(1),
   InOutFlag            VARCHAR2(1),
   MarketFlag           VARCHAR2(1),
   FinanceContact       VARCHAR2(35),
   RegistNo             VARCHAR2(20),
   OccurDate            VARCHAR2(10),
   OldFinanceID         VARCHAR2(59),
   FinanceID            VARCHAR2(11),
   LoanCardNo           VARCHAR2(16),
   IncrementFlag        VARCHAR2(1),
   ModFlag              VARCHAR2(1),
   TraceNumber          VARCHAR2(20),
   RecordFlag           VARCHAR2(20),
   SessionID            VARCHAR2(10),
   ErrorCode            VARCHAR2(80),
   constraint PK_TEMP_CUSTOMERINFO primary key (CustomerID)
);

create table BANK_CUSTOMERINFO  (
   ChinaName            VARCHAR2(80),
   OrganizationCode     VARCHAR2(20),
   LoanCardNo           VARCHAR2(16)                   not null,
   Status               VARCHAR2(1),
   constraint PK_BANK_CUSTOMERINFO primary key (LoanCardNo)
);

create table BANK_LOANCONTRACT  (
   LContractNo          VARCHAR2(60)                     not null,
   CustomerID           VARCHAR2(40),
   OccurDate            VARCHAR2(10),
   IncrementFlag        VARCHAR2(1),
   ModFlag              VARCHAR2(1),
   TraceNumber          VARCHAR2(20),
   RecordFlag           VARCHAR2(20),
   OldFinanceID         VARCHAR2(59),
   FinanceID            VARCHAR2(11),
   CreditNo             VARCHAR2(60),
   LoanCardNo           VARCHAR2(16),
   CustomerName         VARCHAR2(80),
   SessionID            VARCHAR2(10),
   ErrorCode            VARCHAR2(80),
   StartDate            VARCHAR2(10),
   EndDate              VARCHAR2(10),
   BankFlag             VARCHAR2(1),
   GuarantyFlag         VARCHAR2(1),
   AvailabStatus        VARCHAR2(1),
   Currency             VARCHAR2(3),
   BusinessSum          NUMBER(24,6),
   AvailabBalance       NUMBER(24,6),
   Recycle              VARCHAR2(1),
   constraint PK_BANK_LOANCONTRACT primary key (LContractNo)
);

create table BANK_LOANDUEBILL  (
   LDuebillNo           VARCHAR2(60)                     not null,
   LContractNo          VARCHAR2(60),
   OccurDate            VARCHAR2(10),
   Currency             VARCHAR2(3),
   PutoutAmount         NUMBER(24,6),
   ReturnMode           VARCHAR2(2),
   Balance              NUMBER(24,6),
   PutoutDate           VARCHAR2(10),
   PutoutEndDate        VARCHAR2(10),
   BusinessType         VARCHAR2(2),
   Form                 VARCHAR2(1),
   LoanCharacter        VARCHAR2(1),
   Way                  VARCHAR2(5),
   Kind                 VARCHAR2(2),
   ExtenFlag            VARCHAR2(1),
   Classify4            VARCHAR2(2),
   Classify5            VARCHAR2(1),
   IncrementFlag        VARCHAR2(1),
   ModFlag              VARCHAR2(1),
   TraceNumber          VARCHAR2(20),
   RecordFlag           VARCHAR2(20),
   SessionID            VARCHAR2(10),
   ErrorCode            VARCHAR2(80),
   constraint PK_BANK_LOANDUEBILL primary key (LDuebillNo)
);

create table BANK_FACTORING  (
   FactoringNo          VARCHAR2(40)                     not null,
   CustomerID           VARCHAR2(40),
   OccurDate            VARCHAR2(10),
   IncrementFlag        VARCHAR2(1),
   ModFlag              VARCHAR2(1),
   TraceNumber          VARCHAR2(20),
   RecordFlag           VARCHAR2(20),
   OldFinanceID         VARCHAR2(59),
   FinanceID            VARCHAR2(11),
   CreditNo             VARCHAR2(60),
   LoanCardNo           VARCHAR2(16),
   CustomerName         VARCHAR2(80),
   SessionID            VARCHAR2(10),
   ErrorCode            VARCHAR2(80),
   Classify4            VARCHAR2(2),
   Classify5            VARCHAR2(1),
   FactoringType        VARCHAR2(1),
   FactoringStatus      VARCHAR2(1),
   Currency             VARCHAR2(3),
   BusinessSum          NUMBER(24,6),
   BusinessDate         VARCHAR2(10),
   Balance              NUMBER(24,6),
   BalanceChangeDate    VARCHAR2(10),
   GuarantyFlag         VARCHAR2(1),
   FloorFlag            VARCHAR2(1),
   constraint PK_BANK_FACTORING primary key (FactoringNo)
);

create table BANK_DISCOUNT  (
   BillNo               VARCHAR2(60)                     not null,
   CustomerID           VARCHAR2(40),
   OccurDate            VARCHAR2(10),
   IncrementFlag        VARCHAR2(1),
   ModFlag              VARCHAR2(1),
   TraceNumber          VARCHAR2(20),
   RecordFlag           VARCHAR2(20),
   OldFinanceID         VARCHAR2(59),
   FinanceID            VARCHAR2(11),
   CreditNo             VARCHAR2(60),
   LoanCardNo           VARCHAR2(16),
   CustomerName         VARCHAR2(80),
   SessionID            VARCHAR2(10),
   ErrorCode            VARCHAR2(80),
   Classify4            VARCHAR2(2),
   Classify5            VARCHAR2(1),
   BillType             VARCHAR2(1),
   AccepterName         VARCHAR2(80),
   ALoanCardNo          VARCHAR2(16),
   Currency             VARCHAR2(3),
   DiscountSum          NUMBER(24,6),
   DiscountDate         VARCHAR2(10),
   AcceptMaturity       VARCHAR2(10),
   BillSum              NUMBER(24,6),
   BillStatus           VARCHAR2(1),
   constraint PK_BANK_DISCOUNT primary key (BillNo)
);

create table BANK_FINAINFO  (
   FContractNo          VARCHAR2(60)                     not null,
   CustomerID           VARCHAR2(40),
   OccurDate            VARCHAR2(10),
   IncrementFlag        VARCHAR2(1),
   ModFlag              VARCHAR2(1),
   TraceNumber          VARCHAR2(20),
   RecordFlag           VARCHAR2(20),
   OldFinanceID         VARCHAR2(59),
   FinanceID            VARCHAR2(11),
   CreditNo             VARCHAR2(60),
   LoanCardNo           VARCHAR2(16),
   CustomerName         VARCHAR2(80),
   SessionID            VARCHAR2(10),
   ErrorCode            VARCHAR2(80),
   StartDate            VARCHAR2(10),
   EndDate              VARCHAR2(10),
   BankFlag             VARCHAR2(1),
   GuarantyFlag         VARCHAR2(1),
   AvailabStatus        VARCHAR2(1),
   Currency             VARCHAR2(3),
   BusinessSum          NUMBER(24,6),
   AvailabBalance       NUMBER(24,6),
   Recycle              VARCHAR2(1),
   constraint PK_BANK_FINAINFO primary key (FContractNo)
);

create table BANK_FINADUEBILL  (
   FDuebillNo           VARCHAR2(40)                     not null,
   FContractNo          VARCHAR2(40),
   OccurDate            VARCHAR2(10),
   Currency             VARCHAR2(3),
   PutoutAmount         NUMBER(24,6),
   Balance              NUMBER(24,6),
   PutoutDate           VARCHAR2(10),
   PutoutEndDate        VARCHAR2(10),
   BusinessType         VARCHAR2(2),
   Kind                 VARCHAR2(2),
   ExtenFlag            VARCHAR2(1),
   Classify4            VARCHAR2(2),
   Classify5            VARCHAR2(1),
   IncrementFlag        VARCHAR2(1),
   ModFlag              VARCHAR2(1),
   TraceNumber          VARCHAR2(20),
   RecordFlag           VARCHAR2(20),
   SessionID            VARCHAR2(10),
   ErrorCode            VARCHAR2(80),
   ReturnMode           VARCHAR2(2),
   constraint PK_BANK_FINADUEBILL primary key (FDuebillNo)
);

create table BANK_CREDITLETTER  (
   CreditLetterNo       VARCHAR2(60)                     not null,
   CustomerID           VARCHAR2(40),
   OccurDate            VARCHAR2(10),
   IncrementFlag        VARCHAR2(1),
   ModFlag              VARCHAR2(1),
   TraceNumber          VARCHAR2(20),
   RecordFlag           VARCHAR2(20),
   OldFinanceID         VARCHAR2(59),
   FinanceID            VARCHAR2(11),
   CreditNo             VARCHAR2(60),
   LoanCardNo           VARCHAR2(16),
   CustomerName         VARCHAR2(80),
   SessionID            VARCHAR2(10),
   ErrorCode            VARCHAR2(80),
   GuarantyFlag         VARCHAR2(1),
   FloorFlag            VARCHAR2(1),
   Classify5            VARCHAR2(1),
   Currency             VARCHAR2(3),
   CreateSum            NUMBER(24,6),
   CreateDate           VARCHAR2(10),
   AvailabTerm          VARCHAR2(10),
   PayTerm              VARCHAR2(1),
   DepositScale         Number(3),
   CreditStatus         VARCHAR2(1),
   LogOutDate           VARCHAR2(10),
   Balance              NUMBER(24,6),
   BalanceReportDate    VARCHAR2(10),
   constraint PK_BANK_CREDITLETTER primary key (CreditLetterNo)
);

create table BANK_GUARANTEEBILL  (
   GuaranteeBillNo      VARCHAR2(60)                     not null,
   CustomerID           VARCHAR2(40),
   OccurDate            VARCHAR2(10),
   IncrementFlag        VARCHAR2(1),
   ModFlag              VARCHAR2(1),
   TraceNumber          VARCHAR2(20),
   RecordFlag           VARCHAR2(20),
   OldFinanceID         VARCHAR2(59),
   FinanceID            VARCHAR2(11),
   CreditNo             VARCHAR2(60),
   LoanCardNo           VARCHAR2(16),
   CustomerName         VARCHAR2(80),
   SessionID            VARCHAR2(10),
   ErrorCode            VARCHAR2(80),
   GuarantyFlag         VARCHAR2(1),
   FloorFlag            VARCHAR2(1),
   Classify5            VARCHAR2(1),
   GuaranteeType        VARCHAR2(1),
   GuaranteeStatus      VARCHAR2(1),
   Currency             VARCHAR2(3),
   GuaranteeSum         NUMBER(24,6),
   CreateDate           VARCHAR2(10),
   EndDate              VARCHAR2(10),
   DepositScale         Number(3),
   Balance              NUMBER(24,6),
   BalanceOccurDate     VARCHAR2(10),
   constraint PK_BANK_GUARANTEEBILL primary key (GuaranteeBillNo)
);

create table BANK_ACCEPTANCE  (
   AContractNo          VARCHAR2(60),
   AcceptNo             VARCHAR2(20)                     not null,
   CustomerID           VARCHAR2(40),
   OccurDate            VARCHAR2(10),
   IncrementFlag        VARCHAR2(1),
   ModFlag              VARCHAR2(1),
   TraceNumber          VARCHAR2(20),
   RecordFlag           VARCHAR2(20),
   OldFinanceID         VARCHAR2(59),
   FinanceID            VARCHAR2(11),
   CreditNo             VARCHAR2(60),
   LoanCardNo           VARCHAR2(16),
   CustomerName         VARCHAR2(80),
   SessionID            VARCHAR2(10),
   ErrorCode            VARCHAR2(80),
   GuarantyFlag         VARCHAR2(1),
   FloorFlag            VARCHAR2(1),
   Classify5            VARCHAR2(1),
   Currency             VARCHAR2(3),
   AccepDate            VARCHAR2(10),
   AccepSum             NUMBER(24,6),
   AccepEndDate         VARCHAR2(10),
   AccepPayDate         VARCHAR2(10),
   AssureScale          Number(3),
   DraftStatus          VARCHAR2(1),
   constraint PK_BANK_ACCEPTANCE primary key (AcceptNo)
);

create table BANK_CUSTOMERCREDIT  (
   CContractNO          VARCHAR2(60)                     not null,
   CustomerID           VARCHAR2(40),
   OccurDate            VARCHAR2(10),
   IncrementFlag        VARCHAR2(1),
   ModFlag              VARCHAR2(1),
   TraceNumber          VARCHAR2(20),
   RecordFlag           VARCHAR2(20),
   OldFinanceID         VARCHAR2(59),
   FinanceID            VARCHAR2(11),
   CreditNo             VARCHAR2(60),
   LoanCardNo           VARCHAR2(16),
   CustomerName         VARCHAR2(80),
   SessionID            VARCHAR2(10),
   ErrorCode            VARCHAR2(80),
   Currency             VARCHAR2(3),
   CreditLimit          NUMBER(24,6),
   CreditStartDate      VARCHAR2(10),
   CreditEndDate        VARCHAR2(10),
   CreditLogoutDate     VARCHAR2(10),
   CreditLogoutCause    VARCHAR2(2),
   constraint PK_BANK_CUSTOMERCREDIT primary key (CContractNO)
);

create table BANK_FLOORFUND  (
   FloorFundNo          VARCHAR2(60)                     not null,
   CustomerID           VARCHAR2(40),
   OccurDate            VARCHAR2(10),
   IncrementFlag        VARCHAR2(1),
   ModFlag              VARCHAR2(1),
   TraceNumber          VARCHAR2(20),
   RecordFlag           VARCHAR2(20),
   OldFinanceID         VARCHAR2(59),
   FinanceID            VARCHAR2(11),
   CreditNo             VARCHAR2(60),
   LoanCardNo           VARCHAR2(16),
   CustomerName         VARCHAR2(80),
   SessionID            VARCHAR2(10),
   ErrorCode            VARCHAR2(80),
   Classify4            VARCHAR2(2),
   Classify5            VARCHAR2(1),
   FloorType            VARCHAR2(1),
   BusinessNo           VARCHAR2(60),
   Currency             VARCHAR2(3),
   FloorSum             NUMBER(24,6),
   FloorDate            VARCHAR2(10),
   FloorBalance         NUMBER(24,6),
   BalanceOccurDate     VARCHAR2(10),
   ReturnMode           VARCHAR2(2),
   constraint PK_BANK_FLOORFUND primary key (FloorFundNo)
);

create table BANK_INTERESTDUE  (
   CustomerID           VARCHAR2(40)                     not null,
   InterestType         VARCHAR2(1)                      not null,
   Currency             VARCHAR2(3)                      not null,
   OccurDate            VARCHAR2(10),
   OldFinanceID         VARCHAR2(59),
   FinanceID            VARCHAR2(11)                      not null,
   LoanCardNo           VARCHAR2(16),
   IncrementFlag        VARCHAR2(1),
   ModFlag              VARCHAR2(1),
   TraceNumber          VARCHAR2(20),
   RecordFlag           VARCHAR2(20),
   SessionID            VARCHAR2(10),
   ErrorCode            VARCHAR2(80),
   InterestBalance      NUMBER(24,6),
   ChangeDate           VARCHAR2(10),
   constraint PK_BANK_INTERESTDUE primary key (CustomerID, InterestType, Currency,FinanceID)
);
create table BANK_ASSURECONT  (
   ContractNo           VARCHAR2(60)                     not null,
   AssureContNo         VARCHAR2(60)                     not null,
   BusinessType         VARCHAR2(1),
   AssurerName          VARCHAR2(80),
   ALoanCardNo          VARCHAR2(16)                     not null,
   OccurDate            VARCHAR2(10),
   IncrementFlag        VARCHAR2(1),
   ModFlag              VARCHAR2(1),
   TraceNumber          VARCHAR2(20),
   RecordFlag           VARCHAR2(20),
   SessionID            VARCHAR2(10),
   ErrorCode            VARCHAR2(80),
   Customerid           VARCHAR2(40),
   AssureCurrency       VARCHAR2(3),
   AssureSum            NUMBER(24,6),
   CreateDate           VARCHAR2(10),
   AssureForm           VARCHAR2(1),
   AvailabStatus        VARCHAR2(1),
   constraint PK_BANK_ASSURECONT primary key (ContractNo, AssureContNo, ALoanCardNo)
);

create table BANK_GUARANTYCONT  (
   ContractNo           VARCHAR2(60)                     not null,
   GuarantyContNo       VARCHAR2(60)                     not null,
   GuarantySerialNo     VARCHAR2(40)                     not null,
   OccurDate            VARCHAR2(10),
   IncrementFlag        VARCHAR2(1),
   ModFlag              VARCHAR2(1),
   TraceNumber          VARCHAR2(20),
   RecordFlag           VARCHAR2(20),
   SessionID            VARCHAR2(10),
   ErrorCode            VARCHAR2(80),
   Customerid           VARCHAR2(40),
   GuarantyNo           INTEGER,
   BusinessType         VARCHAR2(1),
   PledgorName          VARCHAR2(80),
   GLoanCardNo          VARCHAR2(16),
   EvaluateCurrency     VARCHAR2(3),
   EvaluateSum          NUMBER(24,6),
   EvaluateDate         VARCHAR2(10),
   EvaluateOffice       VARCHAR2(80),
   EvaluateOfficeID     VARCHAR2(10),
   GuarantyType         VARCHAR2(1),
   CreateDate           VARCHAR2(10),
   GuarantyCurrency     VARCHAR2(3),
   GuarantySum          NUMBER(24,6),
   RegistOrgName        VARCHAR2(80),
   RegistDate           VARCHAR2(10),
   GuarantyExplain      VARCHAR2(400),
   AvailabStatus        VARCHAR2(1),
   constraint PK_BANK_GUARANTYCONT primary key (ContractNo, GuarantyContNo, GuarantySerialNo)
);

create table BANK_IMPAWNCONT  (
   ContractNo           VARCHAR2(60)                     not null,
   ImpawnContNo         VARCHAR2(60)                     not null,
   ImpawSerialNo        VARCHAR2(60)                     not null,
   OccurDate            VARCHAR2(10),
   IncrementFlag        VARCHAR2(1),
   ModFlag              VARCHAR2(1),
   TraceNumber          VARCHAR2(20),
   RecordFlag           VARCHAR2(20),
   SessionID            VARCHAR2(10),
   ErrorCode            VARCHAR2(80),
   Customerid           VARCHAR2(40),
   ImpawNo              INTEGER,
   BusinessType         VARCHAR2(1),
   ImpawnName           VARCHAR2(80),
   ILoanCardNo          VARCHAR2(16),
   ValueCurrency        VARCHAR2(3),
   ValueSum             NUMBER(24,6),
   CreateDate           VARCHAR2(10),
   ImpawnType           VARCHAR2(1),
   ImpawnCurrency       VARCHAR2(3),
   ImpawnSum            NUMBER(24,6),
   AvailabStatus        VARCHAR2(1),
   constraint PK_BANK_IMPAWNCONT primary key (ContractNo, ImpawnContNo, ImpawSerialNo)
);