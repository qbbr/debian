#!/bin/sh
# Sokolov Innokenty <r2.kenny@gmail.com>

STAT_BEFORE=`cat /proc/stat | head -n 5`
sleep 1
STAT_AFTER=`cat /proc/stat | head -n 5`

getCoreLoadPercent() {
    local CORE=$1

    BEFORE=`echo "${STAT_BEFORE}" | grep "^cpu${CORE} "`
    AFTER=`echo "${STAT_AFTER}" | grep "^cpu${CORE} "`

    # парсим колонки
    USER0=`echo "${BEFORE}" | awk '{ print $2 }'`
    USER1=`echo "${AFTER}" | awk '{ print $2 }'`
    NICE0=`echo "${BEFORE}" | awk '{ print $3 }'`
    NICE1=`echo "${AFTER}" | awk '{ print $3 }'`
    SYST0=`echo "${BEFORE}" | awk '{ print $4 }'`
    SYST1=`echo "${AFTER}" | awk '{ print $4 }'`
    IDLE0=`echo "${BEFORE}" | awk '{ print $5 }'`
    IDLE1=`echo "${AFTER}" | awk '{ print $5 }'`

    # разность
    USER=`expr ${USER1} - ${USER0}`
    NICE=`expr ${NICE1} - ${NICE0}`
    SYST=`expr ${SYST1} - ${SYST0}`
    IDLE=`expr ${IDLE1} - ${IDLE0}`

    # сумма разностей
    TOTAL=`expr ${USER} + ${NICE} + ${SYST} + ${IDLE}`
    USED=`expr ${USER} + ${NICE} + ${SYST}`

    # средняя загрузка за интервал времени в процентах
    echo "scale=10; (${USED} * 100 / ${TOTAL})" | bc | xargs printf "%0.2f"
}

CORE0=`getCoreLoadPercent 0`
CORE1=`getCoreLoadPercent 1`
CORE2=`getCoreLoadPercent 2`
CORE3=`getCoreLoadPercent 3`

echo "${CORE0}% / ${CORE1}% / ${CORE2} / ${CORE3}"
