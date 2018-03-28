DROP TABLE HIS_LOANCARD;


alter table HIS_ACCEPTANCE modify ACONTRACTNO  VARCHAR2(60);
alter table HIS_ACCEPTANCE modify ASSURESCALE  NUMBER(3);

alter table HIS_ASSURECONT add certType VARCHAR2(20);
alter table HIS_ASSURECONT add CERTID VARCHAR2(20);
alter table HIS_ASSURECONT add REPORTTYPE VARCHAR2(20);

alter table HIS_CREDITLETTER modify CREDITLETTERNO  VARCHAR2(60);
alter table HIS_CREDITLETTER modify DEPOSITSCALE  NUMBER(3);

alter table HIS_CUSTOMERCREDIT modify CCONTRACTNO  VARCHAR2(60);

CREATE TABLE HIS_FINANCEBS_2007
(
   CUSTOMERID VARCHAR2(40) NOT NULL,
   REPORTYEAR char(4) NOT NULL,
   REPORTTYPE char(2) NOT NULL,
   REPORTSUBTYPE char(1) NOT NULL,
   OCCURDATE VARCHAR2(10) NOT NULL,
   OLDFINANCEID VARCHAR2(59),
   FINANCEID VARCHAR2(11),
   LOANCARDNO VARCHAR2(16),
   CUSTOMERNAME VARCHAR2(80),
   INCREMENTFLAG VARCHAR2(1),
   MODFLAG VARCHAR2(1),
   TRACENUMBER VARCHAR2(20),
   RECORDFLAG VARCHAR2(20),
   SESSIONID VARCHAR2(10) NOT NULL,
   ERRORCODE VARCHAR2(80),
   AUDITFIRM VARCHAR2(80),
   AUDITOR VARCHAR2(30),
   AUDITDATE VARCHAR2(10),
   M9100 NUMBER(17,2),
   M9101 NUMBER(17,2),
   M9102 NUMBER(17,2),
   M9103 NUMBER(17,2),
   M9104 NUMBER(17,2),
   M9105 NUMBER(17,2),
   M9106 NUMBER(17,2),
   M9107 NUMBER(17,2),
   M9108 NUMBER(17,2),
   M9109 NUMBER(17,2),
   M9110 NUMBER(17,2),
   M9111 NUMBER(17,2),
   M9112 NUMBER(17,2),
   M9113 NUMBER(17,2),
   M9114 NUMBER(17,2),
   M9115 NUMBER(17,2),
   M9116 NUMBER(17,2),
   M9117 NUMBER(17,2),
   M9118 NUMBER(17,2),
   M9119 NUMBER(17,2),
   M9120 NUMBER(17,2),
   M9121 NUMBER(17,2),
   M9122 NUMBER(17,2),
   M9123 NUMBER(17,2),
   M9124 NUMBER(17,2),
   M9125 NUMBER(17,2),
   M9126 NUMBER(17,2),
   M9127 NUMBER(17,2),
   M9128 NUMBER(17,2),
   M9129 NUMBER(17,2),
   M9130 NUMBER(17,2),
   M9131 NUMBER(17,2),
   M9132 NUMBER(17,2),
   M9133 NUMBER(17,2),
   M9134 NUMBER(17,2),
   M9135 NUMBER(17,2),
   M9136 NUMBER(17,2),
   M9137 NUMBER(17,2),
   M9138 NUMBER(17,2),
   M9139 NUMBER(17,2),
   M9140 NUMBER(17,2),
   M9141 NUMBER(17,2),
   M9142 NUMBER(17,2),
   M9143 NUMBER(17,2),
   M9144 NUMBER(17,2),
   M9145 NUMBER(17,2),
   M9146 NUMBER(17,2),
   M9147 NUMBER(17,2),
   M9148 NUMBER(17,2),
   M9149 NUMBER(17,2),
   M9150 NUMBER(17,2),
   M9151 NUMBER(17,2),
   M9152 NUMBER(17,2),
   M9153 NUMBER(17,2),
   M9154 NUMBER(17,2),
   M9155 NUMBER(17,2),
   M9156 NUMBER(17,2),
   M9157 NUMBER(17,2),
   M9158 NUMBER(17,2),
   M9159 NUMBER(17,2),
   CONSTRAINT PK_HIS_FINANCEBS07 PRIMARY KEY (SESSIONID,OCCURDATE,CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)
);

CREATE TABLE HIS_FINANCEBS_IN
(
   CUSTOMERID VARCHAR2(40) NOT NULL,
   REPORTYEAR char(4) NOT NULL,
   REPORTTYPE char(2) NOT NULL,
   REPORTSUBTYPE char(1) NOT NULL,
   OCCURDATE VARCHAR2(10)  NOT NULL,
   OLDFINANCEID VARCHAR2(59),
   FINANCEID VARCHAR2(11),
   LOANCARDNO VARCHAR2(16),
   INCREMENTFLAG VARCHAR2(1),
   CUSTOMERNAME VARCHAR2(80),
   MODFLAG VARCHAR2(1),
   TRACENUMBER VARCHAR2(20),
   RECORDFLAG VARCHAR2(20),
   SESSIONID VARCHAR2(10) NOT NULL,
   ERRORCODE VARCHAR2(80),
   AUDITFIRM VARCHAR2(80),
   AUDITOR VARCHAR2(30),
   AUDITDATE VARCHAR2(10),
   M9271 NUMBER(17,2),
   M9272 NUMBER(17,2),
   M9273 NUMBER(17,2),
   M9274 NUMBER(17,2),
   M9275 NUMBER(17,2),
   M9276 NUMBER(17,2),
   M9277 NUMBER(17,2),
   M9278 NUMBER(17,2),
   M9279 NUMBER(17,2),
   M9280 NUMBER(17,2),
   M9281 NUMBER(17,2),
   M9282 NUMBER(17,2),
   M9283 NUMBER(17,2),
   M9284 NUMBER(17,2),
   M9285 NUMBER(17,2),
   M9286 NUMBER(17,2),
   M9287 NUMBER(17,2),
   M9288 NUMBER(17,2),
   M9289 NUMBER(17,2),
   M9290 NUMBER(17,2),
   M9291 NUMBER(17,2),
   M9292 NUMBER(17,2),
   M9293 NUMBER(17,2),
   M9294 NUMBER(17,2),
   M9295 NUMBER(17,2),
   M9296 NUMBER(17,2),
   M9297 NUMBER(17,2),
   M9298 NUMBER(17,2),
   M9299 NUMBER(17,2),
   M9300 NUMBER(17,2),
   M9301 NUMBER(17,2),
   M9302 NUMBER(17,2),
   M9303 NUMBER(17,2),
   M9304 NUMBER(17,2),
   M9305 NUMBER(17,2),
   M9306 NUMBER(17,2),
   M9307 NUMBER(17,2),
   M9308 NUMBER(17,2),
   M9309 NUMBER(17,2),
   M9310 NUMBER(17,2),
   M9311 NUMBER(17,2),
   M9312 NUMBER(17,2),
   M9313 NUMBER(17,2),
   M9314 NUMBER(17,2),
   M9315 NUMBER(17,2),
   M9316 NUMBER(17,2),
   M9317 NUMBER(17,2),
   M9318 NUMBER(17,2),
   M9319 NUMBER(17,2),
   M9320 NUMBER(17,2),
   CONSTRAINT PK_HIS_FINANCEBSIN PRIMARY KEY (SESSIONID,OCCURDATE,CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)
);

