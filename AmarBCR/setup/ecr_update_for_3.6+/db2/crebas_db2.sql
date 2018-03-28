DROP TABLE BATCH_CTRL;
DROP TABLE ECR_BATCHDEL;
DROP TABLE ECR_FINANCEBS_2007;
DROP TABLE ECR_FINANCEBS_IN;
DROP TABLE ECR_FINANCECF_2007;
DROP TABLE ECR_FINANCEPS_2007;
DROP TABLE ECR_FINANCECF_IN;
DROP TABLE ECR_LOANCARD;
DROP TABLE ECR_LOANCARDNOCHANGE;
DROP TABLE ECR_PREPAREDATE;
DROP TABLE ECR_PREPARESTATUS;
DROP TABLE ECR_RUNSTATUS;
DROP TABLE ECR_ASSETSDISPOSE;
DROP TABLE ECR_ORGANATTRIBUTE;
DROP TABLE ECR_ORGANCONTACT;
DROP TABLE ECR_ORGANFAMILY;
DROP TABLE ECR_ORGANINFO;
DROP TABLE ECR_ORGANKEEPER;
DROP TABLE ECR_ORGANRELATED;
DROP TABLE ECR_ORGANSTATUS;
DROP TABLE ECR_ORGANSTOCKHOLDER;
DROP TABLE ECR_ORGANSUPERIOR;

CREATE TABLE BATCH_CTRL
(
   BATCHDATE varchar(10) NOT NULL,
   SERIALNO decimal(22) NOT NULL,
   TASKCODE varchar(80),
   TARGETCODE varchar(80),
   UNITCODE varchar(80) NOT NULL,
   RUNDESC varchar(120),
   SUCCESSFLAG varchar(20),
   ERRDESC varchar(400),
   BEGINDATE varchar(40),
   ENDDATE varchar(40),
   RUNTIME varchar(20),
   FIRSTSTARTDATE varchar(40) NOT NULL,
   LOGTYPE varchar(20),
   CONSTRAINT PK_BCTRL PRIMARY KEY (BATCHDATE,SERIALNO)
);

alter table ECR_ERRMAP alter column NOTE set data type VARCHAR(800);

alter table ECR_ACCEPTANCE alter column ACONTRACTNO set data type varchar(60);
alter table ECR_ACCEPTANCE alter column ACCEPSUM set data type decimal(24,6);
alter table ECR_ACCEPTANCE alter column ASSURESCALE set data type decimal(3,0);

alter table ECR_ASSURECONT alter column ASSURESUM set data type decimal(24,6);
alter table ECR_ASSURECONT add CERTTYPE varchar(20);
alter table ECR_ASSURECONT add CERTID varchar(20);
alter table ECR_ASSURECONT add REPORTTYPE varchar(1);

CREATE TABLE ECR_BATCHDEL
(
   CREATEDATE varchar(14) NOT NULL,
   CONTRACTNO varchar(40) NOT NULL,
   DELRESULT varchar(1),
   LOANCARDNO varchar(16),
   DELBUSINESSTYPE varchar(2),
   FINANCEID varchar(11),
   CONSTRAINT PK_ECR_BATCHDEL PRIMARY KEY (CREATEDATE,CONTRACTNO)
);

alter table ECR_CREDITLETTER alter column CREDITLETTERNO set data type varchar(60);
alter table ECR_CREDITLETTER alter column DEPOSITSCALE set data type decimal(3,0);

alter table ECR_CUSTOMERCREDIT alter column CCONTRACTNO set data type  varchar(60);

alter table ECR_ERRHISTORY alter column SERIALNO set data type  decimal(22,0);
alter table ECR_ERRHISTORY alter column ERRMSG set data type varchar(800);
alter table ECR_ERRHISTORY alter column MAINBUSINESSNO set data type varchar(60);

alter table ECR_ERRRECORD rename column errNUMERIC to ERRNUMBER;
alter table ECR_ERRRECORD alter column ERRNUMBER set data type decimal(22,0);

alter table ECR_FEEDBACK alter column ERRMSG set data type varchar(800);
alter table ECR_FEEDBACK alter column MAINBUSINESSNO set data type varchar(60);

