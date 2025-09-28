FROM osrf/ros:galactic-desktop

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    ros-galactic-realsense2-camera \
    && rm -rf /var/lib/apt/lists/*

CMD ["bash", "-lc", "ros2 launch realsense2_camera rs_launch.py \
    pointcloud.enable:=true \
    align_depth.enable:=true \
    pointcloud.stream_index_filter:=-1 \
    enable_gyro:=true \
    enable_accel:=true \
    unite_imu_method:=2 \
    depth_module.laser_power:=100"]