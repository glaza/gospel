use <heart.scad>
use <liliom.scad>
use <csodaszarvas.scad>
use <star.scad>

filter_diameter = 52;
reduction_factor = 2;
generate_handle = false;
handle_radius = 6;
thickness = 2;


filter_cut(filter_diameter/2,reduction_factor);


module filter_cut(radius, reduction_factor)
{
    $fn=filter_diameter;
    difference(){
        filter(radius-0.6);
        
        translate([radius-3.4,-2,0])
        cube([2,6,10], center=true);
        
        translate([radius-0.9,2,0])
        cube([7,2,10], center=true);
        
        translate([-(radius-3.4),2,0])
        cube([2,6,10], center=true);
        
        translate([-(radius-0.9),-2,0])
        cube([7,2,10], center=true);
        
//        // Small 1.5, Medium 2, large 3
//        linear_extrude(thickness, convexity=4)
//        scale([3, 3, 1])
//        liliom();
        
//        linear_extrude(thickness, convexity=4)
//        //translate([-6, -5, 0]) // Large
//        //scale([50, 50, 1])
//        scale([30, 30, 1])
//        csodaszarvas();

//        // Small 0.3, Med 0.6, Big 1.0, Huge 1.3
//        scale([1.3, 1.3, 1])
//        heart(5);

//        linear_extrude(height = 2) {
//            translate([0, -17.5, 0])
//            scale([0.4, 0.4, 1])
//            import("christmas_tree_filled.dxf");
//        }

        linear_extrude(height = 2)
        scale([1.5, 1.5, 1])
        star();
    }
    
    if (generate_handle) 
    {
        translate([radius-8, 0, 0])
        handle(handle_radius);    
    }
}

module handle(handle_radius)
{
    rotate([0,90,0])
    difference() {
        cylinder(r=handle_radius, h=2);
        
        translate([0,-handle_radius,0])
        cube([handle_radius,2*handle_radius,2]);
    }
}

module filter(radius_transformed) 
{
    cylinder(r=radius_transformed,h=2);
    
    translate([radius_transformed,0,0])
    cylinder(r=0.7,h=2);
    
    translate([-radius_transformed,0,0])
    cylinder(r=0.7,h=2);
}

