include <../gospel.scad>

DESK_WIDTH = 1500;
DESK_HEIGHT = 640;
DESK_DEPTH = 750;
DRAWER_HEIGHT = 150;
FRAME_WIDTH = 100;
MONITOR_SIZE = [610, 50, 430];
PANEL_SIZE = [590, 25, 410];
MONITOR_STAND_RADIUS = 25;
MONITOR_STAND_HEIGHT = 100;
PLYWOOD_THICKNESS = 20;
SHELF_SIZE = [DESK_WIDTH - 400, 200, PLYWOOD_THICKNESS];

LIGHT_WOOD = "#deb887";
MEDIUM_WOOD = "#8b6914";
DARK_WOOD = "#443022";
DRAWRS_COLOR = LIGHT_WOOD;



color("dimgrey")
legs(DESK_WIDTH, DESK_HEIGHT);

color(DARK_WOOD)
z(DESK_HEIGHT)
top([DESK_WIDTH, DESK_DEPTH, PLYWOOD_THICKNESS]);

x(DESK_WIDTH/2)
y(MONITOR_SIZE.y-DESK_DEPTH/2)
z(DESK_HEIGHT + 100) {
    monitor();
    
    // Monitor Stand
    color("black")
    z(-150)
    cylinder(r=MONITOR_STAND_RADIUS, h=300, center = true);
}

x(SHELF_SIZE.x/2 + 200)
y(-250)
z(DESK_HEIGHT + 100)
sz(-1) {
    color("navy")
    shelf();
    color("black")
    shelf_legs();
}

x(SHELF_SIZE.x/2 + 200)
y(-250)
z(DESK_HEIGHT - 200) {
    color("navy")
    shelf();
    color("black")
    shelf_legs();
}

module monitor() {
    z(MONITOR_SIZE.z / 2)
    z(MONITOR_STAND_HEIGHT) {
        difference() {
            color("black")
            cube(MONITOR_SIZE, center = true);
    
            y(20)
            cube(PANEL_SIZE, center = true);
        }
        
        color("white")
        cube(PANEL_SIZE, center = true);
    }
    
    color("black")
    z(MONITOR_STAND_HEIGHT/2)
    cylinder(r=MONITOR_STAND_RADIUS, h=MONITOR_STAND_HEIGHT, center = true);
}

module shelf() {
    cube(SHELF_SIZE, center = true);
}
module shelf_legs() {
    for (i = [-1:2:1]) {
        for (j = [-1:2:1]) {
            x(i*0.95*SHELF_SIZE.x/2)
            y(j*0.8*SHELF_SIZE.y/2)
            color("black")
            cylinder(h=200, r=10);
        }
    }
}

module top(size=[1,1,1]) {
    y(-size.y/2) cube(size);
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