CREATE TABLE HIS_FINANCECF_2007
(
   CUSTOMERID VARCHAR2(40) NOT NULL,
   REPORTYEAR char(4) NOT NULL,
   REPORTTYPE char(2) NOT NULL,
   REPORTSUBTYPE char(1) NOT NULL,
   OCCURDATE VARCHAR2(10) NOT NULL,
   OLDFINANCEID VARCHAR2(59),
   FINANCEID VARCHAR2(11),
   LOANCARDNO VARCHAR2(16),
   CUSTOMERNAME VARCHAR2(80),
   INCREMENTFLAG VARCHAR2(1),
   MODFLAG VARCHAR2(1),
   TRACENUMBER VARCHAR2(20),
   RECORDFLAG VARCHAR2(20),
   SESSIONID VARCHAR2(10) NOT NULL,
   ERRORCODE VARCHAR2(80),
   AUDITFIRM VARCHAR2(80),
   AUDITOR VARCHAR2(30),
   AUDITDATE VARCHAR2(10),
   M9199 NUMBER(17,2),
   M9200 NUMBER(17,2),
   M9201 NUMBER(17,2),
   M9202 NUMBER(17,2),
   M9203 NUMBER(17,2),
   M9204 NUMBER(17,2),
   M9205 NUMBER(17,2),
   M9206 NUMBER(17,2),
   M9207 NUMBER(17,2),
   M9208 NUMBER(17,2),
   M9209 NUMBER(17,2),
   M9210 NUMBER(17,2),
   M9211 NUMBER(17,2),
   M9212 NUMBER(17,2),
   M9213 NUMBER(17,2),
   M9214 NUMBER(17,2),
   M9215 NUMBER(17,2),
   M9216 NUMBER(17,2),
   M9217 NUMBER(17,2),
   M9218 NUMBER(17,2),
   M9219 NUMBER(17,2),
   M9220 NUMBER(17,2),
   M9221 NUMBER(17,2),
   M9222 NUMBER(17,2),
   M9223 NUMBER(17,2),
   M9224 NUMBER(17,2),
   M9225 NUMBER(17,2),
   M9226 NUMBER(17,2),
   M9227 NUMBER(17,2),
   M9228 NUMBER(17,2),
   M9229 NUMBER(17,2),
   M9230 NUMBER(17,2),
   M9231 NUMBER(17,2),
   M9232 NUMBER(17,2),
   M9233 NUMBER(17,2),
   M9234 NUMBER(17,2),
   M9235 NUMBER(17,2),
   M9236 NUMBER(17,2),
   M9237 NUMBER(17,2),
   M9238 NUMBER(17,2),
   M9239 NUMBER(17,2),
   M9240 NUMBER(17,2),
   M9241 NUMBER(17,2),
   M9242 NUMBER(17,2),
   M9243 NUMBER(17,2),
   M9244 NUMBER(17,2),
   M9245 NUMBER(17,2),
   M9246 NUMBER(17,2),
   M9247 NUMBER(17,2),
   M9248 NUMBER(17,2),
   M9249 NUMBER(17,2),
   M9250 NUMBER(17,2),
   M9251 NUMBER(17,2),
   M9252 NUMBER(17,2),
   M9253 NUMBER(17,2),
   M9254 NUMBER(17,2),
   M9255 NUMBER(17,2),
   M9256 NUMBER(17,2),
   M9257 NUMBER(17,2),
   M9258 NUMBER(17,2),
   M9259 NUMBER(17,2),
   M9260 NUMBER(17,2),
   M9261 NUMBER(17,2),
   CONSTRAINT PK_HIS_FINANCECF07 PRIMARY KEY (SESSIONID,OCCURDATE,CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)
);

