

windway_width=12;
windway_height=3;
windway_length=16;
sidewall=1;
wall=2;
extra=1;
chamber_height=10;
chamber_width=windway_width;

ramp_angle=12;
opening_width=6;
ramp_length=(wall+extra)/tan(ramp_angle);

length_for_a4=176.4;

// notes=[12,14,15,17,19,20,22]; /* A5 B5 C6 D6 E6 F6 G6 */
notes=[18,22];
num_notes=2;

function note_to_freq(halfstep_from_a4) = 440 * pow(1.059463094359, halfstep_from_a4);

function note_to_length(halfstep_from_a4) = 440/note_to_freq(halfstep_from_a4) * length_for_a4;

for (n=[0:num_notes-1]) {
		echo("whistle ",n," is ",note_to_length(notes[n]),"mm long");
		translate([n*(windway_width+sidewall),0,0])
			whistle(note_to_length(notes[n]));
}



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