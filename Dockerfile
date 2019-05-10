ARG FROM_IMAGE=maimuzo/ros2-source-build:ros2
FROM $FROM_IMAGE

# crystal  or bouncy or ardent
ENV CHOOSE_ROS2_DISTRO crystal 

# setup ROS2 workspace
ENV ROS2_WS /opt/ros2_ws

# ---- install turtlebot3 Remote packages for ROS2 ----

# setup ros2 environment
RUN . $ROS2_WS/install/setup.sh

# Install Cartographer dependencies
RUN apt update && apt install -y \
    google-mock \
    libceres-dev \
    liblua5.3-dev \
    libboost-dev \
    libboost-iostreams-dev \
    libprotobuf-dev \
    protobuf-compiler \
    libcairo2-dev \
    libpcl-dev \
    python3-sphinx
    
# Install Gazebo9
RUN curl -sSL http://get.gazebosim.org | sh

# Install Navigation2 dependencies
RUN apt install -y \
    libsdl-image1.2 \
    libsdl-image1.2-dev \
    libsdl1.2debian \
    libsdl1.2-dev

# setup turtle3 dir
ENV TURTLEBOT3_WS /opt/turtlebot3_ws
RUN mkdir -p $TURTLEBOT3_WS/src
WORKDIR $TURTLEBOT3_WS

# get turtlebot3 sources
RUN wget https://raw.githubusercontent.com/ROBOTIS-GIT/turtlebot3/ros2/turtlebot3.repos
RUN vcs import src < turtlebot3.repos

# build turtlebot3 remote packages
RUN colcon build --symlink-install

# setup entrypoint
COPY ./ros_entrypoint.sh /
RUN chmod +x /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]