ALTER TABLE ECR_FINADUEBILL  drop COLUMN Form;
ALTER TABLE ECR_FINADUEBILL  drop COLUMN LoanCharacter;
ALTER TABLE ECR_FINADUEBILL  drop COLUMN Way;


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
   CONSTRAINT PK_ECR_FINANCEBS07 PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)
);

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
   CONSTRAINT PK_ECR_FINANCEBSIN PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)
);


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
   CONSTRAINT PK_ECR_FINANCECF07 PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)
);

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
   CONSTRAINT PK_ECR_FINANCEPS07 PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)
);

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
   CONSTRAINT PK_ECR_FINANCECFIN PRIMARY KEY (CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)
);

alter table ECR_FINARETURN alter column RETURNTIMES set data type decimal(22,0);
  
alter table ECR_FLOORFUND alter column FLOORFUNDNO set data type varchar(60);

alter table ECR_GUARANTEEBILL alter column DEPOSITSCALE set data type decimal(3,0);

alter table ECR_GUARANTYCONT alter column CONTRACTNO set data type varchar(60);
alter table ECR_GUARANTYCONT alter column GUARANTYCONTNO set data type varchar(60);
alter table ECR_GUARANTYCONT add CUSTOMERID varchar(40);
alter table ECR_GUARANTYCONT alter column GUARANTYNO set data type varchar(2);
alter table ECR_GUARANTYCONT add CERTTYPE varchar(20);
alter table ECR_GUARANTYCONT add CERTID varchar(20);
alter table ECR_GUARANTYCONT add REPORTTYPE varchar(20);

alter table ECR_IMPAWNCONT alter column CONTRACTNO set data type varchar(60);
alter table ECR_IMPAWNCONT alter column IMPAWNCONTNO set data type varchar(60);
alter table ECR_IMPAWNCONT alter column IMPAWSERIALNO set data type varchar(60);
alter table ECR_IMPAWNCONT add CUSTOMERID varchar(40);
alter table ECR_IMPAWNCONT alter column IMPAWNO set data type varchar(2);
alter table ECR_IMPAWNCONT alter column VALUECURRENCY set data type varchar(3);
alter table ECR_IMPAWNCONT add CERTTYPE varchar(20);
alter table ECR_IMPAWNCONT add CERTID varchar(20);
alter table ECR_IMPAWNCONT add REPORTTYPE varchar(20);

CREATE TABLE ECR_LOANCARD
(
   OCCURDATE varchar(10),
   LOANCARDNO varchar(60) PRIMARY KEY NOT NULL,
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
   ERRORCODE varchar(80)
);

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
   CONSTRAINT LOANCARDCHANGE PRIMARY KEY (CUSTOMERID,OLDLOANCARDNO,NEWLOANCARDNO,FINANCEID)
);


alter table ECR_LOANCONTRACT alter column LCONTRACTNO set data type varchar(60);

alter table ECR_LOANDUEBILL alter column LDUEBILLNO set data type varchar(60);
alter table ECR_LOANDUEBILL alter column LCONTRACTNO set data type varchar(60);

alter table ECR_LOANEXTENSION alter column LDUEBILLNO set data type varchar(60);
alter table ECR_LOANEXTENSION alter column LCONTRACTNO set data type varchar(60);

alter table ECR_LOANRETURN alter column LDUEBILLNO set data type varchar(60);
alter table ECR_LOANRETURN alter column LCONTRACTNO set data type varchar(60);
alter table ECR_LOANRETURN alter column RETURNSUM set data type decimal(24,6);

CREATE TABLE ECR_PREPAREDATE
(
   LASTPREPAREDATE varchar(10) PRIMARY KEY NOT NULL
);

CREATE TABLE ECR_PREPARESTATUS
(
   LASTPREPAREDATE date PRIMARY KEY NOT NULL,
   RUNSTATUS varchar(1)
);

alter table ECR_REPORTSTATUS alter column RECORDNUMBER set data type decimal(22,0);
alter table ECR_REPORTSTATUS alter column FEEDBACKNUMBER set data type decimal(22,0);

