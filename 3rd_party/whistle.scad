use <fillet.scad>

$fn = 24;  

//length = 65;
//width = 45;
//height = 25;
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

// Uncomment basic or supported version
//whistle(75, 45, 24);

//add_supports_at_45(75, 45, 24) {
//    whistle(75, 45, 24);
//}
    
add_supports_at_90(75, 45, 24) {
    whistle(75, 45, 24, debug=false);
}


// A hollow box with a windway and fipple
module whistle(length, width, height, debug=false) {
    
    difference() {
        body(length, width, height);
        if(debug) {
            cube([length, width+10, height-top_thinckness]); // main interior
        }
        else {
            cube([length, width, height-top_thinckness]); // main         
        }
        // Cutout Windway
        translate([
            -(mouthpiece_size[0]+rounding_radius+1), 
            (width - ww_width)/2, 
            height - ww_height
        ]) 
            cube([ww_length, ww_width, ww_height]);
        
        // Cutout for fipple block
        fipple_block(width, height);
    }
    
    // form fipple as a seperate piece
    fipple(width, height);
}


module fipple_block(w, h) {
    translate([0, 0, h - fi_height])
        cube([fi_length, w, fi_height + rounding_radius]);
}


module fipple(w, h) {
    // Still some magic numbers here for tweeking fipple size
    difference (){
        fipple_block(w, h);
        translate([2.8, (w - fi_width)/2, h - 2.75]) {
            rotate([0,-22,0])
                cube([18, fi_width, 6]); // fipple - top cut
            rotate([0,17,0])
                cube([18, fi_width, 3]); // fipple - inside cut
        }
        // make sure airway is clear
        translate([0, (w - fi_width)/2, h - 2.75])
            cube([5, fi_width, 10]);
    }
}


// A rounded box with a mouthpiece
module body (length, width, height) {
    fillet(r=rounding_radius, steps=$fn/4) {
        // The main body
        rounded_box([length, width, height], rounding_radius);
        
        // The mouthpiece centered and flush with top
        translate([
                -(mouthpiece_size[0]), 
                width/2 - (mouthpiece_size[1])/2, 
                (height - mouthpiece_size[2])
            ]) 
            rounded_box(mouthpiece_size, rounding_radius);
    }
}


module rounded_box(size, radius) {
    minkowski()     {
        cube(size);
        sphere(r=radius);
    }
}


// Change orientation for printing and add support materials
module add_supports_at_90(length, width, height)
{
    z_offset = rounding_radius + height*sqrt(2)/2;
    translate([0, 0, rounding_radius])
        rotate([90,0,0])
            children(0);
    
    // add a t-shaped supports for mouthpiece
    support_position = height-mouthpiece_size[2];
    support_height = (width - mouthpiece_size[1])/2 ;

    t_support_x([-10,-support_position,0], 6, support_height);
    t_support_x([-10,-height,0], 6, support_height);
}


module add_supports_at_45 (length, width, height)
{
    z_offset = rounding_radius + height*sqrt(2)/2;
    translate([0, 0, z_offset])
        rotate([135,0,0])
            children(0);

    // add a t-shaped support for mouthpiece
    support_position = (height+(width-mouthpiece_size[1])/2) * sqrt(2)/2;
    support_height = (width - mouthpiece_size[1])/2 * sqrt(2)/2;
    t_support_x([-10,-support_position,0], 4, support_height);

    // stabilize the body
    t_support_x([0, 6-height*sqrt(2)/2, 0], length, 6);
    t_support_x([0, -6-height*sqrt(2)/2, 0], length, 6);

    // support the upper edge of hole
    fp_z = (width+fi_width+fi_inset)/2*sqrt(2)/2;
    fp_y = -(height*sqrt(2)/2 + (width+fi_width+fi_inset)/2*sqrt(2)/2);
    t_support_x([0, fp_y, 0], fi_length, fp_z);
}


// make a t-shaped support structure along x-axis
module t_support_x(pos, l, h)
{
    translate(pos) {
        cube([l,.25, h]);
        translate([0, -2, 0])
            cube([l, 4,.25]);
    }
}
