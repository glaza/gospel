include <../../gospel.scad>

$fn = 50;

tolerance = 2;
wall_thickness = 3;
deck_width = 67 + tolerance;
deck_height = 25 + 2 * tolerance;
deck_depth = 93 + tolerance;
block_depth = deck_depth + 1 * wall_thickness;
magnet_depth = 4;
magnet_diameter = 11;
magnet_offset = 1;

// hight = 96
z( 98.5 )
mx()
mz()
difference()
{
    import( "CylinderContainer.stl", convexity = 3 );
    cube( [ 100, 100, 169 ], center = true );
}

difference()
{
    import( "CylinderContainer.stl", convexity = 3 );
    cube( [ 100, 100, 28 ], center = true );
}
// Bottom
cylinder( h = wall_thickness,
          d = 0.92*1.2 * deck_width );

blue()
x( -deck_width/2 )
y( -deck_height/2 )
z( wall_thickness )
cube( [ deck_width, deck_height, deck_depth ] );

/*
difference()
{
    // outer cylinder
    cylinder( h = deck_depth,
              d = 1.2 * deck_width );
    
    // card deck
    x( -deck_width/2 )
    y( -deck_height/2 )
    z( wall_thickness )
    cube( [ deck_width, deck_height, deck_depth ] );
    
    // inner cyl cut-out
    difference()
    {
        z( wall_thickness )
        cylinder( h = deck_depth,
                d = 1.2 * deck_width - 2 * wall_thickness );
        
        x( -1.2*deck_width/2 )
        y( -1.2*deck_height/2 )
        z( wall_thickness )
        cube( [ 1.2*deck_width, 1.2*deck_height, deck_depth ] );
    }
}
*/