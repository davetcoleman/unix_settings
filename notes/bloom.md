# ROS Bloom Release System Notes

## First time release to Bloom

Source: http://wiki.ros.org/bloom/Tutorials/FirstTimeRelease

```
bloom_alias_load            # load our shortcuts for this process
roscd PACKAGE
bcgc --all
e CHANGELOG.rst
bcclft
bcpr patch
 # CREATE PACKAGE on github.com/davetcoleman named PACKAGE-release
 # COPY THE HTTPS URL
bloom-release --rosdistro indigo --track indigo PACKAGE --edit
```


## Updating to Bloom

Catkin Steps:
```
bloom_alias_load          # load our shortcuts for this process
roscd PACKAGE
bcgc			          # catkin_generate_changelog
e CHANGELOG.rst           # cleanup changelog
bccl			          # git commit -a -m "Updated changelogs"
bcpr {major,minor,patch}  # catkin_prepare_release --bump {major,minor,patch}
```

Bloom Steps:

Call the associated alias from indigo or hydro as documented in unix_settings/scripts/bloom.sh

    e.g. indigo_brXXX
