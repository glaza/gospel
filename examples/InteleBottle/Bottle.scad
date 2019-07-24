include <../../gospel.scad>


draw_cover();
#draw_letters( "GLAZA" );

module draw_cover()
{
    rotate_extrude(angle = 360, convexity = 2)
    {   
        x(-39/2)    
        x(86.066)
        y(-134.32)
        polygon(
            points=
                [[-95.284, 92.363],
                 [-94.906, 97.675],
                 [-94.077, 103.715],
                 [-92.508, 111.475],
                 [-90.521, 118.736],
                 [-88.775, 123.684],
                 [-87.062, 127.491],
                 [-87.066, 134.32],
                 // inside
                 [-86.066, 134.32],
                 [-86.062, 127.491],
                 [-87.775, 123.684],
                 [-89.521, 118.736],
                 [-91.508, 111.475],
                 [-93.077, 103.715],
                 [-93.906, 97.675],
                 [-94.284, 92.363],
            ],
            paths=
                [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]]
        );
    }
}

module draw_letters( string )
{
    for ( letter = [string] )
    {
        y(-20)
        rx(90)
        linear_extrude(5)
        text(letter, font="Stencilia\\-Bold");
    }
}