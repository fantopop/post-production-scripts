#!/usr/bin/env python3
import json

class sound_prefs:
    pass

class video_prefs:
    pass

filename = 'test.json'
prefs = {}
sound = []
video = []


sound.bit_depth = '24'
sound.sample_rate = '48000'
sound.file_type = 'wav'
sound.format = 'stereo'

video.fps = '25'
video.codec = 'H.264'
video.width = '1920'
video.heigth = '1080'
video.container = '.mp4'

prefs['sound'] = sound
prefs['video'] = video

f = open(filename, 'w')
json.dump(fp=f, obj=prefs, sort_keys=True, indent=4)
f.close()
