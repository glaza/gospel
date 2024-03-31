
NUMBER_OF_STEPS = 36;
INNER_DIAMETER = 15;
INNER_RADIUS = INNER_DIAMETER / 2;
THICKNESS = 5;
CHAMFER = 1;
HEIGHT = 30;
OUTER_RADIUS = INNER_RADIUS + THICKNESS;



heights = randomArray(NUMBER_OF_STEPS);

color("red") bottomRing(heights);

color("grey")
translate([2 * OUTER_RADIUS + THICKNESS, 0, HEIGHT])
rotate([180, 0, 0])
topRing(heights);


module bottomRing(heights) {
    bottomSegments = buildAllBottomSegments(heights);
    union() {
        for (i = [0 : NUMBER_OF_STEPS - 1]) {
            rotate([0, 0, -i * 360/NUMBER_OF_STEPS])
            polyhedron(bottomSegments[i], cubeFaces);
        }
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

function buildAllBottomSegments(heights) =[
    for (i = [0 : NUMBER_OF_STEPS])
        buildBottomSegment(heights[i], heights[i+1])
];
    
function buildAllTopSegments(heights) =[
    for (i = [0 : NUMBER_OF_STEPS])
    buildTopSegment(heights[i], heights[i+1])
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

function randomArray(n) =
    let(values = rands(0.25*HEIGHT, 0.75*HEIGHT, n))
    concat(values, values[0]);
