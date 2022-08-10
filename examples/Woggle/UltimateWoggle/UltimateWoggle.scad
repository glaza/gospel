use <../../../3rd_party/threads-library-by-cuiso-v1.scad>
use <../../../3rd_party/whistle.scad>
use <../../../3rd_party/fillet.scad>

$fn = 100;

HEIGHT = 25;
HOLE_DIAMETER = 25;
KNOB_DIAMETER = 20;
SCREW_HOLE_DIAMETER = 12.5;
SCREW_DIAMETER = 12;
SCREW_LENGTH = 21.5;

rounding_radius = 2;
top_thinckness = 0;
mouthpiece_size = [10, 12, 2.5];

ww_length = mouthpiece_size[0] + 9;
ww_width  = mouthpiece_size[1] - 2;
ww_height = mouthpiece_size[2];

fi_length = mouthpiece_size[0] + 7;
fi_width  = mouthpiece_size[1] - 2;
fi_height = mouthpiece_size[2];
fi_inset = 4;

//translate([-10, 0, 0])
//rotate([-90, 0, 180])
//import("a-s1_print.stl");

color("salmon")
ring(height = HEIGHT, inner_diameter = HOLE_DIAMETER, screw_diameter = SCREW_HOLE_DIAMETER);

color("cyan")
knob(height = 5, knob_diameter = KNOB_DIAMETER, screw_diameter = SCREW_DIAMETER, screw_length = SCREW_LENGTH);

//// Boxy whislte
//union() 
//{
//    difference()
//    {
//        cube([25, 25, 25], center= true);
//        whistle_cutout(20, 20, 5);
//    }        // form fipple as a seperate piece
//    
//    translate([0, -20/2, -20/2])
//    fipple(20, 20);
//}

//module whistle_cutout(length, width, height)
//{
//    
//    translate([0, -width/2, -height/2])
//    {
//    //        body_part(length, width, height);
//            
//            cube([length, width, height-top_thinckness]);
//            
//            // Cutout Windway
//            translate([
//                -(mouthpiece_size[0]+rounding_radius+1), 
//                (width - ww_width)/2, 
//                height - ww_height
//            ]) 
//                cube([ww_length, ww_width, ww_height]);
//            
//            // Cutout for fipple block
//            fipple_block(width, height);
//    }
//}

module ring(height, inner_diameter, screw_diameter)
{
    outer_diameter = inner_diameter + 10;
    middle_diameter = (inner_diameter + outer_diameter)/2;

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
                
                // Screw landing
                translate([-13, 0, 0]) rotate([0, 90, 0])
                cylinder(d = SCREW_HOLE_DIAMETER, h = 5);
            }
            
            // Cutout for screw
            translate([0.7 * outer_diameter/2, 0, 0])
            cube([6, KNOB_DIAMETER + 2, height], center = true);
            
            
            // Cutout for fipple block
            translate([-3-middle_diameter/2, -2.5, -5])
            rotate([0, -90, 0])
            fipple(5, 0);
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
        cylinder(h = height, d = knob_diameter);
        for (angle = [0:30:360])
        {
            rotate([0, 0, angle])
            translate([knob_diameter/2, 0, 0])
            cylinder(h = height, d = 0.1 * knob_diameter);
        }
        thread_for_screw(diameter=screw_diameter, length=screw_length);
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

module chopped_ring(height, outer_diameter, inner_diameter, start, end) {
    difference()
    {
        // Outer Ring
        chopped_cylinder(height, outer_diameter, start, end);
        
        // Inner Ring Cutout
        scale([1, 1, 1.1])
        chopped_cylinder(height, inner_diameter, start, end - 0.05);
    }
}
