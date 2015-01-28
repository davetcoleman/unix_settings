rm -rf ~/ros/cu_amazon/*
mkdir -p ~/ros/cu_amazon/ws_baxter/src
cd ~/ros/ws_base/src
cp -r * ~/ros/cu_amazon/ws_baxter/src
cd ~/ros/ws_moveit/src
cp -r * ~/ros/cu_amazon/ws_baxter/src
cd ~/ros/ws_moveit_other/src
cp -r * ~/ros/cu_amazon/ws_baxter/src
cd ~/ros/ws_baxter/src
cp -r * ~/ros/cu_amazon/ws_baxter/src

cd ~/ros/cu_amazon/
zip -r ws_baxter.zip ws_baxter
