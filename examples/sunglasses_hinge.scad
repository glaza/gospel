include <../gospel.scad>

$fn = 50;

mirror()
{
    y( 2.375 )
    difference()
    {
        cylinder( h = 2.5, d = 4.75 );
        cylinder( h = 2.5, d = 1.3 );
    }

    cube( [ 21 - 2.375, 1.3, 4 ] );

    x( 21 - 2.375 )
    y( 2.25 )
    rz( 175 )
    cube( [ 12, 1.25, 4 ] );

    x( 2 )
    cube( [ 3, 2.3, 2.5 ] );

    x( 6.0606 )
    y( 1.239 )
    rz( 135 )
    cube( [ 1.5, 1, 2.5 ] );
}