CREATE TABLE HIS_FINANCEPS_2007
(
   CUSTOMERID VARCHAR2(40) NOT NULL,
   REPORTYEAR char(4) NOT NULL,
   REPORTTYPE char(2) NOT NULL,
   REPORTSUBTYPE char(1) NOT NULL,
   OCCURDATE VARCHAR2(10) NOT NULL,
   OLDFINANCEID VARCHAR2(59),
   FINANCEID VARCHAR2(11),
   LOANCARDNO VARCHAR2(16),
   CUSTOMERNAME VARCHAR2(80),
   INCREMENTFLAG VARCHAR2(1),
   MODFLAG VARCHAR2(1),
   TRACENUMBER VARCHAR2(20),
   RECORDFLAG VARCHAR2(20),
   SESSIONID VARCHAR2(10) NOT NULL,
   ERRORCODE VARCHAR2(80),
   AUDITFIRM VARCHAR2(80),
   AUDITOR VARCHAR2(30),
   AUDITDATE VARCHAR2(10),
   M9170 NUMBER(17,2),
   M9171 NUMBER(17,2),
   M9172 NUMBER(17,2),
   M9173 NUMBER(17,2),
   M9174 NUMBER(17,2),
   M9175 NUMBER(17,2),
   M9176 NUMBER(17,2),
   M9177 NUMBER(17,2),
   M9178 NUMBER(17,2),
   M9179 NUMBER(17,2),
   M9180 NUMBER(17,2),
   M9181 NUMBER(17,2),
   M9182 NUMBER(17,2),
   M9183 NUMBER(17,2),
   M9184 NUMBER(17,2),
   M9185 NUMBER(17,2),
   M9186 NUMBER(17,2),
   M9187 NUMBER(17,2),
   M9188 NUMBER(17,2),
   CONSTRAINT PK_HIS_FINANCEPS07 PRIMARY KEY (SESSIONID,OCCURDATE,CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)
);


CREATE TABLE HIS_FINANCECF_IN
(
   CUSTOMERID VARCHAR2(40) NOT NULL,
   REPORTYEAR char(4) NOT NULL,
   REPORTTYPE char(2) NOT NULL,
   REPORTSUBTYPE char(1) NOT NULL,
   OCCURDATE VARCHAR2(10) NOT NULL,
   OLDFINANCEID VARCHAR2(59),
   FINANCEID VARCHAR2(11),
   LOANCARDNO VARCHAR2(16),
   CUSTOMERNAME VARCHAR2(80),
   INCREMENTFLAG VARCHAR2(1),
   MODFLAG VARCHAR2(1),
   TRACENUMBER VARCHAR2(20),
   RECORDFLAG VARCHAR2(20),
   SESSIONID VARCHAR2(10) NOT NULL,
   ERRORCODE VARCHAR2(80),
   AUDITFIRM VARCHAR2(80),
   AUDITOR VARCHAR2(30),
   AUDITDATE VARCHAR2(10),
   M9330 NUMBER(17,2),
   M9331 NUMBER(17,2),
   M9332 NUMBER(17,2),
   M9333 NUMBER(17,2),
   M9334 NUMBER(17,2),
   M9335 NUMBER(17,2),
   M9336 NUMBER(17,2),
   M9337 NUMBER(17,2),
   M9338 NUMBER(17,2),
   M9339 NUMBER(17,2),
   M9340 NUMBER(17,2),
   M9341 NUMBER(17,2),
   M9342 NUMBER(17,2),
   M9343 NUMBER(17,2),
   M9344 NUMBER(17,2),
   M9345 NUMBER(17,2),
   M9346 NUMBER(17,2),
   M9347 NUMBER(17,2),
   M9348 NUMBER(17,2),
   M9349 NUMBER(17,2),
   M9350 NUMBER(17,2),
   M9351 NUMBER(17,2),
   M9352 NUMBER(17,2),
   M9353 NUMBER(17,2),
   M9354 NUMBER(17,2),
   M9355 NUMBER(17,2),
   M9356 NUMBER(17,2),
   M9357 NUMBER(17,2),
   M9358 NUMBER(17,2),
   M9359 NUMBER(17,2),
   M9360 NUMBER(17,2),
   M9361 NUMBER(17,2),
   M9362 NUMBER(17,2),
   M9363 NUMBER(17,2),
   M9364 NUMBER(17,2),
   M9365 NUMBER(17,2),
   M9366 NUMBER(17,2),
   M9367 NUMBER(17,2),
   CONSTRAINT PK_HIS_FINANCECFIN PRIMARY KEY (SESSIONID,OCCURDATE,CUSTOMERID,REPORTYEAR,REPORTTYPE,REPORTSUBTYPE)
);

alter table HIS_FINARETURN modify RETURNTIMES  NUMBER(22,0);

alter table HIS_FLOORFUND modify FLOORFUNDNO  VARCHAR2(60);

alter table HIS_GUARANTEEBILL modify DEPOSITSCALE  NUMBER(3);

alter table HIS_GUARANTYCONT modify CONTRACTNO  VARCHAR2(60);
alter table HIS_GUARANTYCONT modify GUARANTYCONTNO  VARCHAR2(60);
alter table HIS_GUARANTYCONT modify GUARANTYNO  VARCHAR2(2);
ALTER TABLE HIS_GUARANTYCONT  add CERTTYPE VARCHAR2(20);
ALTER TABLE HIS_GUARANTYCONT  add CERTID VARCHAR2(20);
ALTER TABLE HIS_GUARANTYCONT  add REPORTTYPE VARCHAR2(20);

alter table HIS_IMPAWNCONT modify CONTRACTNO  VARCHAR2(60);
alter table HIS_IMPAWNCONT modify IMPAWNCONTNO  VARCHAR2(60);
alter table HIS_IMPAWNCONT modify IMPAWSERIALNO  VARCHAR2(60);
alter table HIS_IMPAWNCONT modify IMPAWNO  VARCHAR2(2);
ALTER TABLE HIS_IMPAWNCONT  add CERTTYPE VARCHAR2(20);
ALTER TABLE HIS_IMPAWNCONT  add CERTID VARCHAR2(20);
ALTER TABLE HIS_IMPAWNCONT  add REPORTTYPE VARCHAR2(20);

CREATE TABLE HIS_LOANCARD
(
   OCCURDATE VARCHAR2(10) NOT NULL,
   LOANCARDNO VARCHAR2(60) NOT NULL,
   LOANCARDPASSWORD VARCHAR2(6),
   STATUS NUMBER(22,0),
   COUNTRYCODE VARCHAR2(3),
   CHINESENAME VARCHAR2(80),
   ENGLISHNAME VARCHAR2(80),
   ORGANIZATIONCODE VARCHAR2(10),
   LICENCECODE VARCHAR2(20),
   REGISTERDATE VARCHAR2(10),
   KIND NUMBER(22,0),
   AREACODE VARCHAR2(6),
   INCREMENTFLAG char(1),
   MODFLAG char(1),
   TRACENUMBER VARCHAR2(20),
   RECORDFLAG VARCHAR2(20),
   SESSIONID VARCHAR2(10) NOT NULL,
   ERRORCODE VARCHAR2(80),
   CONSTRAINT PK_HIS_LOANCARD PRIMARY KEY (SESSIONID,OCCURDATE,LOANCARDNO)
);

