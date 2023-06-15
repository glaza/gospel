use <../../../gospel.scad>
use <Liliom.scad>

GUBANCS_DIA = 32;
GUBANCS_HOLE_DIA = 20;
GUBANCS_TOP_SLICING = 0;
GUBANCS_BOTTOM_SLICING = 4.5;
SCREW_DIA = 12;
SCREW_LENGTH = GUBANCS_DIA - 6;
SCREW_POINT = 3.5;

gubancs();
knob();

//s(0.75)
//y(20)
//difference() {
//    import("screw.stl", 3);
//    cube(40, center=true);
//}

module knob() {
    y(GUBANCS_HOLE_DIA/2) {
        rx(90)
        screw(d=SCREW_DIA, h=SCREW_LENGTH);
        
        y(-SCREW_LENGTH)
        rx(90)
        sxy(1.5)
        cserkesz_liliom();
        
//        y(-SCREW_LENGTH) s(1.5) import("Liliom.example.stl", 3);
    }
}

module gubancs() {
    difference() {
        union() {
            sphere(d=GUBANCS_DIA, $fn=50);
            spikes();
        }
        
        // Vertical Hole
        cylinder(d=GUBANCS_HOLE_DIA, h=100, center=true, $fn=50);
        
        // Screw Thread
        rx(90) thread(d=SCREW_DIA, h=20);
       
        // Screw landing pad
        y(GUBANCS_HOLE_DIA/2) rx(90)
        cylinder(d=SCREW_DIA + 2, h=10, $fn=20);
        
        // Rim
        z(GUBANCS_BOTTOM_SLICING-GUBANCS_DIA) cube(GUBANCS_DIA, center=true);
        z(GUBANCS_DIA-GUBANCS_TOP_SLICING) cube(GUBANCS_DIA, center=true);
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
            rz(theta + phase)
            ry(phy)
            x(GUBANCS_DIA/2)
            spike();
        }
    }
}

module spike(height = 0.5) {
    x(0) ry(90) cylinder(r1=3, r2=2, h=height, center=true, $fn=20);
    x(height) ry(90) cylinder(r1=2, r2=1.4, h=height, center=true, $fn=20);
    x(2*height) ry(90) cylinder(r1=1.4, r2=1, h=height, center=true, $fn=20);
    x(2.5*height) sphere(1, $fn=20);
}