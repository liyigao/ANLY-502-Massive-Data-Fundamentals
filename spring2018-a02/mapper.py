#!/usr/bin/env python
#
# This file has been provided as a starting point. You need to modify this file.
# Reads whole lines stdin; writes key/value pairs to stdout
# --- DO NOT MODIFY ANYTHING ABOVE THIS LINE ---

import sys
import datetime

if __name__ == "__main__":
	for line in sys.stdin:
		start = line.index("[")
		word = datetime.datetime.strptime(line[start+1:start+12], "%d/%b/%Y").strftime("%Y-%m")
		sys.stdout.write("{}\t1\n".format(word))