alter table HIS_LOANCONTRACT modify LCONTRACTNO  VARCHAR2(60);

alter table HIS_LOANDUEBILL modify LDUEBILLNO  VARCHAR2(60);
alter table HIS_LOANDUEBILL modify LCONTRACTNO  VARCHAR2(60);

alter table HIS_LOANEXTENSION modify LDUEBILLNO  VARCHAR2(60);
alter table HIS_LOANEXTENSION modify LCONTRACTNO  VARCHAR2(60);

alter table HIS_LOANRETURN modify LDUEBILLNO  VARCHAR2(60);
alter table HIS_LOANRETURN modify LCONTRACTNO  VARCHAR2(60);
alter table HIS_LOANRETURN modify RETURNTIMES  NUMBER(22,0);


CREATE TABLE HIS_ASSETSDISPOSE
(
  BUSINESSNO VARCHAR2(60) NOT NULL,			--ҵ����
  FINANCEID  VARCHAR2(11),					--���ڻ�������
  OLDFINANCEID  VARCHAR2(59),
  CUSTOMERID     VARCHAR2(40),				--�ͻ����
  CUSTOMERNAME  VARCHAR2(80),				--���������
  LOANCARDNO      VARCHAR2(16),				--�������
  ORGANIZATIONCODE  VARCHAR2(11),			--��֯��������
  BUSINESSREGISTRYNO VARCHAR2(20),			--����ע��ǼǺ�
  BALANCE NUMBER(24,6),					--���
  DISPOSEDATE VARCHAR2(10),					--��������
  DISPOSETYPE VARCHAR2(1),					--��Ҫ�ʲ����÷�ʽ
  RECOVERYAMOUNT NUMBER(24,6),				--�ѻ��ս��
  OCCURDATE      VARCHAR2(10) NOT NULL,
  INCREMENTFLAG  VARCHAR2(1),
  MODFLAG        VARCHAR2(1),
  TRACENUMBER    VARCHAR2(20),
  RECORDFLAG     VARCHAR2(20),
  SESSIONID      VARCHAR2(10) NOT NULL,
  ERRORCODE      VARCHAR2(80),
  CONSTRAINT PK_HIS_ASSETSDISPOSE PRIMARY KEY (SESSIONID,OCCURDATE,BUSINESSNO)
);

/*==============================================================*/
/* Table: HIS_BATCHDELETEFAMILY                                 */
/*==============================================================*/
create table HIS_BATCHDELETEFAMILY  (
   CIFCustomerId      VARCHAR2(40)                    not null,
   ManagerCertType    VARCHAR2(2)                     not null,
   ManagerCertId      VARCHAR2(20)                    not null,
   MemberRelaType     VARCHAR2(1)                     not null,
   MemberCertType     VARCHAR2(2)                     not null,
   MemberCertId       VARCHAR2(20)                    not null,
   UpdateDate         VARCHAR2(10)                    not null,
   Attribute1         VARCHAR2(40),
   OccurDate          VARCHAR2(10),
   IncrementFlag      VARCHAR2(1),
   Modflag            VARCHAR2(1),
   TraceNumber        VARCHAR2(20),
   RecordFlag         VARCHAR2(20),
   SessionId          VARCHAR2(10),
   ErrorCode          VARCHAR2(80),
   FinanceId          VARCHAR2(11),
   constraint PK_HIS_BATCHDELETEFAMILY primary key (CIFCustomerId, ManagerCertType, ManagerCertId, MemberRelaType, MemberCertType, MemberCertId, UpdateDate)
);

comment on table HIS_BATCHDELETEFAMILY is
'��ͥ��Աɾ����';

comment on column HIS_BATCHDELETEFAMILY.CIFCustomerId is
'�ͻ���';

comment on column HIS_BATCHDELETEFAMILY.ManagerCertType is
'��Ҫ��ϵ��֤������';

comment on column HIS_BATCHDELETEFAMILY.ManagerCertId is
'֤������';

comment on column HIS_BATCHDELETEFAMILY.MemberRelaType is
'�����ϵ';

comment on column HIS_BATCHDELETEFAMILY.MemberCertType is
'�����Ա֤������';

comment on column HIS_BATCHDELETEFAMILY.MemberCertId is
'֤������';

comment on column HIS_BATCHDELETEFAMILY.UpdateDate is
'��Ϣ��������';

comment on column HIS_BATCHDELETEFAMILY.Attribute1 is
'Ԥ���ֶ�';

comment on column HIS_BATCHDELETEFAMILY.OccurDate is
'��������';

comment on column HIS_BATCHDELETEFAMILY.IncrementFlag is
'������־';

comment on column HIS_BATCHDELETEFAMILY.Modflag is
'�޸ı�־';

comment on column HIS_BATCHDELETEFAMILY.TraceNumber is
'���ٱ��';

comment on column HIS_BATCHDELETEFAMILY.RecordFlag is
'��¼��־';

comment on column HIS_BATCHDELETEFAMILY.SessionId is
'�����ڴ�';

comment on column HIS_BATCHDELETEFAMILY.ErrorCode is
'�������';

comment on column HIS_BATCHDELETEFAMILY.FinanceId is
'�����д���(���ڻ�������)';

