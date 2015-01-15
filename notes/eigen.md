1;2802;0c# Eigen Library Notes

    Eigen::Affine3d tmp;
	std::cout << "Position: " << tmp.translation() << std::endl;

## Create an empty transform

    Eigen::Affine3d offset = Eigen::Affine3d::Identity();

## Change the location of a transformation

    offset.translation().y() = 0;

## Apply an offset to an existing pose

    pose = offset * pose;

# Create pose with values

    Eigen::Affine3d pose = Eigen::Translation3d(x, y, z) * 
      Eigen::Quaterniond(rw, rx, ry, rz);

# Rotate certain axis

    Eigen::Affine3d grasp_pose;
    grasp_pose = Eigen::AngleAxisd(theta1, Eigen::Vector3d::UnitX())
    * Eigen::AngleAxisd(-0.5*M_PI, Eigen::Vector3d::UnitZ())
    * Eigen::AngleAxisd(theta2, Eigen::Vector3d::UnitX()); // Flip 'direction'

    grasp_pose.translation() = Eigen::Vector3d( yb, xb ,zb);
