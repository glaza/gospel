include <../gospel.scad>

thickness = 2;
margin = 10;
tollerance = 1;

photo_x = 6 * 25.4;
photo_y = 4 * 25.4;
slot_x = photo_x + tollerance;
slot_y = photo_y + tollerance;
frame_x = photo_x + margin + tollerance;
frame_y = photo_y + margin + tollerance;
cutout_x = photo_x - margin;
cutout_y = photo_y - margin;

pictureHolderVertical();

module pictureHolderHorizontal() {
    difference() {
        cube([frame_x, frame_y, thickness], center=true);
        
        y(margin/2) z(thickness/2) 
        cube([slot_x, slot_y + margin, thickness], center=true);
        
        cube([cutout_x, cutout_y, thickness], center=true);
    }
}

module pictureHolderVertical() {
    difference() {
        cube([frame_x, frame_y, thickness], center=true);
        
        x (margin/2) z(thickness/2) 
        cube([slot_x + margin, slot_y, thickness], center=true);
        
        cube([cutout_x, cutout_y, thickness], center=true);
    }
}