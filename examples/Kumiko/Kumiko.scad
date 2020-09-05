HEIGHT=.1;
THICKNESS=.03;


OPEN=true;
CLOSED=false;

for ( x = [0:1:2] )
{
    for ( y = [0:1:2] )
    {
        KakuAsanoha([[x,y],[x+1,y],[x+1,y+1],[x,y+1]]);
    }
}
for ( x = [4:1:6] )
{
    for ( y = [0:1:2] )
    {
        Asanoha([[x,y],[x+1,y],[x+1,y+1],[x,y+1]]);
    }
}
for ( x = [8:1:10] )
{
    for ( y = [0:1:2] )
    {
        Mitsukude([[x,y],[x+1,y],[x+1,y+1],[x,y+1]]);
    }
}
for ( x = [0:1:2] )
{
    for ( y = [4:1:6] )
    {
        BishamonKikkou([[x,y],[x+1,y],[x+1,y+1],[x,y+1]]);
    }
}
for ( x = [4:1:6] )
{
    for ( y = [4:1:6] )
    {
        Tsutsuidutsu([[x,y],[x+1,y],[x+1,y+1],[x,y+1]]);
    }
}

module Mitsukude(rectangle)
{
    // Decompose tile into quarters
    for (quarterRect = mirrorEveryNth(mirrorEveryNth(subdivide(rectangle), 1, 4), 2, 4))
    {
        p0 = quarterRect[0];
        p1 = quarterRect[1];
        p2 = quarterRect[2];
        p3 = quarterRect[3];
        p12 = interpolate(p1, p2);
        p30 = interpolate(p3, p0);
        
        polygon(outline([p1, p30, p0], OPEN));
        polygon(outline([p30, p1, p2]));
        polygon(outline([p3, p30, p2], OPEN));
    }
}

module Asanoha(rectangle)
{
    // Decompose tile into quarters
    for (quarterRect = mirrorEveryNth(mirrorEveryNth(subdivide(rectangle), 1, 4), 2, 4))
    {
        p0 = quarterRect[0];
        p1 = quarterRect[1];
        p2 = quarterRect[2];
        p3 = quarterRect[3];
        p01 = interpolate(p0, p1);
        p12 = interpolate(p1, p2);
        p23 = interpolate(p2, p3);
        p30 = interpolate(p3, p0);
        
        // Cut each quarter in half
        for (triangle = subdivide([p30, p1, p2]))
        {
            polygon(outline(triangle));
        }
        // Bottom
        polygon(outline([p01, p30, p0], OPEN));
        polygon(outline([p1, p30, p01], OPEN));
        // Top
        polygon(outline([p23, p30, p2]));
        polygon(outline([p3, p30, p23], OPEN));
    }
}

module dot(point)
{
    polygon([[point.x-0.05,point.y-0.05],
             [point.x+0.05,point.y-0.05],
             [point.x+0.05,point.y+0.05],
             [point.x-0.05,point.y+0.05]]);
}

module KakuAsanoha(rectangle)
{
    // Decompose tile into quarters
    for (quarterRect = rotateEveryNth(subdivide(rectangle), 1, 2))
    {
        // Cut each quarter in half
        for (outerTriangle = triangulate(quarterRect))
        {
            // Decompose each tringle in 3
            for (innerTriangle = triangulate(outerTriangle))
            {
                polygon(outline(innerTriangle));
            }
        }
    }
}

module BishamonKikkou(rectangle)
{
    // Decompose tile into quarters
    for (quarterRect = mirrorEveryNth(mirrorEveryNth(subdivide(rectangle), 1, 4), 2, 4))
    {
        p0 = quarterRect[0];
        p1 = quarterRect[1];
        p2 = quarterRect[2];
        p3 = quarterRect[3];
        p01 = interpolate(p0, p1, 1/3);
        p12 = interpolate(p1, p2);
        p23 = interpolate(p2, p3, 2/3);
        p30 = interpolate(p3, p0);
        p30_0 = interpolate(p30, p0, 2/3);
        p30_1 = interpolate(p30, p1, 2/3);
        p30_2 = interpolate(p30, p2, 1/3);
        
        // Top
        polygon(outline([p3, p30, p30_2, p23], OPEN));
        polygon(outline([p23, p30_2, p2], OPEN));
        
        // Center
        for (trapezoid = trapizate([p30, p1, p2]))
        {
            polygon(outline(trapezoid));
        }
        
        // Bottom
        polygon(outline([p01, p30_0, p0], OPEN));
        polygon(outline([p30_0, p01, p30_1, p30]));
        polygon(outline([p1, p30_1, p01], OPEN));
    }
}

module Tsutsuidutsu(rectangle)
{
    // Decompose tile into quarters
    for (quarterRect = mirrorEveryNth(mirrorEveryNth(subdivide(rectangle), 1, 4), 2, 4))
    {
        for (trapezoid = trapizate(quarterRect))
        {
            polygon(outline(trapezoid));
        }
    }
}

/**
 * Traces the outline of a shape
 * @param shape Triangle or quadrilateral
 * @return A polygon that traces the outline
 */
