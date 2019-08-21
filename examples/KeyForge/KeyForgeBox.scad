include <../../gospel.scad>

$fn = 50;

tolerance = 3;
wall_thickness = 3;
deck_width = 67 + tolerance;
deck_height = 93 + tolerance;
deck_depth = 25 + 2 * tolerance;
block_depth = deck_depth + 1 * wall_thickness;
magnet_depth = 4;
magnet_diameter = 11;
magnet_offset = 1;

difference()
{
    // Outer shape
    union()
    {
        delta_step = 0.1; // final render
       // delta_step = 1; // debug
        for ( step = [0:delta_step:block_depth-delta_step] )
        {            
            z(step)
            //rz( 30*(cos((step/block_depth+1)*180) + 1) )
            rz( -10*(cos((2*step/block_depth+1)*180) + 1) )
            linear_extrude( height = delta_step,
                            convexity = 2,
                            //twist = 60/block_depth,
                            $fn = 100 ) 
            {
                circle(
                    $fn=6,
                    d = 140 );
            }
        }
    }
    
    // Deck well
    z( deck_depth / 2  + 1.01 * wall_thickness )
    cube( [deck_width, deck_height, deck_depth],
          center = true );
    
    dx()
    x( 35 )
    z( wall_thickness )
    cylinder( h = block_depth,
              $fn = 6,
              d = 35 );
    
    // Magnet holes
    z( block_depth / 2 )
    dx() dz()
    x( 60 )
    z( block_depth / 2 - magnet_depth - magnet_offset )
    cylinder( $fn = 100,
              d = magnet_diameter,
              h = magnet_depth );
    
    //cube([100,100,100]);
}

/*cylinder( h = 100,
          $fn = 6,
          d1 = 0,
          d2 = 0 );
*/