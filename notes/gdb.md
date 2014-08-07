# GDB Notes

## Output Backtrace of All Threads At Once
   thread apply all bt full

## Print variable
   p

## See code
   list

## Backtrace
   bt

## Backtrace all threads
   thread apply all bt

## Change frames
   frame FRAME_NUMBER
   f FRAME_NUMBER

## Change frames towards main
   up

## Print all local variables
   info locals

## Print all global and static variables
   info variables

## Step out of current function
   fin

## Step out of current loop
   u (until)