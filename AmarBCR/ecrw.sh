#!/bin/sh

JAVA_HOME=/java/jdk1.6.0_45
export JAVA_HOME

if [ -z "$JAVA_HOME" ]; then
echo "Please configure the JAVA_HOME!"
exit
fi

CLASSPATH=.:./classes
export CLASSPATH

JLIBDIR=./lib
export JLIBDIR

for LL in `ls $JLIBDIR/*.jar`
do
CLASSPATH=$CLASSPATH:$LL
export CLASSPATH
done

JAVA_OPTION=-Dfile.encoding=GBK
RUN_CLASS=com.amarsoft.app.datax.ecr.AmarECR
ARE_CONFIG_FILE=./etc/ecr_are.xml
TASK=$1

export JAVA_OPTION
export RUN_CLASS
export ARE_CONFIG_FILE
${JAVA_HOME}/bin/java ${JAVA_OPTION} -classpath ${CLASSPATH} ${RUN_CLASS} are=${ARE_CONFIG_FILE} task=${TASK} gui=true