/*==============================================================*/
/* Table: HIS_BATCHDELETEORGAN                                  */
/*==============================================================*/
create table HIS_BATCHDELETEORGAN  (
   CIFCustomerId      VARCHAR2(40)                    not null,
   SegmentType        VARCHAR2(1)                     not null,
   ManagerType        VARCHAR2(1),
   UpdateDate         VARCHAR2(10)                    not null,
   Attribute1         VARCHAR2(40),
   OccurDate          VARCHAR2(10),
   IncrementFlag      VARCHAR2(1),
   Modflag            VARCHAR2(1),
   TraceNumber        VARCHAR2(20),
   RecordFlag         VARCHAR2(20),
   SessionId          VARCHAR2(10),
   ErrorCode          VARCHAR2(80),
   FinanceId          VARCHAR2(11),
   constraint PK_HIS_BATCHDELETEORGAN primary key (CIFCustomerId, SegmentType, UpdateDate)
);

comment on table HIS_BATCHDELETEORGAN is
'������Ϣɾ����';

comment on column HIS_BATCHDELETEORGAN.CIFCustomerId is
'�ͻ���';

comment on column HIS_BATCHDELETEORGAN.SegmentType is
'��Ϣ���(��ɾ���Ķ�)';

comment on column HIS_BATCHDELETEORGAN.ManagerType is
'��ϵ������';

comment on column HIS_BATCHDELETEORGAN.UpdateDate is
'��Ϣ��������';

comment on column HIS_BATCHDELETEORGAN.Attribute1 is
'Ԥ���ֶ�';

comment on column HIS_BATCHDELETEORGAN.OccurDate is
'��������';

comment on column HIS_BATCHDELETEORGAN.IncrementFlag is
'������־';

comment on column HIS_BATCHDELETEORGAN.Modflag is
'�޸ı�־';

comment on column HIS_BATCHDELETEORGAN.TraceNumber is
'���ٱ��';

comment on column HIS_BATCHDELETEORGAN.RecordFlag is
'��¼��־';

comment on column HIS_BATCHDELETEORGAN.SessionId is
'�����ڴ�';

comment on column HIS_BATCHDELETEORGAN.ErrorCode is
'�������';

comment on column HIS_BATCHDELETEORGAN.FinanceId is
'���ڻ�������';

/*==============================================================*/
/* Table: HIS_ORGANATTRIBUTE                                    */
/*==============================================================*/
create table HIS_ORGANATTRIBUTE  (
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
   OccurDate          VARCHAR2(10)                    not null,
   IncrementFlag      VARCHAR2(1),
   Modflag            VARCHAR2(1),
   TraceNumber        VARCHAR2(20),
   RecordFlag         VARCHAR2(20),
   SessionId          VARCHAR2(10)                    not null,
   ErrorCode          VARCHAR2(80),
   constraint PK_HIS_ORGANATTRIBUTE primary key (CIFCustomerId, SessionId,OccurDate)
);

comment on table HIS_ORGANATTRIBUTE is
'�������� ����������Ϣ�ɼ�����C�� 0��1';

comment on column HIS_ORGANATTRIBUTE.CIFCustomerId is
'�ͻ���';

comment on column HIS_ORGANATTRIBUTE.ChineseName is
'������������';

comment on column HIS_ORGANATTRIBUTE.EnglishName is
'����Ӣ������';

comment on column HIS_ORGANATTRIBUTE.RegisterAdd is
'ע�ᣨ�Ǽǣ���ַ';

comment on column HIS_ORGANATTRIBUTE.RegisterCountry is
'����';

comment on column HIS_ORGANATTRIBUTE.RegisterAreaCode is
'ע�ᣨ�Ǽǣ�����������';

comment on column HIS_ORGANATTRIBUTE.RegisterDate is
'��������';

comment on column HIS_ORGANATTRIBUTE.RegisterDueDate is
'֤�鵽����';

comment on column HIS_ORGANATTRIBUTE.BusinessScope is
'��Ӫ��ҵ�񣩷�Χ';

comment on column HIS_ORGANATTRIBUTE.CapitalCurrency is
'ע���ʱ�����';

comment on column HIS_ORGANATTRIBUTE.CapitalFund is
'ע���ʱ�����Ԫ��';

comment on column HIS_ORGANATTRIBUTE.OrgType is
'��֯�������';

comment on column HIS_ORGANATTRIBUTE.OrgTypeSub is
'��֯�������ϸ��';

comment on column HIS_ORGANATTRIBUTE.Industry is
'������ҵ����';

comment on column HIS_ORGANATTRIBUTE.OrgNature is
'��������';

comment on column HIS_ORGANATTRIBUTE.UpdateDate is
'��Ϣ��������';

comment on column HIS_ORGANATTRIBUTE.Attribute1 is
'Ԥ���ֶ�';

comment on column HIS_ORGANATTRIBUTE.OccurDate is
'��������';

comment on column HIS_ORGANATTRIBUTE.IncrementFlag is
'������־';

comment on column HIS_ORGANATTRIBUTE.Modflag is
'�޸ı�־';

comment on column HIS_ORGANATTRIBUTE.TraceNumber is
'���ٱ��';

comment on column HIS_ORGANATTRIBUTE.RecordFlag is
'��¼��־';

comment on column HIS_ORGANATTRIBUTE.SessionId is
'�����ڴ�';

comment on column HIS_ORGANATTRIBUTE.ErrorCode is
'�������';

/*==============================================================*/
/* Table: HIS_ORGANCONTACT                                      */
/*==============================================================*/
create table HIS_ORGANCONTACT  (
   CIFCustomerId      VARCHAR2(40)                    not null,
   OfficeAdd          VARCHAR2(80),
   OfficeContact      VARCHAR2(35),
   FinanceContact     VARCHAR2(35),
   UpdateDate         VARCHAR2(10),
   Attribute1         VARCHAR2(40),
   OccurDate          VARCHAR2(10)                   not null,
   IncrementFlag      VARCHAR2(1),
   Modflag            VARCHAR2(1),
   TraceNumber        VARCHAR2(20),
   RecordFlag         VARCHAR2(20),
   SessionId          VARCHAR2(10)                    not null,
   ErrorCode          VARCHAR2(80),
   constraint PK_HIS_ORGANCONTACT primary key (CIFCustomerId, SessionId,OccurDate)
);

