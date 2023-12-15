#!/bin/bash

#override wget
wget() {
    cat tests/$FFILE
}

function assertEquals()
{
    msg=$1; shift
    expected=$1; shift
    actually=$1; shift
    if [ "$expected" != "$actually" ]; then
        echo "$msg $*"
        echo "EXPECTED=$expected"
        echo "ACTUAL__=$actually"
        echo ""
        exit 2
    fi
}

doTest() {
    FFILE=$1; shift
    EXPTD=$1; shift
    OUT=$(source check_northern_lights $*)

    assertEquals $FFILE "$EXPTD"  "$OUT" $* && echo OK-$FFILE $*
}

doTest test533.json 'WARN: 5.33 solar level in next three days. "2023-12-17 00:00:00" https://www.swpc.noaa.gov/products/3-day-geomagnetic-forecast'
doTest test333.json 'OK: 3.33 solar level in next three days. https://www.swpc.noaa.gov/products/3-day-geomagnetic-forecast'
doTest test500.json 'WARN: 5.00 solar level in next three days. "2023-12-17 21:00:00" https://www.swpc.noaa.gov/products/3-day-geomagnetic-forecast'
doTest test733.json 'CRITICAL: 7.33 solar level in next three days. "2023-12-17 18:00:00" https://www.swpc.noaa.gov/products/3-day-geomagnetic-forecast'

doTest test533.json 'OK: 5.33 solar level in next three days. https://www.swpc.noaa.gov/products/3-day-geomagnetic-forecast' -w 6 -c 7
doTest test533.json 'CRITICAL: 5.33 solar level in next three days. "2023-12-17 00:00:00" https://www.swpc.noaa.gov/products/3-day-geomagnetic-forecast' -w 4 -c 5
