--导入实际在保（代偿）责任信息表

update BCR_GUARANTEEDUTY set incrementflag='6' where GCONTRACTFLAG='2';

--导入担保基础信息表

update BCR_GUARANTEEINFO set incrementflag='6' where exists(select gbusinessno from BCR_GUARANTEEDUTY where BCR_GUARANTEEDUTY.gbusinessno= BCR_GUARANTEEINFO.gbusinessno and  gcontractflag!='1');

--导入担保合同信息表

update BCR_GUARANTEECONT set incrementflag='6' where exists(select gbusinessno from BCR_GUARANTEEDUTY where BCR_GUARANTEEDUTY.gbusinessno= BCR_GUARANTEECONT.gbusinessno and  gcontractflag!='1');

--导入被担保人信息表

update BCR_INSUREDS set incrementflag='6' where exists(select gbusinessno from BCR_GUARANTEEDUTY where BCR_GUARANTEEDUTY.gbusinessno= BCR_INSUREDS.gbusinessno and  gcontractflag!='1');

--导入债权人及主合同信息表

update BCR_CREDITORINFO set incrementflag='6' where exists(select gbusinessno from BCR_GUARANTEEDUTY where BCR_GUARANTEEDUTY.gbusinessno= BCR_CREDITORINFO.gbusinessno and  gcontractflag!='1');

--导入反担保人信息表

update BCR_COUNTERGUARANTOR set incrementflag='6' where exists(select gbusinessno from BCR_GUARANTEEDUTY where BCR_GUARANTEEDUTY.gbusinessno= BCR_COUNTERGUARANTOR.gbusinessno and  gcontractflag!='1');

--导入代偿概况信息信息表

update BCR_COMPENSATORYINFO set incrementflag='6' where exists(select gbusinessno from BCR_GUARANTEEDUTY where BCR_GUARANTEEDUTY.gbusinessno= BCR_COMPENSATORYINFO.gbusinessno and  gcontractflag!='1');

--导入代偿明细信息表

update BCR_COMPENSATORYDETAIL set incrementflag='6' where exists(select gbusinessno from BCR_GUARANTEEDUTY where BCR_GUARANTEEDUTY.gbusinessno= BCR_COMPENSATORYDETAIL.gbusinessno and  gcontractflag!='1');


--导入追偿明细信息表

update BCR_RECOVERYDETAIL set incrementflag='6' where exists(select gbusinessno from BCR_GUARANTEEDUTY where BCR_GUARANTEEDUTY.gbusinessno= BCR_RECOVERYDETAIL.gbusinessno and  gcontractflag!='1');

--导入保费缴纳概况信息表

update BCR_PREMIUMINFO set incrementflag='6' where exists(select gbusinessno from BCR_GUARANTEEDUTY where BCR_GUARANTEEDUTY.gbusinessno= BCR_PREMIUMINFO.gbusinessno and  gcontractflag!='1');


--导入保费缴纳明细信息表

update BCR_PREMIUMDETAIL set incrementflag='6' where exists(select gbusinessno from BCR_GUARANTEEDUTY where BCR_GUARANTEEDUTY.gbusinessno= BCR_PREMIUMDETAIL.gbusinessno and  gcontractflag!='1');