comment on table HIS_ORGANCONTACT is
'�������� ����������Ϣ�ɼ�����E�� 0��1';

comment on column HIS_ORGANCONTACT.CIFCustomerId is
'�ͻ���';

comment on column HIS_ORGANCONTACT.OfficeAdd is
'�칫����������Ӫ����ַ';

comment on column HIS_ORGANCONTACT.OfficeContact is
'��ϵ�绰';

comment on column HIS_ORGANCONTACT.FinanceContact is
'������ϵ�绰';

comment on column HIS_ORGANCONTACT.UpdateDate is
'��Ϣ��������';

comment on column HIS_ORGANCONTACT.Attribute1 is
'Ԥ���ֶ�';

comment on column HIS_ORGANCONTACT.OccurDate is
'��������';

comment on column HIS_ORGANCONTACT.IncrementFlag is
'������־';

comment on column HIS_ORGANCONTACT.Modflag is
'�޸ı�־';

comment on column HIS_ORGANCONTACT.TraceNumber is
'���ٱ��';

comment on column HIS_ORGANCONTACT.RecordFlag is
'��¼��־';

comment on column HIS_ORGANCONTACT.SessionId is
'�����ڴ�';

comment on column HIS_ORGANCONTACT.ErrorCode is
'�������';

/*==============================================================*/
/* Table: HIS_ORGANFAMILY                                       */
/*==============================================================*/
create table HIS_ORGANFAMILY  (
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
   OccurDate          VARCHAR2(10)                    not null,
   IncrementFlag      VARCHAR2(1),
   Modflag            VARCHAR2(1),
   TraceNumber        VARCHAR2(20),
   RecordFlag         VARCHAR2(20),
   SessionId          VARCHAR2(10)                    not null,
   ErrorCode          VARCHAR2(80),
   FinanceId          VARCHAR2(11),
   OldFinanceId       VARCHAR2(11),
   LoancardNo         VARCHAR2(16),
   constraint PK_HIS_ORGANFAMILY primary key (CIFCustomerId, ManagerCertType, ManagerCertId, MemberRelaType, MemberCertType, MemberCertId, SessionId,OccurDate)
);

comment on table HIS_ORGANFAMILY is
'���������ԱB��1��1';

comment on column HIS_ORGANFAMILY.CIFCustomerId is
'�ͻ���';

comment on column HIS_ORGANFAMILY.ManagerName is
'��Ҫ��ϵ������';

comment on column HIS_ORGANFAMILY.ManagerCertType is
'��Ҫ��ϵ��֤������';

comment on column HIS_ORGANFAMILY.ManagerCertId is
'֤������';

comment on column HIS_ORGANFAMILY.MemberRelaType is
'�����ϵ';

comment on column HIS_ORGANFAMILY.MemberName is
'�����Ա����';

comment on column HIS_ORGANFAMILY.MemberCertType is
'�����Ա֤������';

comment on column HIS_ORGANFAMILY.MemberCertId is
'֤������';

comment on column HIS_ORGANFAMILY.UpdateDate is
'��Ϣ��������';

comment on column HIS_ORGANFAMILY.Attribute1 is
'Ԥ���ֶ�';

comment on column HIS_ORGANFAMILY.OccurDate is
'��������';

comment on column HIS_ORGANFAMILY.IncrementFlag is
'������־';

comment on column HIS_ORGANFAMILY.Modflag is
'�޸ı�־';

comment on column HIS_ORGANFAMILY.TraceNumber is
'���ٱ��';

comment on column HIS_ORGANFAMILY.RecordFlag is
'��¼��־';

comment on column HIS_ORGANFAMILY.SessionId is
'�����ڴ�';

comment on column HIS_ORGANFAMILY.ErrorCode is
'�������';

comment on column HIS_ORGANFAMILY.FinanceId is
'�����д���(���ڻ�������)';

comment on column HIS_ORGANFAMILY.OldFinanceId is
'ԭ���ڻ�������';

comment on column HIS_ORGANFAMILY.LoancardNo is
'�������';

/*==============================================================*/
/* Table: HIS_ORGANINFO                                         */
/*==============================================================*/
create table HIS_ORGANINFO  (
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
   OccurDate          VARCHAR2(10)                   not null,
   IncrementFlag      VARCHAR2(1),
   Modflag            VARCHAR2(1),
   TraceNumber        VARCHAR2(20),
   RecordFlag         VARCHAR2(20),
   SessionId          VARCHAR2(10)                    not null,
   ErrorCode          VARCHAR2(80),
   constraint PK_HIS_ORGANINFO primary key (CIFCustomerId, SessionId,OccurDate)
);

comment on table HIS_ORGANINFO is
'����������Ϣ  ����������Ϣ�ɼ�����B��1:1';

comment on column HIS_ORGANINFO.CIFCustomerId is
'�ͻ���';

comment on column HIS_ORGANINFO.MFCustomerId is
'���Ŀͻ���';

comment on column HIS_ORGANINFO.LSCustomerId is
'�Ŵ��ͻ���';

comment on column HIS_ORGANINFO.FinanceId is
'�����д���(���ڻ�������)';

comment on column HIS_ORGANINFO.OldFinanceId is
'ԭ���ڻ�������';

comment on column HIS_ORGANINFO.CustomerType is
'�ͻ�����';

comment on column HIS_ORGANINFO.CreditCode is
'�������ô��� ';

comment on column HIS_ORGANINFO.CorpId is
'��֯��������';

comment on column HIS_ORGANINFO.RegisterType is
'�Ǽ�ע�������';

comment on column HIS_ORGANINFO.RegisterNo is
'�Ǽ�ע�����';

comment on column HIS_ORGANINFO.NationalTaxNo is
'��˰��ʶ��ţ���˰��';

comment on column HIS_ORGANINFO.LocalTaxNo is
'��˰��ʶ��ţ���˰��';

comment on column HIS_ORGANINFO.AccountPermitNo is
'�������֤��׼��';