function outline(shape, open = false) = 
    let (center = center(shape),
         p0 = shape[0],
         p1 = shape[1],
         p2 = shape[2])
    len(shape) == 3 // Triangle
    ? let(p00 = innerPoint([p2, p0, p1]),
          p11 = innerPoint([p0, p1, p2]),
          p22 = innerPoint([p1, p2, p0]))
      open ? [p0, p1, p2, p22, p11, p00]
           : [p0, p1, p2, p0, p00, p22, p11, p00]

    : len(shape) == 4 // Quadrilateral
    ? let (p3 = shape[3],
           p00 = innerPoint([p3, p0, p1]),
           p11 = innerPoint([p0, p1, p2]),
           p22 = innerPoint([p1, p2, p3]),
           p33 = innerPoint([p2, p3, p0]))
        open ? [p0, p1, p2, p3, p33, p22, p11, p00]
             : [p0, p1, p2, p3, p0, p00, p33, p22, p11, p00]
    : // Other polygon
        [];

/**
 * Subdivides the triangle or rectangle
 * +----+    +--+--+
 * |3  2|    |32|32|
 * |    |    |01|01|
 * |    | -> +--+--+
 * |    |    |32|32|
 * |0  1|    |01|01|
 * +----+    +--+--+
 *
 * @param points A vector of 3 or 4 2D points
 *               Triangle: [[x1,y1],[x2,y2],[x3,y3]]
 *               Rectangle: [[x1,y1],[x2,y2],[x3,y3],[x4,y4]]
 * @return A vector of 3 triangles or 4 rectangles
 */
function subdivide(shape) = len(shape) == 3
    ? // Triangle
        let (center = center(shape),
             p0 = shape[0],
             p1 = shape[1],
             p2 = shape[2])
        [
            [p0, p1, center],
            [p1, p2, center],
            [p2, p0, center]
        ]

    : // Rectangle
        let (center = center(shape),
             p0 = shape[0],
             p1 = shape[1],
             p2 = shape[2],
             p3 = shape[3],
             p01 = center([p0, p1]),
             p12 = center([p1, p2]),
             p23 = center([p2, p3]),
             p30 = center([p3, p0]))
        [
            [p0,     p01,    center, p30],
            [p01,    p1,     p12,    center],
            [center, p12,    p2,     p23],
            [p30,    center, p23,    p3]
        ];

/**
 * Triangulates the triangle or rectangle
 * @param points A vector of 3 or 4 2D points
 *               Triangle: [[x1,y1],[x2,y2],[x3,y3]]
 *               Rectangle: [[x1,y1],[x2,y2],[x3,y3],[x4,y4]]
 * @return A vector of 2 or 3 triangles
 */
function triangulate(shape) =
    len(shape) == 3
    ? subdivide(shape) // Triangle
    : // Rectangle
        let (p0 = shape[0],
             p1 = shape[1],
             p2 = shape[2],
             p3 = shape[3])
        [
            [p0, p1, p2],
            [p0, p2, p3]
        ];

/**
 * Cut the shape into trapezoids
 * @param shape Triangle or Quadrilateral
 * @return A vector of trapezoids
 */
function trapizate(shape) =
    let (pc = center(shape),
         p0 = shape[0],
         p1 = shape[1],
         p2 = shape[2])
    len(shape) == 3 // Triangle
    ? let (p01 = interpolate(p0, p1, 2/3),
           p12 = interpolate(p1, p2, 2/3),
           p20 = interpolate(p2, p0, 2/3))
        [[p0,  p01, pc,  p20],
         [p01, p1,  p12, pc],
         [pc,  p12, p2,  p20]]

    : len(shape) == 4 // Quadrilateral
    ? let (p3 = shape[3],
           p0c = interpolate(p0, pc),
           p1c = interpolate(p1, pc),
           p2c = interpolate(p2, pc),
           p3c = interpolate(p3, pc))
        [[p0,  p1,  p1c, p0c],
         [p1,  p2,  p2c, p1c],
         [p2,  p3,  p3c, p2c],
         [p3,  p0,  p0c, p3c],
         [p0c, p1c, p2c, p3c]]
         
     : [];
    
/**
 * Rotates every second shape
 * +--+ +--+ +--+ +--+    +--+ +--+ +--+ +--+
 * |32| |32| |32| |32|    |32| |21| |32| |21|
 * |01| |01| |01| |01| -> |01| |30| |01| |30|
 * +--+ +--+ +--+ +--+    +--+ +--+ +--+ +--+
 *
 * @param shapes A vector of triangles or rectangles
 * @param start The stating index where to start mirroring
 * @param n The period to mirror shapes at
 * @param i The current index of the shape vector.
 *          This variable is used to implement tail
 *          recursion: Do not use as a starting index  
 *          as it will skip all shapes before it.
 * @return A vector of shapes where every second is rotated
 */
function rotateEveryNth(shapes, start, n, i=0) =
    let (rotateNow = i >= start && (i - start) % n == 0)
    i == (len(shapes) - 1)
    ? [rotateShape(shapes[i], rotateNow)] // Last shape
    : concat([rotateShape(shapes[i], rotateNow)], rotateEveryNth(shapes, start, n, i+1));

