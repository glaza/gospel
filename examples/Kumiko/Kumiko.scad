//
// This is a Kumiko pattern generator
// It generates 2D polygons very fast
// Don't forget to linear_extrude it!
// @author George Laza (geodynamics)
//
// Sample images can be found at these sites:
// ------------------------------------------
// http://www.kskdesign.com.au/shoji/kumiko.html
// http://yoshiharawoodworks.com/en/about/kumiko
// https://simplynativejapan.com.au/materials/kumiko
// https://www.tanihata.co.jp/english/takumi/tree
// http://www.sashikan.com/en/design_list.html

// Example:
// --------
// Kumiko(KAKUASANOHA, [[0,0],[1,0],[1,1],[0,1]], [2,2]);

rows=3;
cols=3;
for (x = [0:1:(rows-1)])
{
    for (y = [0:1:(cols-1)])
    {
        tile = _computeTileRect([[0,0],[10,0],[10,10],[0,10]], [3, 3], x, y);
        
        Kumiko(x + y*cols,
               _scaleRect(tile, -.2),
               [2, 2]);
    }
}

// Pattern Constants:
// ------------------
NONE = 0; // Can be used to only draw the frame

// Square
KAKUASANOHA  = 1;
GOMAGARA     = 2;
TSUTSUIDUTSU = 3;
MASUTSUNAGI  = 4;

// Hexagonal
MITSUKUDE    = 6;
ASANOHA      = 7;
BISHAMON     = 5;

/*
Sakura
SakuraKikko
KasaneRindo
YaeUrahanaKikko
KawariUrahanaKikko
Kagome
YaeKagome
HishisannojiKuzushi
MasuTsunagi
ManjiTsunagi

Sayagata
Izutsu
WariBishi
SanjuBishi
TsumiIsiKikko

Mikado
Shokko
NijyuShokko
AsanohaKikko
BentenKikko
*/

/**
 * Renders a 2D Kumiko pattern
 * @param pattern One of the pattern constants
 * @param rectangle A vector of 4 points denoting the
 *                  coordinates of the bouding box
 *                  in a counter clockwise direction
 *                  Example: [[0,0],[1,0],[1,1],[0,1]]
 * @param grid A vector holding two integers:
 *             the number of columns and rows
 *             in the grid. Example: [cols,rows]
 * @param frame A boolean indicating whether to box
 *              the model in a frame or not.
 * @param thickness The thickness of all the edges
 *                  In absolute size compared to
 *                  rectangle provided above. Ex:
 *                  rect = [[0,0],[1,0],[1,1],[0,1]]
 *                  grid = [2,2], thickness = 0.1
 *                  each edge will be 1/5 of the 
 *                  tile, which is huge, by the way. 
 *                  If left as 0, an appropriate 
 *                  thickness will be selected: 3%
 */
module Kumiko(pattern = KAKUASANOHA,
              rectangle = [[0,0],[1,0],[1,1],[0,1]],
              grid = [1, 1],
              frame = true,
              thickness = 0)
{
    actualThickness = thickness == 0
        ? let (sampleTile = _computeTileRect(rectangle, grid, 0, 0))
          0.03*norm(_vectorize([sampleTile[0], sampleTile[1]]))
        : thickness;
    
    if (frame)
    {
        Frame(rectangle, FRAME_LEFT, actualThickness);
        Frame(rectangle, FRAME_BOTTOM, actualThickness);
        Frame(rectangle, FRAME_RIGHT, actualThickness);
        Frame(rectangle, FRAME_TOP, actualThickness);
    }
    
    scaledRect = frame ? _scaleRect(rectangle, -actualThickness/2) : rectangle;
    
    for (x = [0:1:grid.x-1])
    {
        for (y = [0:1:grid.y-1])
        {
            tile = _computeTileRect(scaledRect, grid, x, y);
            
            if (pattern == KAKUASANOHA)
                KakuAsanoha(tile, actualThickness);
            if (pattern == ASANOHA)
                Asanoha(tile, actualThickness);
            if (pattern == MITSUKUDE)
                Mitsukude(tile, actualThickness);
            if (pattern == BISHAMON)
                BishamonKikkou(tile, actualThickness);
            if (pattern == TSUTSUIDUTSU)
                Tsutsuidutsu(tile, actualThickness);
            if (pattern == GOMAGARA)
                GomaGara(tile, actualThickness);
            if (pattern == MASUTSUNAGI)
                MasuTsunagi(tile, actualThickness);
        }
    }
}


