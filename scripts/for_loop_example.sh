set -x
for file in /home/dave/ros/ws_baxter/src/large_data_files_not_backedup/plant_graph_trial6_after_paper/new/*
do
    echo $file
    filename="${file%.*}"
    echo $filename
    mkdir $filename
    mv $file $filename
    cd $filename
    unzip $file
    cd ..    
done

set +x
cd /home/dave/ros/ws_baxter/src/large_data_files_not_backedup/plant_graph_trial6_after_paper/new