include <../gospel.scad>;

DEPTH          =  5;
SEGMENT_RADIUS =  6;
SEGMENT_WIDTH  = 10;
SEGMENT_HEIGHT = 20;
TOLERANCE      = 0.4;
WALL_THICKNESS =  2;
SOCKET_RADIUS  = SEGMENT_RADIUS + TOLERANCE;
SOCKET_WIDTH   = SEGMENT_WIDTH * 2.5;
SOCKET_HEIGHT  = SEGMENT_HEIGHT + SOCKET_RADIUS*2;
TOTAL_HEIGHT   = SEGMENT_HEIGHT + 1.5*SEGMENT_WIDTH;
HOLE_WIDTH     = TOTAL_HEIGHT - SOCKET_WIDTH;

//one_segment();
dupx()
seven_segment();

module seven_segment()
{
    x(TOTAL_HEIGHT+SOCKET_WIDTH/2)
    y(SOCKET_WIDTH/2)
    {
        one_segment();

        y(TOTAL_HEIGHT)
        one_segment();

        x(-TOTAL_HEIGHT)
        one_segment();

        x(-TOTAL_HEIGHT)
        y(TOTAL_HEIGHT)
        one_segment();

        rz(90)
        one_segment();

        y(TOTAL_HEIGHT)
        rz(90)
        one_segment();

        y(TOTAL_HEIGHT*2)
        rz(90)
        one_segment();

        // Fills
        // Bottom Hole
        x(-TOTAL_HEIGHT+SOCKET_WIDTH/2)
        y(SOCKET_WIDTH/2)
        cube([HOLE_WIDTH,HOLE_WIDTH,DEPTH]);

        // Top Hole
        x(-TOTAL_HEIGHT+SOCKET_WIDTH/2)
        y(TOTAL_HEIGHT+SOCKET_WIDTH/2)
        cube([HOLE_WIDTH,HOLE_WIDTH,DEPTH]);

        // Corners
        intersection()
        {
            x(-TOTAL_HEIGHT-SOCKET_WIDTH/2)
            y(-SOCKET_WIDTH/2)
            cube([TOTAL_HEIGHT+SOCKET_WIDTH,
                2*TOTAL_HEIGHT+SOCKET_WIDTH,
                DEPTH]);

            union()
            {
                // Right
                corners();

                // Left
                x(-TOTAL_HEIGHT)
                mirror([1,0,0])
                corners();
            }
        }
    }
}

module corners()
{
    // Bottom Right
    rz(-45)
    y(-SOCKET_WIDTH)
    cube([2*SOCKET_WIDTH,2*SOCKET_WIDTH,DEPTH]);

    // Top Right
    y(2*TOTAL_HEIGHT)
    rz(45)
    y(-SOCKET_WIDTH)
    cube([2*SOCKET_WIDTH,2*SOCKET_WIDTH,DEPTH]);

    // Center Right
    y(TOTAL_HEIGHT)
    rz(45)
    y(-2*SOCKET_WIDTH)
    cube([2*SOCKET_WIDTH,2*SOCKET_WIDTH,DEPTH]);
}

module one_segment()
{
    y(TOTAL_HEIGHT/2)
    {
        socket();
        segment();
    }
}

module segment()
{
    intersection()
    {            
        xy(-50)
        cube([100,100,DEPTH]);

        dupy()
        {
            // Body
            z(DEPTH/2)
            rx(-90)
            cylinder(r = SEGMENT_RADIUS,
                    h = SEGMENT_HEIGHT/2,
                    $fn = 100);

            // Tip
            z(DEPTH/2)
            y(SEGMENT_HEIGHT/2+SEGMENT_RADIUS)
            rx(90)
            cylinder(r1 = 0,
                    r2 = SEGMENT_RADIUS,
                    h = SEGMENT_RADIUS,
                    $fn = 100);
        }
    }
}

module socket()
{
    
    dupy()
    difference()
    {
        // Body
        difference()
        {
            x(-SOCKET_WIDTH/2)
            cube([SOCKET_WIDTH, 
                TOTAL_HEIGHT/2, 
                DEPTH]);

            dupx()
            y(TOTAL_HEIGHT/2)
            rz(-45)
            z(-TOLERANCE/2)
            cube([SOCKET_WIDTH, 
                SOCKET_HEIGHT/2, 
                DEPTH+TOLERANCE]);
        }
        // Body
        z(DEPTH/2)
        rx(-90)
        cylinder(r = SOCKET_RADIUS,
                h = SEGMENT_HEIGHT/2,
                $fn = 100);

        // Tip
        z(DEPTH/2)
        y(SEGMENT_HEIGHT/2 + SOCKET_RADIUS)
        rx(90)
        cylinder(r1 = 0,
                r2 = SOCKET_RADIUS,
                h = SOCKET_RADIUS,
                $fn = 100);
    }
}