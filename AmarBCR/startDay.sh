#!/bin/sh
##查看数据是否导入
sHome=/home/Amarsoft/app/AmarBCR
sYesTerday=`date --date='yesterday' '+%Y-%m-%d'`
echo ${sYesTerday}.ok >> $sHome/log/startDay_${sYesTerday}.log
iCount=1
cd /home/Amarsoft/date/dbbackRZ
echo "检查数据文件是否导入成功！" >> $sHome/log/startDay_${sYesTerday}.log
while [ $iCount -le 3 ];
do
if [ -e ${sYesTerday}.ok ];then
	echo "数据文件导入成功！" >> $sHome/log/startDay_${sYesTerday}.log
  iCount=10
  break
else
	echo "数据文件未导入成功！" >> $sHome/log/startDay_${sYesTerday}.log
  iCount=`expr $iCount + 1`
  sleep 600
fi
done

if [ $iCount -eq 10 ];then
#执行批量
echo "执行批量！" >> $sHome/log/startDay_${sYesTerday}.log
cd /home/Amarsoft/app/AmarBCR
./bcr.sh init
./bcr.sh prepare
./bcr.sh validate
##./bcr.sh transfer
##./bcr.sh report
else
echo "数据文件未导入成功！" >> $sHome/log/startDay_${sYesTerday}.log
fi
