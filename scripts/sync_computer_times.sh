
echo "BAXTER NTP Status:"
ntpq -p 128.138.244.56

echo "BAXTER TO MONSTER"
ntpdate -q 128.138.244.56
echo "GATEWAY TO MONSTER"
ntpdate -q $ROS_GATEWAY_IP
echo "Syncing Monster"
sudo ntpdate pool.ntp.org