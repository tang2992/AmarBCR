--����ʵ���ڱ���������������Ϣ��

update BCR_GUARANTEEDUTY set incrementflag='6' where GCONTRACTFLAG='2';

--���뵣��������Ϣ��

update BCR_GUARANTEEINFO set incrementflag='6' where exists(select gbusinessno from BCR_GUARANTEEDUTY where BCR_GUARANTEEDUTY.gbusinessno= BCR_GUARANTEEINFO.gbusinessno and  gcontractflag!='1');

--���뵣����ͬ��Ϣ��

update BCR_GUARANTEECONT set incrementflag='6' where exists(select gbusinessno from BCR_GUARANTEEDUTY where BCR_GUARANTEEDUTY.gbusinessno= BCR_GUARANTEECONT.gbusinessno and  gcontractflag!='1');

--���뱻��������Ϣ��

update BCR_INSUREDS set incrementflag='6' where exists(select gbusinessno from BCR_GUARANTEEDUTY where BCR_GUARANTEEDUTY.gbusinessno= BCR_INSUREDS.gbusinessno and  gcontractflag!='1');

--����ծȨ�˼�����ͬ��Ϣ��

update BCR_CREDITORINFO set incrementflag='6' where exists(select gbusinessno from BCR_GUARANTEEDUTY where BCR_GUARANTEEDUTY.gbusinessno= BCR_CREDITORINFO.gbusinessno and  gcontractflag!='1');

--���뷴��������Ϣ��

update BCR_COUNTERGUARANTOR set incrementflag='6' where exists(select gbusinessno from BCR_GUARANTEEDUTY where BCR_GUARANTEEDUTY.gbusinessno= BCR_COUNTERGUARANTOR.gbusinessno and  gcontractflag!='1');

--��������ſ���Ϣ��Ϣ��

update BCR_COMPENSATORYINFO set incrementflag='6' where exists(select gbusinessno from BCR_GUARANTEEDUTY where BCR_GUARANTEEDUTY.gbusinessno= BCR_COMPENSATORYINFO.gbusinessno and  gcontractflag!='1');

--���������ϸ��Ϣ��

update BCR_COMPENSATORYDETAIL set incrementflag='6' where exists(select gbusinessno from BCR_GUARANTEEDUTY where BCR_GUARANTEEDUTY.gbusinessno= BCR_COMPENSATORYDETAIL.gbusinessno and  gcontractflag!='1');


--����׷����ϸ��Ϣ��

update BCR_RECOVERYDETAIL set incrementflag='6' where exists(select gbusinessno from BCR_GUARANTEEDUTY where BCR_GUARANTEEDUTY.gbusinessno= BCR_RECOVERYDETAIL.gbusinessno and  gcontractflag!='1');

--���뱣�ѽ��ɸſ���Ϣ��

update BCR_PREMIUMINFO set incrementflag='6' where exists(select gbusinessno from BCR_GUARANTEEDUTY where BCR_GUARANTEEDUTY.gbusinessno= BCR_PREMIUMINFO.gbusinessno and  gcontractflag!='1');


--���뱣�ѽ�����ϸ��Ϣ��

update BCR_PREMIUMDETAIL set incrementflag='6' where exists(select gbusinessno from BCR_GUARANTEEDUTY where BCR_GUARANTEEDUTY.gbusinessno= BCR_PREMIUMDETAIL.gbusinessno and  gcontractflag!='1');

