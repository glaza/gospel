use <../../gospel.scad>

$fn = 50;
HEIGHT = 34;
BUTTON_DIAMETER = 26;
SHAFT_DIAMETER = BUTTON_DIAMETER + 1;
OUTER_DIAMETER = SHAFT_DIAMETER + 3;
HOLE_DIAMETER = 20;
BUTTON_DEPTH = 16;
SPRING_HEIGHT = 4;
SPRING_DIAMETER = 7;

y(17) spring();

button();

color("brown", 0.65)
body();


module body() {
    difference() {
        sz(0.5) {
            y(-SPRING_HEIGHT/2) rx(90) cylinder(h=OUTER_DIAMETER-SPRING_HEIGHT, d=OUTER_DIAMETER, center=true);
            y(OUTER_DIAMETER/2-SPRING_HEIGHT) sy(0.6) sphere(d=OUTER_DIAMETER);
        }
        sz(0.5) {
            rx(90) cylinder(h=2*BUTTON_DEPTH, d=SHAFT_DIAMETER);
            cylinder(h=OUTER_DIAMETER, d=HOLE_DIAMETER, center=true);
            sphere(d=SHAFT_DIAMETER);
        }
        y(17) sy(1.5) spring();
    }
}

module spring() {
    rx(90)
    cylinder(h=SPRING_HEIGHT, d=SPRING_DIAMETER);
}

module button() {
    sz(0.5)
    difference() {
        union() {
            rx(90) cylinder(h=BUTTON_DEPTH, d=BUTTON_DIAMETER);
            sphere(d=BUTTON_DIAMETER);
        }
        cylinder(h=OUTER_DIAMETER, d=HOLE_DIAMETER, center=true);
    }
}