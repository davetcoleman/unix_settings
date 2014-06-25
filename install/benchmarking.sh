# Dave's common test for benchmarking
# keywords benchmark, cpu
sudo apt-get install sysbench

sysbench --test=cpu --cpu-max-prime=20000 run

# Commen block:
: <<'END'

## Super Fast PC at JSK: 
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


END
