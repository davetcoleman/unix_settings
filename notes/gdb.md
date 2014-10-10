# GDB Notes

## Basics

### Output Backtrace of All Threads At Once
    thread apply all bt full

### Print variable
    p

### See code
    list

### Backtrace
    bt

### Backtrace all threads
    thread apply all bt

### Change frames
    frame FRAME_NUMBER
    f FRAME_NUMBER

### Change frames towards main
    up

### Print all local variables
    info locals

### Print all global and static variables
    info variables

## Navigation

### Step out of current function
    fin

### Step out of current loop
    u (until)

### Step INTO function
    s (step)

### Step OVER subfunctions
    n (next)

### Run gdb on a running process
    ps aux | grep gzserver# get process id
    sudo gdb -p 23845     # connect to that id


