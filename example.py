#!/usr/bin/env python

import os
import sys

from glusterfs import gfapi
v = gfapi.Volume(os.environ['GLUSTERSERVER'],os.environ['GLUSTERVOL'])
v.set_logging(os.environ['OPENSHIFT_LOG_DIR'] + '/gfapi.log',7)
v_ret = v.mount()
if v_ret != 0 :
    print "Mount failed, trying to exit.  Will hang instead."
    print "Kill me now."
    sys.exit(1)
v.listdir("/")

