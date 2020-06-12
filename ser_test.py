"""
Just reads from the hard-coded port name.
This doesn't save to disk yet.
TODO Refactor to use docopt.
"""

import time

import serial

ser0 = serial.Serial('/dev/ttyACM0') # TODO This port name should be a parameter. 
ser1 = serial.Serial('/dev/ttyACM1') # TODO This port name should be a parameter. 
ser2 = serial.Serial('/dev/ttyACM2') # TODO This port name should be a parameter. 

line_count = 0
start_time = None
while True:
    if start_time is None:
        start_time = time.time()
    line = ser0.read(4);
    line1 = ser1.read(4);
    line2 = ser2.read(4);
    line_count += 1

    if line_count % 500 == 0:
        current_time = time.time()
        if current_time - start_time > 1.0:
            print('Got ' + str(line_count) + ' lines in ' + str(current_time - start_time))
            print('\t' + str(line_count / (current_time - start_time)) + ' lines per second')
            print('\t' + str(line_count / 6 / (current_time - start_time)) + ' samples per sensor per second')
            print('\tLast line: ' + str(line))
