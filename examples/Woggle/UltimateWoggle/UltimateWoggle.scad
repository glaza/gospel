use <../../../3rd_party/threads-library-by-cuiso-v1.scad>
//use <41786_customizer_multitone_whistle.scad> 

$fn = 100;

HEIGHT = 38.5;
HOLE_DIAMETER = 25;
KNOB_DIAMETER = 20;
SCREW_HOLE_DIAMETER = 12.5;
SCREW_DIAMETER = 12;

//translate([-10, 0, 0])
//rotate([-90, 0, 180])
//import("a-s1_print.stl");

color("salmon")
ring(height = HEIGHT, inner_diameter = HOLE_DIAMETER, screw_diameter = SCREW_HOLE_DIAMETER);

color("cyan")
knob(height = 5, knob_diameter = KNOB_DIAMETER, screw_diameter = SCREW_DIAMETER, screw_length = 28);

//color("green")
//translate([0, 40, 0])
//shaped_ring(height = HEIGHT, diameter = KNOB_DIAMETER);



module ring(height, inner_diameter, screw_diameter)
{
    outer_diameter = inner_diameter + 7.5;

    difference()
    {
        difference()
        {
            // Outer Ring
            chopped_cylinder(height, outer_diameter, start = 0, end = 0.85);
            
            // Inner Ring Cutout
            scale([1, 1, 1.1])
            chopped_cylinder(height, inner_diameter, start = 0, end = 0.8);
            
            // Slants
            translate([2.325 + outer_diameter/2, -outer_diameter/2, outer_diameter/4])
            rotate([0, -67.5, 0])
            cube([outer_diameter, outer_diameter, height]);
            
            translate([2.325 - outer_diameter/2, -outer_diameter/2, -0.65 * outer_diameter])
            rotate([0, 67.5, 0])
            cube([outer_diameter, outer_diameter, height]);
        }

        // Screw Thread Hole
        rotate([0, 90, 0])
        thread_for_screw(diameter = screw_diameter, length = inner_diameter);
        
        // Whistle Body Cutout
        translate([1.5-inner_diameter/2, 0, 0])
        cube([8, 5.75, height + 1], center = true);
        
        // Whistle Hole Cutouts
        translate([-5.5-inner_diameter/2, 0, 8.3])
        rotate([0, 27.5, 0])
        cube([6, 5.75, 7], center = true);
        
        translate([-4.5-inner_diameter/2, 0, 10.625])
        cube([6, 5.75, 2], center = true);
    }
    
    // Whistle
    translate([1 - inner_diameter/2, 0, 1])
    rotate([90, -90, 0])
    import("2081176_Whistle-4-2.stl");
    
    // Whistle Bottom Cover
    translate([-1.2-inner_diameter/2, 0, 0.5-height/2])
    cube([3, 5.75, 1], center = true);
    
    
//    translate([2-inner_diameter/2, 3.8, height])
//    rotate([180, 90, 0])
//    import("495172_Emergency_Whistle.stl");
    
    // Flat region for screw to press against
//    translate([-inner_diameter/2, 0, 0])
//    cube([0.1 * inner_diameter, inner_diameter/2, height], center = true);
}

module knob(height, knob_diameter, screw_diameter, screw_length)
{
    scale([1, 0.95, 0.95])
    translate([knob_diameter, 0, 0])
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

//module shaped_ring(height, diameter)
//{
//    steps = 50;
//
//    points = [
//        // first expression generating the points in the positive Y quadrant
//        for (angle = [0 : 30 : 360]) [10, 10 * sin(angle), 50],
//    ];
//    echo(points);
//
//    polyhedron(points);  
        
    //hull()
//    {
//        for (angle = [0:5:360])
//        {
//            rotate([0, 0, angle])
//            translate([diameter/2, 0, 0])
//            cube([5, 5, (1 + sin(angle/2)) * height], center = true);
//        }
//    }
//}