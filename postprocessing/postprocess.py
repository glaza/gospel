#!/usr/bin/python3

import sys
import re
import os
TIME_LAPSE_CAMERA = True


def fetch(regex, line):
    label_match = re.search("\\(\\?P\\<(?P<label>.+)\\>", regex)
    match = re.match(regex, line)
    if match:
        return match.group(label_match.group("label"))
    return None


def message(output_file, message, args):
    '''M117'''
    output_file.write("M117 " + message.format_map(args))
    output_file.write("\n")


def x(output_file, x, comment):
    '''G0 X'''
    output_file.write("G0 X{0:d} ; {1}".format(x, comment))
    output_file.write("\n")


def xy(output_file, x, y, comment):
    '''G0'''
    output_file.write("G0 X{0:d} Y{1:d} ; {2}".format(x, y, comment))
    output_file.write("\n")

def output_line(output_file, line):
    output_file.write(line + "\n")

def process(input_file, output_file):
    time = None
    time_left_seconds = 0
    time_left_minutes = 0
    layer_count = None
    last_g_line = None

    for line in input_file:
        line = line.strip()

        if not time:
            time = fetch(";TIME:(?P<time_elapsed>\\d*)", line)

        if not layer_count:
            layer_count = fetch(";LAYER_COUNT:(?P<layer_count>\\d+)", line)

        # Example G0 and G1 lines
        # -----------------------
        # G1 F1200 X97.996 Y131.371 E149.00487
        # G0 F6000 X97.561 Y131.428
        # G0 X95.882 Y124.631
        if re.match("G[01]( [FXYZE]\\d+(\\.\\d+)*)+", line):
            last_g_line = line

        if re.match("G1 X0 Y220 ;Present print"):
            output_line(output_file, line)
            output_line(output_file, "G1 X10 Y220 ;Stop pressing the sutter")
            continue

        time_elapsed = fetch(";TIME_ELAPSED:(?P<time_elapsed>\\d*)", line)
        if time_elapsed:
            time_left = float(time) - float(time_elapsed)
            time_left_seconds = time_left % 60
            time_left_minutes = time_left // 60

            output_line(output_file, line)
            message(output_file, 
                    "{percent:2.1%} " +
                    "{time_left_minutes:5.0f}m " +
                    "{time_left_seconds:2.0f}s",
                    {
                        'percent': float(time_elapsed) / float(time),
                        'time_left_seconds': time_left_seconds,
                        'time_left_minutes': time_left_minutes
                    })
            continue

        layer_index = fetch(";LAYER:(?P<layer_index>\\d*)", line)
        if layer_index:
            output_file.write(line)
            output_file.write("\n")
            if TIME_LAPSE_CAMERA:
                xy(output_file, 20, 220, "Position the plate")
                x(output_file, 0, "Click the shutter button")
                x(output_file, 20, "Pause for just a bit")
                output_line(output_file, last_g_line)

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
                       "/processed_" +
                       os.path.basename(file_path), "w")
    process(input_file, output_file)
    input_file.close()
    output_file.close()
