include<../gospel.scad>;

$fn=50;

insert();

module knob()
{
    difference()
    {
        sxy(25/40)
        sphere(r=20);
        
        cylinder(d=7, h=100, center=true);
        rx(180)
        cylinder(d=13, h=100);
     
        z(25+15)
        cube([50,50,50], center=true);
    }
}

module insert()
{
    difference()
    {
        sxy(25/40)
        sphere(r=20);
        
        rx(180)
        difference()
        {
            cylinder(d=40, h=100);
            cylinder(d=13*.97, h=100);
        }
        z(12)
        cube([50,50,50], center=true);
    }
}