CREATE TABLE ECR_RUNSTATUS
(
   RUNRESULT varchar(1),
   RUNSTATUS varchar(3)
);

alter table ECR_SESSION alter column STATUS set data type decimal(22,0);
alter table ECR_SESSION alter column DATATYPE set data type decimal(22,0);

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
  CONSTRAINT PK_ECR_ASSETSDISPOSE PRIMARY KEY (BUSINESSNO)
);


/*==============================================================*/
/* Table: ECR_ORGANATTRIBUTE                                    */
/*==============================================================*/
create table ECR_ORGANATTRIBUTE  (
   CIFCustomerId      VARCHAR(40)                    not null,
   ChineseName        VARCHAR(80),
   EnglishName        VARCHAR(80),
   RegisterAdd        VARCHAR(80),
   RegisterCountry    VARCHAR(3),
   RegisterAreaCode   VARCHAR(6),
   RegisterDate       VARCHAR(10),
   RegisterDueDate    VARCHAR(10),
   BusinessScope      VARCHAR(400),
   CapitalCurrency    VARCHAR(3),
   CapitalFund        DECIMAL(10,2),
   OrgType            VARCHAR(1),
   OrgTypeSub         VARCHAR(2),
   Industry           VARCHAR(5),
   OrgNature          VARCHAR(2),
   UpdateDate         VARCHAR(10),
   Attribute1         VARCHAR(40),
   OccurDate          VARCHAR(10),
   IncrementFlag      VARCHAR(1),
   Modflag            VARCHAR(1),
   TraceNumber        VARCHAR(20),
   RecordFlag         VARCHAR(20),
   SessionId          VARCHAR(10),
   ErrorCode          VARCHAR(80),
   constraint PK_ECR_ORGATTR primary key (CIFCustomerId)
);
comment on table ECR_ORGANATTRIBUTE is '机构属性 机构基本信息采集报文C段 0：1';
comment on column ECR_ORGANATTRIBUTE.CIFCustomerId is '客户号';
comment on column ECR_ORGANATTRIBUTE.ChineseName is '机构中文名称';
comment on column ECR_ORGANATTRIBUTE.EnglishName is '机构英文名称';
comment on column ECR_ORGANATTRIBUTE.RegisterAdd is '注册（登记）地址';
comment on column ECR_ORGANATTRIBUTE.RegisterCountry is '国别';
comment on column ECR_ORGANATTRIBUTE.RegisterAreaCode is '注册（登记）地行政区划';
comment on column ECR_ORGANATTRIBUTE.RegisterDate is '成立日期';
comment on column ECR_ORGANATTRIBUTE.RegisterDueDate is '证书到期日';
comment on column ECR_ORGANATTRIBUTE.BusinessScope is '经营（业务）范围';
comment on column ECR_ORGANATTRIBUTE.CapitalCurrency is '注册资本币种';
comment on column ECR_ORGANATTRIBUTE.CapitalFund is '注册资本（万元）';
comment on column ECR_ORGANATTRIBUTE.OrgType is '组织机构类别';
comment on column ECR_ORGANATTRIBUTE.OrgTypeSub is '组织机构类别细分';
comment on column ECR_ORGANATTRIBUTE.Industry is '经济行业分类';
comment on column ECR_ORGANATTRIBUTE.OrgNature is '经济类型';
comment on column ECR_ORGANATTRIBUTE.UpdateDate is '信息更新日期';
comment on column ECR_ORGANATTRIBUTE.Attribute1 is '预留字段';
comment on column ECR_ORGANATTRIBUTE.OccurDate is '发生日期';
comment on column ECR_ORGANATTRIBUTE.IncrementFlag is '增量标志';
comment on column ECR_ORGANATTRIBUTE.Modflag is '修改标志';
comment on column ECR_ORGANATTRIBUTE.TraceNumber is '跟踪编号';
comment on column ECR_ORGANATTRIBUTE.RecordFlag is '记录标志';
comment on column ECR_ORGANATTRIBUTE.SessionId is '报送期次';
comment on column ECR_ORGANATTRIBUTE.ErrorCode is '错误代码';

