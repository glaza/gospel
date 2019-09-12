include <../gospel.scad>

$fn = 100;
thickness = 2;

//cup();

z( -4 )
hook();





module cup()
{
    difference()
    {
        cylinder( h = 60, d1 = 60 + thickness, d2 = 72 + thickness );

        z( thickness )
        cylinder( h = 60, d1 = 60, d2 = 72 );
        
        punch_size = 10;
        z( thickness + 2 * punch_size / 2 )
        for ( i = [0:45:180] )
        {
            for ( j = [0:1.5 * punch_size:50] )
            {
                rz( i + 1.5 * j )
                z ( 0.75 * j )
                rx( 45 )
                cube( [100, punch_size, punch_size], center = true );
            }
        }
    }
}

module hook()
{
    xz( -20 )
    rx( 90 )
    difference()
    {
        cylinder( h = 10, d = 10, center = true );

        sz( 1.1 )
        z( -0.05 )
        cylinder( h = 10, d = 5, center = true );
    }

    cube_len = 17.5;
    x( -20 )
    z( -cube_len / 2 )
    cube( [8, 10, cube_len], center = true );
    
    difference()
    {
        z( -7.5 )
        x( -7.5 )
        ry( 45 )
        cube( [8, 10, 30], center = true );

        xy( -10 )
        cube([20,20,20]);
    }
    cylinder( h = thickness, d = 60 + thickness );
}