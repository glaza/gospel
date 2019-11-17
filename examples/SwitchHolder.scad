include <../gospel.scad>

WALL = 2;

cube([33.5,42, WALL]);

difference()
{
    rx(-22)
    x(WALL) y(13.2) z(9.85)
    ry(-90)
    cylinder(r=16, $fn=3, h=WALL);

    z(-20)
    cube([10,60,40], center=true);
}


y(-WALL) z(-WALL-6.5)
cube([7.0,WALL,WALL+6.5+WALL]);

z(-6.5-WALL)
cube([7.0,1,WALL]);

y(42) z(-WALL-6.5)
cube([7.0,WALL,WALL+6.5+WALL]);

y(42-1) z(-6.5-WALL)
cube([7.0,1,WALL]);