/*==============================================================*/
/* Table: ECR_ORGANCONTACT                                      */
/*==============================================================*/
create table ECR_ORGANCONTACT  (
   CIFCustomerId      VARCHAR(40)                    not null,
   OfficeAdd          VARCHAR(80),
   OfficeContact      VARCHAR(35),
   FinanceContact     VARCHAR(35),
   UpdateDate         VARCHAR(10),
   Attribute1         VARCHAR(40),
   OccurDate          VARCHAR(10),
   IncrementFlag      VARCHAR(1),
   Modflag            VARCHAR(1),
   TraceNumber        VARCHAR(20),
   RecordFlag         VARCHAR(20),
   SessionId          VARCHAR(10),
   ErrorCode          VARCHAR(80),
   constraint PK_ECR_ORGANCONTACT primary key (CIFCustomerId)
);

comment on table ECR_ORGANCONTACT is
'机构联络 机构基本信息采集报文E段 0：1';

comment on column ECR_ORGANCONTACT.CIFCustomerId is
'客户号';

comment on column ECR_ORGANCONTACT.OfficeAdd is
'办公（生产、经营）地址';

comment on column ECR_ORGANCONTACT.OfficeContact is
'联系电话';

comment on column ECR_ORGANCONTACT.FinanceContact is
'财务部联系电话';

comment on column ECR_ORGANCONTACT.UpdateDate is
'信息更新日期';

comment on column ECR_ORGANCONTACT.Attribute1 is
'预留字段';

comment on column ECR_ORGANCONTACT.OccurDate is
'发生日期';

comment on column ECR_ORGANCONTACT.IncrementFlag is
'增量标志';

comment on column ECR_ORGANCONTACT.Modflag is
'修改标志';

comment on column ECR_ORGANCONTACT.TraceNumber is
'跟踪编号';

comment on column ECR_ORGANCONTACT.RecordFlag is
'记录标志';

comment on column ECR_ORGANCONTACT.SessionId is
'报送期次';

comment on column ECR_ORGANCONTACT.ErrorCode is
'错误代码';

/*==============================================================*/
/* Table: ECR_ORGANFAMILY                                       */
/*==============================================================*/
create table ECR_ORGANFAMILY  (
   CIFCustomerId      VARCHAR(40)                    not null,
   ManagerName        VARCHAR(80),
   ManagerCertType    VARCHAR(2)                     not null,
   ManagerCertId      VARCHAR(20)                    not null,
   MemberRelaType     VARCHAR(1)                     not null,
   MemberName         VARCHAR(80),
   MemberCertType     VARCHAR(2)                     not null,
   MemberCertId       VARCHAR(20)                    not null,
   UpdateDate         VARCHAR(10),
   Attribute1         VARCHAR(40),
   OccurDate          VARCHAR(10),
   IncrementFlag      VARCHAR(1),
   Modflag            VARCHAR(1),
   TraceNumber        VARCHAR(20),
   RecordFlag         VARCHAR(20),
   SessionId          VARCHAR(10),
   ErrorCode          VARCHAR(80),
   FinanceId          VARCHAR(11),
   OldFinanceId       VARCHAR(11),
   LoancardNo         VARCHAR(16),
   constraint PK_ECR_ORGFAMILY primary key (CIFCustomerId, ManagerCertType, ManagerCertId, MemberRelaType, MemberCertType, MemberCertId)
);

comment on table ECR_ORGANFAMILY is
'机构家族成员B段1：1';

comment on column ECR_ORGANFAMILY.CIFCustomerId is
'客户号';

comment on column ECR_ORGANFAMILY.ManagerName is
'主要关系人姓名';

comment on column ECR_ORGANFAMILY.ManagerCertType is
'主要关系人证件类型';

comment on column ECR_ORGANFAMILY.ManagerCertId is
'证件号码';

comment on column ECR_ORGANFAMILY.MemberRelaType is
'家族关系';

comment on column ECR_ORGANFAMILY.MemberName is
'家族成员姓名';

