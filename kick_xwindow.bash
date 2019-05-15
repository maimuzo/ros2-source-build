#!/bin/bash
docker run -it --rm --name turtle3head -p 11311:11311 -e DISPLAY=192.168.99.1:0 maimuzo/ros2-source-build:turtlebot3-on-kinetic