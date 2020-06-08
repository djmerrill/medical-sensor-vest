"""
Just reads from the hard-coded port name.
I'm getting around 550 samples per second.
This doesn't save to disk yet.
TODO Refactor to use docopt.
"""

import time

import serial

ser = serial.Serial('/dev/ttyACM0') # TODO This port name should be a parameter. 


line_count = 0
start_time = time.time()
while True:
    line = ser.readline();
    line_count += 1

    if line_count % 500 == 0:
        current_time = time.time()
        if current_time - start_time > 1.0:
            print('Got ' + str(line_count) + ' lines in ' + str(current_time - start_time))
            print('\t' + str(line_count / (current_time - start_time)) + ' lines per second')
            print('\t' + str(line_count / 6 / (current_time - start_time)) + ' samples per sensor per second')
            print('\tLast line: ' + str(line))