comment on column ECR_ORGANFAMILY.MemberCertType is
'家族成员证件类型';

comment on column ECR_ORGANFAMILY.MemberCertId is
'证件号码';

comment on column ECR_ORGANFAMILY.UpdateDate is
'信息更新日期';

comment on column ECR_ORGANFAMILY.Attribute1 is
'预留字段';

comment on column ECR_ORGANFAMILY.OccurDate is
'发生日期';

comment on column ECR_ORGANFAMILY.IncrementFlag is
'增量标志';

comment on column ECR_ORGANFAMILY.Modflag is
'修改标志';

comment on column ECR_ORGANFAMILY.TraceNumber is
'跟踪编号';

comment on column ECR_ORGANFAMILY.RecordFlag is
'记录标志';

comment on column ECR_ORGANFAMILY.SessionId is
'报送期次';

comment on column ECR_ORGANFAMILY.ErrorCode is
'错误代码';

comment on column ECR_ORGANFAMILY.FinanceId is
'管理行代码(金融机构代码)';

comment on column ECR_ORGANFAMILY.OldFinanceId is
'原金融机构代码';

comment on column ECR_ORGANFAMILY.LoancardNo is
'贷款卡编码';

/*==============================================================*/
/* Table: ECR_ORGANINFO                                         */
/*==============================================================*/
create table ECR_ORGANINFO  (
   CIFCustomerId      VARCHAR(40)                    not null,
   MFCustomerId       VARCHAR(40),
   LSCustomerId       VARCHAR(40),
   FinanceId          VARCHAR(11),
   OldFinanceId       VARCHAR(11),
   CustomerType       VARCHAR(1),
   CreditCode         VARCHAR(18),
   CorpId             VARCHAR(10),
   RegisterType       VARCHAR(2),
   RegisterNo         VARCHAR(20),
   NationalTaxNo      VARCHAR(20),
   LocalTaxNo         VARCHAR(20),
   AccountPermitNo    VARCHAR(20),
   LoancardNo         VARCHAR(16),
   GatherDate         VARCHAR(10),
   Attribute1         VARCHAR(40),
   OccurDate          VARCHAR(10),
   IncrementFlag      VARCHAR(1),
   Modflag            VARCHAR(1),
   TraceNumber        VARCHAR(20),
   RecordFlag         VARCHAR(20),
   SessionId          VARCHAR(10),
   ErrorCode          VARCHAR(80),
   constraint PK_ECR_ORGANINFO primary key (CIFCustomerId)
);

comment on table ECR_ORGANINFO is
'机构基础信息  机构基本信息采集报文B段1:1';

comment on column ECR_ORGANINFO.CIFCustomerId is
'客户号';

comment on column ECR_ORGANINFO.MFCustomerId is
'核心客户号';

comment on column ECR_ORGANINFO.LSCustomerId is
'信贷客户号';

comment on column ECR_ORGANINFO.FinanceId is
'管理行代码(金融机构代码)';

comment on column ECR_ORGANINFO.OldFinanceId is
'原金融机构代码';

comment on column ECR_ORGANINFO.CustomerType is
'客户类型';

comment on column ECR_ORGANINFO.CreditCode is
'机构信用代码 ';

comment on column ECR_ORGANINFO.CorpId is
'组织机构代码';

comment on column ECR_ORGANINFO.RegisterType is
'登记注册号类型';

comment on column ECR_ORGANINFO.RegisterNo is
'登记注册号码';

comment on column ECR_ORGANINFO.NationalTaxNo is
'纳税人识别号（国税）';

comment on column ECR_ORGANINFO.LocalTaxNo is
'纳税人识别号（地税）';

comment on column ECR_ORGANINFO.AccountPermitNo is
'开户许可证核准号';

comment on column ECR_ORGANINFO.LoancardNo is
'贷款卡编码';

comment on column ECR_ORGANINFO.GatherDate is
'数据提取日期';

comment on column ECR_ORGANINFO.Attribute1 is
'预留字段';

comment on column ECR_ORGANINFO.OccurDate is
'发生日期';

comment on column ECR_ORGANINFO.IncrementFlag is
'增量标志';