//  _  __               _ _         
// | |/ /   _ _ __ ___ (_) | _____  
// | ' / | | | '_ ` _ \| | |/ / _ \ 
// | . \ |_| | | | | | | |   < (_) |
// |_|\_\__,_|_| |_| |_|_|_|\_\___/ 
//  _____ _ _           
// |_   _(_) | ___  ___ 
//   | | | | |/ _ \/ __|
//   | | | | |  __/\__ \
//   |_| |_|_|\___||___/
//

/**
 *      Mitsukude
 *
 *   3            .2
 *   |         .-' |
 *   |      .-'    |
 *   |   .-'       |
 *  30.-'          |
 *   |`-.          |
 *   |   `-.       |
 *   |      `-.    |
 *   |         `-. |
 *   0            `1
 */
module Mitsukude(rectangle, thickness)
{
    // Decompose tile into quarters
    for (quarterRect = _mirrorEveryNth(_mirrorEveryNth(_subdivide(rectangle), 1, 4), 2, 4))
    {
        p0 = quarterRect[0];
        p1 = quarterRect[1];
        p2 = quarterRect[2];
        p3 = quarterRect[3];
        p30 = _interpolate(p3, p0);
        
        polygon(_outline([p1, p30, p0], thickness, OPEN));
        polygon(_outline([p30, p1, p2], thickness));
        polygon(_outline([p3, p30, p2], thickness, OPEN));
    }
}

/**
 *       Asanoha
 *
 *   3    23------.2
 *   |   /     .-'/|
 *   |  /   .-'  / |
 *   | / .-'    /  |
 *  30.-'______/   |
 *   |`-.      \   |
 *   | \ `-.    \  |
 *   |  \   `-.  \ |
 *   |   \     `-.\|
 *   0    01------`1
 */
module Asanoha(rectangle, thickness)
{
    // Decompose tile into quarters
    for (quarterRect = _mirrorEveryNth(_mirrorEveryNth(_subdivide(rectangle), 1, 4), 2, 4))
    {
        p0 = quarterRect[0];
        p1 = quarterRect[1];
        p2 = quarterRect[2];
        p3 = quarterRect[3];
        p01 = _interpolate(p0, p1, 1/3);
        p12 = _interpolate(p1, p2);
        p23 = _interpolate(p2, p3, 2/3);
        p30 = _interpolate(p3, p0);
        
        // Cut each quarter in half
        for (triangle = _subdivide([p30, p1, p2]))
        {
            polygon(_outline(triangle, thickness));
        }
        // Top
        polygon(_outline([p23, p30, p2], thickness));
        polygon(_outline([p3, p30, p23], thickness, OPEN));
        // Bottom
        polygon(_outline([p01, p30, p0], thickness, OPEN));
        polygon(_outline([p1, p30, p01], thickness));
    }
}

/**
 *   Kaku-Asanoha
 *
 *   3-rectangle-2
 *   |     |   / |
 *   |     |  /  |
 *   |     | /  outer triangle
 *   |_____|/____|
 *   |     | quar|
 *   |     | rect|
 *   |     |     |
 *   |     |     |
 *   0-----------1
 */
