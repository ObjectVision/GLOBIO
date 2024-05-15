"""
Example:
Hello geodms module

Erik Oudejans ( Object Vision BV) - 04-2024 
"""

import sys
sys.path.append('C:/Program Files/ObjectVision/GeoDms15.0.1/')
import geodms

geodms_version = geodms.version()
print(f"Hello geodms({geodms_version}) module!")