comment on column ECR_ORGANINFO.Modflag is
'修改标志';

comment on column ECR_ORGANINFO.TraceNumber is
'跟踪编号';

comment on column ECR_ORGANINFO.RecordFlag is
'记录标志';

comment on column ECR_ORGANINFO.SessionId is
'报送期次';

comment on column ECR_ORGANINFO.ErrorCode is
'错误代码';

/*==============================================================*/
/* Table: ECR_ORGANKEEPER                                       */
/*==============================================================*/
create table ECR_ORGANKEEPER  (
   CIFCustomerId      VARCHAR(40)                    not null,
   ManagerType        VARCHAR(1)                     not null,
   ManagerName        VARCHAR(80),
   CertType           VARCHAR(2),
   CertId             VARCHAR(20),
   UpdateDate         VARCHAR(10),
   Attribute1         VARCHAR(40),
   OccurDate          VARCHAR(10),
   IncrementFlag      VARCHAR(1),
   Modflag            VARCHAR(1),
   TraceNumber        VARCHAR(20),
   RecordFlag         VARCHAR(20),
   SessionId          VARCHAR(10),
   ErrorCode          VARCHAR(80),
   constraint PK_ECR_KEEPER primary key (CIFCustomerId, ManagerType)
);

comment on table ECR_ORGANKEEPER is
'机构高管及主要关系人 机构基本信息采集报文F段 0：n';

comment on column ECR_ORGANKEEPER.CIFCustomerId is
'客户号';

comment on column ECR_ORGANKEEPER.ManagerType is
'关系人类型';

comment on column ECR_ORGANKEEPER.ManagerName is
'姓名';

comment on column ECR_ORGANKEEPER.CertType is
'证件类型';

comment on column ECR_ORGANKEEPER.CertId is
'证件号码';

comment on column ECR_ORGANKEEPER.UpdateDate is
'信息更新日期';

comment on column ECR_ORGANKEEPER.Attribute1 is
'预留字段';

comment on column ECR_ORGANKEEPER.OccurDate is
'发生日期';

comment on column ECR_ORGANKEEPER.IncrementFlag is
'增量标志';

comment on column ECR_ORGANKEEPER.Modflag is
'修改标志';

comment on column ECR_ORGANKEEPER.TraceNumber is
'跟踪编号';

comment on column ECR_ORGANKEEPER.RecordFlag is
'记录标志';

comment on column ECR_ORGANKEEPER.SessionId is
'报送期次';

comment on column ECR_ORGANKEEPER.ErrorCode is
'错误代码';

/*==============================================================*/
/* Table: ECR_ORGANRELATED                                      */
/*==============================================================*/
create table ECR_ORGANRELATED  (
   CIFCustomerId      VARCHAR(40)                    not null,
   RelationShip       VARCHAR(2)                     not null,
   RelativeEntName    VARCHAR(80)                    not null,
   RegisterType       VARCHAR(2),
   RegisterNo         VARCHAR(20),
   CorpId             VARCHAR(10),
   CreditCode         VARCHAR(18),
   UpdateDate         VARCHAR(10),
   Attribute1         VARCHAR(40),
   OccurDate          VARCHAR(10),
   IncrementFlag      VARCHAR(1),
   Modflag            VARCHAR(1),
   TraceNumber        VARCHAR(20),
   RecordFlag         VARCHAR(20),
   SessionId          VARCHAR(10),
   ErrorCode          VARCHAR(80),
   constraint PK_ECR_ORGRELATED primary key (CIFCustomerId, RelationShip, RelativeEntName)
);

comment on table ECR_ORGANRELATED is
'机构主要关联企业 机构基本信息采集报文H段 0：n';

comment on column ECR_ORGANRELATED.CIFCustomerId is
'客户号';

comment on column ECR_ORGANRELATED.RelationShip is
'关联类型';

comment on column ECR_ORGANRELATED.RelativeEntName is
'关联企业名称';

comment on column ECR_ORGANRELATED.RegisterType is
'登记注册号类型';

comment on column ECR_ORGANRELATED.RegisterNo is
'登记注册号码';

