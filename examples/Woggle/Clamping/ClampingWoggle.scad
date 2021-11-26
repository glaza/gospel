use <../../gospel.scad>

$fn = 50;
HEIGHT = 34;
OUTER_DIAMETER = 42;
BUTTON_DIAMETER = 26;
SHAFT_DIAMETER = BUTTON_DIAMETER + 2;
HOLE_DIAMETER = 20;
BUTTON_DEPTH = 17;

angle = 120;
mz() rz(90) y(16) bentSpring(angle);

button();

mz()
color("brown", 0.65) 
bodyTop();

mz()
color("brown", 0.65)
bodyBottom();

module bodyTop() {
    intersection() {
        difference() {
            cylinder(h=HEIGHT/2, d=OUTER_DIAMETER);
            
            // Vertical hole
            cylinder(h=3*HEIGHT, d=HOLE_DIAMETER, center=true);
            
            // Hole for sprint coil
            x(-16) z(-0.01) cylinder(h=7, d=6);
                    
            // Horizontal button shaft
            rx(90) cylinder(h=40, d=SHAFT_DIAMETER);
            sphere(d=SHAFT_DIAMETER);
            
            // Spring fixed arm groove
            x(-17) y(0) z(-0.01) rz(210) cube([2, 14, 7]);
            
            // Bottom handle groove
            intersection() {
                x(-1) y(-2) z(0) cylinder(h=7, d=OUTER_DIAMETER-5);
                union() {
                    y(15) cube([10, 10, 10], center = true);
                }
            }
        }
        sz(1) sphere(d=OUTER_DIAMETER);
    }
}

module bodyBottom() {
    intersection() {
        difference() {
            z(-HEIGHT/2) cylinder(h=HEIGHT/2, d=OUTER_DIAMETER);
            cylinder(h=3*HEIGHT, d=HOLE_DIAMETER, center = true);
            
            // Button shaft
            rx(90) cylinder(h=40, d=SHAFT_DIAMETER);
            sphere(d=SHAFT_DIAMETER);
            
            // Hole for sprint coil
            x(-16) z(-6.499) cylinder(h=6.5, d=6);
            
            // Spring swinging arm groove
            z(0.001) 
            intersection() {
                x(-1) y(-2) z(-6.5) cylinder(h=7, d=OUTER_DIAMETER-5);
                union() {
                    x(-95) z(-100) cube([100, 100, 100]);
                    y(15) cube([10, 10, 10], center = true);
                }
            }
        }
        sz(1) sphere(d=OUTER_DIAMETER);
    }
}

module spring(angle=0) {
    z(-6) {
        // Central Coil
        cylinder(h=12, d=5);

        // Bottom arm
        rz(angle/2) x(2) {
            z(0.5) rx(90) cylinder(h=19, d=1);
            y(-19) cylinder(h=9, d=1);
        }

        // Top Arm
        rz(-angle/2) x(-2) {
            z(11.5) rx(90) cylinder(h=19, d=1);
            z(12-9) y(-19) cylinder(h=9, d=1);
        }
    }
}


module bentSpring(angle=0) {
    z(-6) {
        // Central Coil
        cylinder(h=12, d=5);

        // Bottom arm
        rz(angle/2) x(2) {
            z(0.5) rx(90) {
                for (i = [1:18]) {
                    a = 2.5*i;
                    ry(-a) z(i) ry(-a) {
                        cylinder(h=1, d=1);
                        if (i == 18) rx(-90) y(-1) cylinder(h=9, d=1);
                    }
                }
            }
            
        }

        // Top Arm
        rz(-angle/2) x(-2) {
            z(11.5) rx(90) cylinder(h=19, d=1);
            z(12-9) y(-19) cylinder(h=9, d=1);
        }
    }
}
module button() {
    difference() {
        union() {
            rx(90) cylinder(h=BUTTON_DEPTH, d=BUTTON_DIAMETER);
            sphere(d=BUTTON_DIAMETER);
        }
        cylinder(h=OUTER_DIAMETER, d=HOLE_DIAMETER, center=true);
    }
}