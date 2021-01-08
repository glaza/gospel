use <../../gospel.scad>

BODY_DIAMETER=130;
BODY_HEIGHT=100;
BOTTOM_THICKNESS=10;
LEG_HOLE_DIAMETER=5;
LEG_DIAMETER=10;
$fn=50;

sheep();

module sheep() {
    z(100) {
        x(20) !head();
        white() body();
        bottom();
        legs();
    }
}

module legs() {
    dy() leg();
    x(-50) dy() leg();
}

module leg() {
    ry(-90) rz(-20) z(0.25*BODY_HEIGHT) ry(-90) z(65) { 
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
            z(50) ry(-90) cylinder(d=50, h=BODY_HEIGHT+2, $fn=100);
            
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

module head() {
    ry(-90)
    cylinder(h=30, d1=44, d2=41);
    
    s(1.1) {
        difference() {
            ry(-100)
            minkowski() { // Convolve a sphere with a triangle
                sz(0.5)
                sphere(d=40); 
                
                sy(0.25, 0.5)
                cylinder(d=20, h=1, $fn=3);
            }
            
            nostrilDistance = rand(8, 3);
            dy()
            x(10) y(nostrilDistance) z(-10)
            sphere(d=5, $fn=20);
        }
        
        earRoll = rand(0, 25);
        earPitch = rand(-45, 25);
        sy(1, 0.25)
        dy()
        rx(earRoll)
        y(25)
        x(-earPitch/5)
        ry(earPitch)
        ear();
        
        mouthAngle = rand(-90, 60);
        rx(mouthAngle) y(25) z(-10)
        rx(-mouthAngle) mouth();
    }
}

module mouth() {
    ry(90)
    {
        rotate_extrude(angle=360, convexity = 4)
        x(7.5)
        circle(d=3, $fn=20);
        
        red()
        z(-1.5)
        cylinder(r=7.5, h=1);
        
        toothHeight = rand(3, 1);
        dx()
        white()
        for (tooth=[-5:2:5]) {
            x(2) y(tooth) 
            ry(90)
            cylinder(r=1, h=(4), $fn=10);
        }
    }
}


module ear() {
    sx(0.5)
    intersection() {
        cylinder(d=30, h=100);
        difference() {
            sphere(d=50);
            
            z(-3)
            sphere(d=50);
        }
    }
}
