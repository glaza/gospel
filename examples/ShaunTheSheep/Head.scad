include <../../gospel.scad>

head();

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
