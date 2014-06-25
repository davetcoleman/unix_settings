#!/bin/bash
extra_text=""
if [  ]; then #n"$1" == "--break-main" ]; then
  #extra_text="break Controller::initRequest(hardware_interface::RobotHW*, ros::NodeHandle&, ros::NodeHandle, std::set<std::string>&)"
  extra_text="break main"
  shift
fi

EXEC="$1"

shift

run_text="run"
for a in "$@"; do
  run_text="${run_text} \"$a\""
done

TMPFILE=/tmp/gdbrun.$$.$#.tmp
cat > ${TMPFILE} <<EOF
set breakpoint pending on
break controller.h:119
${run_text}
EOF

echo ${TMPFILE}

gdb -x ${TMPFILE} "${EXEC}"
rm -f "${TMPFILE}"