comment on column ECR_ORGANRELATED.CorpId is
'组织机构代码';

comment on column ECR_ORGANRELATED.CreditCode is
'机构信用代码';

comment on column ECR_ORGANRELATED.UpdateDate is
'信息更新日期';

comment on column ECR_ORGANRELATED.Attribute1 is
'预留字段';

comment on column ECR_ORGANRELATED.OccurDate is
'发生日期';

comment on column ECR_ORGANRELATED.IncrementFlag is
'增量标志';

comment on column ECR_ORGANRELATED.Modflag is
'修改标志';

comment on column ECR_ORGANRELATED.TraceNumber is
'跟踪编号';

comment on column ECR_ORGANRELATED.RecordFlag is
'记录标志';

comment on column ECR_ORGANRELATED.SessionId is
'报送期次';

comment on column ECR_ORGANRELATED.ErrorCode is
'错误代码';

/*==============================================================*/
/* Table: ECR_ORGANSTATUS                                       */
/*==============================================================*/
create table ECR_ORGANSTATUS  (
   CIFCustomerId      VARCHAR(40)                    not null,
   AccountStatus      VARCHAR(1),
   Scope              VARCHAR(1),
   OrgStatus          VARCHAR(1),
   UpdateDate         VARCHAR(10),
   Attribute1         VARCHAR(40),
   OccurDate          VARCHAR(10),
   IncrementFlag      VARCHAR(1),
   Modflag            VARCHAR(1),
   TraceNumber        VARCHAR(20),
   RecordFlag         VARCHAR(20),
   SessionId          VARCHAR(10),
   ErrorCode          VARCHAR(80),
   constraint PK_ECR_ORGANSTATUS primary key (CIFCustomerId)
);

comment on table ECR_ORGANSTATUS is
'机构状态 机构基本信息采集报文D段 0：1';

comment on column ECR_ORGANSTATUS.CIFCustomerId is
'客户号';

comment on column ECR_ORGANSTATUS.AccountStatus is
'基本户状态';

comment on column ECR_ORGANSTATUS.Scope is
'企业规模';

comment on column ECR_ORGANSTATUS.OrgStatus is
'机构状态';

comment on column ECR_ORGANSTATUS.UpdateDate is
'信息更新日期';

comment on column ECR_ORGANSTATUS.Attribute1 is
'预留字段';

comment on column ECR_ORGANSTATUS.OccurDate is
'发生日期';

comment on column ECR_ORGANSTATUS.IncrementFlag is
'增量标志';

comment on column ECR_ORGANSTATUS.Modflag is
'修改标志';

comment on column ECR_ORGANSTATUS.TraceNumber is
'跟踪编号';

comment on column ECR_ORGANSTATUS.RecordFlag is
'记录标志';

comment on column ECR_ORGANSTATUS.SessionId is
'报送期次';

comment on column ECR_ORGANSTATUS.ErrorCode is
'错误代码';

/*==============================================================*/
/* Table: ECR_ORGANSTOCKHOLDER                                  */
/*==============================================================*/
create table ECR_ORGANSTOCKHOLDER  (
   CIFCustomerId      VARCHAR(40)                    not null,
   StockHolderType    VARCHAR(1)                     not null,
   StockHolderName    VARCHAR(80)                    not null,
   CertType           VARCHAR(2),
   CertId             VARCHAR(20),
   CorpId             VARCHAR(10),
   CreditCode         VARCHAR(18),
   StockHodingRatio   DECIMAL(10,2),
   UpdateDate         VARCHAR(10),
   Attribute1         VARCHAR(40),
   OccurDate          VARCHAR(10),
   IncrementFlag      VARCHAR(1),
   Modflag            VARCHAR(1),
   TraceNumber        VARCHAR(20),
   RecordFlag         VARCHAR(20),
   SessionId          VARCHAR(10),
   ErrorCode          VARCHAR(80),
   constraint PK_ECR_ORGANHOLDER primary key (CIFCustomerId, StockHolderType, StockHolderName)
);

comment on table ECR_ORGANSTOCKHOLDER is
'机构重要股东 机构基本信息采集报文G段 0：n';

