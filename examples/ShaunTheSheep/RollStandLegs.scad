include <../gospel.scad>

DIAMETER=130;
THICKNESS=40;
HEIGHT=115;
BORDER_HEIGHT=10;
LEG_HEIGHT=40;
HOLE=42;

body();

dz() dx() leg();


module body() {
    intersection() {
        union() {
            bod(HEIGHT, DIAMETER, DIAMETER);

            dz()
            z(-HEIGHT/2-BORDER_HEIGHT/2)
            bod(BORDER_HEIGHT, DIAMETER-20, DIAMETER+1);
        }
        
        union() {
            dx()
            rz(60)
            y(DIAMETER/2+0.125*THICKNESS)
            cylinder(h=HEIGHT*2, d=0.75*THICKNESS, center=true);
            
            y(DIAMETER) cube([DIAMETER+THICKNESS/2,200,200], center=true);
        }
    }
}

module bod(height, diameter1, diameter2=diameter1) {
    difference() {
        cylinder(h=height,
                 d1=diameter1+THICKNESS,
                 d2=diameter2+THICKNESS,
                 center=true);
        cylinder(h=height+1,
                 d1=diameter1,
                 d2=diameter2,
                 center=true);
    }
}


module leg() difference() {
    z(0.25*DIAMETER)
    rz(-30)
    y(DIAMETER/2+THICKNESS/4+LEG_HEIGHT)
    rx(90)
    cylinder(h=LEG_HEIGHT, d1=10, d2=70);
    
    z(-50)
    y(DIAMETER/2+THICKNESS-16)
    cube([100,100,100]);
}