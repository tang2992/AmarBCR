#!/bin/sh
##�鿴�����Ƿ���
sHome=/home/Amarsoft/app/AmarBCR
sYesTerday=`date --date='yesterday' '+%Y-%m-%d'`
echo ${sYesTerday}.ok >> $sHome/log/startDay_${sYesTerday}.log
iCount=1
cd /home/Amarsoft/date/dbbackRZ
echo "��������ļ��Ƿ���ɹ���" >> $sHome/log/startDay_${sYesTerday}.log
while [ $iCount -le 3 ];
do
if [ -e ${sYesTerday}.ok ];then
	echo "�����ļ�����ɹ���" >> $sHome/log/startDay_${sYesTerday}.log
  iCount=10
  break
else
	echo "�����ļ�δ����ɹ���" >> $sHome/log/startDay_${sYesTerday}.log
  iCount=`expr $iCount + 1`
  sleep 600
fi
done

if [ $iCount -eq 10 ];then
#ִ������
echo "ִ��������" >> $sHome/log/startDay_${sYesTerday}.log
cd /home/Amarsoft/app/AmarBCR
./bcr.sh init
./bcr.sh prepare
./bcr.sh validate
##./bcr.sh transfer
##./bcr.sh report
else
echo "�����ļ�δ����ɹ���" >> $sHome/log/startDay_${sYesTerday}.log
fi
