use <../../gospel.scad>


eye();

module eye() {
    difference() {
        union() {
            sxy(1.075) lens();
            z(2) sxy(1.075) lens();
            z(1) sxy(1.075) lens();
        }
        z(1) sxy(1.02) lens();
        z(-1) sz(10) sxy(0.95) lens();
        
    }
    z(1) glass() lens();
}

module lens() {
    linear_extrude(1) import("Lens.svg");
}

// Moved to Gospel examples
