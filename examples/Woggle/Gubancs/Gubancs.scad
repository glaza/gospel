use <../../../gospel.scad>

GUBANCS_DIA = 30;
GUBANCS_HOLE_DIA = 20;
SCREW_DIA = 12;
SCREW_LENGTH = 22;
SCREW_POINT = 3.5;

gubancs();
y(GUBANCS_HOLE_DIA/2) knob(SCREW_LENGTH);

//s(0.75)
//y(20)
//difference() {
//    import("screw.stl", 3);
//    cube(40, center=true);
//}

module knob(length) {
    rx(90) cylinder(d2=SCREW_DIA/1.5, d1=SCREW_DIA/8, h=SCREW_POINT, $fn=20);
    y(-SCREW_POINT) rx(90) screw(d=SCREW_DIA, h=length);
    y(-length-SCREW_POINT) s(1.25) import("Liliom.example.stl", 3);
}

module gubancs() {
    difference() {
        union() {
            sphere(d=GUBANCS_DIA, $fn=50);
            spikes();
        }
        
        cylinder(d=GUBANCS_HOLE_DIA, h=100, center=true, $fn=50);
        
        rx(90) thread(d=SCREW_DIA, h=20);
    }
}

module spikes() {
    for(theta = [30:60:360]) {
        for(phy = [-35:17.5:35]) {
            rz(theta + 1.75*phy)
            ry(phy)
            x(GUBANCS_DIA/2)
            spike();
        }
    }
}

module spike() {
    x(0) ry(90) cylinder(r1=3, r2=2, h=1, center=true, $fn=20);
    x(1) ry(90) cylinder(r1=2, r2=1.4, h=1, center=true, $fn=20);
    x(2) ry(90) cylinder(r1=1.4, r2=1, h=1, center=true, $fn=20);
    x(2.5) sphere(1, $fn=20);
}