comment on column HIS_ORGANINFO.LoancardNo is
'�������';

comment on column HIS_ORGANINFO.GatherDate is
'������ȡ����';

comment on column HIS_ORGANINFO.Attribute1 is
'Ԥ���ֶ�';

comment on column HIS_ORGANINFO.OccurDate is
'��������';

comment on column HIS_ORGANINFO.IncrementFlag is
'������־';

comment on column HIS_ORGANINFO.Modflag is
'�޸ı�־';

comment on column HIS_ORGANINFO.TraceNumber is
'���ٱ��';

comment on column HIS_ORGANINFO.RecordFlag is
'��¼��־';

comment on column HIS_ORGANINFO.SessionId is
'�����ڴ�';

comment on column HIS_ORGANINFO.ErrorCode is
'�������';

/*==============================================================*/
/* Table: HIS_ORGANKEEPER                                       */
/*==============================================================*/
create table HIS_ORGANKEEPER  (
   CIFCustomerId      VARCHAR2(40)                    not null,
   ManagerType        VARCHAR2(1)                     not null,
   ManagerName        VARCHAR2(80),
   CertType           VARCHAR2(2),
   CertId             VARCHAR2(20),
   UpdateDate         VARCHAR2(10),
   Attribute1         VARCHAR2(40),
   OccurDate          VARCHAR2(10)                    not null,
   IncrementFlag      VARCHAR2(1),
   Modflag            VARCHAR2(1),
   TraceNumber        VARCHAR2(20),
   RecordFlag         VARCHAR2(20),
   SessionId          VARCHAR2(10)                    not null,
   ErrorCode          VARCHAR2(80),
   constraint PK_HIS_ORGANKEEPER primary key (CIFCustomerId, ManagerType, SessionId,OccurDate)
);

comment on table HIS_ORGANKEEPER is
'�����߹ܼ���Ҫ��ϵ�� ����������Ϣ�ɼ�����F�� 0��n';

comment on column HIS_ORGANKEEPER.CIFCustomerId is
'�ͻ���';

comment on column HIS_ORGANKEEPER.ManagerType is
'��ϵ������';

comment on column HIS_ORGANKEEPER.ManagerName is
'����';

comment on column HIS_ORGANKEEPER.CertType is
'֤������';

comment on column HIS_ORGANKEEPER.CertId is
'֤������';

comment on column HIS_ORGANKEEPER.UpdateDate is
'��Ϣ��������';

comment on column HIS_ORGANKEEPER.Attribute1 is
'Ԥ���ֶ�';

comment on column HIS_ORGANKEEPER.OccurDate is
'��������';

comment on column HIS_ORGANKEEPER.IncrementFlag is
'������־';

comment on column HIS_ORGANKEEPER.Modflag is
'�޸ı�־';

comment on column HIS_ORGANKEEPER.TraceNumber is
'���ٱ��';

comment on column HIS_ORGANKEEPER.RecordFlag is
'��¼��־';

comment on column HIS_ORGANKEEPER.SessionId is
'�����ڴ�';

comment on column HIS_ORGANKEEPER.ErrorCode is
'�������';

/*==============================================================*/
/* Table: HIS_ORGANRELATED                                      */
/*==============================================================*/
create table HIS_ORGANRELATED  (
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
   SessionId          VARCHAR2(10)                    not null,
   ErrorCode          VARCHAR2(80),
   constraint PK_HIS_ORGANRELATED primary key (CIFCustomerId, RelationShip, RelativeEntName, SessionId)
);

comment on table HIS_ORGANRELATED is
'������Ҫ������ҵ ����������Ϣ�ɼ�����H�� 0��n';

comment on column HIS_ORGANRELATED.CIFCustomerId is
'�ͻ���';

comment on column HIS_ORGANRELATED.RelationShip is
'��������';

comment on column HIS_ORGANRELATED.RelativeEntName is
'������ҵ����';

comment on column HIS_ORGANRELATED.RegisterType is
'�Ǽ�ע�������';

comment on column HIS_ORGANRELATED.RegisterNo is
'�Ǽ�ע�����';

comment on column HIS_ORGANRELATED.CorpId is
'��֯��������';

comment on column HIS_ORGANRELATED.CreditCode is
'�������ô���';

comment on column HIS_ORGANRELATED.UpdateDate is
'��Ϣ��������';

comment on column HIS_ORGANRELATED.Attribute1 is
'Ԥ���ֶ�';

comment on column HIS_ORGANRELATED.OccurDate is
'��������';

comment on column HIS_ORGANRELATED.IncrementFlag is
'������־';

comment on column HIS_ORGANRELATED.Modflag is
'�޸ı�־';

comment on column HIS_ORGANRELATED.TraceNumber is
'���ٱ��';

comment on column HIS_ORGANRELATED.RecordFlag is
'��¼��־';

comment on column HIS_ORGANRELATED.SessionId is
'�����ڴ�';

comment on column HIS_ORGANRELATED.ErrorCode is
'�������';

/*==============================================================*/
/* Table: HIS_ORGANSTATUS                                       */
/*==============================================================*/
create table HIS_ORGANSTATUS  (
   CIFCustomerId      VARCHAR2(40)                    not null,
   AccountStatus      VARCHAR2(1),
   Scope              VARCHAR2(1),
   OrgStatus          VARCHAR2(1),
   UpdateDate         VARCHAR2(10),
   Attribute1         VARCHAR2(40),
   OccurDate          VARCHAR2(10)                    not null,
   IncrementFlag      VARCHAR2(1),
   Modflag            VARCHAR2(1),
   TraceNumber        VARCHAR2(20),
   RecordFlag         VARCHAR2(20),
   SessionId          VARCHAR2(10)                    not null,
   ErrorCode          VARCHAR2(80),
   constraint PK_HIS_ORGANSTATUS primary key (CIFCustomerId, SessionId,OccurDate)
);

comment on table HIS_ORGANSTATUS is
'����״̬ ����������Ϣ�ɼ�����D�� 0��1';