comment on column ECR_ORGANSTOCKHOLDER.CIFCustomerId is
'客户号';

comment on column ECR_ORGANSTOCKHOLDER.StockHolderType is
'股东类型';

comment on column ECR_ORGANSTOCKHOLDER.StockHolderName is
'股东名称';

comment on column ECR_ORGANSTOCKHOLDER.CertType is
'证件类型/登记注册号类型';

comment on column ECR_ORGANSTOCKHOLDER.CertId is
'证件号码/登记注册号码';

comment on column ECR_ORGANSTOCKHOLDER.CorpId is
'组织机构代码';

comment on column ECR_ORGANSTOCKHOLDER.CreditCode is
'机构信用代码';

comment on column ECR_ORGANSTOCKHOLDER.StockHodingRatio is
'持股比例';

comment on column ECR_ORGANSTOCKHOLDER.UpdateDate is
'信息更新日期';

comment on column ECR_ORGANSTOCKHOLDER.Attribute1 is
'预留字段';

comment on column ECR_ORGANSTOCKHOLDER.OccurDate is
'发生日期';

comment on column ECR_ORGANSTOCKHOLDER.IncrementFlag is
'增量标志';

comment on column ECR_ORGANSTOCKHOLDER.Modflag is
'修改标志';

comment on column ECR_ORGANSTOCKHOLDER.TraceNumber is
'跟踪编号';

comment on column ECR_ORGANSTOCKHOLDER.RecordFlag is
'记录标志';

comment on column ECR_ORGANSTOCKHOLDER.SessionId is
'报送期次';

comment on column ECR_ORGANSTOCKHOLDER.ErrorCode is
'错误代码';

/*==============================================================*/
/* Table: ECR_ORGANSUPERIOR                                     */
/*==============================================================*/
create table ECR_ORGANSUPERIOR  (
   CIFCustomerId      VARCHAR(40)                    not null,
   SuperiorName       VARCHAR(80),
   RegisterType       VARCHAR(2),
   RegisterNo         VARCHAR(20),
   CorpId             VARCHAR(10),
   CreditCode         VARCHAR(18),
   UpdateDate         VARCHAR(10),
   Attribute1         VARCHAR(40),
   OccurDate          VARCHAR(10),
   IncrementFlag      VARCHAR(1),
   Modflag            VARCHAR(1),
   TraceNumber        VARCHAR(20),
   RecordFlag         VARCHAR(20),
   SessionId          VARCHAR(10),
   ErrorCode          VARCHAR(80),
   constraint PK_ECR_ORGANSUPERIOR primary key (CIFCustomerId)
);

comment on table ECR_ORGANSUPERIOR is
'机构上级机构(主管部门) 机构基本信息采集报文I段 0：1';

comment on column ECR_ORGANSUPERIOR.CIFCustomerId is
'客户号';

comment on column ECR_ORGANSUPERIOR.SuperiorName is
'上级机构名称';

comment on column ECR_ORGANSUPERIOR.RegisterType is
'登记注册号类型';

comment on column ECR_ORGANSUPERIOR.RegisterNo is
'登记注册号';

comment on column ECR_ORGANSUPERIOR.CorpId is
'组织机构代码';

comment on column ECR_ORGANSUPERIOR.CreditCode is
'机构信用代码';

comment on column ECR_ORGANSUPERIOR.UpdateDate is
'信息更新日期';

comment on column ECR_ORGANSUPERIOR.Attribute1 is
'预留字段';

comment on column ECR_ORGANSUPERIOR.OccurDate is
'发生日期';

comment on column ECR_ORGANSUPERIOR.IncrementFlag is
'增量标志';

comment on column ECR_ORGANSUPERIOR.Modflag is
'修改标志';

comment on column ECR_ORGANSUPERIOR.TraceNumber is
'跟踪编号';

comment on column ECR_ORGANSUPERIOR.RecordFlag is
'记录标志';

comment on column ECR_ORGANSUPERIOR.SessionId is
'报送期次';

comment on column ECR_ORGANSUPERIOR.ErrorCode is
'错误代码';



