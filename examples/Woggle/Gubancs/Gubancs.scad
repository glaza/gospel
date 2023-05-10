use <../../../gospel.scad>

$fn = 50;

gubancs();
knob();
y(-15) import("Liliom.stl", 3);

//s(0.75)
//y(20)
//difference() {
//    import("screw.stl", 3);
//    cube(40, center=true);
//}

module knob(length = 15) {
    rx(-90) cylinder(r1=2, r2=0.5, h=2);
    rx(90) screw(8, length);
}

module gubancs() {
    difference() {
        union() {
            sphere(r=10);
            spikes();
        }
        
        cylinder(r=6, h=50, center=true);
        
        rx(90) thread(8, 20);
    }
}

module spikes() {
    for(theta = [30:60:360]) {
        for(phy = [-40:20:40]) {
            rz(theta + 1.5*phy)
            ry(phy)
            x(10)
            spike();
        }
    }
}

module spike() {
    x(0) ry(90) cylinder(r1=2, r2=1.25, h=0.5, center=true);
    x(0.5) ry(90) cylinder(r1=1.25, r2=0.75, h=0.5, center=true);
    x(1) ry(90) cylinder(r1=0.75, r2=0.5, h=0.5, center=true);
    x(1.25) sphere(0.5);
}