include <../../gospel.scad>

$fn = 50;

tolerance = 3;
wall_thickness = 3;
block_depth = 15.5 + wall_thickness;
magnet_depth = 4;
magnet_diameter = 11;
magnet_offset = 1;

difference()
{
    union()
    {
        difference()
        {
            cylinder( h = block_depth,
                      $fn=6,
                      d = 140 );

            z( wall_thickness )
            cylinder( h = block_depth,
                      $fn=6,
                      d = 120 );
        }
        
        dx()
        x( 60 )
        cylinder( h = block_depth,
                  $fn=100,
                  d = magnet_diameter + 2 * wall_thickness );
    }
   
        
    // Magnet holes
    z( block_depth / 2 )
    dx() dz()
    x( 60 )
    z( block_depth / 2 - magnet_depth - magnet_offset )
    cylinder( $fn = 100,
              d = magnet_diameter,
              h = magnet_depth );
    
}



rz( 30 )
x( -2.5 )
cube( [5, 60, block_depth] );

rz( -90 )
x( -2.5 )
cube( [5, 53, block_depth] );

rz( 150 )
x( -2.5 )
cube( [5, 60, block_depth] );
