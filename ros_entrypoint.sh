#!/bin/bash
set -e

# setup ros1 environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
source "$CATKIN_WS/devel/setup.bash"

# setup environment
export TURTLEBOT3_MODEL=burger
# export ROS_MASTER_URI=http://localhost:11311
# export ROS_HOSTNAME=localhost

# kick ROS & Turtlebot3
roscore &
roslaunch turtlebot3_bringup turtlebot3_remote.launch &
exec "$@"
