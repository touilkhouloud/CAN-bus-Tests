#!/bin/bash

#config the can interfaces

canconfig can0 bitrate 50000
if [ $? -eq 0 ];then
	lava-test-case canconfig_can0 --result pass
else
        lava-test-case canconfig_can0 --result fail

fi

sleep 3

canconfig can1 bitrate 50000
if [ $? -eq 0 ];then
        lava-test-case canconfig_can1 --result pass
else
        lava-test-case canconfig_can1 --result fail

fi


sleep 3


#bring up the devices

canconfig can0 start
if [ $? -eq 0 ];then
        lava-test-case start_can0 --result pass
else
        lava-test-case start_can0 --result fail

fi


sleep 3

canconfig can1 start
if [ $? -eq 0 ];then
        lava-test-case start_can1 --result pass
else
        lava-test-case start_can1 --result fail

fi


sleep 3

#send frames

cansequence -p can0 &
if [ $? -eq 0 ];then
        lava-test-case send_frames_through_can0 --result pass
else
        lava-test-case send_frames_through_can0 --result fail

fi


candump can1 > /dev/null &
if [ $? -eq 0 ];then
        lava-test-case receive_frames_through_can1 --result pass
else
        lava-test-case receive_frames_through_can1 --result fail

fi

sleep 10

canconfig can0 stop
if [ $? -eq 0 ];then
        lava-test-case stop_can0 --result pass
else
        lava-test-case stop_can0 --result fail

fi

sleep 3

canconfig can1 stop
if [ $? -eq 0 ];then
        lava-test-case stop_can1 --result pass
else
        lava-test-case stop_can1 --result fail

fi


sleep 5
