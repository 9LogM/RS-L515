# RS-L515-Docker

This project provides a containerized ROS 2 solution for publishing 3D point cloud and sensor data from an Intel RealSense L515 camera.

## Overview
This setup uses Docker to run the official realsense-ros wrapper. The configuration has been optimized to correctly handle the L515's specific parameters, such as enabling the laser emitter and aligning depth data to produce a colored point cloud.

## Key Topics to Subscribe To
For a project using this data, you will most likely subscribe to one of the following topics:

- **3D Point Cloud**
    - **Topic Name:** /camera/depth/color/points
    - **Message Type:** sensor_msgs/msg/PointCloud2
    - **Description:** The complete 3D point cloud with color information. This is the main data stream for 3D applications.

- **2D Color Image**
    - **Topic Name:** /camera/color/image_raw
    - **Message Type:** sensor_msgs/msg/Image
    - **Description:** The standard 2D video feed from the camera's RGB sensor, useful for computer vision tasks or as a visual feed.

## Prerequisites
- Intel RealSense L515 Camera  
- Docker Engine


## Installation
1. Clone the repository
    ```bash
    git clone https://github.com/9LogM/RS-L515.git
    ```

2. Build the service
    ```bash
    docker compose build
    ```
  
## Usage
1. **Connect the Camera:**
Plug your RealSense L515 camera into a USB 3.0 port on your computer.

2. **Start the Publisher:**
Run the following command to start the container in the background.
    ```bash
    docker compose up -d
    ```
    The camera node is now running and publishing data to the ROS 2 topics.

3. **Check the Topics (Optional):**
To verify that data is flowing, you can "enter" the container and list the topics.
    ```bash
    # Enter the container
    docker exec -it l515-pub bash

    # Inside the container, source ROS and list topics
    source /opt/ros/galactic/setup.bash
    ros2 topic list
    ```

4. **Stop the Publisher:**
When you are finished, stop the container with:
    ```bash
    docker compose down
    ```

## RViz Visualization Guide
To see the 3D point cloud, you can use RViz from inside the container.

1. **Allow Display Access:**
On your host machine (not in Docker), run this command once per session to allow the container to draw windows on your screen.
    ```bash
    xhost +local:docker
    ```

2. **Launch RViz:**
Enter the running container and launch RViz.
    ```bash
    docker exec -it l515-pub bash
    source /opt/ros/galactic/setup.bash
    rviz2
    ```

3. **Configure RViz:**

    1. Set Fixed Frame: In the "Global Options" panel, change the Fixed Frame from map to camera_link. The status should turn to "OK".
    2. Add PointCloud2 Display: Click the Add button at the bottom of the "Displays" panel.
    3. Choose the PointCloud2 display type and click OK.
    4. In the new PointCloud2 display options, set the Topic to /camera/depth/color/points.

You should now see the live, colored 3D point cloud from your L515 camera.
