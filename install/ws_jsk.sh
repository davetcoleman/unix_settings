mkdir -p ~/ros/ws_jsk/src
cd ~/ros/ws_jsk/src
catkin_init_workspace 

sudo rosdep init
rosdep update

wstool init .
wstool merge https://rtm-ros-robotics.googlecode.com/svn/trunk/rtm-ros-robotics.rosinstall
wstool merge http://svn.code.sf.net/p/jsk-ros-pkg/code/trunk/jsk.rosinstall
wstool update

sudo apt-get install -y libomniorb4-dev omniidl libomniorb4* omni* libblas* liblapack* f2c omniidl-python omniorb-nameserver libomniorb4-1-dbg libomniorb4-dev omniorb omniorb-idl python-omniorb-dbg python-omniorb-doc

# unusure about the next line for the thinkpad...
sudo apt-get install libglapi-mesa xserver-xorg-video-intel libgl1-mesa-glx libgl1-mesa-dri xserver-xorg-core
sudo apt-get install -y gsfonts-x11 texlive-fonts-extra xfonts-100dpi xfonts-75dpi xfonts-100dpi-transcoded xfonts-75dpi-transcoded
sudo apt-get install -y ros-groovy-pcl* ros-groovy-openni* ros-groovy-simulator-gazebo

touch jsk-ros-pkg/jsk_openni_kinect/CATKIN_IGNORE
touch jsk-ros-pkg/jsk_baxter_robot/baxtereus/CATKIN_IGNORE
rm -rf RethinkRobotics/

read -p "Put robot_models.tgz in the src/ folder"
untgz robot_models.tgz 

cd ~/ros/ws_jsk
catmake
source devel/setup.bash
rm -rf `rospack find openrtm_aist`/build/
catmake
catmake