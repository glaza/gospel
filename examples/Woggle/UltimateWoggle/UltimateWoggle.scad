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
cover();

module cover()
{
    difference()
    {
        cylinder(d = RING_DIAMETER + 3, h = COVER_HEIGHT, center = true);
        
        cylinder(d = HOLE_DIAMETER, h = COVER_HEIGHT + 1, center = true);
        translate([0, 0, -2]) cylinder(d = RING_DIAMETER + 1, h = COVER_HEIGHT, center = true);
    }
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