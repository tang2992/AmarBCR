1.��������ɾ���ر���©���������ٱ���δ����Ĵ����ó���������ݣ�������ݲ����ǡ�
2.�������ݵ��ص��ǣ�������ҵ�������ڲ����ڴ�������ڣ�������������С�ڷſ����
3.����2.1�淶�����е�Ҫ��
�״ηſ�ʱ�����ͺ�ͬ+����+��ݣ�ÿ�λ���ʱ�����ͽ��+���ÿ��չ��ʱ�����ͽ��+չ�ڡ�
----------------------------------------���´���
--���»����ҵ��������
update his_loanreturn set occurdate =returndate 
where incrementflag='1' and sessionid='0000000000';
--���½��������ҵ��������
update his_loanduebill set occurdate=putoutdate,balance=putoutamount 
where incrementflag='1' and sessionid='0000000000'; 
--���������ʷ�����Ϣ 
insert into HIS_LOANDUEBILL(LCONTRACTNO,LDUEBILLNO,OCCURDATE, 
CURRENCY,PutoutAmount,BALANCE,PUTOUTDATE,
PUTOUTENDDATE,BUSINESSTYPE,FORM,LOANCHARACTER,WAY,
KIND,EXTENFLAG,CLASSIFY4,CLASSIFY5,SESSIONID,
INCREMENTFLAG,TRACENUMBER)SELECT  EL.LCONTRACTNO AS LCONTRACTNO,
EL.LDUEBILLNO AS LDUEBILLNO,LR.Returndate AS OCCURDATE,
EL.CURRENCY AS CURRENCY,EL.PutoutAmount AS PutoutAmount,           
(EL.PutoutAmount-((select sum(LR1.ReturnSum) 
from HIS_LOANRETURN LR1 where LR1.LDuebillno=EL.Lduebillno 
and LR1.OCCURDATE <=LR.OCCURDATE))
) AS BALANCE,EL.PUTOUTDATE AS PUTOUTDATE,           
EL.PUTOUTENDDATE AS PUTOUTENDDATE,EL.BUSINESSTYPE AS BUSINESSTYPE,           
EL.FORM AS FORM,EL.LOANCHARACTER AS LOANCHARACTER,
EL.WAY AS WAY, EL.KIND AS KIND,           
case when EL.Extenflag='1' then '1' else '2' end as EXTENFLAG,           
EL.CLASSIFY4 AS CLASSIFY4,EL.CLASSIFY5 AS CLASSIFY5,           
EL.SESSIONID AS SESSIONID,'2' AS INCREMENTFLAG,           
EL.TRACENUMBER AS TRACENUMBER 
FROM HIS_LOANDUEBILL EL,HIS_LOANRETURN LR           
WHERE EL.LDuebillno = LR.LDuebillno            
AND LR.INCREMENTFLAG='1' AND EL.PUTOUTDATE<>LR.RETURNDATE
and LR.sessionid='0000000000' and EL.sessionid='0000000000';

--չ�ڻ�����ʷ�����Ϣ 
insert into HIS_LOANDUEBILL(LCONTRACTNO,LDUEBILLNO,OCCURDATE,CURRENCY,PutoutAmount,
BALANCE,PUTOUTDATE,PUTOUTENDDATE,BUSINESSTYPE,FORM,LOANCHARACTER,WAY,KIND,EXTENFLAG,        
CLASSIFY4,CLASSIFY5,SESSIONID,INCREMENTFLAG,TRACENUMBER)       
SELECT  DB.LContractno AS LContractno,
DB.LDuebillNo AS LDuebillNo,
LE.OCCURDATE AS OCCURDATE,
DB.CURRENCY AS CURRENCY,         
DB.PutoutAmount AS PutoutAmount,         
LE.EXTENSUM AS BALANCE,       
DB.PUTOUTDATE AS PUTOUTDATE,         
DB.PUTOUTENDDATE AS PUTOUTENDDATE,         
DB.BUSINESSTYPE AS BUSINESSTYPE,         
DB.FORM AS FORM,         
DB.LOANCHARACTER AS LOANCHARACTER,         
DB.WAY AS WAY,         
DB.KIND AS KIND,         
'1' as EXTENFLAG,         
DB.CLASSIFY4 AS CLASSIFY4,         
DB.CLASSIFY5 AS CLASSIFY5,         
DB.SESSIONID AS SESSIONID,         
'2' AS INCREMENTFLAG,          
DB.TRACENUMBER AS TRACENUMBER         
 FROM HIS_LOANDUEBILL DB,         
 HIS_LOANEXTENSION LE           