module KakuAsanoha(rectangle, thickness)
{
    // Decompose tile into quarters
    for (quarterRect = _rotateEveryNth(_subdivide(rectangle), 1, 2))
    {
        // Cut each quarter in half
        for (outerTriangle = _triangulate(quarterRect))
        {
            // Decompose each tringle in 3
            for (innerTriangle = _triangulate(outerTriangle))
            {
                polygon(_outline(innerTriangle, thickness));
            }
        }
    }
}

/**
 *   Bishamon-kikkou
 *
 *   3    23      .2
 *   |    |    .-' |
 *   |    | .-'    |
 *   |   .C'      .12
 *  30.-'   `-. -' |
 *   |`-.      |   |
 *   |   `-.   |   |
 *   A      `-.|   |
 *   |-.     .-B-. |
 *   0  `-01'     `1
 */
module BishamonKikkou(rectangle, thickness)
{    
    // Decompose tile into quarters
    for (quarterRect = _mirrorEveryNth(_mirrorEveryNth(_subdivide(rectangle), 1, 4), 2, 4))
    {
        p0 = quarterRect[0];
        p1 = quarterRect[1];
        p2 = quarterRect[2];
        p3 = quarterRect[3];
        p01 = _interpolate(p0, p1, 1/3);
        p12 = _interpolate(p1, p2);
        p23 = _interpolate(p2, p3, 2/3);
        p30 = _interpolate(p3, p0);
        pA = _interpolate(p30, p0, 2/3);
        pB = _interpolate(p30, p1, 2/3);
        pC = _interpolate(p30, p2, 1/3);
        
        up = _vectorize([p0, p3]);
        down = _vectorize([p3, p0]);
        
        // Top
        polygon(_outline([p3, p30, pC, p23], thickness, OPEN));
        polygon(_outline([p23, pC, p2], thickness, OPEN));
        
        // Center
        for (trapezoid = _trapizate([p30, p1, p2]))
        {
            polygon(_outline(trapezoid, thickness));
        }
        
        // Bottom
        polygon(_outline([p01, pA, p0], thickness, OPEN));
        polygon(_outline([pA, p01, pB, p30], thickness));
        polygon(_outline([p1, pB, p01], thickness, OPEN));
    }
}

/**
 *   Tsutsuidutsu
 *
 *   +-----------+
 *   |\_________/|
 *   | |       | |
 *   | |       | |
 *   | |       | |
 *   | |       | |
 *   | |       | |
 *   | |_______| |
 *   |/         \|
 *   +-----------+
 */
module Tsutsuidutsu(rectangle, thickness)
{
    // Decompose tile into quarters
    for (quarterRect = _mirrorEveryNth(_mirrorEveryNth(_subdivide(rectangle), 1, 4), 2, 4))
    {
        for (trapezoid = _trapizate(quarterRect))
        {
            polygon(_outline(trapezoid, thickness));
        }
    }
}

/**
 *           Goma Gara
 *
 *   3                 ,-2
 *                  ,-H ,I
 *               ,-' ,G' |
 *            ,-' ,-' |  |
 *         ,-' ,-'    |  |
 *       ,B---C-------E--F
 *    ,-' ,-'         |  |
 *   0---A------------D--1
 *
 */
module GomaGara(rectangle, thickness)
{
    // Decompose tile into quarters
    for (quarterRect = _rotateEveryNth(_rotateEveryNth(_rotateEveryNth(_subdivide(rectangle), 1, 1), 2, 1), 3, 1))
    {
        for (triangle = _mirrorEveryNth(_triangulate(quarterRect)), 1, 1) {
            p0 = triangle[0];
            p1 = triangle[1];
            p2 = triangle[2];
            pA = _interpolate(p0, p1, 0.25);
            pB = _interpolate(p0, p2, 0.2);
            pI = _interpolate(p1, p2, 0.75);
            pH = _interpolate(p0, p2, 0.8);
            pF = _interpolate(p1, p2, 0.2);
            pC = _interpolate(pA, pI, 0.2666);
            pD = _interpolate(p0, p1, 0.8);
            pG = _interpolate(pA, pI, 0.7333);
            pE = _interpolate(pB, pF, 0.75);//0.7925);
            
            polygon(_outline([p0, pA, pC, pB], thickness));
            polygon(_outline([pA, pD, pE, pC], thickness));
            polygon(_outline([pD, p1, pF, pE], thickness));
            polygon(_outline([pE, pF, pI, pG], thickness));
            polygon(_outline([pC, pE, pG], thickness));
            polygon(_outline([pB, pC, pG, pH], thickness));
            polygon(_outline([pG, pI, p2, pH], thickness));
        }
    }
}

