#!/usr/bin/env python

# changevol script by bruenig
# depends on: python, pygtk, alsa-utils

import pygtk
import gtk
import gobject
import commands
import sys
import os
import re

def err(msg):
  print msg
  sys.exit(1)

def usage():
  print '''
Usage: changevol [options] [number]

Options:
  -i, --increase  increase volume by `number'
  -d, --decrease  decrease volume by `number'
  -t, --toggle    toggle mute on and off
  -h, --help      display this help message

Note:
  `number' won't be exact due to amixer oddities
'''
  sys.exit(0)

class GetVolInfo():

  def __init__(self, command):
    self.amixeroutput = commands.getoutput(command)

    if re.compile("off]$", re.M).search(self.amixeroutput, 1):
      self.realvol = "0"
      self.endlabel = "Mute"
    else:
      self.tempvolarray1 = self.amixeroutput.split("[")
      self.tempvolarray2 = self.tempvolarray1[1].split("%")
      self.realvol = self.tempvolarray2[0]
      self.endlabel = self.realvol + " %"

    self.percent = float(self.realvol)/100
    self.label = "Volume " + self.endlabel

class ProgressBar:

  def timeout_callback(self):
    gtk.main_quit()
    return False

  def __init__(self, fraction, label):
    self.window = gtk.Window(gtk.WINDOW_POPUP)
    self.window.set_border_width(1)
    self.window.set_default_size(180, -1)
    self.window.set_position(gtk.WIN_POS_CENTER)

    timer = gobject.timeout_add(1000, self.timeout_callback)

    self.bar = gtk.ProgressBar()
    self.bar.set_fraction(fraction)
    self.bar.set_orientation(gtk.PROGRESS_LEFT_TO_RIGHT)
    self.bar.set_text(label)
    self.bar.show()

    self.window.add(self.bar)
    self.window.show()


#Run through parameters, set variables and such
if (len(sys.argv) < 2) or (sys.argv[1] == '-h') or (sys.argv[1] == '--help'):
  usage()
else:
  OPTION = sys.argv[1]

if (len(sys.argv) > 2):
  NUMBER = sys.argv[2]

if (OPTION == '-i') or (OPTION == '--increase'):
  command = "amixer set Master " + NUMBER + "%+"
elif (OPTION == '-d') or (OPTION == '--decrease'):
  command = "amixer set Master " + NUMBER + "%-"
elif (OPTION == '-t') or (OPTION == '--toggle'):
  command = "amixer sset Master toggle"
else:
  err("Option not recognized, see changevol --help.")

#Execution
volume = GetVolInfo(command)
ProgressBar(volume.percent, volume.label)
gtk.main()
