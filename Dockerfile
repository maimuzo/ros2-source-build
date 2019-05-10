ARG FROM_IMAGE=osrf/ros:kinetic-desktop-full 
FROM $FROM_IMAGE

ENV ROS_DISTRO kinetic

# upgrade packages
RUN apt-get update && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/*

# skip installation of kinetic
# RUN wget https://raw.githubusercontent.com/ROBOTIS-GIT/robotis_tools/master/install_ros_$ROS_DISTRO.sh && chmod 755 ./ install_ros_$ROS_DISTRO.sh && bash ./install_ros_$ROS_DISTRO.sh

# Install Dependent Turtlebot3 Packages
RUN apt-get update && apt-get install -y ros-kinetic-joy ros-kinetic-teleop-twist-joy ros-kinetic-teleop-twist-keyboard ros-kinetic-laser-proc ros-kinetic-rgbd-launch ros-kinetic-depthimage-to-laserscan ros-kinetic-rosserial-arduino ros-kinetic-rosserial-python ros-kinetic-rosserial-server ros-kinetic-rosserial-client ros-kinetic-rosserial-msgs ros-kinetic-amcl ros-kinetic-map-server ros-kinetic-move-base ros-kinetic-urdf ros-kinetic-xacro ros-kinetic-compressed-image-transport ros-kinetic-rqt-image-view ros-kinetic-gmapping ros-kinetic-navigation ros-kinetic-interactive-markers \
    && rm -rf /var/lib/apt/lists/*

# sertup workspace
ENV CATKIN_WS /opt/turtlebot3/catkin_ws
RUN mkdir -p $CATKIN_WS/src
WORKDIR $CATKIN_WS/src

# get Turtlebot3 sources
RUN git clone https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git
RUN git clone https://github.com/ROBOTIS-GIT/turtlebot3.git

# import workspace environment and build Turtlebot3 from source by bash
RUN /bin/bash -c '. /opt/ros/kinetic/setup.bash; cd $CATKIN_WS; catkin_make'

# setup entrypoint
COPY ./ros_entrypoint.sh /
RUN chmod +x /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]