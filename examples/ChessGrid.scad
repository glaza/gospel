include <../gospel.scad>

$fn = 25;
THICK = 1;
GAP = 0.25;
EDGE = 23.5;
WALL = EDGE - THICK;
LONG_WALL = 2*EDGE;
DEPTH = 10;
SHAFT = 3.5;
WIRE = 1.5;
REED_DIA = 2.5;
REED_LENGTH = 16;
SHORT_WALL = EDGE - SHAFT/2;
FINS = 2;


//for (row = [0 : 1]) {
//    for (col = [0 : 1]) {
//        x(col*2.0*EDGE) y(row*2.0*EDGE) square();
//    }
//}
square();

module square() {
    blue() y(EDGE/2) z(DEPTH/2)
    cube([THICK, WALL, DEPTH], center = true);
    
    magenta() y(-EDGE/2) z(DEPTH/2 - REED_DIA/2)
    cube([THICK, EDGE - 2*SHAFT + GAP, DEPTH - REED_DIA], center = true);
    
    red() x(THICK/2) z(DEPTH/2)
    cube([LONG_WALL, THICK, DEPTH], center = true);
    
    green() x(EDGE) y(-THICK/2) z(DEPTH/2)
    cube([THICK, LONG_WALL, DEPTH], center = true);
    
    yellow() x(THICK/2) y(-EDGE) z(DEPTH/2)
    cube([LONG_WALL, THICK, DEPTH], center = true);

    cyan() dy() x(EDGE + FINS/2) y(THICK + GAP/2) z(DEPTH/2 - REED_DIA/2)
    cube([FINS, THICK, DEPTH - REED_DIA], center = true);
    
    white() dx() x(THICK + GAP/2) y(-EDGE - FINS/2) z(DEPTH/2 - REED_DIA/2)
    cube([THICK, FINS, DEPTH - REED_DIA], center = true);
    
    magenta() x(EDGE - THICK - GAP/2) y(-EDGE - FINS/2) z(DEPTH/2 - REED_DIA/2)
    cube([THICK, FINS, DEPTH - REED_DIA], center = true);
    
    blue() x(-EDGE + THICK) y(-EDGE - FINS/2) z(DEPTH/2 - REED_DIA/2)
    cube([THICK, FINS, DEPTH - REED_DIA], center = true);
    
    red() x(EDGE + FINS/2) y(-EDGE + THICK + GAP/2) z(DEPTH/2 - REED_DIA/2)
    cube([FINS, THICK, DEPTH - REED_DIA], center = true);
   
    white() x(EDGE + FINS/2) y(EDGE - FINS - THICK/2 - GAP/2) z(DEPTH/2 - REED_DIA/2)
    cube([FINS, THICK, DEPTH - REED_DIA], center = true);
   
    
    y(-SHAFT/2) well();
    y(SHAFT/2-EDGE) well();
    
//    y(-EDGE/2) z(DEPTH - REED_DIA/2) rx(90)
//    cylinder(h = REED_LENGTH, d = REED_DIA, center = true);
}

module well() {
    difference() {
        cylinder(h = DEPTH - REED_DIA, d = SHAFT);
        cylinder(h = DEPTH - REED_DIA + 1, d = WIRE);
    }
}

module half_well() {
    
    intersection() {
        well();
        x(-SHAFT/2) cube([SHAFT, SHAFT, DEPTH]);
    }
}