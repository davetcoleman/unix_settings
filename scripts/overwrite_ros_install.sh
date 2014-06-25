sudo mv /opt/ros/hydro/include/urdf_parser/exportdecl.h /opt/ros/hydro/include/urdf_parser/_exportdecl.h
sudo mv /opt/ros/hydro/include/urdf_parser/urdf_parser.h /opt/ros/hydro/include/urdf_parser/_urdf_parser.h
sudo mv /opt/ros/hydro/lib/liburdfdom_model.so /opt/ros/hydro/lib/_liburdfdom_model.so
sudo mv /opt/ros/hydro/lib/liburdfdom_model_state.so /opt/ros/hydro/lib/_liburdfdom_model_state.so
sudo mv /opt/ros/hydro/lib/liburdfdom_sensor.so /opt/ros/hydro/lib/_liburdfdom_sensor.so
sudo mv /opt/ros/hydro/lib/liburdfdom_world.so /opt/ros/hydro/lib/_liburdfdom_world.so
sudo mv /opt/ros/hydro/lib/pkgconfig/urdfdom.pc /opt/ros/hydro/lib/pkgconfig/_urdfdom.pc
sudo mv /opt/ros/hydro/share/urdfdom/cmake/urdfdom-config.cmake /opt/ros/hydro/share/urdfdom/cmake/_urdfdom-config.cmake

cd ~/ros/urdfdom # where the git repo was checked out
mkdir -p build
cd build
cmake ../ -DCMAKE_INSTALL_PREFIX=/opt/ros/hydro
make -j8
sudo make install

# now rebuild your catkin workspace
cd ~/ros/ws_catkin
catkin_make