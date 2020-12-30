use <../../gospel.scad>
use <Head.scad>;

BODY_DIAMETER=130;
BODY_HEIGHT=100;
BOTTOM_THICKNESS=10;
LEG_HOLE_DIAMETER=5;
LEG_DIAMETER=10;
$fn=50;

sheep();

module sheep() {
    z(100) {
        x(20) head();
        white() body();
        bottom();
    }
    !legs();
}

module legs() {
    dy() leg();
    x(-50) dy() leg();
}

module leg() {
    z(100) ry(-90) rz(-20) z(0.25*BODY_HEIGHT) ry(-90) z(65) { 
        cylinder(d=LEG_HOLE_DIAMETER-0.25, h=10);
        z(5) for (i = [0:30])
        rx(0.4*i) z(0.9*i) rx(0.25*i) { 
            if (i<29) {
               cylinder(d=LEG_DIAMETER, h=1);
            } else {
                z(7.5) rz(180) rx(180) difference() {
                    sphere(d=20, $fn=50);
                    z(-10)
                    cube([20,20,20], center=true);
                    x(10)
                    cylinder(d=5, h=10, $fn=20);
                } 
            }
        }       
    }
}

module bottom() {
    ry(-90)
    intersection() {
        difference() {
            cylinder(d=BODY_DIAMETER+BOTTOM_THICKNESS, h=BODY_HEIGHT, $fn=100);
            z(-1) cylinder(d=BODY_DIAMETER, h=BODY_HEIGHT+2, $fn=100);
            
            // Leg holes
            rz(20) z(0.75*BODY_HEIGHT) ry(-90) cylinder(d=LEG_HOLE_DIAMETER, h=BODY_HEIGHT);
            rz(-20) z(0.75*BODY_HEIGHT) ry(-90) cylinder(d=LEG_HOLE_DIAMETER, h=BODY_HEIGHT);
            rz(20) z(0.25*BODY_HEIGHT) ry(-90) cylinder(d=LEG_HOLE_DIAMETER, h=BODY_HEIGHT);
            rz(-20) z(0.25*BODY_HEIGHT) ry(-90) cylinder(d=LEG_HOLE_DIAMETER, h=BODY_HEIGHT);
        }
        x(-BODY_DIAMETER) cylinder(d=1.5*BODY_DIAMETER, h=BODY_HEIGHT);
        
        z(0.6*BODY_HEIGHT) sz(1.35) ry(-90) cylinder(d=0.65*BODY_DIAMETER, h=2*BODY_HEIGHT);
    }
}

module body() {
    ry(-90)
    cylinder(d=BODY_DIAMETER, h=BODY_HEIGHT);
}

/*
module legs() {
    x(-50) 
    dy() {
        xy(-30) {
            rz(45) leg();
            foot();
        }
        
        x(25) y(31.5) {
            rz(-90) leg();
            foot();
        }
    }
}

module leg() {
    z(1)
    ry(10)
    cylinder(d=LEG_DIAMETER, h=25);
}


module foot() {
    difference() {
        sphere(d=20, $fn=50);
        z(-10)
        cube([20,20,20], center=true);
        x(10)
        cylinder(d=5, h=10, $fn=20);
    }
}*/