/**
 * Rotates the shape counter-clockwise
 * +--+    +--+
 * |32|    |21|
 * |01| -> |30|
 * +--+    +--+
 *
 * @param shape A vector of 3 or 4 points
 * @return The same list of points rolled over
 */
function rotateShape(shape, rotateNow=true) =
    !rotateNow 
    ? shape
    
    : len(shape) == 3
    ? [shape[2], shape[0], shape[1]]

    : len(shape) == 4
    ? [shape[3], shape[0], shape[1], shape[2]]
    
    : shape;

/**
 * Mirrors every Nth shape
 * start = 2
 * n = 2
 * +--+ +--+ +--+ +--+    +--+ +--+ +--+ +--+
 * |32| |32| |32| |32|    |32| |23| |32| |23|
 * |01| |01| |01| |01| -> |01| |10| |01| |10|
 * +--+ +--+ +--+ +--+    +--+ +--+ +--+ +--+
 *      ^
 * @param shapes A vector of triangles or rectangles
 * @param start The stating index where to start mirroring
 * @param n The period to mirror shapes at
 * @param i The current index of the shape vector.
 *          This variable is used to implement tail
 *          recursion: Do not use as a starting index  
 *          as it will skip all shapes before it.
 * @return A list of shapes with every Nth mirrored
 */
function mirrorEveryNth(shapes, start, n, i=0) =
    let (mirrorNow = i >= start && (i - start) % n == 0)
    i == (len(shapes) - 1)
    ? [mirrorShape(shapes[i], mirrorNow)] // Last shape
    : concat([mirrorShape(shapes[i], mirrorNow)], mirrorEveryNth(shapes, start, n, i+1));


/**
 * Mirrors the shape in the X direction
 * +--+    +--+
 * |32|    |23|
 * |01| -> |10|
 * +--+    +--+
 *
 * @param shape A vector of 3 or 4 points
 * @param mirrorNow Whether to mirror or not
 * @return The same list of points reordered
 */
function mirrorShape(shape, mirrorNow=true) = 
    !mirrorNow
    ? shape
    
    : len(shape) == 3 
    ? [shape[1], shape[0], shape[2]]
    
    : len(shape) == 4
    ? [shape[1], shape[0], shape[3], shape[2]]
    
    : shape;

/**
 * Interpolates a point on a line
 * @param p0 The first point on the line
 * @param p1 The second point on the line
 * @param amount How far along the line 
 *               segment the result should be
 * @return A point on the line
 */
function interpolate(p0, p1, amount=0.5) =
    let (dx = p1.x - p0.x, 
         dy = p1.y - p0.y)
    [p0.x + amount*dx, p0.y + amount*dy];


/**
 * Computes the center point of a line or shape
 * @param points An vector of 2, 3 or 4 2D points
 *               Line: [[x1,y1],[x2,y2]]
 *               Triangle: [[x1,y1],[x2,y2],[x3,y3]]
 * @return A single point that is at the center: [cx,cy]
 */
function center(shape) =
    len(shape) == 2 // Line with 2 points
    ? interpolate(shape[0], shape[1])
         
    : len(shape) == 3 // Triangle with 3 points
    ? [(shape[0].x + shape[1].x + shape[2].x)/3,
       (shape[0].y + shape[1].y + shape[2].y)/3]
             
    : len(shape) == 4 // Quad with 4 points
    ? [(shape[0].x + shape[1].x + shape[2].x + shape[3].x)/4,
       (shape[0].y + shape[1].y + shape[2].y + shape[3].y)/4]
    
    : [5, 5];

/**
 * @param triangle A vector of 3 points
 * @param thichness The stick thickness
 * @return the innter point that is half of the
 *         thichness inside of the corner.
 * 0     2
 *  \ w /
 *  u\|/v
 *    1
 */
function innerPoint(triangle) =
    let(u = normalize(vectorize([triangle[1], triangle[0]])),
        v = normalize(vectorize([triangle[1], triangle[2]])),
        w = normalize([u.x+v.x, u.y+v.y]),
        angle = acos(dot(u, v)),
        normW = THICKNESS / (2*sin(angle/2)))
    [triangle[1].x + w.x*normW, triangle[1].y + w.y*normW];
// Testing angle, expect 45
echo("angle", acos(dot([1, 0], [0.707107, 0.707107])));

// Testing innerPoint, expect [0.1, 0.1]
echo("innerPoint", innerPoint([[0, 1], [0, 0], [1, 0]], 0.2));
// Testing innerPoint, expect [11, 11]
echo("innerPoint", innerPoint([[10, 15], [10, 10], [15, 10]], 2)); 


function dot(u, v) = u.x*v.x + u.y*v.y;
function normalize(vec) = [vec.x/norm(vec), vec.y/norm(vec)];
//// Testing normalize, expect [0.707, 0.707]
//echo("normalize", normalize([[0,0], [1,1]]));

function normOf(line) = norm(vectorize(line));
function vectorize(line) = [dx(line), dy(line)];
function dx(line) = line[1].x - line[0].x;
function dy(line) = line[1].y - line[0].y;
function sq(num) = num * num;