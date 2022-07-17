use <../../../gospel.scad>

$fn = 50;
LAYER = 0.2;
OUTER_RADIUS = 10;
INNER_RADIUS = OUTER_RADIUS-1.4;
OUTER_DIAMETER = 2*OUTER_RADIUS;

MAGNET_HEIGHT = 4;
MAGNET_DIAMETER = 11;
MAGNET_MARGIN = 7;
MAGNET_DEPTH = 2*LAYER;

HEIGHT = MAGNET_DIAMETER + 4*MAGNET_DEPTH;

#body();

magnet();

module body() {
    difference() {
        y(MAGNET_HEIGHT/2 + MAGNET_DEPTH - LAYER)
        cube([OUTER_DIAMETER-2*MAGNET_DEPTH, MAGNET_HEIGHT+MAGNET_DEPTH, HEIGHT], center=true);
        
        magnet();
    }
        
    sy(2) {
        difference() {
            cylinder(h=HEIGHT, r=OUTER_RADIUS, center=true);
            cylinder(h=HEIGHT+1, r=INNER_RADIUS, center=true);
            y(-50) cube([100,100,100], center=true);
        }
        
        //sz(3) s(25) import("Braid3.stl");
        //sz(4) s(24.5) import("Braid4.stl");
    }
}

module magnet() {
    y(MAGNET_HEIGHT/2 + MAGNET_DEPTH)
    rx(90)
    cylinder(h=MAGNET_HEIGHT, d=MAGNET_DIAMETER, center=true);
}


red() strand(0);
//color("lightpink", 0.5) rz(0) strand(60);
//color("crimson", 0.5) rz(0) strand(90);
blue() strand(120);
green() strand(240);


RING_RADIUS = 40;
AMPLITUDE = 5;
module strand(phase) {
    rz(phase)
    for (angle = [0:360]) {
        rz(angle-phase)
        ry(AMPLITUDE*sin((angle-phase)*5))
        x(RING_RADIUS+AMPLITUDE*sin((angle+phase)*5))
        cube(1);
    }
//    r(t) =ringRadi+ellipseWidth+ellipseWidth(sin(periods2t))
//    θ(t) =t
//    z(t) =ellipseHeightfudgeFactorcos(periods/2*t)^2
//    Domain: 0:360
}


RING_RADIUS = 40;
ELLIPSE_HEIGHT = 10;
ELLIPSE_WIDTH = 20;
function strandXY(angle) = 5;