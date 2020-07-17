include <../gospel.scad>


//retainer();
head();
z(53) body();
legs();


module head() {
    sphere(d=50);
}

module legs() {
    xy(-30) {
        rz(45) leg();
        foot();
    }
     
    x(-30) y(30) {
        rz(-45) leg();
        foot();
    }
    
    xy(30) {
        rz(-135) leg();
        foot();
    }
     
    x(30) y(-30) {
        rz(135) leg();
        foot();
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