WHERE (DB.LDuebillNo = LE.LDuebillNo          
AND LE.INCREMENTFLAG='1' and DB.INCREMENTFLAG='1') 
AND LE.OCCURDATE NOT IN (SELECT OCCURDATE 
FROM HIS_LOANDUEBILL HLD_T 
WHERE HLD_T.LDUEBILLNO=LE.LDUEBILLNO); 


--����չ�ڱ�־
update HIS_LOANDUEBILL SET EXTENFLAG='1' WHERE LDUEBILLNO 
IN (SELECT LDUEBILLNO FROM HIS_LOANEXTENSION) 
AND OCCURDATE>=(SELECT MIN(OCCURDATE) FROM HIS_LOANEXTENSION HLE 
WHERE HLE.LDUEBILLNO=HIS_LOANDUEBILL.LDUEBILLNO); 

--���º�ͬ��Ϣ
update his_loancontract set occurdate=startdate 
where incrementflag='1' and sessionid='0000000000'
and startdate is not null
and startdate <>'';  

--��ݻ�����ʷ��ͬ��Ϣ 
--insert into HIS_LOANCONTRACT(LContractNo,CustomerID,OccurDate,IncrementFlag,
--ModFlag,TraceNumber,RecordFlag,OldFinanceID,FinanceID,CreditNo,LoanCardNo,CustomerName , 
--SessionID,ErrorCode,StartDate,EndDate,BankFlag,GuarantyFlag,AvailabStatus ,Currency ,BusinessSum ,
-- AvailabBalance)         
--SELECT HLC.LContractNo ,HLC.CustomerID ,HLD.PutOutDate ,'2' ,HLC.ModFlag ,HLC.TraceNumber  ,HLC.RecordFlag ,
--HLC.OldFinanceID ,HLC.FinanceID  ,HLC.CreditNo ,HLC.LoanCardNo ,
--HLC.CustomerName ,HLC.SessionID  ,HLC.ErrorCode  ,
--HLC.StartDate  ,HLC.EndDate ,HLC.BankFlag ,HLC.GuarantyFlag ,
--'1',HLC.Currency ,HLC.BusinessSum  , 
--0
--FROM HIS_LOANDUEBILL HLD,HIS_LOANCONTRACT HLC             
--WHERE HLC.OCCURDATE<>HLD.PUTOUTDATE 
--AND HLD.PUTOUTDATE <>'0' 
--AND  HLC.LCONTRACTNO = HLD.LCONTRACTNO  
--AND HLD.INCREMENTFLAG='1' 
--AND HLD.LDUEBILLNO=(SELECT MIN(LDUEBILLNO) 
--FROM HIS_LOANDUEBILL HLD_T 
--WHERE HLD_T.LCONTRACTNO=HLD.LCONTRACTNO 
--AND HLD_T.PUTOUTDATE=HLD.PUTOUTDATE); 


--���Ӻ�ͬ���µ�����ҵ��������
update his_assurecont 	
set occurdate=(select occurdate from his_loancontract 
where his_loancontract.lcontractno=his_assurecont.contractno 
and his_loancontract.lcontractno in(
select contractno from his_assurecont )) 
where businesstype='1'
;

