/**
 * GOSPEL: George's OpenSCAD Procedural Enhancement Library
 * @author glaza
 *
 * Index:
 *      Translation: x, y, z, xy, xz, yz, xyz (displacement, variation)
 *      Scaling:     sx, sy, sz, sxy, sxz, syz, s (factor, variation)
 *      Rotation:    rx, ry, rz (angle, variation)
 *      Duplication: dx, dy, dz ()
 */

/**
 * Translates the children in the X,Y,Z direction
 * @param d Displacement in X,Y,Z direction
 * @param variation The random variation + or - added to the displacement * 
 *  x      Translate X
 *  y      Translate Y
 *  z      Translate Z
 *  xy     Translate equaly in X and Y
 *  xz     Translate equaly in X and Z
 *  yz     Translate equaly in Y and Z
 *  xyz    Translate equaly in X, Y and Z
 */
function rand(value, variation=0) = value + rands(-variation,variation,1)[0]; 
 
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
 *  rx     Rotate around X
 *  ry     Rotate around Y
 *  rz     Rotate around Z
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
    rotate([0,angle+v,0])
    children();
}
module rz(angle, variation=0) 
{   
    v = rands(-variation,variation,1)[0];
    rotate([0,0,angle+v])
    children();
}

/**
 * Duplicates the children across the different planes.
 *      dx: YZ plane, dy: XZ plane, dz: XY plane
 */
module dx() 
{
    mirror([1,0,0])
    children();

    children();
}
module dy() 
{
    mirror([0,1,0])
    children();

    children();
}
module dz() 
{
    mirror([0,0,1])
    children();

    children();
}

/**
 * Mirrors across diferent planes.
 *      mx: YZ plane, my: XZ plane, mz: XY plane
 */
module mx() 
{
    mirror([1,0,0])
    children();
}
module my() 
{
    mirror([0,1,0])
    children();
}
module mz() 
{
    mirror([0,0,1])
    children();
}

/**
 * Scales in different directions
 *      mx: YZ plane, my: XZ plane, mz: XY plane
 */
module sx(factor, variation=0) 
{
    scaleFactor = rand(factor, variation);
    scale([scaleFactor,1,1])
    children();
}
module sy(factor, variation=0) 
{
    scaleFactor = rand(factor, variation);
    scale([1,scaleFactor,1])
    children();
}
module sz(factor, variation=0) 
{
    scaleFactor = rand(factor, variation);
    scale([1,1,scaleFactor])
    children();
}
module sxy(factor, variation=0) 
{
    sx(factor, variation)
    sy(factor, variation)
    children();
}
module syz(factor, variation=0) 
{
    sz(factor, variation)
    sy(factor, variation)
    children();
}
module sxz(factor, variation=0) 
{   
    sx(factor, variation)
    sz(factor, variation)
    children();
}
module s(factor, variation=0) 
{   
    sxy(factor, variation)
    sz(factor, variation)
    children();
}

/**
 * Shortcuts
 */
module diff() //does not work
{
    difference()
    {
        children();
    }
}


/**
 * Colours
 */
module red()     { color("Red") children(); }
module blue()    { color("RoyalBlue") children(); }
module green()   { color("Green") children(); }
module black()   { color("Black") children(); }
module white()   { color("White") children(); }
module cyan()    { color("Cyan") children(); }
module magenta() { color("Magenta") children(); }
module yellow()  { color("Yellow") children(); }
module glass()   { color([0.5, 0.5, 1], 0.25) children(); }

/**
 * shapes
 * @param size A vector passed to the cube
 * @param r The radius of the sphere
 * @param half Whether all corners or only top ones
 */
module rounded(size, r, half)
{
    radius = half
        ? min(r, 0.999*min(size[0]/2, size[1]/2, size[2]))
        : min(r, 0.999*min(size)/2);
    
    diameter = 2*radius;
    width = size[0] - diameter;
    height = size[1] - diameter;
    depth = half 
        ? (size[2] - radius) 
        : size[2] - diameter;
    shift = half ? radius : 0; 
    
    intersection()
    {
        z(-shift)
        xyz(radius)
        minkowski()
        {
            sphere(radius);
            cube([width,height,depth]);
        }
        
        cube(size);
    }
}
