use <../gospel.scad>

$fn=25;

horse();

module horse() {
    color("#FFFFFF80")
    leg("2021");
    y(3) body();
    y(6) leg("MTT");
}

module pins(scale = 1.0) {
    z(17.5) {
        x(17.5) rx(-90) sxy(scale) cylinder(d=3, h=9);
        x(2.5) rx(-90) sxy(scale) cylinder(d=3, h=9);
    }
}

module body() {
    
    difference() {
        union() {
            // Body
            z(10) cube([20, 3, 10]);
            
            // Head
            x(10) z(15) ry(45) {
                difference() {
                    union() {
                        // Noze
                        z(13) cube([7, 3, 5]);
                        z(13.5) cube([10, 3, 4]);
                        // Neck
                        z(3) cube([6, 3, 15]);
                        // Eyebrow
                        x(1) z(18) cube([1, 3, 1]);
                        
                           
                        // Hair
                        for (i = [0:5]) {
                            x(-1) z(16-2*i) cube([1, 3, 1]);
                        }
                    }
                    // Eye
                    x(3) z(15) rx(-90) cylinder(d=1.5, h=9);
                }
            }
            
            // Tail
            x(3) z(18) ry(-140) cube([3, 3, 8]);
            x(-1.5) z(13.25) ry(-170) cube([3, 3, 8]);
        }
        pins();
    }
}

module leg(string="2021") {
    difference() {
        union() {
            z(10) cube([20, 3, 10]);
            
            x(17) cube([3, 3, 3]);
            cube([3, 3, 3]);
            
            z(7) {
                x(17) cube([3, 3, 3]);
                cube([3, 3, 3]);
            }

            x(0.5) z(3) {
                x(17) cube([2, 3, 4]);
                cube([2, 3, 4]);
            }
        }
        pins();
        x(19) z(11) sx(1.325) rz(180) rx(90) linear_extrude(3) text(string, size=4, font="Arial Black");
    }
}
