import time

import serial

ser = serial.Serial('/dev/ttyACM0')


line_count = 0
start_time = time.time()
while True:
    line = ser.readline();
    line_count += 1

    if line_count % 50 == 0:
        current_time = time.time()
        if current_time - start_time > 1.0:
            print('Got ' + str(line_count) + ' lines in ' + str(current_time - start_time))
            print('\t' + str(line_count / (current_time - start_time)) + ' lines per second')
            print('\tLast line: ' + str(line))
