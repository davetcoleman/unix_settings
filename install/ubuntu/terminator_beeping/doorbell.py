#!/usr/bin/python

import pyglet # for playing sounds
import time
beeper = pyglet.media.load('/home/dave/unix_settings/install/ubuntu/terminator_beeping/doorbell.wav')
beeper.play()
time.sleep(1);
