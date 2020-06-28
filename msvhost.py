"""
MSVHost.

Usage:
    msvhost.py [options]

Options:
    -h --help       Show this message.
    --version       Show version.
    -n PORTS        Number of ports [default: 1]
    -t SECONDS      Seconds to record data [default: 10]
    -d SECONDS      Seconds to delay start of recording (optional)
    -s              Suppress debug messages to stdout.
"""

import time

import serial

from docopt import docopt




def main(arguments):
    if '-d' in arguments and arguments['-d'] is not None:
        print('Waiting ' + arguments['-d'] + ' seconds')
        time.sleep(float(arguments['-d']))

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
            print('Saved ' + str(len(data)) + ' frames to ' + filename)

    sers = []
    active_ports = 0

    for i in range(int(arguments['-n'])):
        print('Attempting to open serial port ' + str(i))
        try:
            sers.append(serial.Serial('/dev/ttyACM' + str(i))) # TODO This port name should be a parameter. 
            active_ports += 1
            print('\tSuccess')
        except:
            sers.append(None)
            print('\tFailed')

    assert active_ports > 0

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
            data.append('\n')
            data.append(time.time())
            data.append('\n')

    frame_count = 0
    start_time = None

    # The break condition should be time based and set using a command line option
    while start_time is None or time.time() - start_time < float(arguments['-t']):


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
            

        if not arguments['-s']:
            if frame_count % 1000*active_ports == 0 and start_time is not None:
            #if True:
                current_time = time.time()
                if current_time - start_time > 1.0:
                #if True:
                    print('Got ' + str(frame_count) + ' frames in ' + str(current_time - start_time))
                    print('\t' + str(frame_count / (current_time - start_time)) + ' frames per second')
                    print('\t' + str(frame_count / active_ports / (current_time - start_time)) + ' samples per sensor per second')
                    print('\tLast line: ' + str([str(d) for d in line]))



    for i, data in enumerate(datas):
        save_data(data, str(i) + '_data.txt')

    print('Finished')
    exit(0)


if __name__ == '__main__':
    arguments = docopt(__doc__, version='Medical Sensor Vest Host 0.1')
    main(arguments)