/**
 *           Goma Gara
 *
 *   3--F-----------E--2
 *   |   `-.     ,-'   |
 *   G      '-K-'     ,D
 *   |`-.  ,-' `-. ,-' |
 *   |   :L.     ,J.   |
 *   H,-'   `-I-'   `-.C
 *   |     ,-' `-.     |
 *   0----A-------B----1
 *
 */
module MasuTsunagi(rectangle, thickness)
{
    // Decompose tile into quarters
    for (quarterRect = _subdivide(rectangle))
    {
        p0 = quarterRect[0];
        p1 = quarterRect[1];
        p2 = quarterRect[2];
        p3 = quarterRect[3];
        pA = _interpolate(p0, p1, 1/3);
        pB = _interpolate(p0, p1, 2/3);
        pC = _interpolate(p1, p2, 1/3);
        pD = _interpolate(p1, p2, 2/3);
        pE = _interpolate(p2, p3, 1/3);
        pF = _interpolate(p2, p3, 2/3);
        pG = _interpolate(p3, p0, 1/3);
        pH = _interpolate(p3, p0, 2/3);
        pI = _interpolate(pA, pD, 1/3);
        pJ = _interpolate(pA, pD, 2/3);
        pK = _interpolate(pH, pE, 2/3);
        pL = _interpolate(pH, pE, 1/3);
        
        polygon(_outline([p0, pA, pI, pL, pH], thickness));
        polygon(_outline([pA, pB, pI], thickness));
        polygon(_outline([pC, pD, pJ], thickness));
        polygon(_outline([pE, pF, pK], thickness));
        polygon(_outline([pH, pL, pG], thickness));
    }
}

/**
 * Draws a rectangular box frame on the inside
 * 
 * 3----2  +----+
 * |    |  |\__/|
 * |    |  ||__||
 * |    |  |/  \|
 * 0----1  +----+
 * 
 * @param rectangle A vector of 4 points
 * @param side One of FRAME_* constants
 * @param thickness The thickness of the edges
 */
FRAME_LEFT   = 0;
FRAME_BOTTOM = 1;
FRAME_RIGHT  = 2;
FRAME_TOP    = 3;
module Frame(rectangle, side, thickness)
{
    scaledRect = _scaleRect(rectangle, -thickness/2);
    p0 = rectangle[0];
    p1 = rectangle[1];
    p2 = rectangle[2];
    p3 = rectangle[3];
    p00 = scaledRect[0];
    p11 = scaledRect[1];
    p22 = scaledRect[2];
    p33 = scaledRect[3];
    
    if (side == FRAME_LEFT)
        polygon([p0, p3, p33, p00]);
    if (side == FRAME_BOTTOM)
        polygon([p0, p00, p11, p1]);
    if (side == FRAME_RIGHT)
        polygon([p1, p11, p22, p2]);
    if (side == FRAME_TOP)
        polygon([p2, p22, p33, p3]);
}


//  _   _ _   _ _ _ _         
// | | | | |_(_) (_) |_ _   _ 
// | | | | __| | | | __| | | |
// | |_| | |_| | | | |_| |_| |
//  \___/ \__|_|_|_|\__|\__, |
//                      |___/ 
//  _____                 _   _                 
// |  ___|   _ _ __   ___| |_(_) ___  _ __  ___ 
// | |_ | | | | '_ \ / __| __| |/ _ \| '_ \/ __|
// |  _|| |_| | | | | (__| |_| | (_) | | | \__ \
// |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
//

