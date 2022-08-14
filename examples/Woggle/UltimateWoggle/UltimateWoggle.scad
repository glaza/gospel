use <../../../3rd_party/threads-library-by-cuiso-v1.scad>

$fn = 100;

HEIGHT = 20;
HOLE_DIAMETER = 25;
RING_DIAMETER = 32;

KNOB_DIAMETER = 20;
SCREW_HOLE_DIAMETER = 12.5;
SCREW_DIAMETER = 12;
SCREW_LENGTH = 24.5;

COVER_HEIGHT = HEIGHT + 2;
COVER_INNER_DIAMETER = RING_DIAMETER + 1;

// Ring
color("cyan")
ring(
    height = HEIGHT,
    inner_diameter = HOLE_DIAMETER,
    outer_diameter = RING_DIAMETER,
    screw_diameter = SCREW_HOLE_DIAMETER
);

// Screw
color("white")
knob(height = 5, knob_diameter = KNOB_DIAMETER, screw_diameter = SCREW_DIAMETER, screw_length = SCREW_LENGTH);

// Cover
color("red", 0.5)
blank_cover();

union()
{   color("red")
    cover_cutout();
    //vader();
    //monster();
    //minion();
}

module blank_cover()
{
    difference()
    {
        cylinder(d = RING_DIAMETER + 3, h = COVER_HEIGHT, center = true);
        
        cylinder(d = HOLE_DIAMETER, h = COVER_HEIGHT + 1, center = true);
        
        translate([0, 0, -2])
        cylinder(d = COVER_INNER_DIAMETER, h = COVER_HEIGHT, center = true);
    }
}

// Has a bend that does not fit
module tooth()
{
    scale([0.45, 0.45, 0.45])
    rotate([14, 0, 0])
    translate([-4, -16, -90])
    import("Covers/tooth-2657612.stl", 3);
}

module vader()
{    
    scale(0.7)
    rotate([0, 0, 0])
    translate([-100, -95, -45])
    import("Covers/vader-1685408.stl");
}

module monster()
{    
    scale(0.5)
    rotate([0, 0, 0])
    translate([0, -11, -25])
    import("Covers/monster-154516.stl");
}

// Seems not to be manifold
module minion()
{
    scale(0.65)
    rotate([0, 0, 0])
    translate([-00, -10, -80])
    import("Covers/Minion_Dave-403110.stl");
}

module monster()
{    
    scale(0.5)
    rotate([0, 0, 0])
    translate([0, -11, -25])
    import("Covers/monster-154516.stl");
}

module cover_cutout()
{
    cylinder(d = HOLE_DIAMETER, h = 4*COVER_HEIGHT, center = true);
    
    translate([0, 0, COVER_HEIGHT/2-2])
    rotate([180, 0, 0])
    cylinder(d = COVER_INNER_DIAMETER, h = 5*COVER_HEIGHT);
}

module ring(height, inner_diameter, outer_diameter, screw_diameter)
{
    difference()
    {
        difference()
        {
            union()
            {
                // Outer ring
                chopped_ring(height, outer_diameter, inner_diameter, start = 0, end = 0.75);
               
                // Inner ring
                chopped_ring(height, outer_diameter, inner_diameter, start = 0, end = 0.85);
                
                // Screw landing pad
                translate([-13, 0, 0]) rotate([0, 90, 0])
                cylinder(d = SCREW_HOLE_DIAMETER, h = 2);
            }
            
            // Screw head cutout
            translate([0.7 * outer_diameter/2, 0, 0])
            cube([6, KNOB_DIAMETER + 2, height + 1], center = true);
        }

        // Screw Thread Hole
        rotate([0, 90, 0])
        thread_for_screw(diameter = screw_diameter, length = inner_diameter);
    }
}

module knob(height, knob_diameter, screw_diameter, screw_length)
{
    scale([1, 0.95, 0.95])
    translate([knob_diameter-6, 0, 0])
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
        
        thread_for_screw(diameter=screw_diameter, length=screw_length);
    }
}

module chopped_ring(height, outer_diameter, inner_diameter, start, end)
{
    difference()
    {
        // Outer Ring
        chopped_cylinder(height, outer_diameter, start, end);
        
        // Inner Ring Cutout
        scale([1, 1, 1.1])
        chopped_cylinder(height, inner_diameter, start, end - 0.05);
    }
}


module chopped_cylinder(height, diameter, start = 0, end = 1)
{
    intersection()
    {
        cylinder(h = height, d = diameter, center = true);

        translate([(start + (end - start)/2 - 0.5) * diameter, 0, 0])
        cube([(end - start) * diameter, diameter, height], center = true);
    }
}