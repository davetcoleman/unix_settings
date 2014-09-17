# Dave's common test for benchmarking
# keywords benchmark, cpu
sudo apt-get install sysbench

sysbench --test=cpu --cpu-max-prime=20000 run

# Comment block:
: <<'END'

## Super Fast PC at JSK ----------------------------------
Test execution summary:
    total time:                          20.9671s
    total number of events:              10000
    total time taken by event execution: 20.9662
    per-request statistics:
         min:                                  2.04ms
         avg:                                  2.10ms
         max:                                  2.52ms
         approx.  95 percentile:               2.17ms

Threads fairness:
    events (avg/stddev):           10000.0000/0.00
    execution time (avg/stddev):   20.9662/0.00

## ROS Monster old desktop at CU ------------------------

Test execution summary:
    total time:                          23.9578s
    total number of events:              10000
    total time taken by event execution: 23.9558
    per-request statistics:
         min:                                  2.20ms
         avg:                                  2.40ms
         max:                                  2.75ms
         approx.  95 percentile:               2.53ms

Threads fairness:
    events (avg/stddev):           10000.0000/0.00
    execution time (avg/stddev):   23.9558/0.00

## ROS Monster new desktop at CU ------------------------

Test execution summary:
    total time:                          22.2772s
    total number of events:              10000
    total time taken by event execution: 22.2708
    per-request statistics:
         min:                                  2.15ms
         avg:                                  2.23ms
         max:                                  6.78ms
         approx.  95 percentile:               2.26ms

Threads fairness:
    events (avg/stddev):           10000.0000/0.00
    execution time (avg/stddev):   22.2708/0.00






END
