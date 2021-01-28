#!/bin/bash
file=/var/log/anaconda/X.log
grep ' (WW) ' $file | sed 's/ (WW) / Warning: /g' >full.log
grep ' (II) ' $file | sed 's/ (II) / Information: /g' >>full.log
cat full.log
