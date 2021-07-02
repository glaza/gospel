include <../gospel.scad>

$fn = 20;
THICK = 2;
SCREW = 6;
SCREW_HOLE = SCREW-2*THICK;
SIZE = [81, 63+27, 23];
INNER_SIZE = [SIZE.x-2*THICK, SIZE.y-2*THICK, SIZE.z];
USB_DIAMETER = 4;
USB_HEIGHT = 10;
KEY_HOLE = [14, 14, 14];
KEY_SPACING = KEY_HOLE.x + 5;
ENCODER_HOLE = 7;

z(SIZE.z)
lid();
bin();
//knobs();

module bin() {
    difference() {
        cube(SIZE, center=true);
        
        z(THICK) cube(INNER_SIZE, center=true);
        
        x(SIZE.x/2-THICK/2) z(2*THICK)
        cube([2*THICK, USB_DIAMETER, SIZE.z], center=true);
    }
    
    dx() dy()
    x(SIZE.x/2-SCREW/2)
    y(SIZE.y/2-SCREW/2)
    z(-SIZE.z/2)
    pin();
}

module pin() {
    difference() {
        cylinder(h=SIZE.z, d=SCREW);
        cylinder(h=2*SIZE.z, d=SCREW_HOLE);
    }
}

module lid() {
    difference() {
        cube([SIZE.x, SIZE.y, THICK], center=true);
            
        dx() dy()
        x(SIZE.x/2-SCREW/2)
        y(SIZE.y/2-SCREW/2)
        cylinder(h=2*SIZE.z, d=SCREW_HOLE);
        
        y(THICK-SIZE.y/2)
        for (i = [0:2]) {
            y(i*KEY_SPACING)
            dx()
            for (j = [0:1]) {
                x(KEY_SPACING/2 + j*KEY_SPACING)
                y(KEY_SPACING/2)
                cube(KEY_HOLE, center=true);
            }
        }
        
        for(e = [0:2]) {
            x((e-1)*SIZE.x/3)
            y(SIZE.y/2-KEY_SPACING+THICK)
            cylinder(h=2*SIZE.z, d=ENCODER_HOLE, center=true);
        }
    }
}

module knobs() {
    blue()
    z(SIZE.z+5)
    for(k = [0:2]) {
        x((k-1)*SIZE.x/3)
        y(SIZE.y/2-KEY_SPACING+THICK)
        cylinder(h=10, d=25, center=true);
    }
}