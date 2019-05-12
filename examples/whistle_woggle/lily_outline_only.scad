include <../../gospel.scad>;
use <liliom_simplified.scad>

module outline()
{
    z( 4.75 )
    linear_extrude( height = 1, center = true )
    sxy( 0.75 )
    x( 76.5 ) y( -100 )
    liliom_outline();    
}

outline();
