sudo apt-get install -y libboost-all-dev cmake python-dev python-qt4-dev python-qt4-gl python-opengl freeglut3-dev libassimp-dev doxygen graphviz libode-dev

mkdir -p ~/ros/ompl_dave/
#hg clone ssh://hg@bitbucket.org/ompl/ompl
#hg clone ssh://hg@bitbucket.org/ompl/omplapp

cd ~/ros/ompl_dave/omplapp
rm -rf ompl
ln -s ../ompl ompl

mkdir -p build/Release
cd build/Release
cmake ../..
#If you want Python bindings or a GUI, type the following two commands:
make installpyplusplus && cmake . # download & install Py++
make update_bindings
#Compile OMPL.app by typing make.
make
#Optionally, run the test programs by typing make test.
#Optionally, generate documentation by typing make doc.
#If you need to install the library, you can type 
#sudo make install
#The install location is specified by CMAKE_INSTALL_PREFIX. If you install in a non-standard location, you have to set the environment variable PYTHONPATH to the directory where the OMPL python module is installed (e.g., $HOME/lib/python2.7/site-packages).
