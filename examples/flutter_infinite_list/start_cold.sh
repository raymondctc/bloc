#!/bin/sh

#source ./env.sh $1

adb shell am start -S -W \
com.awesomeproject2/.MainActivity \
-c android.intent.category.LAUNCHER \
-a android.intent.action.MAIN
