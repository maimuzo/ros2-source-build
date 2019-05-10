#!/bin/bash
set -e

# setup ros2 environment
source "$ROS2_WS/install/setup.bash"

# setup Turtlebot3 environment
source "$TURTLEBOT3_WS/install/setup.bash"

exec "$@"
