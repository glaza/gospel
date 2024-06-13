
NUMBER_OF_STEPS = 16;
INNER_DIAMETER = 15;
INNER_RADIUS = INNER_DIAMETER / 2;
THICKNESS = 5;
CHAMFER = 1;
HEIGHT = 30;
OUTER_RADIUS = INNER_RADIUS + THICKNESS;
TEXT_SIZE = 4;
TEXT_DEPTH = 0.5;
HEIGHTS = [
    [21.6625, 10.464, 9.51756, 22.407, 12.7313, 11.2683, 8.48914, 9.94045, 20.0596, 21.5109, 18.7317, 17.2687, 7.59297, 20.4824, 19.536, 8.33749, 21.6625],
    [20.8879, 15.4114, 9.49103, 10.7345, 12.525, 21.0721, 20.1542, 11.8115, 18.1885, 9.84583, 8.92794, 17.475, 19.2655, 20.509, 14.5886, 9.11207, 20.8879],
    [9.84079, 13.9774, 18.2822, 19.8554, 13.9597, 10.265, 22.1203, 11.0808, 18.9192, 7.87971, 19.735, 16.0403, 10.1446, 11.7178, 16.0226, 20.1592, 9.84079],
];

//heights = generateHeightArray(NUMBER_OF_STEPS);
//echo(heights);
heights = HEIGHTS[0];

color("red")
bottomRing(heights, "JUBI 24 JUBI 24");

color("grey")
translate([3*OUTER_RADIUS, 0, 0])
bottomRing(heights, "KARAKÓ VÁRMEGYE", flipped = true);
//bottomRing(heights, "HONT  VÁRMEGYE", flipped = true);

//translate([0, 0, HEIGHT + 2])
//rotate([180, 0, 225])
//color("grey") bottomRing(heights, "HONT  VÁRMEGYE", flipped = true);

//translate([0, 0, 2])
//color("grey") topRing(heights);

//color("grey")
//translate([2 * OUTER_RADIUS + THICKNESS, 0, HEIGHT])
//rotate([180, 0, 0])
//topRing(heights);


module bottomRing(heights, label = "", flipped = false) {
    bottomSegments = buildAllBottomSegments(heights);
    union() {
        for (i = [0 : NUMBER_OF_STEPS - 1]) {
            rotate([0, 0, -i * 360/NUMBER_OF_STEPS])
            polyhedron(bottomSegments[i], cubeFaces);
        }
        
        rotate([0, 0, 180/NUMBER_OF_STEPS])
        difference() {
            cylinder(h=THICKNESS, r=OUTER_RADIUS-CHAMFER, $fn=NUMBER_OF_STEPS);
            cylinder(h=THICKNESS, r=INNER_RADIUS+1.5*CHAMFER, $fn=NUMBER_OF_STEPS);
        }
    }    

    letters(label, flipped);
}

module letters(string, flipped = false) {
    direction = flipped ? -1 : 1;
    for (l = [0 : len(string) - 1]) {
        translate([0, 0, (flipped ? TEXT_SIZE : 0)])
        rotate([0, 0, l * direction * 360 / NUMBER_OF_STEPS])
        translate([0, TEXT_DEPTH-OUTER_RADIUS, 2 * CHAMFER])
        rotate([flipped ? 180 : 0, 0, 0])
        rotate([90, 0, (flipped ? 180 : 0)])
        translate([0, 0, 0])
        linear_extrude(2*TEXT_DEPTH)
        text(string[l], size=TEXT_SIZE, halign="center", font="Arial Black");
    }
}

module topRing(heights) {
    topSegments = buildAllTopSegments(heights);
    union() {
        for (i = [0 : NUMBER_OF_STEPS - 1]) {
            rotate([0, 0, -i * 360/NUMBER_OF_STEPS])
            polyhedron(topSegments[i], cubeFaces);
        }
    }
};

function buildAllBottomSegments(heights) = [
    for (i = [0 : NUMBER_OF_STEPS]) buildBottomSegment(heights[i], heights[i+1])
];
    
function buildAllTopSegments(heights) = [
    for (i = [0 : NUMBER_OF_STEPS]) buildTopSegment(heights[i], heights[i+1])
];
    
cubeFaces = [
  //[0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3],  // left
  [0,1,9,8],  // front chamfer
  [1,2,10,9], // right chamfer
  [2,3,11,10],// back chamfer
  [0,8,11,3], // left chamfer
  [8,9,10,11], // bottom chamfer
];
    
function buildBottomSegment(currentHeight, nextHeight) = 
    let(
        angle = 180 / NUMBER_OF_STEPS,
        inner = INNER_RADIUS * tan(angle),
        outer = OUTER_RADIUS * tan(angle),
        innerChamfer = (INNER_RADIUS+CHAMFER) * tan(angle),
        outerChamfer = (OUTER_RADIUS-CHAMFER) * tan(angle)
    )
[
    [-outer, OUTER_RADIUS, CHAMFER],          //  0
    [outer, OUTER_RADIUS, CHAMFER],           //  1
    [inner, INNER_RADIUS, CHAMFER],           //  2
    [-inner, INNER_RADIUS, CHAMFER],          //  3
    [-outer, OUTER_RADIUS, currentHeight],    //  4
    [outer, OUTER_RADIUS, nextHeight],        //  5
    [inner, INNER_RADIUS, nextHeight],        //  6
    [-inner, INNER_RADIUS, currentHeight],    //  7
    [-outerChamfer, OUTER_RADIUS-CHAMFER, 0], //  8
    [outerChamfer, OUTER_RADIUS-CHAMFER, 0],  //  9
    [innerChamfer, INNER_RADIUS+CHAMFER, 0],  // 10
    [-innerChamfer, INNER_RADIUS+CHAMFER, 0], // 11
];
    
function buildTopSegment(currentHeight, nextHeight) = 
    let(
        angle = 180 / NUMBER_OF_STEPS,
        inner = INNER_RADIUS * tan(angle),
        outer = OUTER_RADIUS * tan(angle), innerChamfer = (INNER_RADIUS+CHAMFER) * tan(angle),
        outerChamfer = (OUTER_RADIUS-CHAMFER) * tan(angle)
    )
[
    [-outer, OUTER_RADIUS, HEIGHT-CHAMFER],
    [outer, OUTER_RADIUS, HEIGHT-CHAMFER],
    [inner, INNER_RADIUS, HEIGHT-CHAMFER],
    [-inner, INNER_RADIUS, HEIGHT-CHAMFER],
    [-outer, OUTER_RADIUS, currentHeight],
    [outer, OUTER_RADIUS, nextHeight],
    [inner, INNER_RADIUS, nextHeight],
    [-inner, INNER_RADIUS, currentHeight],
    [-outerChamfer, OUTER_RADIUS-CHAMFER, HEIGHT], //  8
    [outerChamfer, OUTER_RADIUS-CHAMFER, HEIGHT],  //  9
    [innerChamfer, INNER_RADIUS+CHAMFER, HEIGHT],  // 10
    [-innerChamfer, INNER_RADIUS+CHAMFER, HEIGHT], // 11
];


// Generate random values
function randomArray(steps) = rands(0.25*HEIGHT, 0.75*HEIGHT, steps);
    
//function doubleArray(array) = concat(array, array);

function invertArray(array) = [
    for (i = [len(array) - 1: -1: 0]) HEIGHT - array[i]
];

// Append the first value after the last value (closing the shape)
function closeArray(array) = concat(array, array[0]);

function generateHeightArray(steps) = 
    let(
        random = randomArray(steps/2),
        inverted = invertArray(random)
    )
    closeArray(concat(random, inverted));