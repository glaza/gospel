include <../gospel.scad>

DESK_WIDTH = 1500;
DESK_HEIGHT = 640;
DESK_DEPTH = 750;
DRAWER_HEIGHT = 150;
FRAME_WIDTH = 100;

PLYWOOD_THICKNESS = 20;

LIGHT_WOOD = "#deb887";
MEDIUM_WOOD = "#8b6914";
DARK_WOOD = "#443022";
DRAWRS_COLOR = DARK_WOOD;


color("white")
legs(DESK_WIDTH, DESK_HEIGHT);

z(DESK_HEIGHT)
drawers([DESK_WIDTH, DESK_DEPTH, DRAWER_HEIGHT]);


z(DESK_HEIGHT+DRAWER_HEIGHT)
y(-DESK_DEPTH/2) rx(20) y(DESK_DEPTH/2)
top([DESK_WIDTH, DESK_DEPTH, PLYWOOD_THICKNESS]);


module top(size=[1,1,1]) {
    y(-size.y/2) {
        color(DRAWRS_COLOR)
        difference() {
            cube(size);
            
            x(FRAME_WIDTH) y(FRAME_WIDTH) z(-size.z)
            cube([size.x-2*FRAME_WIDTH, size.y-2*FRAME_WIDTH, 3*size.z]);
        }
        
        // Glass
        color("#8888FF", 0.25)
        x(FRAME_WIDTH) y(FRAME_WIDTH)
        cube([size.x-2*FRAME_WIDTH, size.y-2*FRAME_WIDTH, size.z]);
    }
}

module drawers(size=[1,1,1]) {
    y(-size.y/2) {
        color(DRAWRS_COLOR)
        drawer(size, false);
        
       
        xz(2*PLYWOOD_THICKNESS) {
            
            color("white")
            drawer([300, size.y-2*PLYWOOD_THICKNESS, size.z-2*PLYWOOD_THICKNESS]);
            
            color(DRAWRS_COLOR)
            x(300+1*PLYWOOD_THICKNESS) z(-PLYWOOD_THICKNESS)
            cube([PLYWOOD_THICKNESS, size.y, size.z-PLYWOOD_THICKNESS]);
            
            color("white")
            x(300+3*PLYWOOD_THICKNESS) y(-0)
            drawer([700, size.y-2*PLYWOOD_THICKNESS, size.z-2*PLYWOOD_THICKNESS]);
            
            color(DRAWRS_COLOR)
            x(1000+4*PLYWOOD_THICKNESS) z(-PLYWOOD_THICKNESS)
            cube([PLYWOOD_THICKNESS, size.y, size.z-PLYWOOD_THICKNESS]);
            
            color("white")
            x(1000+6*PLYWOOD_THICKNESS) y(-0)
            drawer([300, size.y-2*PLYWOOD_THICKNESS, size.z-2*PLYWOOD_THICKNESS]);
        }
    }
}

module drawer(size=[1,1,1], front=true) {
    difference() {
        cube(size);
        
        x(PLYWOOD_THICKNESS)
        y(-PLYWOOD_THICKNESS)
        z(PLYWOOD_THICKNESS)
        cube([size.x-2*PLYWOOD_THICKNESS, size.y, size.z]);
        
    }
    if (front) {
        difference() {
            cube([size.x, PLYWOOD_THICKNESS, size.z]);
            x(size.x/2 - 50) y(-0.1) z(40)
            cube([100, 2*PLYWOOD_THICKNESS, 30]);
        }
    }
}


module legs(width, height) {
    x(100) leg(height);
    x(100) y(-170/2) z(height-50) cube([width-200, 170, 50]);
    x(width-100) leg(height);
}

module leg(height) {
    // foot
    z(20) beveledCube([80, 700, 20], 100);
    z(20/2) cube([80, 700, 20], center = true);
    
    // leg
    z(height/2) cube([50, 100, height], center = true);
    
    // arm
    z(height) mz() beveledCube([80, height, 50], 500);    
}

module beveledCube(size=[1,1,1], bevel=0.25) {
    sx(size.x/size.y)
    sxy(sqrt(2))
    rz(45)
    cylinder(h=size.z, d1=size.y, d2=size.y-bevel,  $fn=4);
}