/**
 * Calculates the grid tile coordinates
 *
 * grid=[2,3] tile coords   i=1,j=1
 * 3---+---2   +---+---+   +---+---+
 * |   |   |   |0,0|1,0|   |   |   |
 * +---+---+   +---+---+   +---3---2
 * |   |   |   |0,1|1,1|   |   |   |
 * +---+---+   +---+---+   +---0---1
 * |   |   |   |0,2|1,2|   |   |   |
 * 0---+---1   +---+---+   +---+---+
 * 
 * @param rectangle The entire grid coordinates
 * @param grid A 1x2 vector holding the number of
 *             columns and rows in the grid [cols,rows]
 * @param i The 0-based colum index of the tile
 * @param j The 0-based row index of the tile
 * @return A rectangle representing the selected tile
 */
function _computeTileRect(rectangle, grid, i, j) =
    let(r0 = rectangle[0],
        r1 = rectangle[1],
        r3 = rectangle[3],
        u0 = _vectorize([r0, _interpolate(r0, r1, i/grid.x)]),
        v0 = _vectorize([r0, _interpolate(r0, r3, j/grid.y)]),
        u1 = _vectorize([r0, _interpolate(r0, r1, (i+1)/grid.x)]),
        v1 = _vectorize([r0, _interpolate(r0, r3, (j+1)/grid.y)]),
        p0 = _addVec(r0, _addVec(u0, v0)),
        p1 = _addVec(r0, _addVec(u1, v0)),
        p2 = _addVec(r0, _addVec(u1, v1)),
        p3 = _addVec(r0, _addVec(u0, v1)))
    //[p0, p1, p2, p3];
    [p0,p1,p2,p3];

/**
 * Traces the outline of a shape
 * @param shape Triangle or quadrilateral
 * @param geometry One of:
 *
 *  CLOSED   OPEN   PARTIAL
 *
 *  3----2  3----2  3----2
 *  |    |       |       |
 *  |    |       |       |
 *  0----1  0----1  0    1
 *  
 *    2       2       2
 *   / \       \       \
 *  0---1   0---1   0   1
 *
 * @return A polygon that traces the outline
 */
