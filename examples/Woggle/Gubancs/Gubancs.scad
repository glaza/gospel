
use <threads-library-by-cuiso-v1.scad>
use <Liliom.scad>

GUBANCS_DIA = 32;
GUBANCS_HOLE_DIA = 20;
GUBANCS_TOP_SLICING = 0;
GUBANCS_BOTTOM_SLICING = 4.5;
SCREW_DIA = 12;
SCREW_LENGTH = GUBANCS_DIA - 6;
SCREW_POINT = 3.5;


gubancs();


module gubancs() {
    difference() {
        union() {
            sphere(d=GUBANCS_DIA, $fn=50);
            spikes();
        }
        
        // Vertical Hole
        cylinder(d=GUBANCS_HOLE_DIA, h=100, center=true, $fn=50);
        
        // Screw Thread
        rotate([90, 0, 0]) 
        thread_for_nut(diameter=SCREW_DIA, length=20);
       
        // Screw landing pad
        translate([0, GUBANCS_HOLE_DIA/2, 0])
        rotate([90, 0, 0])
        cylinder(d=SCREW_DIA + 2, h=10, $fn=20);
        
        // Rim
        translate([0, 0, GUBANCS_BOTTOM_SLICING - GUBANCS_DIA])
        cube(GUBANCS_DIA, center=true);
        
        translate([0, 0, GUBANCS_DIA - GUBANCS_TOP_SLICING])
        cube(GUBANCS_DIA, center=true);
    }
}

module spikes() {
    spike_row(32);
    spike_row(15.5, 33.75);
    spike_row(-2);
    spike_row(-19.5, 33.75);
    spike_row(-37);
}

module spike_row(phy, phase = 0) {
    for(theta = [-45:67.5:235]) {
        if (theta + phase < 235 && !(abs(phy) < 10 && theta == 90)) {
            rotate([0, 0, theta + phase])
            rotate([0, phy, 0])
            translate([GUBANCS_DIA/2, 0, 0])
            spike();
        }
    }
}

module spike(height = 0.5) {
    rotate([0, 90, 0])
    cylinder(r1=3, r2=2, h=height, center=true, $fn=20);
    
    translate([height, 0, 0])
    rotate([0, 90, 0])
    cylinder(r1=2, r2=1.4, h=height, center=true, $fn=20);
    
    translate([2*height, 0, 0])
    rotate([0, 90, 0])
    cylinder(r1=1.4, r2=1, h=height, center=true, $fn=20);
    
    translate([2.5*height, 0, 0])
    sphere(1, $fn=20);
}