update his_guarantycont 
set occurdate=(select occurdate 
from his_loancontract where
his_loancontract.lcontractno=his_guarantycont.contractno) 
where businesstype='1';

 
update his_impawncont 
set occurdate=(select occurdate 
from his_loancontract where 
his_loancontract.lcontractno=his_impawncont.contractno) 
where businesstype='1';



-------------------��------------------------����ó������
--���»����ҵ��������
update his_finareturn set occurdate =returndate 
where incrementflag='1' and sessionid='0000000000';
--���½��������ҵ��������
update his_finaduebill set occurdate=putoutdate,balance=putoutamount 
where incrementflag='1' and sessionid='0000000000'; 
--���������ʷ�����Ϣ 

insert into HIS_FINADUEBILL(FCONTRACTNO,FDUEBILLNO,OCCURDATE, 
CURRENCY,PutoutAmount,BALANCE,PUTOUTDATE,
PUTOUTENDDATE,BUSINESSTYPE,FORM,LOANCHARACTER,WAY,
KIND,EXTENFLAG,CLASSIFY4,CLASSIFY5,SESSIONID,
INCREMENTFLAG,TRACENUMBER)SELECT  EL.FCONTRACTNO AS FCONTRACTNO,
EL.FDUEBILLNO AS FDUEBILLNO,LR.Returndate AS OCCURDATE,
EL.CURRENCY AS CURRENCY,EL.PutoutAmount AS PutoutAmount,           
(EL.PutoutAmount-((select sum(LR1.ReturnSum) 
from HIS_FINARETURN LR1 where LR1.FDuebillno=EL.Fduebillno 
and LR1.OCCURDATE <=LR.OCCURDATE))
) AS BALANCE,EL.PUTOUTDATE AS PUTOUTDATE,           
EL.PUTOUTENDDATE AS PUTOUTENDDATE,EL.BUSINESSTYPE AS BUSINESSTYPE,           
EL.FORM AS FORM,EL.LOANCHARACTER AS LOANCHARACTER,
EL.WAY AS WAY, EL.KIND AS KIND,           
case when EL.Extenflag='1' then '1' else '2' end as EXTENFLAG,           
EL.CLASSIFY4 AS CLASSIFY4,EL.CLASSIFY5 AS CLASSIFY5,           
EL.SESSIONID AS SESSIONID,'2' AS INCREMENTFLAG,           
EL.TRACENUMBER AS TRACENUMBER 
FROM HIS_FINADUEBILL EL,HIS_FINARETURN LR           
WHERE EL.FDuebillno = LR.FDuebillno            
AND LR.INCREMENTFLAG='1' AND EL.PUTOUTDATE<>LR.RETURNDATE
and LR.sessionid='0000000000' and EL.sessionid='0000000000';

--չ�ڻ�����ʷ�����Ϣ 
insert into HIS_FINADUEBILL(FCONTRACTNO,FDUEBILLNO,OCCURDATE,CURRENCY,PutoutAmount,
BALANCE,PUTOUTDATE,PUTOUTENDDATE,BUSINESSTYPE,FORM,LOANCHARACTER,WAY,KIND,EXTENFLAG,        
CLASSIFY4,CLASSIFY5,SESSIONID,INCREMENTFLAG,TRACENUMBER)       
SELECT  DB.FContractno AS FContractno,
DB.FDuebillNo AS FDuebillNo,
LE.OCCURDATE AS OCCURDATE,
DB.CURRENCY AS CURRENCY,         
DB.PutoutAmount AS PutoutAmount,         
LE.EXTENSUM AS BALANCE,       
DB.PUTOUTDATE AS PUTOUTDATE,         
DB.PUTOUTENDDATE AS PUTOUTENDDATE,         
DB.BUSINESSTYPE AS BUSINESSTYPE,         
DB.FORM AS FORM,         
DB.LOANCHARACTER AS LOANCHARACTER,         
DB.WAY AS WAY,         
DB.KIND AS KIND,         
'1' as EXTENFLAG,         
DB.CLASSIFY4 AS CLASSIFY4,         
DB.CLASSIFY5 AS CLASSIFY5,         
DB.SESSIONID AS SESSIONID,         
'2' AS INCREMENTFLAG,          
DB.TRACENUMBER AS TRACENUMBER         
FROM HIS_FINADUEBILL DB,         
HIS_FINAEXTENSION LE           
WHERE (DB.FDuebillNo = LE.FDuebillNo          
AND LE.INCREMENTFLAG='1' and DB.INCREMENTFLAG='1') 
AND LE.OCCURDATE NOT IN (SELECT OCCURDATE 
FROM HIS_FINADUEBILL HLD_T 
WHERE HLD_T.FDUEBILLNO=LE.FDUEBILLNO); 