CLOSED=0;
OPEN=1;
PARTIAL=2;
function _outline(shape, thickness, geometry = CLOSED) = 
    let (center = _center(shape),
         p0 = shape[0],
         p1 = shape[1],
         p2 = shape[2])
    len(shape) == 3 // Triangle
    ? let(p00 = _innerPoint([p2, p0, p1], thickness, geometry),
          p11 = _innerPoint([p0, p1, p2], thickness),
          p22 = _innerPoint([p0, p2, p1], thickness, geometry))
        geometry == CLOSED
        ? [p0, p1, p2, p0, p00, p22, p11, p00]

        // geometry == OPEN
        : [p0, p1, p2, p22, p11, p00]

    : len(shape) == 4 // Quadrilateral
    ? let (p3 = shape[3],
           p00 = _innerPoint([p3, p0, p1], thickness, geometry),
           p11 = _innerPoint([p0, p1, p2], thickness),
           p22 = _innerPoint([p1, p2, p3], thickness),
           p33 = _innerPoint([p2, p3, p0], thickness))
        geometry == CLOSED
        ? [p0, p1, p2, p3, p0, p00, p33, p22, p11, p00]
        
        : let(p33 = _innerPoint([p0, p3, p2], thickness, OPEN))
        geometry == OPEN
        ? [p0, p1, p2, p3, p33, p22, p11, p00]

        : // geometry == PARTIAL
        [p1, p2, p3, p33, p22, p11]
        
    : len(shape) == 5 // Pentagon
    ? let (p3 = shape[3],
           p4 = shape[4],
           p00 = _innerPoint([p3, p0, p1], thickness, geometry),
           p11 = _innerPoint([p0, p1, p2], thickness),
           p22 = _innerPoint([p1, p2, p3], thickness),
           p33 = _innerPoint([p2, p3, p0], thickness),
           p44 = _innerPoint([p3, p4, p0], thickness))
        geometry == CLOSED
        ? [p0, p1, p2, p3, p4, p0, p00, p44, p33, p22, p11, p00]
        
        : let(p44 = _innerPoint([p0, p4, p3], thickness, OPEN))
        geometry == OPEN
        ? [p0, p1, p2, p3, p4, p44, p33, p22, p11, p00]

        : // geometry == PARTIAL
        [p1, p2, p3, p4, p44, p33, p22, p11]
        
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
function _subdivide(shape) = len(shape) == 3
    ? // Triangle
        let (center = _center(shape),
             p0 = shape[0],
             p1 = shape[1],
             p2 = shape[2])
        [
            [p0, p1, center],
            [p1, p2, center],
            [p2, p0, center]
        ]

    : // Rectangle
        let (center = _center(shape),
             p0 = shape[0],
             p1 = shape[1],
             p2 = shape[2],
             p3 = shape[3],
             p01 = _center([p0, p1]),
             p12 = _center([p1, p2]),
             p23 = _center([p2, p3]),
             p30 = _center([p3, p0]))
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
function _triangulate(shape) =
    len(shape) == 3
    ? _subdivide(shape) // Triangle
    : // Rectangle
        let (p0 = shape[0],
             p1 = shape[1],
             p2 = shape[2],
             p3 = shape[3])
        [
            [p0, p1, p2],
            [p0, p3, p2]
        ];

/**
 * Cut the shape into trapezoids
 * @param shape Triangle or Quadrilateral
 * @return A vector of trapezoids
 */
function _trapizate(shape) =
    let (pc = _center(shape),
         p0 = shape[0],
         p1 = shape[1],
         p2 = shape[2])
    len(shape) == 3 // Triangle
    ? let (p01 = _interpolate(p0, p1, 2/3),
           p12 = _interpolate(p1, p2, 2/3),
           p20 = _interpolate(p2, p0, 2/3))
        [[p0,  p01, pc,  p20],
         [p01, p1,  p12, pc],
         [pc,  p12, p2,  p20]]

    : len(shape) == 4 // Quadrilateral
    ? let (p3 = shape[3],
           p0c = _interpolate(p0, pc),
           p1c = _interpolate(p1, pc),
           p2c = _interpolate(p2, pc),
           p3c = _interpolate(p3, pc))
        [[p0,  p1,  p1c, p0c],
         [p1,  p2,  p2c, p1c],
         [p2,  p3,  p3c, p2c],
         [p3,  p0,  p0c, p3c],
         [p0c, p1c, p2c, p3c]]
         
     : [];
    
/**
 * Rotates every Nth  shape
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
function _rotateEveryNth(shapes, start, n, i=0) =
    let (rotateNow = i >= start && (i - start) % n == 0)
    i == (len(shapes) - 1)
    ? [_rotateShape(shapes[i], rotateNow)] // Last shape
    : concat([_rotateShape(shapes[i], rotateNow)], _rotateEveryNth(shapes, start, n, i+1));

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
function _rotateShape(shape, rotateNow=true) =
    !rotateNow 
    ? shape
    
    : len(shape) == 3
    ? [shape[1], shape[2], shape[0]]

    : len(shape) == 4
    ? [shape[1], shape[2], shape[3], shape[0]]
    
    : shape;

/**
 * Mirrors every Nth shape
 * start = 2
 * n = 2
 * +--+ +--+ +--+ +--+    +--+ +--+ +--+ +--+
 * |32| |32| |32| |32|    |32| |23| |32| |23|
 * |01| |01| |01| |01| -> |01| |10| |01| |10|
 * +--+ +--+ +--+ +--+    +--+ +--+ +--+ +--+
 *      ^         ^
 * @param shapes A vector of triangles or rectangles
 * @param start The stating index where to start mirroring
 * @param n The period to mirror shapes at
 * @param i The current index of the shape vector.
 *          This variable is used to implement tail
 *          recursion: Do not use as a starting index  
 *          as it will skip all shapes before it.
 * @return A list of shapes with every Nth mirrored
 */
