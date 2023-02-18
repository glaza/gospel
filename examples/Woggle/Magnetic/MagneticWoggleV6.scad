use <../../../gospel.scad>

$fn = 50;
HEIGHT = 46;
RADIUS = 26;

MAGNET_HEIGHT = 4;
MAGNET_DIAMETER = 11;
MAGNET_MARGIN = 7;
MAGNET_DEPTH = 0.9;

SCREW_DIAMETER = 10;
SCREW_LENGTH = 9;
SCREW_HEAD = [16, MAGNET_HEIGHT + MAGNET_DEPTH - 1, 19];

dz()
y(MAGNET_HEIGHT/2+MAGNET_DEPTH)
z(HEIGHT/2-MAGNET_MARGIN) rx(90)
magnet();

color("white")
!knob(height = SCREW_HEAD[1], knob_diameter = 0.9*SCREW_HEAD[2], screw_diameter = SCREW_DIAMETER, screw_length = SCREW_LENGTH);

//color("red", 0.2)
body();


module body() {
    intersection() {
        difference() {
            union() {
                difference() {
                    // Main circle
                    sx(0.3) cylinder(h=HEIGHT, r=RADIUS, center=true);
                    
                    // Shaft hole
                    intersection() {
                        sy(0.85) sx(0.2)
                        cylinder(h=HEIGHT*1.001, r=RADIUS, center=true);
                        
                        y(MAGNET_HEIGHT + 2*MAGNET_DEPTH)
                        y(50) cube([100,100,HEIGHT*1.1], center=true);
                    }
             
                    
                    // Magnet holes
                    dz()
                    y(MAGNET_HEIGHT/2+MAGNET_DEPTH)
                    z(HEIGHT/2-MAGNET_MARGIN) rx(90)
                    magnet();
                    
                    // Magnet insert holes
                    y(MAGNET_HEIGHT/2 + MAGNET_DEPTH)
                    cube([MAGNET_DIAMETER, MAGNET_HEIGHT, HEIGHT-2*MAGNET_MARGIN], center=true);
                }
                
                // Bump for screw
                y(MAGNET_HEIGHT + 2*MAGNET_DEPTH + SCREW_HEAD[1]/2)
                //cube([RADIUS/2, SCREW_HEAD[1], SCREW_HEAD[2]], center=true);
                y(0.3*MAGNET_HEIGHT) sz(1.25) ry(45) rx(90)
                cylinder(h=MAGNET_HEIGHT, d1=0.5*RADIUS, d2=0.75*RADIUS, $fn=4);
            }

            // Thread
            y(0.0001) rx(90)
            thread(SCREW_DIAMETER, SCREW_LENGTH + SCREW_HEAD[1], center=true);
            
            // Screw cutout
            y(SCREW_HEAD[1]/2) cube(SCREW_HEAD, center=true);
        }
        
        // Front circle
        sz(0.875) ry(90)
        cylinder(h=HEIGHT, r=RADIUS, center=true);
        
        // Half
        y(50) cube([100,100,HEIGHT*1.1], center=true);
    }
}

module magnet() {
    cylinder(h=MAGNET_HEIGHT, d=MAGNET_DIAMETER, center=true);
}

module bit() {
    difference() {
        screw(h=SCREW_LENGTH, d=SCREW_DIAMETER, center=true);
        
        cube([2, SCREW_DIAMETER, 2], center=true);
    }
    
//    z(-SCREW_LENGTH)
//    sz(2)
//    s(0.75)
//    sphere(d=SCREW_DIAMETER-1);
}

module knob(height, knob_diameter, screw_diameter, screw_length)
{
    rz(-90)
    scale([1, 0.95, 0.95])
    translate([height, 0, 0])
    rotate([0, -90, 0])
    {
        intersection()
        {
            union()
            {
                // Main head
                cylinder(h = height, d = knob_diameter);
                // Teeth
                for (angle = [0:30:360])
                {
                    rotate([0, 0, angle])
                    translate([knob_diameter/2, 0, 0])
                    cylinder(h = height, d = 0.1 * knob_diameter);
                }
            }
            
            // Cone shape
            cylinder(h = height, d2 = 1.75 * knob_diameter, d1 = 0.8 * knob_diameter);
        }
        
        //thread_for_screw(diameter=screw_diameter, length=screw_length);
    }
    
    rx(90)
    screw(h=SCREW_LENGTH, d=SCREW_DIAMETER, center=true);;
}
