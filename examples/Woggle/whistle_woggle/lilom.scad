include <../../gospel.scad>;
use <liliom_simplified.scad>

module lily()
{
    y( -3 )
    difference()
    {
        intersection()
        {
            ry(-90)
            my()
            //blue()
            import("a-s1_print.stl", 10);
     
            cube([100,100,8.75], center=true);        
        }    
        y( -23 )
        cube([11,11,10], center=true);
    }

    difference()
    {
        minkowski()
        {
            linear_extrude( height = 1/*8.75*/, center = true )
            sxy( 0.75 )
            x( 76.5 ) y( -100 )
            liliom_background();
            
            sphere( $fn = 0, d = 8.75 - 0.8);
        }
        
        red()
        y( 3 )
        cube([8.75,44,10], center=true);
        
        
        y( 30 )
        rx( 90 )
        cylinder( $fn = 50, h = 50, d = 8, center = true );
    }
}

module outline()
{
    z( 4.75 )
    linear_extrude( height = 1, center = true )
    sxy( 0.75 )
    x( 76.5 ) y( -100 )
    liliom_outline();    
}


lily();

black()
outline();
