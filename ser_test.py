"""
Just reads from the hard-coded port name.
TODO Refactor to use docopt.
"""

import time

import serial

ser0 = serial.Serial('/dev/ttyACM0') # TODO This port name should be a parameter. 
ser1 = serial.Serial('/dev/ttyACM1') # TODO This port name should be a parameter. 
#ser2 = serial.Serial('/dev/ttyACM2') # TODO This port name should be a parameter. 

# I know this is weird, but this remapping is so the Arduino serial functions work correctly
# These value can change if needed
# The newline in particular might not be needed at all
zero_char = 64
newline_char = 65

line_count = 0
start_time = None

_ = ser0.readline()


ser0_data = []

# The break condition should be time based and set using a command line option
while len(ser0_data) < 100000:

    # record start time, the Arduino might not start right away so we should wait for the first good read
    if start_time is None:
        start_time = time.time()
    line = ser0.read(4);

    # I'm just saving it like this for testing
    for d in line:
        ser0_data.append(d)

    # I think this will really read and take time, even if the data is not used. So it's ok for testing
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


# Just counting for testing visulization
counts = [0]*256
for d in ser0_data:
    counts[d] += 1

# Print the histogram for testing
for i, c in enumerate(counts):
    print(str(i) + ': ' + str(c))

# Save the data from band 0
# The file name should be a command line option
with open('data.txt', 'w') as f:
    for i, d in enumerate(ser0_data):
        # fix the mapping
        if d == newline_char:
            f.write('\n')
        elif d == zero_char:
            f.write('0 ')
        else:
            # Saves the numbers unicode strings so it is easy to check manually
            f.write(str(d) + ' ')
