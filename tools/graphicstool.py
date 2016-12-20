#!/usr/bin/env python

import os.path
import sys

if len(sys.argv) < 4:
    sys.stderr.write("usage: " + sys.argv[0] + " <input p8> <graphics section letter> <collab subdir>")
    exit(1)
                     
# fixme: replace with args
inputfile = sys.argv[1]
section = sys.argv[2]
collabprefix = sys.argv[3]

sections = list('0abcdefghijklmnopqrstuvw')
sectionindex = sections.index(section) / 4
sectionname = "gfx"
sectionsize = 32
if sectionindex > 3:
    sectionname = "map"
    sectionindex = sectionindex-4
    sectionsize = 16
outfile = sectionname + str(sectionindex)
    
outfile = os.path.join(collabprefix, sectionname, outfile)
col = (sections.index(section) % 4) * 32

mergedlines = ['']*sectionsize

with open(inputfile, 'r') as source:
    while True:
        if source.readline().startswith('__' + sectionname + '__'): break

    for _ in range(0, sectionindex*sectionsize):
        source.readline()

    with open(outfile, 'r') as output:
        for outlineidx in range(0,sectionsize):
            i = source.readline()
            o = output.readline()
            mergedlines[outlineidx] = o[0:col] + i[col:col+32] + o[col+32:]

with open(outfile, 'w') as output:
    for outline in mergedlines:
        output.write(outline)
