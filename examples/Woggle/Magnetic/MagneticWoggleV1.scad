use <../../gospel.scad>

$fn = 50;
HEIGHT = 40;
RADIUS = 23;
MAGNET_HEIGHT = 4;
MAGNET_DIAMETER = 11;
MAGNET_MARGIN = 7;
MAGNET_DEPTH = 1;
SCREW_DIAMETER = 10;
SCREW_HEIGHT = 12;

#!body();

rx(90)
bit();

dz()
y(MAGNET_HEIGHT/2+MAGNET_DEPTH)
z(HEIGHT/2-MAGNET_MARGIN) rx(90)
magnet();

module body() {
    intersection() {
        difference() {
            sx(0.3)
            cylinder(h=HEIGHT, r=RADIUS, center=true);

            // Half
            y(-50) cube([100,100,HEIGHT*1.1], center=true);

            // Hole
            intersection() {
                sy(0.90) sx(0.23)
                cylinder(h=HEIGHT*1.001, r=RADIUS, center=true);
                
                y(MAGNET_HEIGHT + 2*MAGNET_DEPTH)
                y(50) cube([100,100,HEIGHT*1.1], center=true);
            }            
            
            // Thread
            y(0.0001) rx(90)
            thread(SCREW_DIAMETER, MAGNET_HEIGHT+2*MAGNET_DEPTH, center=true);
      
            // Magnets
            dz()
            y(MAGNET_HEIGHT/2+MAGNET_DEPTH)
            z(HEIGHT/2-MAGNET_MARGIN) rx(90)
            magnet();
        }
        
        sz(0.875) ry(90)
        cylinder(h=HEIGHT, r=RADIUS, center=true);
    }
}

module magnet() {
    cylinder(h=MAGNET_HEIGHT, d=MAGNET_DIAMETER, center=true);
}

module bit() {
    difference() {
        screw(h=SCREW_HEIGHT, d=SCREW_DIAMETER, center=true);
        
        cube([2, SCREW_DIAMETER, 2], center=true);
    }
    
    z(-SCREW_HEIGHT)
    sz(2)
    s(0.75)
    sphere(d=SCREW_DIAMETER-1);
}

module whistle() {
    
}