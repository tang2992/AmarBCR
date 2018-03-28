alter table ECR_ALSDATACHECK alter column LOANCONTRACTNUM set data type decimal(22,0);
alter table ECR_ALSDATACHECK alter column LOANDUEBILLNUM set data type decimal(22,0);
alter table ECR_ALSDATACHECK alter column FACTORINGNUM set data type decimal(22,0);
--在终端运行db2 reorg table ECR_ALSDATACHECK
alter table ECR_ALSDATACHECK alter column DISCOUNTNUM set data type decimal(22,0);
alter table ECR_ALSDATACHECK alter column FINAINFONUM set data type decimal(22,0);
alter table ECR_ALSDATACHECK alter column FINADUEBILLNUM set data type decimal(22,0);
--在终端运行db2 reorg table ECR_ALSDATACHECK
alter table ECR_ALSDATACHECK alter column CREDITLETTERNUM set data type decimal(22,0);
alter table ECR_ALSDATACHECK alter column GUARANTEEBILLNUM set data type decimal(22,0);
alter table ECR_ALSDATACHECK alter column ACCEPTNUM set data type decimal(22,0);
--在终端运行db2 reorg table ECR_ALSDATACHECK
alter table ECR_ALSDATACHECK alter column CUSTOMERCREDITNUM set data type decimal(22,0);
alter table ECR_ALSDATACHECK alter column ASSURECONTNUM set data type decimal(22,0);
alter table ECR_ALSDATACHECK alter column GUARANTYCONTNUM set data type decimal(22,0);
--在终端运行db2 reorg table ECR_ALSDATACHECK
alter table ECR_ALSDATACHECK alter column IMPAWNCONTNUM set data type decimal(22,0);
alter table ECR_ALSDATACHECK alter column FLOORFUNDNUM set data type decimal(22,0);

alter table BANK_ACCEPTANCE alter column ASSURESCALE set data type decimal(3,0);

alter table BANK_ASSURECONT add CERTTYPE VARCHAR(20);
alter table BANK_ASSURECONT add CERTID VARCHAR(20);
alter table BANK_ASSURECONT add REPORTTYPE VARCHAR(20);

alter table BANK_GUARANTYCONT alter column GUARANTYNO set data type varchar(2);
alter table BANK_GUARANTYCONT add CERTTYPE VARCHAR(20);
alter table BANK_GUARANTYCONT add CERTID VARCHAR(20);
alter table BANK_GUARANTYCONT add REPORTTYPE VARCHAR(20);

alter table BANK_IMPAWNCONT alter column IMPAWNO set data type varchar(2);
alter table BANK_IMPAWNCONT add CERTTYPE VARCHAR(20);
alter table BANK_IMPAWNCONT add CERTID VARCHAR(20);
alter table BANK_IMPAWNCONT add REPORTTYPE VARCHAR(20);



  
    
