#!/bin/sh
DEVICE=/dev/cpc2012
cat $DEVICE &
PID=$!
exec >$DEVICE
echo -
echo J
echo -
echo r
echo -
sleep 1
kill $PID

