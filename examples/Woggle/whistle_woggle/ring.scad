include <../gospel.scad>;
use <../3rd_party/Nut_Job.scad>;


/* [Bolt and Rod Options] */

//Head type - Hex, Socket Cap, Button Socket Cap or Countersunk Socket Cap (ignored for Rod)
head_type              			= "hex";//[hex,socket,button,countersunk]
//Drive type - Socket, Phillips, Slot (ignored for Hex head type and Rod)
drive_type              		= "socket";//[socket,phillips,slot]
//Distance between flats for the hex head or diameter for socket or button head (ignored for Rod)
head_diameter    				= 12;	
//Height of the head (ignored for Rod)
head_height  					= 5;	
//Diameter of drive type (ignored for Hex head and Rod)
drive_diameter					= 5;	
//Width of slot aperture for phillips or slot drive types
slot_width					    = 1;
//Depth of slot aperture for slot drive type
slot_depth 					    = 2;
//Surface texture (socket head only)
texture                         = "exclude";//[include,exclude]
//Outer diameter of the thread
thread_outer_diameter           = 25;		
//Thread step or Pitch (2mm works well for most applications ref. ISO262: M3=0.5,M4=0.7,M5=0.8,M6=1,M8=1.25,M10=1.5)
thread_step    					= 2;
//Step shape degrees (45 degrees is optimised for most printers ref. ISO262: 30 degrees)
step_shape_degrees 				= 45;	
//Length of the threaded section
thread_length  					= 25;	
//Countersink in both ends
countersink  					= 2;	
//Length of the non-threaded section
non_thread_length				= 0;	
//Diameter for the non-threaded section (-1: Same as inner diameter of the thread, 0: Same as outer diameter of the thread, value: The given value)
non_thread_diameter				= 0;	

//Type: Normal or WingNut
nut_type	                    = "normal";//[normal,wingnut]
//Distance between flats for the hex nut
nut_diameter    				= 30;	
//Height of the nut
nut_height	  				    = 6;	
//Outer diameter of the bolt thread to match (usually set about 1mm larger than bolt diameter to allow easy fit - adjust to personal preferences) 
nut_thread_outer_diameter     	= 26;		
//Thread step or Pitch (2mm works well for most applications ref. ISO262: M3=0.5,M4=0.7,M5=0.8,M6=1,M8=1.25,M10=1.5)
nut_thread_step    				= 2;
//Step shape degrees (45 degrees is optimised for most printers ref. ISO262: 30 degrees)
nut_step_shape_degrees 			= 45;	
//Wing radius ratio.  The proportional radius of the wing on the wing nut compared to the nut height value (default = 1)
wing_ratio                      = 1;
wing_radius=wing_ratio * nut_height;

//Number of facets for hex head type or nut. Default is 6 for standard hex head and nut
facets                          = 6;
//Number of facets for hole in socket head. Default is 6 for standard hex socket
socket_facets                   = 6;
//Depth of hole in socket head. Default is 3.5
socket_depth                    = 3.5;
//Resolution (lower values for higher resolution, but may slow rendering)
resolution    					= 0.5;	
nut_resolution    				= resolution;

module screw_round()
{
    intersection()
    {
        difference()
        {
            hex_screw(thread_outer_diameter,thread_step,step_shape_degrees,thread_length,resolution,countersink,head_diameter,0,non_thread_length,non_thread_diameter);

            // Hole        
            z( 12.5 )
            rx( 90 )
            cylinder( d = 20, h = 25, center = true, $fn = 50 );
        }

        // Outer shape
        union()
        {
            z( 12.5 )
            rx( 90 )
            cylinder( d = 25, h = 25, center = true, $fn = 50 );
            cube( [100, 100, 25], center = true );
        }
    }
}

module screw()
{
    difference()
    {
        hex_screw(thread_outer_diameter,thread_step,step_shape_degrees,thread_length,resolution,countersink,head_diameter,0,non_thread_length,non_thread_diameter);

        // Hole        
        z( 12.5 )
        rx( 90 )
        cylinder( d = 20, h = 25, center = true, $fn = 50 );
    }
}

module nut()
{
    hex_nut(nut_diameter,nut_height,nut_thread_step,nut_step_shape_degrees,nut_thread_outer_diameter,nut_resolution);
}

/*
screw_round();


x( 30 )
screw();

x( -5 )
y( 32 )
nut();

xy( 32 )*/
nut();