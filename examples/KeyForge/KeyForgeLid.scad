include <../../gospel.scad>

$fn = 50;

tolerance = 3;
wall_thickness = 3;
magnet_depth = 4;
magnet_diameter = 11;
magnet_offset = 1;
block_depth = magnet_depth + 2 * magnet_offset;

difference()
{
    union()
    {
        //cylinder( h = block_depth,
        //          $fn=6,
        //          d = 140 );
        
        delta_step = 0.2; // final render
        //delta_step = 1; // debug
        for ( step = [0:delta_step:block_depth/*-delta_step*/] )
        {            
            z(step)
            //rz( 30*(cos((step/block_depth+1)*180) + 1) )
            //rz( -10*(cos((2*step/block_depth+1)*180) + 1) )
            sy( 1 - 0.5 * step / block_depth )
            rz( 0 * step )
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
        
        dx() 
        x(60)
        cylinder( h = block_depth,
                  d = magnet_diameter + 2 * magnet_offset );
    }   
        
    
    z( magnet_offset )
    union()
    {        
        inner_step = 0.2; // final render
        for ( in_step = [0:inner_step:block_depth-magnet_offset] )
        {            
            z(in_step)
            //rz( 30*(cos((step/block_depth+1)*180) + 1) )
            //rz( -10*(cos((2*step/block_depth+1)*180) + 1) )
            sx( 1.5 )
            sxy( 0.55 * in_step / block_depth )
            rz( 10 * ( block_depth - magnet_offset - in_step ) )
            linear_extrude( height = inner_step,
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
    
    // Magnet holes
    z( block_depth / 2 )
    dx()
    x( 60 )
    z( block_depth / 2 - magnet_depth - magnet_offset )
    cylinder( $fn = 100,
              d = magnet_diameter,
              h = magnet_depth );
    
}