--����չ�ڱ�־
update HIS_FINADUEBILL SET EXTENFLAG='1' WHERE FDUEBILLNO 
IN (SELECT FDUEBILLNO FROM HIS_FINAEXTENSION) 
AND OCCURDATE>=(SELECT MIN(OCCURDATE) FROM HIS_FINAEXTENSION HLE 
WHERE HLE.FDUEBILLNO=HIS_FINADUEBILL.FDUEBILLNO); 

--���º�ͬ��Ϣ
update his_FINAINFO set occurdate=startdate 
where incrementflag='1' and sessionid='0000000000'
and startdate is not null
and startdate <>'';  

--��ݻ�����ʷ��ͬ��Ϣ 
--insert into HIS_FINAINFO(FContractNo,CustomerID,OccurDate,IncrementFlag,
--ModFlag,TraceNumber,RecordFlag,OldFinanceID,FinanceID,CreditNo,LoanCardNo,CustomerName , 
--SessionID,ErrorCode,StartDate,EndDate,BankFlag,GuarantyFlag,AvailabStatus ,Currency ,BusinessSum ,
-- AvailabBalance)         
--SELECT HLC.FContractNo ,HLC.CustomerID ,HLD.PutOutDate ,'2' ,HLC.ModFlag ,HLC.TraceNumber  ,HLC.RecordFlag ,
--HLC.OldFinanceID ,HLC.FinanceID  ,HLC.CreditNo ,HLC.LoanCardNo ,
--HLC.CustomerName ,HLC.SessionID  ,HLC.ErrorCode  ,
--HLC.StartDate  ,HLC.EndDate ,HLC.BankFlag ,HLC.GuarantyFlag ,
--'1',HLC.Currency ,HLC.BusinessSum  , 
--0
--FROM HIS_FINADUEBILL HLD,HIS_FINAINFO HLC             
--WHERE HLC.OCCURDATE<>HLD.PUTOUTDATE 
--AND HLD.PUTOUTDATE <>'0' 
--AND  HLC.FCONTRACTNO = HLD.FCONTRACTNO  
--AND HLD.INCREMENTFLAG='1' 
--AND HLD.FDUEBILLNO=(SELECT MIN(FDUEBILLNO) 
--FROM HIS_FINADUEBILL HLD_T 
--WHERE HLD_T.FCONTRACTNO=HLD.FCONTRACTNO 
--AND HLD_T.PUTOUTDATE=HLD.PUTOUTDATE); 


--���Ӻ�ͬ���µ�����ҵ��������
update his_assurecont 	
set occurdate=(select occurdate from his_finainfo 
where his_finainfo.Fcontractno=his_assurecont.contractno ) 
where businesstype='4'
;


update his_guarantycont 
set occurdate=(select occurdate 
from his_finainfo where
his_finainfo.Fcontractno=his_guarantycont.contractno) 
where businesstype='4';

 
update his_impawncont 
set occurdate=(select occurdate 
from his_finainfo where 
his_finainfo.Fcontractno=his_impawncont.contractno) 
where businesstype='4'; 