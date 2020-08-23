include <../../gospel.scad>

ry(-90)
cylinder(h=30, d1=44, d2=41);

s(1.1)
head();

module head() {
    difference() {
        ry(-100)
        minkowski() {
            sz(0.5)
            sphere(d=40);
            sy(0.25)
            cylinder(d=20, h=1, $fn=3);
        }
        
        dy()
        x(10) y(-10) z(-10)
        sphere(d=5, $fn=20);
    }
    
    dy()
    rx(-10)
    ry(-20)
    ear();
    
    x(0) y(23) z(-10)
    mouth();
}

module mouth(){
    ry(90)    
    {
        rotate_extrude(angle=180, convexity = 4)
        x(7.5)
        circle(d = 3, $fn=20);
        
        red()
        z(-1.5)
        cylinder(r=7.5, h=1);
        
        dx()
        white()
        for (tooth=[-3:2:5]) {
            x(2) y(tooth) 
            ry(90)
            cylinder(r=1, h=4, $fn=10);
        }
    }
}


module ear() {
    y(25)
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




