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

#!body();

magnet();

module body() {
    difference() {
        y(MAGNET_HEIGHT/2+MAGNET_DEPTH)
        cube([OUTER_DIAMETER-2*MAGNET_DEPTH, MAGNET_HEIGHT+2*MAGNET_DEPTH, HEIGHT], center=true);
        
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
