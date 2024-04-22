"""
Example:
Runs GLOBIO geodms allocation for region Western-Europe
Shows how to change parameter 'LandusePriorityCodes' to '1|10|30|21|22'

Erik Oudejans ( Object Vision BV) - 04-2024 
"""

import sys

sys.path.append('/path/to/dms/installation') # python version 3.12.2

from geodms import *

def set_GLOBIO_input_dir(root, InDir:str):
    in_dir = root.find("/parameters/input/InDir")
    in_dir.set_expr(f'"{InDir}"')
    return

def set_GLOBIO_output_dir(root, OutDir:str):
    out_dir = root.find("/parameters/input/OutDir")
    out_dir.set_expr(f'"{OutDir}"')
    return

def run():
    try:
        dms_engine = Engine()
        dms_config = dms_engine.load_config('../prj/root.dms')
        root = dms_config.root()

        parameters = root.find("/parameters")
        if (parameters.is_null()):
            return

        param_LandusePriorityCodes = parameters.find("/parameters/input/LandusePriorityCodes")
        if (param_LandusePriorityCodes.is_null()):
            return

        # set in- and output directories
        set_GLOBIO_input_dir(root, "D:/SourceData/GLOBIO/input")
        set_GLOBIO_output_dir(root, "D:/SourceData/GLOBIO/output")

        # change parameter
        param_LandusePriorityCodes = parameters.find("/parameters/input/LandusePriorityCodes") 
        if (param_LandusePriorityCodes.is_null()):
            return

        # change expr
        param_LandusePriorityCodes.set_expr('"1|10|30|21|22"')

        # get example output: Western-Europe
        example_output = root.find("/Allocation/per_region/Western_Europe/MakeGrid/result")
        example_output.update()

    except Exception as e:
        input(f"Error: {e}")

if __name__ == "__main__":
    run()
