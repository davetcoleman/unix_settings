sudo chown "$USER" "$HOME"
sudo chown -R "$USER" ~/Dropbox ~/.dropbox ~/.dropbox-master
sudo chattr -R -i ~/Dropbox
sudo chmod -R u+rw ~/Dropbox ~/.dropbox ~/.dropbox-master
