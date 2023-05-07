use <../../../gospel.scad>

$fn = 50;

RING_HEIGHT = 16;
RING_RADIUS = 25;
RING_WALL = 3;
RING_SCALE = 0.33;

SCREW_DIAMETER = 10;
SCREW_LENGTH = RING_RADIUS - 2.5*RING_WALL;

KNOB_WIDTH = 5;
KNOB_DIAMETER = 17;

GAP = 5;

color("red", 1)
dx() x(-GAP-KNOB_WIDTH/2) ring();

ry(90) middle();


module ring() {
    difference() {
        sy(RING_SCALE)
        difference() {
            cylinder(h=RING_HEIGHT, r=RING_RADIUS, center=true);
            difference() {
                sy(1-0.5*RING_SCALE)
                cylinder(h=RING_HEIGHT + 1, r=RING_RADIUS-RING_WALL, center=true);
                x(-RING_WALL) cutPlane();
            }
            cutPlane();
        }
        
        ry(90)
        thread(SCREW_DIAMETER, SCREW_LENGTH, center=true);
    }
}

module cutPlane() {
    x(50) cube([100, 100, 100], center=true);
}

module middle() {
    dz()
    z(KNOB_WIDTH/2)
    screw(h=SCREW_LENGTH, d=SCREW_DIAMETER);
    
    cylinder(h = KNOB_WIDTH, d = KNOB_DIAMETER, center=true);
    for (angle = [0:30:360])
    {
        rotate([0, 0, angle])
        translate([KNOB_DIAMETER/2, 0, 0])
        cylinder(h = KNOB_WIDTH, d = 0.1 * KNOB_DIAMETER, center=true);
    }
}
