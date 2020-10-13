


from matplotlib import pyplot as plt
import numpy as np




# find data files

# data_filenames = ['0_data.txt']
data_filenames = []
for i in range(8):
    data_filenames.append(str(i) + '_data.txt')


# open data files


for filename in data_filenames:
    lines = None
    with open(filename, 'r') as f:
        lines = f.readlines()
    print('Got ' + str(len(lines)) + ' lines from ' + filename)

    print('Tossing first and last 5%')
    five_p = int(len(lines) * 0.05)
    lines = lines[five_p:-five_p]

    # process data files, times and frame endings
    datapoints = [] # type is (time, [data])
    last_data = None
    for i, line in enumerate(lines):
        timestamp = None
        data = None
        try:
            timestamp = float(line)
        except ValueError:
            data = [int(x) for x in line.split()]

        if data is not None:
            if data[-6:] != [13, 10, 13, 10, 13, 10]:
                print('Got bad data line #' + str(i) + ': ' + str(line))
            else:
                data = data[:-6]

        if last_data is not None and timestamp is not None:
            datapoints.append((timestamp, last_data))
        elif data is not None:
            last_data = data
        else:
            print('Something went wrong', data, last_data, timestamp, line)


    x = np.array(list([d[0] for d in datapoints]))
    for i in range(len(datapoints[0][1])):
        y = np.array(list([d[1][i] for d in datapoints]))
        plt.plot(x, y)
    plt.show()


    hist = {}
    biggest_gap = 0
    last_time = None
    gaps = []
    for dp in datapoints:
        frame = dp[1]
        for d in frame:
            try:
                hist[d] += 1
            except KeyError:
                hist[d] = 1
        time = dp[0]
        if last_time is not None:
            gap = time - last_time
            gaps.append(gap)
            if gap > biggest_gap:
                biggest_gap = gap
        last_time = time


    # report weird stuff
    for i in range(255):
        try:
            v = hist[i]
        except KeyError:
            v = 0
        print(str(i) + ': ' + str(v))



    print('Biggest gap: ' + str(biggest_gap) + ' (' + str(1.0/biggest_gap) + ' Hz)')
    mean_gap = sum(gaps)/len(gaps)
    print('Mean gap: ' + str(mean_gap) + ' (' + str(1.0/mean_gap) + ' Hz)')






















