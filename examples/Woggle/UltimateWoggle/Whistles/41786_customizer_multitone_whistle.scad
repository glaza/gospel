// Thing 41786

windway_width=12/1;
windway_height=3/1;
windway_length=16/1;
sidewall=1/1;
wall=2/1;
extra=1/1;
chamber_height=10/1;
chamber_width=windway_width;

ramp_angle=12/1;
opening_width=6/1;
ramp_length=(wall+extra)/tan(ramp_angle);

module whistle(chamber_length=86) {
	difference() {
		union() {
			translate([0,wall/4,0]) difference() {
				cube([windway_width+sidewall*2,windway_length+wall/2,windway_height+wall*2], center=true);
				cube([windway_width,windway_length+wall/2+extra,windway_height], center=true);
			}
			
			translate([0,chamber_length/2+windway_length/2+wall,-chamber_height/2+windway_height/2]) { 
				difference() {
					cube([chamber_width+sidewall*2, chamber_length+wall*2, chamber_height+wall*2], center=true);
					cube([chamber_width,chamber_length,chamber_height], center=true);
					translate([0,-chamber_length/2-wall/2,chamber_height/2+wall-windway_height/2-wall])
					cube([windway_width, wall*2, windway_height], center=true);
				}
			}

			translate([0,windway_length/2-(chamber_height-windway_height)/2+0.001,-chamber_height/2-wall+0.001]) {
				difference() {
					cube([chamber_width+sidewall*2,chamber_height-windway_height,chamber_height-windway_height], center=true);
					translate([0,-(chamber_height-windway_height)/2,-(chamber_height-windway_height)/2])
						rotate([0,90,0]) 
							cylinder(r=chamber_height-windway_height, h=chamber_width+sidewall*2+1, center=true, $fn=30);
				}
			}

		}
		
		translate([-windway_width/2,windway_length/2+opening_width+wall-opening_width/2,windway_height/2-0.01])
			ramp_cutout();
	}
}

module ramp_cutout() {
		 translate([0,-opening_width,0]) rotate([0,0,90]) rotate([90,0,0]) linear_extrude(height=windway_width)
	 		polygon(points=[[0,0],[opening_width,0],[opening_width+ramp_length,wall+extra],[0,wall+extra]], paths=[[0,1,2,3,0]]);
}