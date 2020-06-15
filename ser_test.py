"""
Just reads from the hard-coded port name.
TODO Refactor to use docopt.
"""

import time

import serial


# Save the data from band
# The file name should be a command line option
def save_data(data, filename):
    with open(filename, 'w') as f:
        for i, d in enumerate(data):
            # fix the mapping
            if d == newline_char:
                f.write('\n')
            elif d == zero_char:
                f.write('0 ')
            else:
                # Saves the numbers unicode strings so it is easy to check manually
                f.write(str(d) + ' ')


sers = []
active_ports = 0

for i in range(4):
    try:
        sers.append(serial.Serial('/dev/ttyACM' + str(i))) # TODO This port name should be a parameter. 
        active_ports += 1
    except:
        sers.append(None)

# I know this is weird, but this remapping is so the Arduino serial functions work correctly
# These value can change if needed
# The newline in particular might not be needed at all
zero_char = 64
newline_char = 65


# attempt to syncronize
for ser in sers:
    if ser is not None:
        _ = ser.readline()

# lists for data
datas = []
for ser in sers:
    datas.append([])

def check_end_frame(data):
    if len(data) < 3:
        return False
    return data[-3] == newline_char and data[-1] == 10 and data[-2] == 13

def check_data(data):
    if check_end_frame(data):
        data.append(newline_char)
        data.append(time.time())
        data.append(newline_char)
        data.append(newline_char)

line_count = 0
frame_count = 0
start_time = None

# The break condition should be time based and set using a command line option
while frame_count/active_ports < 10000:


    for i, ser in enumerate(sers):
        if ser is None:
            continue
        # record start time, the Arduino might not start right away so we should wait for the first good read
        if start_time is None:
            start_time = time.time()
        line = ser.read(16);
        assert len(line) == 16

        # I'm just saving it like this for testing
        for d in line:
            if check_end_frame(datas[i]):
                frame_count += 1
            check_data(datas[i])
            datas[i].append(d)
        

    if line_count % 500*active_ports == 0:
    #if True:
        current_time = time.time()
        if current_time - start_time > 1.0:
        #if True:
            print('Got ' + str(frame_count) + ' frames in ' + str(current_time - start_time))
            print('\t' + str(frame_count / (current_time - start_time)) + ' frames per second')
            print('\t' + str(frame_count / active_ports / (current_time - start_time)) + ' samples per sensor per second')
            print('\tLast line: ' + str([str(d) for d in line]))

visualize = False

if visualize:
    # Just counting for testing visulization
    counts = [0]*256
    for d in ser0_data:
        counts[d] += 1

    # Print the histogram for testing
    for i, c in enumerate(counts):
        print(str(i) + ': ' + str(c))

for i, data in enumerate(datas):
    save_data(data, str(i) + '_data.txt')