comment on column HIS_ORGANSTATUS.CIFCustomerId is
'�ͻ���';

comment on column HIS_ORGANSTATUS.AccountStatus is
'������״̬';

comment on column HIS_ORGANSTATUS.Scope is
'��ҵ��ģ';

comment on column HIS_ORGANSTATUS.OrgStatus is
'����״̬';

comment on column HIS_ORGANSTATUS.UpdateDate is
'��Ϣ��������';

comment on column HIS_ORGANSTATUS.Attribute1 is
'Ԥ���ֶ�';

comment on column HIS_ORGANSTATUS.OccurDate is
'��������';

comment on column HIS_ORGANSTATUS.IncrementFlag is
'������־';

comment on column HIS_ORGANSTATUS.Modflag is
'�޸ı�־';

comment on column HIS_ORGANSTATUS.TraceNumber is
'���ٱ��';

comment on column HIS_ORGANSTATUS.RecordFlag is
'��¼��־';

comment on column HIS_ORGANSTATUS.SessionId is
'�����ڴ�';

comment on column HIS_ORGANSTATUS.ErrorCode is
'�������';

/*==============================================================*/
/* Table: HIS_ORGANSTOCKHOLDER                                  */
/*==============================================================*/
create table HIS_ORGANSTOCKHOLDER  (
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
   SessionId          VARCHAR2(10)                    not null,
   ErrorCode          VARCHAR2(80),
   constraint PK_HIS_ORGANSTOCKHOLDER primary key (CIFCustomerId, StockHolderType, StockHolderName, SessionId)
);

comment on table HIS_ORGANSTOCKHOLDER is
'������Ҫ�ɶ� ����������Ϣ�ɼ�����G�� 0��n';

comment on column HIS_ORGANSTOCKHOLDER.CIFCustomerId is
'�ͻ���';

comment on column HIS_ORGANSTOCKHOLDER.StockHolderType is
'�ɶ�����';

comment on column HIS_ORGANSTOCKHOLDER.StockHolderName is
'�ɶ�����';

comment on column HIS_ORGANSTOCKHOLDER.CertType is
'֤������/�Ǽ�ע�������';

comment on column HIS_ORGANSTOCKHOLDER.CertId is
'֤������/�Ǽ�ע�����';

comment on column HIS_ORGANSTOCKHOLDER.CorpId is
'��֯��������';

comment on column HIS_ORGANSTOCKHOLDER.CreditCode is
'�������ô���';

comment on column HIS_ORGANSTOCKHOLDER.StockHodingRatio is
'�ֹɱ���';

comment on column HIS_ORGANSTOCKHOLDER.UpdateDate is
'��Ϣ��������';

comment on column HIS_ORGANSTOCKHOLDER.Attribute1 is
'Ԥ���ֶ�';

comment on column HIS_ORGANSTOCKHOLDER.OccurDate is
'��������';

comment on column HIS_ORGANSTOCKHOLDER.IncrementFlag is
'������־';

comment on column HIS_ORGANSTOCKHOLDER.Modflag is
'�޸ı�־';

comment on column HIS_ORGANSTOCKHOLDER.TraceNumber is
'���ٱ��';

comment on column HIS_ORGANSTOCKHOLDER.RecordFlag is
'��¼��־';

comment on column HIS_ORGANSTOCKHOLDER.SessionId is
'�����ڴ�';

comment on column HIS_ORGANSTOCKHOLDER.ErrorCode is
'�������';

/*==============================================================*/
/* Table: HIS_ORGANSUPERIOR                                     */
/*==============================================================*/
create table HIS_ORGANSUPERIOR  (
   CIFCustomerId      VARCHAR2(40)                    not null,
   SuperiorName       VARCHAR2(80),
   RegisterType       VARCHAR2(2),
   RegisterNo         VARCHAR2(20),
   CorpId             VARCHAR2(10),
   CreditCode         VARCHAR2(18),
   UpdateDate         VARCHAR2(10),
   Attribute1         VARCHAR2(40),
   OccurDate          VARCHAR2(10)                   not null,
   IncrementFlag      VARCHAR2(1),
   Modflag            VARCHAR2(1),
   TraceNumber        VARCHAR2(20),
   RecordFlag         VARCHAR2(20),
   SessionId          VARCHAR2(10)                    not null,
   ErrorCode          VARCHAR2(80),
   constraint PK_HIS_ORGANSUPERIOR primary key (CIFCustomerId, SessionId,OccurDate)
);

comment on table HIS_ORGANSUPERIOR is
'�����ϼ�����(���ܲ���) ����������Ϣ�ɼ�����I�� 0��1';

comment on column HIS_ORGANSUPERIOR.CIFCustomerId is
'�ͻ���';

comment on column HIS_ORGANSUPERIOR.SuperiorName is
'�ϼ���������';

comment on column HIS_ORGANSUPERIOR.RegisterType is
'�Ǽ�ע�������';

comment on column HIS_ORGANSUPERIOR.RegisterNo is
'�Ǽ�ע���';

comment on column HIS_ORGANSUPERIOR.CorpId is
'��֯��������';

comment on column HIS_ORGANSUPERIOR.CreditCode is
'�������ô���';

comment on column HIS_ORGANSUPERIOR.UpdateDate is
'��Ϣ��������';

comment on column HIS_ORGANSUPERIOR.Attribute1 is
'Ԥ���ֶ�';

comment on column HIS_ORGANSUPERIOR.OccurDate is
'��������';

comment on column HIS_ORGANSUPERIOR.IncrementFlag is
'������־';

comment on column HIS_ORGANSUPERIOR.Modflag is
'�޸ı�־';

comment on column HIS_ORGANSUPERIOR.TraceNumber is
'���ٱ��';

comment on column HIS_ORGANSUPERIOR.RecordFlag is
'��¼��־';

comment on column HIS_ORGANSUPERIOR.SessionId is
'�����ڴ�';

comment on column HIS_ORGANSUPERIOR.ErrorCode is
'�������';
