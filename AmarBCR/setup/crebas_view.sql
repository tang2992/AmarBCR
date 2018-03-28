/*==============================================================*/
/* Database name:  AmarECR3        		                        */
/* Created on:     2010-12-14 11:17:22                          */
/*==============================================================*/


/*==============================================================*/
create view ECR_V_ASSURECONT as (
select G.*,B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_ASSURECONT G, ECR_LOANCONTRACT B where G.ContractNo = B.LContractNo and G.BusinessType = '1'
union select G.*,
		B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_ASSURECONT G, ECR_FACTORING B where G.ContractNo = B.FactoringNo and G.BusinessType = '2')
union select G.*,
		B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_ASSURECONT G, ECR_GUARANTEEBILL B where G.ContractNo = B.GuaranteeBIllNo and G.BusinessType = '3')
union select G.*,
		B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_ASSURECONT G, ECR_FINAINFO B where G.ContractNo = B.FContractNo and G.BusinessType = '4')
union select G.*,
		B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_ASSURECONT G, ECR_CUSTOMERCREDIT B where G.ContractNo = B.Customer and G.BusinessType = '5')
union select G.*,
		B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_ASSURECONT G, ECR_DISCOUNT B where G.ContractNo = B.BillNo and G.BusinessType = '6')
union select G.*,
		B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_ASSURECONT G, ECR_ACCEPTANCE B where G.ContractNo = B.AcceptNo and G.BusinessType = '7')


/*==============================================================*/
create view ECR_V_GUARANTYCONT as (
select G.*,B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_GUARANTYCONT G, ECR_LOANCONTRACT B where G.ContractNo = B.LContractNo and G.BusinessType = '1'
union select G.*,
		B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_GUARANTYCONT G, ECR_FACTORING B where G.ContractNo = B.FactoringNo and G.BusinessType = '2')
union select G.*,
		B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_GUARANTYCONT G, ECR_GUARANTEEBILL B where G.ContractNo = B.GuaranteeBillNo and G.BusinessType = '3')
union select G.*,
		B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_GUARANTYCONT G, ECR_FINAINFO B where G.ContractNo = B.FContractNo and G.BusinessType = '4')
union select G.*,
		B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_GUARANTYCONT G, ECR_CUSTOMERCREDIT B where G.ContractNo = B.Customer and G.BusinessType = '5')
union select G.*,
		B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_GUARANTYCONT G, ECR_DISCOUNT B where G.ContractNo = B.BillNo and G.BusinessType = '6')
union select G.*,
		B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_GUARANTYCONT G, ECR_ACCEPTANCE B where G.ContractNo = B.AcceptNo and G.BusinessType = '7')

/*==============================================================*/
create view ECR_V_IMPAWNCONT as (
select G.*,B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_IMPAWNCONT G, ECR_LOANCONTRACT B where G.ContractNo = B.LContractNo and G.BusinessType = '1'
union select G.*,
		B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_IMPAWNCONT G, ECR_FACTORING B where G.ContractNo = B.FactoringNo and G.BusinessType = '2')
union select G.*,
		B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_IMPAWNCONT G, ECR_GUARANTEEBILL B where G.ContractNo = B.GuaranteeBIllNo and G.BusinessType = '3')
union select G.*,
		B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_IMPAWNCONT G, ECR_FINAINFO B where G.ContractNo = B.FContractNo and G.BusinessType = '4')
union select G.*,
		B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_IMPAWNCONT G, ECR_CUSTOMERCREDIT B where G.ContractNo = B.Customer and G.BusinessType = '5')
union select G.*,
		B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_IMPAWNCONT G, ECR_DISCOUNT B where G.ContractNo = B.BillNo and G.BusinessType = '6')
union select G.*,
		B.FinanceID, 
		B.OldFinanceID, 
		B.CustomerID, 
		B.LoancardNo, 
		B.AvailabStatus as BAvailabStatus 
		from ECR_IMPAWNCONT G, ECR_ACCEPTANCE B where G.ContractNo = B.AcceptNo and G.BusinessType = '7')

/*==============================================================*/
create view ECR_V_VOUCHER as (
select G.ALoancardNo as LoancardNo, 
		G.AssurerName as ChinaName, C.CustomerID, 
		C.OrganizationCode     
		from ECR_ASSURECONT G  left join ECR_CUSTOMERINFO C on G.ALoancardNo = C.LoancardNo      
union select G.GLoancardNo as LoancardNo, 
		G. PledgorName as ChinaName, 
		C.CustomerID, C.OrganizationCode     
		from ECR_GUARANTYCONT G  left join ECR_CUSTOMERINFO C on G.GLoancardNo = C.LoancardNo 
union select G.ILoancardNo as LoancardNo, 
		G.ImpawnName as ChinaName, 
		C.CustomerID, C.OrganizationCode     
		from ECR_IMPAWNCONT G  left join ECR_CUSTOMERINFO C on G.ILoancardNo = C.LoancardNo)

/*==============================================================*/
create view ECR_V_LOANDUEBILL as (
select C.FinanceID, C.OldFinanceID, 
		C.CustomerID, C.LoancardNo, 
		C.CustomerName C.BusinessSum, 
		C.StartDate, 
		C.EndDate, 
		AvailabStatus,
		D.* 
		from ECR_LOANCONTRACT C,ECR_LOANDUEBILL D where C.LContractNo = D.LContractNo)

/*==============================================================*/
create view ECR_V_FINADUEBILL as (
select C.FinanceID, 
		C.OldFinanceID, 
		C.CustomerID, 
		C.LoancardNo, 
		C.CustomerName, 
		C.BusinessSum, 
		C.StartDate, 
		C.EndDate, 
		AvailabStatus,
		D.* from ECR_FINAINFO C, ECR_FINADUEBILL D where C.FContractNo = D.FContractNo)