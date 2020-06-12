"""
Just reads from the hard-coded port name.
This doesn't save to disk yet.
TODO Refactor to use docopt.
"""

import time

import serial

ser0 = serial.Serial('/dev/ttyACM0') # TODO This port name should be a parameter. 
ser1 = serial.Serial('/dev/ttyACM1') # TODO This port name should be a parameter. 
#ser2 = serial.Serial('/dev/ttyACM2') # TODO This port name should be a parameter. 

zero_char = 64
newline_char = 65

line_count = 0
start_time = None

_ = ser0.readline()


ser0_data = []


while len(ser0_data) < 100000:
    if start_time is None:
        start_time = time.time()
    line = ser0.read(4);
    assert len(line) == 4, len(line)
    for d in line:
        ser0_data.append(d)
    #assert line[-1] == 10, line[-1]
    line1 = ser1.read(4);
    #line2 = ser2.read(4);
    line_count += 1

    #if line_count % 500 == 0:
    if True:
        current_time = time.time()
        if current_time - start_time > 1.0:
        #if True:
            print('Got ' + str(line_count) + ' lines in ' + str(current_time - start_time))
            print('\t' + str(line_count / (current_time - start_time)) + ' lines per second')
            print('\t' + str(line_count / 6 / (current_time - start_time)) + ' samples per sensor per second')
            print('\tLast line: ' + str(line))



counts = [0]*256
for d in ser0_data:
    counts[d] += 1


for i, c in enumerate(counts):
    print(str(i) + ': ' + str(c))

with open('data.txt', 'w') as f:
    for i, d in enumerate(ser0_data):
        if d == newline_char:
            f.write('\n')
        elif d == zero_char:
            f.write('0 ')
        else:
            f.write(str(d) + ' ')
