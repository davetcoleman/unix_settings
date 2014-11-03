# GDB Notes

## Navigation -----------------------------------------------------------------

### Step OVER subfunctions
    n (next)

### Step out of current function
    fin

### Step out of current loop
    u (until)

### Step INTO function
    s (step)

## Basics -------------------------------------------------------------------

### See code
    list

### Print variable
    p

### Backtrace
    bt

### Change frames
    frame FRAME_NUMBER
    f FRAME_NUMBER

### Change frames towards main
    up

### Print all local variables
    info locals

### Print all global and static variables
    info variables

## Advanced -------------------------------------------------------------------

### Run gdb on a running process
    ps aux | grep gzserver# get process id
    sudo gdb -p 23845     # connect to that id

### Output Backtrace of All Threads At Once
    thread apply all bt full

### Backtrace all threads
    thread apply all bt

## Graphics -------------------------------------------------------------------

### Documentation
    http://davis.lbl.gov/Manuals/GDB/gdb_21.html

### Show Text User Interface
    C-x A 

## Breakpoints -------------------------------------------------------------------

### Set a breakpoint on any line in current file
    break 123

### Remove a breakpoint
    clear linenum
	clear filename:linenum

### Set a breakpoint on the source line that point is on
    C-x C-a C-b
    
