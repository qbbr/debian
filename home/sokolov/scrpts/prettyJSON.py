#!/usr/bin/env python
import sys
import simplejson as json

print json.dumps(json.loads(sys.stdin.read()), indent=4)

sys.exit(0)
