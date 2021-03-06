#!/usr/bin/python3

import sys
import re
import os

TIME_LAPSE_CAMERA = True
CAMERA_Y_POSITION = 110 # Center
TIME_REMAINING = False
RETRACTION = 5 #mm
FILE_NAME_PREFIX = "p"

def fetch(regex, line):
    label_match = re.search("\\(\\?P\\<(?P<label>.+)\\>", regex)
    match = re.match(regex, line)
    if match:
        return match.group(label_match.group("label"))
    return None


def message(output_file, message, args):
    '''M117'''
    output_line(output_file, "M117 " + message.format_map(args))

def x(output_file, x, comment):
    '''G0 X'''
    output_line(output_file, "G0 F9000 X{0:d} ;GEO: {1}".format(x, comment))

def e(output_file, e, comment):
    '''G1 E'''
    output_line(output_file, "G1 F1800 E{0:.5f} ;GEO: {1}".format(e, comment))

def xy(output_file, x, y, comment):
    '''G0'''
    output_line(output_file, "G0 F9000 X{0:d} Y{1:d} ;GEO: {2}".format(x, y, comment))

def output_line(output_file, line):
    output_file.write(line + "\n")

def process(input_file, output_file):
    time_total = None
    time_left_seconds = 0
    time_left_minutes = 0
    last_g_line = None
    last_extruder_position = None

    for line in input_file:
        line = line.strip()

        if TIME_REMAINING:
            if not time_total:
                time_total = fetch(";TIME:(?P<time_total>\\d*)", line)

            time_elapsed = fetch(";TIME_ELAPSED:(?P<time_elapsed>\\d*)", line)
            if time_elapsed:
                time_left = float(time_total) - float(time_elapsed)
                time_left_seconds = time_left % 60
                time_left_minutes = time_left // 60

                output_line(output_file, line)
                message(output_file, 
                        "{percent:2.1%} " +
                        "{time_left_minutes:5.0f}m " +
                        "{time_left_seconds:2.0f}s",
                        {
                            'percent': float(time_elapsed) / float(time_total),
                            'time_left_seconds': time_left_seconds,
                            'time_left_minutes': time_left_minutes
                        })
                continue

        if TIME_LAPSE_CAMERA: 
            # Match a move or extrude line to save the last positions 
            #
            # Example G0 and G1 lines
            # -----------------------
            # G1 F1200 X97.996 Y131.371 E149.00487
            # G0 F6000 X97.561 Y131.428
            # G0 X95.882 Y124.631
            if re.match("G[01]( [FXYZE]\\d+(\\.\\d+)*)+", line):
                last_g_line = line
                e_matcher = re.match(".*E(?P<extruder_pos>\\d+\\.\\d+).*", line)
                if e_matcher:
                    last_extruder_position = float(e_matcher.group("extruder_pos"))

            # Match the layer index to insert the button press
            layer_index = fetch(";LAYER:(?P<layer_index>\\d*)", line)
            if layer_index:
                output_line(output_file, line)
                if last_extruder_position:
                    e(output_file,
                      last_extruder_position - RETRACTION,
                      "Retract {0:d}mm".format(RETRACTION))
                xy(output_file, 20, CAMERA_Y_POSITION, "Position the plate")
                x(output_file, 0, "Click the shutter button")
                x(output_file, 20, "Pause for just a bit")
                output_line(output_file, last_g_line)
                if last_extruder_position:
                    e(output_file, last_extruder_position, "Unretract 5mm")
                continue
            
            # Match the very last move line to ensure we stop pressing the button
            if re.match("G1 X0 Y220 ;Present print", line):
                output_line(output_file, line)
                output_line(output_file, "G1 X10 Y220 ;GEO: Stop pressing the sutter")
                continue
        
        # Nothing left to do, write out the line
        output_line(output_file, line)

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("usage: %s <GCode filename>" % sys.argv[0])
        sys.exit(1)

    file_path = sys.argv[1]
    if not os.path.isfile(file_path):
        print("File path %s does not exist. Exiting..." % file_path)
        sys.exit(1)

    input_file = open(file_path, "r")

    output_file = open(os.path.dirname(file_path) +
                       "/" + FILE_NAME_PREFIX +
                       os.path.basename(file_path), "w")
    process(input_file, output_file)
    input_file.close()
    output_file.close()
