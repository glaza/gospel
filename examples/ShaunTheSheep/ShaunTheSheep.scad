include <../gospel.scad>


//retainer();
x(80) z(50) head();
z(53) body();
legs();


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


module legs() {
    dy() {
        xy(-30) {
            rz(45) leg();
            foot();
        }
        
        xy(30) {
            rz(-135) leg();
            foot();
        }
    }
}


module body() {
    CLOUD_DIAMETER=30;
    CLOUD_MAX_DIVISOR=0.8;
    CLOUD_THETA_SCALE=0.7*CLOUD_MAX_DIVISOR;
    CLOUD_STEPS=180;
      
    white()
    sx(0.6)
    sy(0.7)
    sz(0.5)
    x(-CLOUD_STEPS/2)
    for(layer=[0:15:CLOUD_STEPS]) {
        for(theta=[0:360/5*(CLOUD_MAX_DIVISOR-CLOUD_THETA_SCALE*sin(layer)):360]) {
            x(CLOUD_STEPS*(0.5+0.5*sin(layer-90)))
            rx(theta)
            y(10+50*sin(layer))
            sphere(d=CLOUD_DIAMETER);
        }
    }
}




module leg() {
    z(1)
    ry(7.5)
    cylinder(d=10, h=30, $fn=50);
}


module foot() {
    difference() {
        sphere(d=20, $fn=50);
        z(-10)
        cube([20,20,20], center=true);
        x(10)
        cylinder(d=5, h=10, $fn=20);
    }
}


module retainer() {
    cube([78.5, 70, 27.5], center=true);
}