function _mirrorEveryNth(shapes, start, n, i=0) =
    let (mirrorNow = i >= start && (i - start) % n == 0)
    i == (len(shapes) - 1)
    ? [_mirrorShape(shapes[i], mirrorNow)] // Last shape
    : concat([_mirrorShape(shapes[i], mirrorNow)], _mirrorEveryNth(shapes, start, n, i+1));


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
function _mirrorShape(shape, mirrorNow=true) = 
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
function _interpolate(p0, p1, amount=0.5) =
    let (dx = p1.x - p0.x, 
         dy = p1.y - p0.y)
    [p0.x + amount*dx, p0.y + amount*dy];

/**
 * Computes the center point of a line or shape
 * @param points An vector of 2, 3 or 4 2D points
 *               Line: [[x1,y1],[x2,y2]]
 *               Triangle: [[x1,y1],[x2,y2],[x3,y3]]
 * @return A single point that is at the center.
 */
function _center(shape) =
    len(shape) == 2 // Line with 2 points
    ? _interpolate(shape[0], shape[1])
         
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
function _innerPoint(triangle, thickness, geometry = CLOSED) =
    let(u = _normalize(_vectorize([triangle[1], triangle[0]])),
        v = _normalize(_vectorize([triangle[1], triangle[2]])),
        w = _normalize([u.x+v.x, u.y+v.y]),
        angle = acos(_dot(u, v)),
        normW = thickness / (2*sin(angle/2)),
        normU = thickness / (2*sin(angle)))
    geometry == CLOSED
    ? _addVec(triangle[1], _scaleVec(w, normW))
    
    : // geometry == OPEN
    _addVec(triangle[1], _scaleVec(u, normU));

/**
 * Scales the rectangle around its center
 * 
 *                   3--------2
 * 3----2            |        |
 * |    | + amount = |        |
 * |    |    | |     |        |
 * 0----1            |        |
 *                   0--------1
 *
 * 3----2            
 * |    | - amount = 3--2
 * |    |    | |     |  |
 * 0----1            0--1
 *
 * @param rectangle A vector of 4 points
 * @param amount The absolute about by which to
 *               expand or shrink
 * @return A rectangle expanded or shrunk 
 */
function _scaleRect(rectangle, amount) =
    let (p0 = rectangle[0],
         p1 = rectangle[1],
         p2 = rectangle[2],
         p3 = rectangle[3],
         u = _scaleVec(_normalize(_vectorize([p0, p1])), amount),
         v = _scaleVec(_normalize(_vectorize([p0, p3])), amount))
     [_subVec(p0, _addVec(u, v)),
      _addVec(p1, _addVec(u, [-v.x, -v.y])),
      _addVec(p2, _addVec(u, v)),
      _addVec(p3, _addVec([-u.x,-u.y], v))];

function _dot(u, v) = u.x*v.x + u.y*v.y;
function _normalize(vec) = [vec.x/norm(vec), vec.y/norm(vec)];
function _scaleVec(vector, factor) = [vector.x*factor, vector.y*factor];
function _addVec(point, vector) = [point.x+vector.x, point.y+vector.y];
function _subVec(point, vector) = [point.x-vector.x, point.y-vector.y];
function _vectorize(line) = [_dx(line), _dy(line)];
function _dx(line) = line[1].x - line[0].x;
function _dy(line) = line[1].y - line[0].y;