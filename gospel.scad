/**
 * GOSPEL: George's OpenSCAD Procedural Enhancement Library
 * @author glaza
 */


/**
 * Translates the children in the X,Y,Z direction
 * @param dx Displacement in X,Y,Z direction
 * @param variation The random variation + or - added to dx
 */
module x(dx, variation=0) 
{   
    vx = rands(-variation,variation,1)[0];
    translate([dx+vx,0,0])
    children();
}
module y(dy, variation=0) 
{   
    vy = rands(-variation,variation,1)[0];
    translate([0,dy+vy,0])
    children();
} 
module z(dz, variation=0) 
{   
    vz = rands(-variation,variation,1)[0];
    translate([0,0,dz+vz])
    children();
}
module xy(d, variation=0) 
{   
    x(d, variation)
    y(d, variation)
    children();
}
module yz(d, variation=0) 
{   
    z(d, variation)
    y(d, variation)
    children();
}
module xz(d, variation=0) 
{   
    x(d, variation)
    z(d, variation)
    children();
}
module xyz(d, variation=0) 
{   
    xy(d, variation)
    z(d, variation)
    children();
}

/**
 * Rotates the children around the X axis
 * @param angle Degrees to rotate around the X axis
 * @param variation The random variation + or - added
 */
module rx(angle, variation=0) 
{   
    v = rands(-variation,variation,1)[0];
    rotate([angle+v,0,0])
    children();
}
module ry(angle, variation=0) 
{   
    v = rands(-variation,variation,1)[0];
    rotate([0,angle+v,0,0])
    children();
}
module rz(angle, variation=0) 
{   
    v = rands(-variation,variation,1)[0];
    rotate([0,0,angle+v])
    children();
}

/**
 * Duplicates the children across the XZ plane
 */
module dupx() 
{
    mirror([1,0,0])
    children();

    children();
}
module dupy() 
{
    mirror([0,1,0])
    children();

    children();
}

/**
 * Colours
 */
module red()
{
    color("red")
    children();
}