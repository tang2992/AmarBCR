执行顺序：
先按顺序执行crebas_db2.sql、crebas_db2_his.sql、initMap.sql。
再执行crebas_db2_datacheck.sql（如果执行问题，在终端运行db2 reorg table ECR_ALSDATACHECK）
最后执行reorg.sql整理表结构